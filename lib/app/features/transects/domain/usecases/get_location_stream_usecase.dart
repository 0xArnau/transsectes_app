import 'package:transsectes_app/app/features/transects/domain/entities/geo_point_entity.dart';
import 'package:transsectes_app/app/features/transects/domain/repositories/geolocation_repository.dart';
import 'package:transsectes_app/app/core/errors/data_error.dart';
import 'package:transsectes_app/app/core/results/result.dart';

/// Use case for getting a stream of location updates.
///
/// This class defines the logic for fetching location updates as a stream of [GeoPointEntity] objects,
/// interacting with the [GeolocationRepository]. It returns a [Result] containing either the stream of
/// [GeoPointEntity] or a [DataError] if the operation fails.
class GetLocationStreamUseCase {
  final GeolocationRepository repository;

  /// Constructor for the use case, accepts an instance of the [GeolocationRepository].
  GetLocationStreamUseCase(this.repository);

  /// Executes the logic for getting a stream of location updates.
  ///
  /// Returns a [Result] containing the [Stream<GeoPointEntity?>] on success or a [DataError] on failure.
  Future<Result<Stream<GeoPointEntity?>, DataError>> execute() async {
    try {
      final positionStream = await repository.positionStream();
      return Result.success(positionStream);
    } catch (e) {
      return Result.failure(LocalError(LocalErrorType.unknown));
    }
  }
}
