import 'package:transsectes_app/app/features/transects/domain/repositories/geolocation_repository.dart';
import 'package:geocoding/geocoding.dart';
import 'package:transsectes_app/app/core/errors/data_error.dart';
import 'package:transsectes_app/app/core/results/result.dart';

/// Use case for fetching an address from coordinates.
///
/// This class defines the logic for retrieving an address based on the latitude and longitude,
/// interacting with the [GeolocationRepository]. It returns a [Result] containing either a [Placemark] or
/// a [DataError] if the operation fails.
class GetAddressFromCoordinatesUseCase {
  final GeolocationRepository repository;

  /// Constructor for the use case, accepts an instance of the [GeolocationRepository].
  GetAddressFromCoordinatesUseCase(this.repository);

  /// Executes the logic for getting an address from coordinates.
  ///
  /// Returns a [Result] containing the [Placemark] on success or a [DataError] on failure.
  Future<Result<Placemark, DataError>> execute(
      double latitude, double longitude) async {
    try {
      final address =
          await repository.getAddressFromCoordinates(latitude, longitude);
      return Result.success(address);
    } catch (e) {
      return Result.failure(LocalError(LocalErrorType.unknown));
    }
  }
}
