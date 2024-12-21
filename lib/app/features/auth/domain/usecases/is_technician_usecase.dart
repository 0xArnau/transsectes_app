import 'package:transsectes_app/app/features/auth/domain/repositories/auth_repository.dart';
import 'package:transsectes_app/app/shared/domain/data_error.dart';
import 'package:transsectes_app/app/shared/domain/result.dart';

/// Use case for checking if the user is a technician.
///
/// This class defines the logic for checking if the current user is a technician,
/// interacting with the [AuthRepository]. It returns a [Result] containing a [bool]
/// indicating whether the user is a technician or a [DataError] if the operation fails.
class IsTechnicianUseCase {
  final AuthRepository repository;

  /// Constructor for the use case, accepts an instance of the [AuthRepository].
  IsTechnicianUseCase(this.repository);

  /// Executes the logic to check if the user is a technician.
  ///
  /// Accepts an email and calls the repository to check if the user is a technician.
  /// Returns a [Result] containing a [bool] on success or a [DataError] on failure.
  Future<Result<bool, DataError>> execute(String email) async {
    return await repository.isTechnician(email);
  }
}
