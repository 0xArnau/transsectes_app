import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:logger/logger.dart';
import 'package:transsectes_app/app/core/errors/data_error.dart';
import 'package:transsectes_app/app/core/exceptions/exception.dart';
import 'package:transsectes_app/app/core/results/result.dart';
import 'package:transsectes_app/app/features/auth/data/mapper/user_mapper.dart';
import 'package:transsectes_app/app/features/auth/domain/datasources/auth_datasource.dart';
import 'package:transsectes_app/app/features/auth/domain/entities/user_entity.dart';
import 'package:transsectes_app/app/features/auth/domain/exceptions/auth_exceptions.dart';
import 'package:transsectes_app/generated/l10n.dart';

/// Implementation of the [AuthDatasource] interface for Firebase.
class AuthFirebaseDatasourceImpl implements AuthDatasource {
  FirebaseAuth _firebaseAuth;
  final FirebaseFirestore _firebaseFirestore;

  /// Constructor to initialize [FirebaseAuth] and [FirebaseFirestore] instances.
  AuthFirebaseDatasourceImpl({
    FirebaseAuth? firebaseAuth,
    FirebaseFirestore? firebaseFirestore,
  })  : _firebaseAuth = firebaseAuth ?? FirebaseAuth.instance,
        _firebaseFirestore = firebaseFirestore ?? FirebaseFirestore.instance;

  @override
  Future<Result<void, DataError>> forgotPassword(String email) async {
    try {
      await _firebaseAuth.sendPasswordResetEmail(email: email);

      return Result.success(null);
    } catch (e) {
      Logger().e(e);
      return Result.failure(RemoteError(RemoteErrorType.unknown));
    }
  }

  void _updateFirebaseAuth() {
    _firebaseAuth = FirebaseAuth.instance;
  }

  @override
  Future<Result<bool, DataError>> isEmailVerified(String email) async {
    try {
      _updateFirebaseAuth();

      final user = _firebaseAuth.currentUser;
      if (user == null) {
        return Result.failure(RemoteError(RemoteErrorType.unknown));
      }
      await user.reload();
      Logger().d(user.emailVerified);
      return Result.success(user.emailVerified);
    } catch (e) {
      Logger().e(e);
      return Result.failure(RemoteError(RemoteErrorType.unknown));
    }
  }

  @override
  Future<Result<bool, DataError>> isTechnician(String email) async {
    try {
      _updateFirebaseAuth();

      final currentEmail = _firebaseAuth.currentUser?.email;
      if (currentEmail == null || currentEmail.isEmpty) {
        return Result.success(false);
      }

      final documentSnapshot = await _firebaseFirestore
          .collection('tecnics')
          .doc(currentEmail.toLowerCase())
          .get();

      return Result.success(documentSnapshot.exists);
    } catch (e) {
      Logger().e(e);
      return Result.success(false);
    }
  }

