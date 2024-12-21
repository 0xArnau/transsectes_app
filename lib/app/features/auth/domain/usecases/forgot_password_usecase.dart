import 'package:transsectes_app/app/features/auth/domain/repositories/auth_repository.dart';
import 'package:transsectes_app/app/shared/domain/data_error.dart';
import 'package:transsectes_app/app/shared/domain/result.dart';

/// Use case for initiating a password reset process.
///
/// This class defines the logic for initiating a password reset action, interacting
/// with the [AuthRepository] to send a reset password email. It returns a [Result]
/// containing a success message or a [DataError] if the operation fails.
class ForgotPasswordUseCase {
  final AuthRepository repository;

  /// Constructor for the use case, accepts an instance of the [AuthRepository].
  ForgotPasswordUseCase(this.repository);

  /// Executes the forgot password logic.
  ///
  /// Accepts an email and calls the repository to send a password reset email.
  /// Returns a [Result] indicating success or failure.
  Future<Result<void, DataError>> execute(String email) async {
    return await repository.forgotPassword(email);
  }
}
