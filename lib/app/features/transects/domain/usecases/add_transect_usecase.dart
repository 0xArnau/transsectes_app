import 'package:transsectes_app/app/features/transects/domain/repositories/transect_repository.dart';
import 'package:transsectes_app/app/core/errors/data_error.dart';
import 'package:transsectes_app/app/core/results/result.dart';
import 'package:transsectes_app/app/features/transects/domain/entities/transect_entity.dart';

/// Use case for adding a new transect.
///
/// This class defines the logic for adding a new transect into the repository.
/// It returns a [Result] containing `void` on success or an error message on failure.
class AddTransectUseCase {
  final TransectRepository repository;

  /// Constructor for the use case, accepts an instance of the [TransectRepository].
  AddTransectUseCase(this.repository);

  /// Executes the logic to add a new transect.
  ///
  /// Accepts a [TransectEntity] and calls the repository to add it.
  /// Returns a [Result] indicating success or failure.
  Future<Result<void, DataError>> execute(TransectEntity transect) async {
    return await repository.addTransect(transect);
  }
}
