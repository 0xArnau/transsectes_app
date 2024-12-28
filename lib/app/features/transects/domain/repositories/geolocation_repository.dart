import 'package:transsectes_app/app/features/transects/domain/entities/geo_point_entity.dart';
import 'package:geocoding/geocoding.dart';

/// Interface for handling geolocation operations, including fetching current location,
/// streaming location updates, handling location permissions, and reverse geocoding.
abstract class GeolocationRepository {
  /// Fetches the current position of the device as a `GeoPointEntity`.
  ///
  /// Returns the current position or throws an error if location is unavailable.
  Future<GeoPointEntity> getCurrentPosition();

  /// Returns a stream of location updates as `GeoPointEntity` objects.
  ///
  /// The stream emits the latest location periodically based on the settings.
  Future<Stream<GeoPointEntity?>> positionStream();

  /// Requests the necessary permissions for accessing location.
  ///
  /// Returns `true` if permissions are granted, otherwise `false`.
  Future<bool> requestLocationPermissions();

  /// Gets the address corresponding to the given latitude and longitude.
  ///
  /// Returns a `Placemark` containing the address details for the provided coordinates.
  Future<Placemark> getAddressFromCoordinates(
    double latitude,
    double longitude,
  );
}
