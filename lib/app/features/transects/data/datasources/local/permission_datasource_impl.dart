import 'package:geolocator/geolocator.dart';
import 'package:logger/logger.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:transsectes_app/app/features/transects/domain/datasources/permission_datasource.dart';
import 'package:transsectes_app/app/features/transects/domain/exceptions/gps_exception.dart';

/// Implementation of the `PermissionDataSource` interface.
///
/// This class implements the methods to request location permissions and
/// handle GPS service status, using the `permission_handler` package.
class PermissionDatasourceImpl implements PermissionDataSource {
  @override
  Future<bool> requestGpsServiceEnabled() async {
    final serviceEnabled = await Geolocator.isLocationServiceEnabled();

    if (!serviceEnabled) {
      throw GpsServiceDisabled(
          'GPS service is disabled, please enable it before continuing');
    }

    return true;
  }

  @override
  Future<bool> requestLocationBackgroundPermission() async {
    await requestGpsServiceEnabled();

    final permission = await Permission.locationAlways.isGranted;

    if (permission) return permission;

    /// When requesting the 'location always' permission directly,
    /// or when requesting both permissions at the same time,
    /// the system will ignore the request.
    /// So, instead of calling only Permission.location.request(),
    /// make sure to first call either Permission.location.request()
    /// or Permission.locationWhenInUse.request(), and obtain permission
    /// to read the GPS. Once you obtain this permission, you can call
    /// Permission.locationAlways.request().
    await requestLocationForegroundPermission();

    final request = await Permission.locationAlways.request();

    Logger().d(request);

    if (request.isPermanentlyDenied) {
      Logger().e(request);
      throw PermanentlyDeniedException(
          'Location background permissions is permanently denied');
    }

    return request.isGranted;
  }

  @override
  Future<bool> requestLocationForegroundPermission() async {
    final permission = await Permission.locationWhenInUse.isGranted;

    if (permission) return permission;

    return (await Permission.locationWhenInUse.request()).isGranted;
  }

  @override
  Future<bool> requestLocationPermission() async {
    final permission = await Permission.location.isGranted;

    if (permission) return permission;

    return (await Permission.location.request()).isGranted;
  }
}
