import 'package:transsectes_app/app/features/transects/domain/repositories/transect_repository.dart';
import 'package:transsectes_app/app/core/errors/data_error.dart';
import 'package:transsectes_app/app/core/results/result.dart';

/// Use case for removing all transects.
///
/// This class defines the logic for clearing all transects from the repository.
/// It returns a [Result] containing `void` on success or an error message on failure.
class RemoveAllTransectsUseCase {
  final TransectRepository repository;

  /// Constructor for the use case, accepts an instance of the [TransectRepository].
  RemoveAllTransectsUseCase(this.repository);

  /// Executes the logic to remove all transects.
  ///
  /// Calls the repository to remove all transects.
  /// Returns a [Result] indicating success or failure.
  Future<Result<void, DataError>> execute() async {
    return await repository.removeAllTransects();
  }
}
