import 'package:transsectes_app/app/features/transects/domain/repositories/transect_repository.dart';
import 'package:transsectes_app/app/core/errors/data_error.dart';
import 'package:transsectes_app/app/core/results/result.dart';
import 'package:transsectes_app/app/features/transects/domain/entities/transect_entity.dart';

/// Use case for retrieving transects for a specific user.
///
/// This class defines the logic for retrieving transects belonging to a user from the repository.
/// It returns a [Stream] of [Result] containing a [List] of [TransectEntity] on success
/// or an error message on failure.
class GetUserTransectsUseCase {
  final TransectRepository repository;

  /// Constructor for the use case, accepts an instance of the [TransectRepository].
  GetUserTransectsUseCase(this.repository);

  /// Executes the logic to fetch transects of a specific user.
  ///
  /// Accepts a [userEmail] and returns a [Stream] of [Result] with a list of [TransectEntity] on success,
  /// or an error message if the operation fails.
  Stream<Result<List<TransectEntity>, DataError>> execute(String? userEmail) {
    return repository.getUserTransects(userEmail);
  }
}
