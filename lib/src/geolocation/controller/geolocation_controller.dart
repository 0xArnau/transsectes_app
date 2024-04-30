import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:geolocator/geolocator.dart';
import 'package:logger/logger.dart';
import 'package:permission_handler/permission_handler.dart';

class GeolocationController {
  static final GeolocationController _instance =
      GeolocationController._internal();

  static late bool _serviceEnabled;
  static late LocationPermission _permission;

  factory GeolocationController() {
    return _instance;
  }
  GeolocationController._internal();

  static Future<void> initialize() async {
    Logger().d("Initialize geolocation service & _permission");

    // Test if location services are enabled.
    _serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!_serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      Logger().e('Location services are disabled.');
      return Future.error('Location services are disabled.');
    }

    _permission = await Geolocator.checkPermission();
    if (_permission == LocationPermission.denied) {
      _permission = await Geolocator.requestPermission();
      if (_permission == LocationPermission.denied) {
        // _permissions are denied, next time you could try
        // requesting _permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now.
        Logger().e('Location permissions are denied');
        return Future.error('Location permissions are denied');
      }
    }

    if (_permission == LocationPermission.deniedForever) {
      // _permissions are denied forever, handle appropriately.
      Logger().e(
          'Location permissions are permanently denied, we cannot request permissions.');
      return Future.error(
        'Location permissions are permanently denied, we cannot request permissions.',
      );
    }

    Logger().d([
      _serviceEnabled,
      _permission,
    ]);
  }

  static bool get serviceEnabled => _serviceEnabled;
  static LocationPermission get permission => _permission;

  static Future<GeoPoint> getLocation() async {
    if (!_serviceEnabled ||
        _permission == LocationPermission.denied ||
        _permission == LocationPermission.deniedForever) {
      return Future.error(
        "Error: service enabled? $_serviceEnabled, permissions status: $_permission",
      );
    }

    Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );

    return GeoPoint(position.latitude, position.longitude);
  }

  static Future<bool> foregroundGeolocationPermission() async {
    Logger().d("ForegroundGeolocationPermission");

    if (!await Permission.locationWhenInUse.serviceStatus.isEnabled) {
      Logger().d("Foreground geolocation service is not enabled");

      return false;
      // return Future.error("Foreground geolocation service is not enabled");
    }

    final PermissionStatus status = await Permission.location.request();

    if (status != PermissionStatus.granted) {
      return false;
      // return Future.error("Error: foreground geolocation is not granted");
    }

    return true;
  }

  static Future<bool> backgroundGeolocationPermission() async {
    final PermissionStatus status = await Permission.locationAlways.request();

    if (status != PermissionStatus.granted) {
      return false;
      // return Future.error("Error: background geolocation is not granted");
    }

    return true;
  }

  static Future<List<bool>> checkGeolocationPermissions() async {
    final bool foreground = await Permission.location.isGranted;
    final bool background = await Permission.locationAlways.isGranted;

    return [foreground, background];
  }
}
