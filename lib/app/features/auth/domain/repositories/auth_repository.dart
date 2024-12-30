import 'package:transsectes_app/app/features/auth/domain/entities/user_entity.dart';
import 'package:transsectes_app/app/core/errors/data_error.dart';
import 'package:transsectes_app/app/core/results/result.dart';

/// Interface for the authentication repository.
///
/// This abstract class defines the methods to interact with the authentication
/// system, including signing in, signing up, checking if a user is authenticated,
/// checking email verification, and checking if the user is a technician.
abstract class AuthRepository {
  /// Signs in the user with the provided email and password.
  ///
  /// Returns a [Result] that either contains the authenticated user [UserEntity]
  /// or a [DataError] if the sign-in operation fails.
  Future<Result<UserEntity, DataError>> signIn(String email, String password);

  /// Signs up a new user with the provided email and password.
  ///
  /// Returns a [Result] that contains the signed-up user [UserEntity]
  /// or a [DataError] if the sign-up operation fails.
  Future<Result<UserEntity, DataError>> signUp(String email, String password);

  /// Signs out the current authenticated user.
  ///
  /// Returns a [Result] containing a [void] if the sign-out operation succeeds,
  /// or a [DataError] if the operation fails.
  Future<Result<void, DataError>> signOut();

  /// Checks if the user is authenticated.
  ///
  /// Returns a [Result] containing a [bool] indicating whether the user is authenticated
  /// or a [DataError] if the check operation fails.
  Future<Result<bool, DataError>> isAuthenticated();

  /// Checks if the user's email is verified.
  ///
  /// Returns a [Result] containing a [bool] indicating whether the email is verified
  /// or a [DataError] if the check operation fails.
  Future<Result<bool, DataError>> isEmailVerified(String email);

  /// Checks if the user is a technician.
  ///
  /// Returns a [Result] containing a [bool] indicating whether the user is a technician
  /// or a [DataError] if the check operation fails.
  Future<Result<bool, DataError>> isTechnician(String email);

  /// Sends a password reset email to the specified email address.
  ///
  /// Returns a [Result] containing a [void] if the operation succeeds,
  /// or a [DataError] if the operation fails.
  Future<Result<void, DataError>> forgotPassword(String email);

  /// Checks if the user is currently authenticated.
  ///
  /// Returns a [Result] containing a [bool] indicating whether the user is authenticated
  /// or a [DataError] if the operation fails.
  Result<bool, DataError> isUserAuthenticated();

  /// Retrieves the current authenticated user.
  ///
  /// Returns a [Result] containing the [UserEntity] of the currently authenticated user
  /// or a [DataError] if the operation fails.
  Result<UserEntity, DataError> getCurrentUser();

  /// Deletes the user's account and all associated information from Firebase.
  ///
  /// This method attempts to delete the currently authenticated user's account. If
  /// the operation fails due to insufficient authentication, it throws a
  /// [RequiresRecentLoginException]. For other errors, a [DeleteUserAccountException]
  /// is thrown.
  ///
  /// Throws:
  /// - [RequiresRecentLoginException]: If the user needs to reauthenticate.
  /// - [DeleteUserAccountException]: For other unexpected errors.
  Future<void> deleteUserAccountAndInformation();
}