  @override
  Future<Result<UserEntity, DataError>> signIn(
      String email, String password) async {
    try {
      final userFirebase = (await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      ))
          .user;

      if (userFirebase == null) {
        return Result.failure(RemoteError(RemoteErrorType.unknown));
      }

      // Map userFirebase to UserEntity
      UserEntity userEntity = UserMapper.toUserEntity(userFirebase);

      // Verify if the user is a technician and update the field
      final isTechnicianResult = await isTechnician(userEntity.email);
      bool isTechnicianValue = false;
      if (isTechnicianResult.isSuccess) {
        isTechnicianValue = isTechnicianResult.value ?? false;
      }

      userEntity = userEntity.copyWith(isTechnician: isTechnicianValue);

      return Result.success(userEntity);
    } catch (e) {
      Logger().e(e);
      return Result.failure(RemoteError(RemoteErrorType.unknown));
    }
  }

  @override
  Future<Result<void, DataError>> signOut() async {
    try {
      await _firebaseAuth.signOut();
      return Result.success(null);
    } catch (e) {
      Logger().e(e);
      return Result.failure(RemoteError(RemoteErrorType.unknown));
    }
  }

  @override
  Future<Result<UserEntity, DataError>> signUp(
      String email, String password) async {
    try {
      final userFirebase = (await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      ))
          .user;

      if (userFirebase == null) {
        return Result.failure(RemoteError(RemoteErrorType.unknown));
      }

      // Map userFirebase to UserEntity
      UserEntity userEntity = UserMapper.toUserEntity(userFirebase);

      // Verify if the user is a technician and update the field
      final isTechnicianResult = await isTechnician(userEntity.email);
      if (!isTechnicianResult.isSuccess) {
        return Result.failure(RemoteError(RemoteErrorType.unknown));
      }

      userEntity = userEntity.copyWith(isTechnician: isTechnicianResult.value!);

      return Result.success(userEntity);
    } catch (e) {
      Logger().e(e);
      return Result.failure(RemoteError(RemoteErrorType.unknown));
    }
  }

  @override
  Result<bool, DataError> isUserAuthenticated() {
    try {
      return Result.success(_firebaseAuth.currentUser != null);
    } catch (e) {
      Logger().e(e);
      return Result.failure(RemoteError(RemoteErrorType.unknown));
    }
  }

  @override
  Result<UserEntity, DataError> getCurrentUser() {
    try {
      User? userFirebase = _firebaseAuth.currentUser;

      if (userFirebase == null) {
        return Result.failure(RemoteError(RemoteErrorType.unknown));
      }

      UserEntity userEntity = UserMapper.toUserEntity(userFirebase);
      return Result.success(userEntity);
    } catch (e) {
      Logger().e(e);
      return Result.failure(RemoteError(RemoteErrorType.unknown));
    }
  }

  @override
  @override
  Future<void> deleteUserAccountAndInformation() async {
    Logger().d('Attempting to delete user account and information.');

    try {
      final user = FirebaseAuth.instance.currentUser;

      // Ensure a user is authenticated
      if (user == null) {
        throw DeleteUserAccountException(S.current.noUserAuthenticated);
      }

      // Verify technician status
      await _verifyNonTechnicianStatus(user.email);

      // Delete the user account
      await user.delete();
      Logger().d('User account successfully deleted.');
    } catch (e) {
      _handleAccountDeletionError(e);
    }
  }

  /// Verifies that the user is not a technician.
  ///
  /// Throws a [RequiresNonTechnicianException] if the user is a technician.
  Future<void> _verifyNonTechnicianStatus(String? email) async {
    if (email == null) {
      throw DeleteUserAccountException(S.current.userEmailMissing);
    }

    final isTechnicianResult = await isTechnician(email);

    isTechnicianResult.fold(
      (isTechnician) {
        if (isTechnician) {
          Logger().e('User is a technician and cannot perform this action.');
          throw RequiresNonTechnicianException(
              S.current.requiresNonTechnician);
        }
      },
      (error) {},
    );
  }

  /// Handles errors during account deletion.
  ///
  /// Logs the error and throws specific exceptions based on the error type.
  void _handleAccountDeletionError(dynamic error) {
    Logger().e(error);

    if (error is FirebaseAuthException &&
        error.code == 'requires-recent-login') {
      Logger().d('Account deletion requires recent login.');
      throw RequiresRecentLoginException(
          S.current.userMustReauthenticate);
    } else if (error is RequiresNonTechnicianException) {
      throw RequiresNonTechnicianException(
          S.current.requiresNonTechnician);
    } else {
      Logger()
          .d('Unexpected error during account deletion: ${error.toString()}');
      throw DeleteUserAccountException(
          S.current.unexpectedErrorWhileDeletingAccount);
    }
  }

  @override
  Future<void> verifyEmailForCurrentUser() async {
    try {
      User? userFirebase = _firebaseAuth.currentUser;
      await userFirebase!.sendEmailVerification();
    } catch (e) {
      Logger().e(e.toString());
      throw AuthException(S.current.currentUserMissing);
    }
  }
}
