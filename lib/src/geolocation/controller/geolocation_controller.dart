import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:logger/logger.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:transsectes_app/generated/l10n.dart';

class GeolocationController {
  static final GeolocationController _instance =
      GeolocationController._internal();

  static late bool _serviceEnabled;
  static late LocationPermission _permission;
  static late LocationSettings _locationSettings;

  static const int distanceFilter = 1;

  factory GeolocationController() {
    return _instance;
  }
  GeolocationController._internal();

  static Future<void> initialize() async {
    Logger().d("Initialize location settings");

    if (defaultTargetPlatform == TargetPlatform.android) {
      _locationSettings = AndroidSettings(
          accuracy: LocationAccuracy.high,
          distanceFilter: distanceFilter,
          forceLocationManager: true,
          intervalDuration: const Duration(seconds: 10),
          //(Optional) Set foreground notification config to keep the app alive
          //when going to the background
          foregroundNotificationConfig: ForegroundNotificationConfig(
            notificationText: S.current.app_background_notification_text,
            notificationTitle: S.current.app_background_notification_title,
            enableWakeLock: true,
          ));
    } else if (defaultTargetPlatform == TargetPlatform.iOS ||
        defaultTargetPlatform == TargetPlatform.macOS) {
      _locationSettings = AppleSettings(
        accuracy: LocationAccuracy.high,
        activityType: ActivityType.fitness,
        distanceFilter: distanceFilter,
        pauseLocationUpdatesAutomatically: true,
        // Only set to true if our app will be started up in the background.
        showBackgroundLocationIndicator: false,
      );
    } else {
      _locationSettings = const LocationSettings(
        accuracy: LocationAccuracy.high,
        distanceFilter: distanceFilter,
      );
    }

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

  /// Updates the user's address based on the current [LatLng].
  ///
  /// The [provider] is the instance of the [UserProvider] that holds the current user's [UserProvider.position].
  ///
  /// Returns a [List] of [String] containing the administrativeArea, subAdministrativeArea, and locality, or empty strings if an error occurs.
  Future<List<String>> getAddress(List<GeoPoint> geopoints) async {
    Logger().d("Get addresses");
    try {
      List<Placemark> first = await placemarkFromCoordinates(
        geopoints[0].latitude,
        geopoints[0].longitude,
      );

      List<Placemark> last = await placemarkFromCoordinates(
        geopoints[geopoints.length - 1].latitude,
        geopoints[geopoints.length - 1].longitude,
      );

      String administrativeAreaFirst = first[0].administrativeArea ?? "";
      String subAdministrativeAreaFirst = first[0].subAdministrativeArea ?? "";
      String localityFirst = first[0].locality ?? "";

      String administrativeAreaLast = last[0].administrativeArea ?? "";
      String subAdministrativeAreaLast = last[0].subAdministrativeArea ?? "";
      String localityLast = last[0].locality ?? "";

      Logger().d([
        "First",
        geopoints[0].latitude,
        geopoints[0].longitude,
        administrativeAreaFirst,
        subAdministrativeAreaFirst,
        localityFirst,
      ]);

      Logger().d([
        "Lasst",
        geopoints[geopoints.length - 1].latitude,
        geopoints[geopoints.length - 1].longitude,
        administrativeAreaLast,
        subAdministrativeAreaLast,
        localityLast,
      ]);

      return [
        administrativeAreaFirst,
        subAdministrativeAreaFirst,
        localityFirst,
        administrativeAreaLast,
        subAdministrativeAreaLast,
        localityLast,
      ];
    } catch (e) {
      Logger().e(e);
      return ['', '', '', '', '', ''];
    }
  }

  Stream<Position> positionStream() {
    Logger().d("positionStream");
    return Geolocator.getPositionStream(locationSettings: _locationSettings);
  }
}
