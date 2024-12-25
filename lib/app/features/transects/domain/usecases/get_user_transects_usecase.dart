import 'package:logger/logger.dart';
import 'package:transsectes_app/app/features/transects/domain/repositories/transect_repository.dart';
import 'package:transsectes_app/app/core/errors/data_error.dart';
import 'package:transsectes_app/app/core/results/result.dart';
import 'package:transsectes_app/app/features/transects/domain/entities/transect_entity.dart';

/// Use case for retrieving transects created by a specific user from the repository.
///
/// This class encapsulates the logic for retrieving transects belonging to a specific user.
/// It interacts with the [TransectRepository] to fetch the user's transects and returns a [Stream] of [Result],
/// which contains either:
/// - A [List] of [TransectEntity] on success.
/// - A [DataError] on failure.
class GetUserTransectsUseCase {
  final TransectRepository repository;

  /// Constructor for the use case, accepts an instance of the [TransectRepository].
  ///
  /// [repository]: The repository to fetch the transects from.
  GetUserTransectsUseCase(this.repository);

  /// Executes the logic to fetch the transects belonging to a specific user.
  ///
  /// [userEmail]: The email of the user whose transects should be fetched.
  ///
  /// Returns a [Result] that contains:
  /// - A [Stream] of [List<TransectEntity>] on success.
  /// - A [DataError] on failure.
  ///
  /// This method provides a reactive stream, allowing the caller to listen for changes in the user's transects.
  Result<Stream<List<TransectEntity>>, DataError> execute(String? userEmail) {
    return repository.getUserTransects(userEmail);
  }
}
