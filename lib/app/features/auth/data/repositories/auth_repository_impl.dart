import 'package:transsectes_app/app/features/auth/domain/datasources/auth_datasource.dart';
import 'package:transsectes_app/app/features/auth/domain/entities/user_entity.dart';
import 'package:transsectes_app/app/features/auth/domain/repositories/auth_repository.dart';
import 'package:transsectes_app/app/core/errors/data_error.dart';
import 'package:transsectes_app/app/core/results/result.dart';

/// Implementation of the [AuthRepository] interface that handles business logic
/// related to authentication operations, delegating the actual data management
/// to the [AuthDatasource].
class AuthRepositoryImpl implements AuthRepository {
  final AuthDatasource _authDatasource;

  AuthRepositoryImpl({required AuthDatasource authDatasource})
      : _authDatasource = authDatasource;

  @override
  Future<Result<void, DataError>> forgotPassword(String email) {
    return _authDatasource.forgotPassword(email);
  }

  @override
  Future<Result<bool, DataError>> isAuthenticated() {
    // TODO: implement signIn
    throw UnimplementedError();
  }

  @override
  Future<Result<bool, DataError>> isEmailVerified(String email) {
    return _authDatasource.isEmailVerified(email);
  }

  @override
  Future<Result<bool, DataError>> isTechnician(String email) {
    return _authDatasource.isTechnician(email);
  }

  @override
  Future<Result<UserEntity, DataError>> signIn(String email, String password) {
    return _authDatasource.signIn(email, password);
  }

  @override
  Future<Result<void, DataError>> signOut() {
    return _authDatasource.signOut();
  }

  @override
  Future<Result<UserEntity, DataError>> signUp(String email, String password) {
    return _authDatasource.signUp(email, password);
  }

  @override
  Result<bool, DataError> isUserAuthenticated() {
    return _authDatasource.isUserAuthenticated();
  }

  @override
  Result<UserEntity, DataError> getCurrentUser() {
    return _authDatasource.getCurrentUser();
  }

  @override
  Future<void> deleteUserAccountAndInformation() {
    return _authDatasource.deleteUserAccountAndInformation();
  }

  @override
  Future<void> verifyEmailForCurrentUser() {
    return _authDatasource.verifyEmailForCurrentUser();
  }
}
