import 'package:transsectes_app/app/features/transects/domain/repositories/transect_repository.dart';
import 'package:transsectes_app/app/core/errors/data_error.dart';
import 'package:transsectes_app/app/core/results/result.dart';
import 'package:transsectes_app/app/features/transects/domain/entities/transect_entity.dart';

/// Use case for updating an existing transect.
///
/// This class defines the logic for updating an existing transect in the repository.
/// It returns a [Result] containing `void` on success or an error message on failure.
class UpdateTransectUseCase {
  final TransectRepository repository;

  /// Constructor for the use case, accepts an instance of the [TransectRepository].
  UpdateTransectUseCase(this.repository);

  /// Executes the logic to update an existing transect.
  ///
  /// Accepts a [TransectEntity] and calls the repository to update the transect.
  /// Returns a [Result] indicating success or failure.
  Future<Result<void, DataError>> execute(TransectEntity transect) async {
    return await repository.updateTransect(transect);
  }
}
