import 'package:transsectes_app/app/features/auth/domain/repositories/auth_repository.dart';

/// Use case for deleting a user account and all associated information.
///
/// This class encapsulates the logic for deleting a user account,
/// interacting with the [AuthRepository] to perform the operation.
///
/// The operation is expected to delete the account of the currently
/// authenticated user along with any associated data.
///
/// Example usage:
/// ```dart
/// final deleteUserAccountUsecase = DeleteUserAccountUsecase(authRepository);
/// await deleteUserAccountUsecase.execute();
/// ```
class DeleteUserAccountUsecase {
  /// The repository responsible for handling user authentication and account operations.
  final AuthRepository repository;

  /// Creates an instance of [DeleteUserAccountUsecase].
  ///
  /// [repository] must be an instance of [AuthRepository].
  DeleteUserAccountUsecase(this.repository);

  /// Executes the account deletion logic.
  ///
  /// Calls the repository method to delete the user's account and all
  /// associated information. If the operation fails, it will propagate
  /// the error for handling.
  ///
  /// Returns:
  /// - A [Future] that completes once the operation finishes.
  ///
  /// Throws:
  /// - [RequiresRecentLoginException]: If the user needs to reauthenticate.
  /// - [DeleteUserAccountException]: For other unexpected errors.
  Future<void> execute() async {
    return await repository.deleteUserAccountAndInformation();
  }
}
