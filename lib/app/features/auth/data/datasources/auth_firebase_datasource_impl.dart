import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:logger/logger.dart';
import 'package:transsectes_app/app/features/auth/data/mapper/user_mapper.dart';
import 'package:transsectes_app/app/features/auth/domain/datasources/auth_datasource.dart';
import 'package:transsectes_app/app/features/auth/domain/entities/user_entity.dart';
import 'package:transsectes_app/app/shared/domain/data_error.dart';
import 'package:transsectes_app/app/shared/domain/result.dart';

/// Implementation of the [AuthDatasource] interface for Firebase.
class AuthFirebaseDatasourceImpl implements AuthDatasource {
  final FirebaseAuth _firebaseAuth;
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

  @override
  Future<Result<bool, DataError>> isEmailVerified(String email) async {
    try {
      final user = _firebaseAuth.currentUser;
      if (user == null) {
        return Result.failure(RemoteError(RemoteErrorType.unknown));
      }

      return Result.success(user.emailVerified);
    } catch (e) {
      Logger().e(e);
      return Result.failure(RemoteError(RemoteErrorType.unknown));
    }
  }

  @override
  Future<Result<bool, DataError>> isTechnician(String email) async {
    try {
      final currentEmail = _firebaseAuth.currentUser?.email;
      if (currentEmail == null || currentEmail.isEmpty) {
        return Result.failure(RemoteError(RemoteErrorType.unknown));
      }

      final documentSnapshot = await _firebaseFirestore
          .collection('tecnics')
          .doc(currentEmail.toLowerCase())
          .get();

      return Result.success(documentSnapshot.exists);
    } catch (e) {
      Logger().e(e);
      return Result.failure(RemoteError(RemoteErrorType.unknown));
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
}
