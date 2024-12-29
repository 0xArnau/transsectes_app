import 'package:transsectes_app/app/features/transects/domain/entities/geo_point_entity.dart';
import 'package:transsectes_app/app/features/transects/domain/repositories/geolocation_repository.dart';
import 'package:transsectes_app/app/core/errors/data_error.dart';
import 'package:transsectes_app/app/core/results/result.dart';

/// Use case for fetching the current device position.
///
/// This class defines the logic for retrieving the current position of the device,
/// interacting with the [GeolocationRepository] to perform the action.
/// It returns a [Result] containing either the [GeoPointEntity] or a [DataError] if the operation fails.
class GetCurrentPositionUseCase {
  final GeolocationRepository repository;

  /// Constructor for the use case, accepts an instance of the [GeolocationRepository].
  GetCurrentPositionUseCase(this.repository);

  /// Executes the logic for getting the current position.
  ///
  /// Returns a [Result] containing a [GeoPointEntity] on success or a [DataError] on failure.
  Future<Result<GeoPointEntity, DataError>> execute() async {
    try {
      final position = await repository.getCurrentPosition();
      return Result.success(position);
    } catch (e) {
      return Result.failure(LocalError(LocalErrorType.unknown));
    }
  }
}
