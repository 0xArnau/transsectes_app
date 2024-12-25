import 'package:transsectes_app/app/features/transects/domain/repositories/transect_repository.dart';
import 'package:transsectes_app/app/core/errors/data_error.dart';
import 'package:transsectes_app/app/core/results/result.dart';
import 'package:transsectes_app/app/features/transects/domain/entities/transect_entity.dart';

/// Use case for retrieving all transects.
///
/// This class defines the logic for retrieving all transects from the repository.
/// It returns a [Stream] of [Result] containing a [List] of [TransectEntity] on success
/// or an error message on failure.
class GetAllTransectsUseCase {
  final TransectRepository repository;

  /// Constructor for the use case, accepts an instance of the [TransectRepository].
  GetAllTransectsUseCase(this.repository);

  /// Executes the logic to fetch all transects.
  ///
  /// Returns a [Stream] of [Result] with a list of [TransectEntity] on success,
  /// or an error message if the operation fails.
  Stream<Result<List<TransectEntity>, DataError>> execute() {
    return repository.getAllTransects();
  }
}
