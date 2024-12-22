import 'package:transsectes_app/app/features/auth/domain/repositories/auth_repository.dart';
import 'package:transsectes_app/app/core/errors/data_error.dart';
import 'package:transsectes_app/app/core/results/result.dart';

/// Use case for checking if the user is authenticated.
class IsUserAuthenticatedUseCase {
  final AuthRepository repository;

  /// Constructor for the use case, accepts an instance of the [AuthRepository].
  ///
  /// [repository] The authentication repository used to check the user's authentication status.
  IsUserAuthenticatedUseCase(this.repository);

  /// Executes the use case to check if the user is authenticated.
  ///
  /// Returns a [Result] containing a [bool] indicating whether the user is authenticated
  /// or a [DataError] if the operation fails.
  Result<bool, DataError> execute() {
    return repository.isUserAuthenticated();
  }
}
