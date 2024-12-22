import 'package:transsectes_app/app/features/auth/domain/repositories/auth_repository.dart';
import 'package:transsectes_app/app/core/errors/data_error.dart';
import 'package:transsectes_app/app/core/results/result.dart';

/// Use case for checking if the user's email is verified.
///
/// This class defines the logic for checking if the current user's email is verified,
/// interacting with the [AuthRepository]. It returns a [Result] containing a [bool]
/// indicating whether the email is verified or a [DataError] if the operation fails.
class IsEmailVerifiedUseCase {
  final AuthRepository repository;

  /// Constructor for the use case, accepts an instance of the [AuthRepository].
  IsEmailVerifiedUseCase(this.repository);

  /// Executes the logic to check if the user's email is verified.
  ///
  /// Accepts an email and calls the repository to check if the email is verified.
  /// Returns a [Result] containing a [bool] on success or a [DataError] on failure.
  Future<Result<bool, DataError>> execute(String email) async {
    return await repository.isEmailVerified(email);
  }
}
