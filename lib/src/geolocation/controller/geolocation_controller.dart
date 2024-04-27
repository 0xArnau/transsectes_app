import 'package:location/location.dart';
import 'package:logger/logger.dart';

class GeolocationController {
  static final GeolocationController _instance =
      GeolocationController._internal();

  static final Location location = new Location();

  static late bool _serviceEnabled;
  static late PermissionStatus _permissionGranted;
  static late LocationData _locationData;

  factory GeolocationController() {
    return _instance;
  }
  GeolocationController._internal();

  static Future<void> initialize() async {
    Logger().d("Initialize geolocation service & permission");

    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        Logger().d("1");
        return;
      }
    }

    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        Logger().d("2");
        return;
      }
    }

    _locationData = await Location().getLocation();

    Logger().d("KLK");
  }

  static bool get serviceEnabled => _serviceEnabled;
  static PermissionStatus get permissionGranted => _permissionGranted;
  static LocationData get locationData => _locationData;

  static Future<LocationData> getLocation() async {
    return await location.getLocation();
  }
}
