import 'package:transsectes_app/app/features/transects/domain/entities/geo_point_entity.dart';

/// Interface for geolocation data source.
///
/// This interface defines the necessary methods for fetching current position
/// and receiving location updates as a stream of `GeoPointEntity` objects.
abstract class GeolocationDataSource {
  /// Fetches the current position of the device.
  ///
  /// Returns a `GeoPointEntity` containing the latitude and longitude.
  Future<GeoPointEntity> getCurrentPosition();

  /// Returns a stream of location updates based on the provided settings.
  ///
  /// The stream emits `GeoPointEntity` objects representing the latitude and
  /// longitude at intervals. If location data is not available, `null` may be returned.
  Stream<GeoPointEntity?> positionStream();
}
