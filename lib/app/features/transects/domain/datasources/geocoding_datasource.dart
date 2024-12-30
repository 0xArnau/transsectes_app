import 'package:geocoding/geocoding.dart';

/// Interface for reverse geocoding operations.
///
/// This interface defines a method for obtaining a `Placemark` from latitude
/// and longitude coordinates, typically used to get a human-readable address.
abstract class GeocodingDataSource {
  /// Gets the address (Placemark) for the given coordinates (latitude, longitude).
  ///
  /// Returns the first `Placemark` from the geocoding results.
  Future<Placemark> getAddressFromCoordinates(
    double latitude,
    double longitude,
  );
}
