import 'package:transsectes_app/app/features/auth/domain/entities/user_entity.dart';
import 'package:transsectes_app/app/features/auth/domain/repositories/auth_repository.dart';
import 'package:transsectes_app/app/core/errors/data_error.dart';
import 'package:transsectes_app/app/core/results/result.dart';

/// Use case for signing in a user.
///
/// This class defines the logic for the sign-in operation, interacting with the
/// [AuthRepository] to perform the sign-in action. It returns a [Result] containing
/// either the authenticated [UserEntity] or a [DataError] if the operation fails.
class SignInUseCase {
  final AuthRepository repository;

  /// Constructor for the use case, accepts an instance of the [AuthRepository].
  SignInUseCase(this.repository);

  /// Executes the sign-in logic.
  ///
  /// Accepts an email and password, and calls the repository to perform the sign-in.
  /// Returns a [Result] that contains a [UserEntity] on success or a [DataError] on failure.
  Future<Result<UserEntity, DataError>> execute(
      String email, String password) async {
    return await repository.signIn(email, password);
  }
}
