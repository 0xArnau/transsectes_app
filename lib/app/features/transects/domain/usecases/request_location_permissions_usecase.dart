import 'package:transsectes_app/app/core/errors/data_error.dart';
import 'package:transsectes_app/app/core/results/result.dart';
import 'package:transsectes_app/app/features/transects/domain/repositories/geolocation_repository.dart';

/// Use case for requesting location permissions.
///
/// This class defines the logic for requesting the necessary location permissions
/// to access the device's location, interacting with the [GeolocationRepository].
/// It returns a [Result] containing either `true` if permissions are granted or a [DataError] if the operation fails.
class RequestLocationPermissionsUseCase {
  final GeolocationRepository repository;

  /// Constructor for the use case, accepts an instance of the [GeolocationRepository].
  RequestLocationPermissionsUseCase(this.repository);

  /// Executes the logic for requesting location permissions.
  ///
  /// Returns a [Result] containing `true` if permissions are granted or a [DataError] if permissions are not granted.
  Future<Result<bool, DataError>> execute() async {
    final permissionsGranted = await repository.requestLocationPermissions();
    return Result.success(permissionsGranted);
  }
}
