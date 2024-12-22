import 'package:transsectes_app/app/features/auth/domain/repositories/auth_repository.dart';
import 'package:transsectes_app/app/core/errors/data_error.dart';
import 'package:transsectes_app/app/core/results/result.dart';

/// Use case for signing out the current user.
///
/// This class defines the logic for the sign-out operation, interacting with the
/// [AuthRepository] to perform the sign-out action. It returns a [Result] containing
/// a success message or a [DataError] if the operation fails.
class SignOutUseCase {
  final AuthRepository repository;

  /// Constructor for the use case, accepts an instance of the [AuthRepository].
  SignOutUseCase(this.repository);

  /// Executes the sign-out logic.
  ///
  /// Calls the repository to perform the sign-out. Returns a [Result] indicating
  /// success or failure.
  Future<Result<void, DataError>> execute() async {
    return await repository.signOut();
  }
}
