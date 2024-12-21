import 'package:transsectes_app/app/features/auth/domain/entities/user_entity.dart';
import 'package:transsectes_app/app/features/auth/domain/repositories/auth_repository.dart';
import 'package:transsectes_app/app/shared/domain/data_error.dart';
import 'package:transsectes_app/app/shared/domain/result.dart';

/// Use case for signing up a new user.
///
/// This class defines the logic for the sign-up operation, interacting with the
/// [AuthRepository] to perform the sign-up action. It returns a [Result] containing
/// the signed-up [UserEntity] or a [DataError] if the operation fails.
class SignUpUseCase {
  final AuthRepository repository;

  /// Constructor for the use case, accepts an instance of the [AuthRepository].
  SignUpUseCase(this.repository);

  /// Executes the sign-up logic.
  ///
  /// Accepts an email and password, and calls the repository to perform the sign-up.
  /// Returns a [Result] that contains the signed-up [UserEntity] on success or a [DataError] on failure.
  Future<Result<UserEntity, DataError>> execute(
      String email, String password) async {
    return await repository.signUp(email, password);
  }
}
