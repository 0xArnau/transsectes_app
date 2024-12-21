import 'package:transsectes_app/app/features/auth/domain/entities/user_entity.dart';
import 'package:transsectes_app/app/shared/domain/data_error.dart';
import 'package:transsectes_app/app/shared/domain/result.dart';

/// A repository interface for handling authentication operations such as sign-in, sign-up,
/// email verification, password reset, sign-out, and checking user roles.
///
/// This interface defines the methods for interacting with authentication-related functionality,
/// such as signing in users, signing up new users, checking if the user is a technician,
/// verifying the user's email, sending password reset instructions, and logging the user out.
abstract class AuthDatasource {
  /// Signs in a user with the given [email] and [password].
  ///
  /// Returns a [Result] containing the signed-in [UserEntity] in case of success or a [DataError] if the operation fails.
  Future<Result<UserEntity, DataError>> signIn(String email, String password);

  /// Signs up a new user with the given [email] and [password].
  ///
  /// Returns a [Result] containing the created [UserEntity] in case of success or a [DataError] if the operation fails.
  Future<Result<UserEntity, DataError>> signUp(String email, String password);

  /// Checks if the user is a technician.
  ///
  /// Returns a [Result] containing a [bool] indicating whether the user is a technician or a [DataError] if the operation fails.
  Future<Result<bool, DataError>> isTechnician(String email);

  /// Checks if the user's email is verified.
  ///
  /// Returns a [Result] containing a [bool] indicating whether the user's email is verified or a [DataError] if the operation fails.
  Future<Result<bool, DataError>> isEmailVerified(String email);

  /// Sends a password reset request to the given [email].
  ///
  /// Returns a [Result] containing [void] in case of success or a [DataError] if the operation fails.
  Future<Result<void, DataError>> forgotPassword(String email);

  /// Signs out the currently authenticated user.
  ///
  /// Returns a [Result] containing [void] in case of success or a [DataError] if the operation fails.
  Future<Result<void, DataError>> signOut();

  /// Checks if the user is currently authenticated.
  ///
  /// Returns a [Result] containing a [bool] indicating whether the user is authenticated or a [DataError]
  /// if the operation fails.
  Result<bool, DataError> isUserAuthenticated();

  /// Retrieves the current authenticated user.
  ///
  /// Returns a [Result] containing the [UserEntity] of the currently authenticated user or a [DataError]
  /// if the operation fails.
  Result<UserEntity, DataError> getCurrentUser();
}
