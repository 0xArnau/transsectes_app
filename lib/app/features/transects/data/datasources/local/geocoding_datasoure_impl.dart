import 'package:geocoding/geocoding.dart';
import 'package:transsectes_app/app/features/transects/domain/datasources/geocoding_datasource.dart';

/// Implementation of the `GeocodingDataSource` interface.
///
/// This class implements the method to perform reverse geocoding using the
/// `placemarkFromCoordinates` function from the `geocoding` package.
class GeocodingDatasourceImpl implements GeocodingDataSource {
  @override
  Future<Placemark> getAddressFromCoordinates(
      double latitude, double longitude) async {
    return (await placemarkFromCoordinates(latitude, longitude))[0];
  }
}
