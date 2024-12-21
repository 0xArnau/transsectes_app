import 'package:transsectes_app/app/features/auth/domain/entities/user_entity.dart';
import 'package:transsectes_app/app/features/auth/domain/repositories/auth_repository.dart';
import 'package:transsectes_app/app/shared/domain/data_error.dart';
import 'package:transsectes_app/app/shared/domain/result.dart';

/// Use case for getting the current authenticated user.
class GetCurrentUserUseCase {
  final AuthRepository repository;

  /// Constructor for the use case, accepts an instance of the [AuthRepository].
  ///
  /// [repository] The authentication repository used to retrieve the current user.
  GetCurrentUserUseCase(this.repository);

  /// Executes the use case to fetch the current authenticated user.
  ///
  /// Returns a [Result] containing the [UserEntity] in case of success or a [DataError]
  /// if the operation fails.
  Result<UserEntity, DataError> execute() {
    return repository.getCurrentUser();
  }
}
