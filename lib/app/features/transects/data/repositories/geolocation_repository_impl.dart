import 'package:geocoding/geocoding.dart';
import 'package:transsectes_app/app/features/transects/domain/entities/geo_point_entity.dart';
import 'package:transsectes_app/app/features/transects/domain/datasources/geolocation_datasource.dart';
import 'package:transsectes_app/app/features/transects/domain/datasources/permission_datasource.dart';
import 'package:transsectes_app/app/features/transects/domain/datasources/geocoding_datasource.dart';
import 'package:transsectes_app/app/features/transects/domain/repositories/geolocation_repository.dart';
import 'package:transsectes_app/generated/l10n.dart';

/// Implementation of the `GeolocationRepository` interface.
///
/// This class interacts with the GeolocationDataSource, PermissionDataSource, and
/// GeocodingDataSource to provide a unified interface for geolocation operations.
class GeolocationRepositoryImpl implements GeolocationRepository {
  final GeolocationDataSource geolocationDataSource;
  final PermissionDataSource permissionDataSource;
  final GeocodingDataSource geocodingDataSource;

  GeolocationRepositoryImpl({
    required this.geolocationDataSource,
    required this.permissionDataSource,
    required this.geocodingDataSource,
  });

  @override
  Future<GeoPointEntity> getCurrentPosition() async {
    // First, ensure the necessary permissions are granted
    final hasPermission = await requestLocationPermissions();
    if (!hasPermission) {
      throw Exception(S.current.locationPermissionsNotGranted);
    }

    // Fetch the current position from the geolocation data source
    return await geolocationDataSource.getCurrentPosition();
  }

  @override
  Future<Stream<GeoPointEntity?>> positionStream() async {
    // First, ensure the necessary permissions are granted
    final hasPermission = await requestLocationPermissions();
    if (!hasPermission) {
      throw Exception(S.current.locationPermissionsNotGranted);
    }
    // Return the location stream from the geolocation data source
    return geolocationDataSource.positionStream();
  }

  @override
  Future<bool> requestLocationPermissions() async {
    // Request foreground and background location permissions
    bool foregroundPermission =
        await permissionDataSource.requestLocationForegroundPermission();
    bool backgroundPermission =
        await permissionDataSource.requestLocationBackgroundPermission();

    return foregroundPermission && backgroundPermission;
  }

  @override
  Future<Placemark> getAddressFromCoordinates(
      double latitude, double longitude) async {
    // Use the geocoding data source to fetch the address based on coordinates
    return await geocodingDataSource.getAddressFromCoordinates(
      latitude,
      longitude,
    );
  }
}
