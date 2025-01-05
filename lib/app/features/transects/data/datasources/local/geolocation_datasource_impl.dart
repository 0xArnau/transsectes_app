import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:geolocator/geolocator.dart';
import 'package:transsectes_app/app/features/transects/domain/datasources/geolocation_datasource.dart';
import 'package:transsectes_app/app/features/transects/domain/entities/geo_point_entity.dart';
import 'package:transsectes_app/generated/l10n.dart';

/// Implementation of the `GeolocationDataSource` interface.
///
/// This class implements methods to get the current position and listen to
/// location updates. It uses the `geolocator` package to access the device's
/// location services.
class GeolocationDatasourceImpl implements GeolocationDataSource {
  @override
  Future<GeoPointEntity> getCurrentPosition() async {
    final position = await Geolocator.getCurrentPosition(
      locationSettings: _getLocationSettings(),
    );

    return GeoPointEntity(
      latitude: position.latitude,
      longitude: position.longitude,
    );
  }

  @override
  Stream<GeoPointEntity?> positionStream() {
    LocationSettings locationSettings = _getLocationSettings();

    return Geolocator.getPositionStream(
      locationSettings: locationSettings,
    ).map((Position? position) => position == null
        ? null
        : GeoPointEntity(
            latitude: position.latitude,
            longitude: position.longitude,
          ));
  }

  /// Private helper function that determines the appropriate `LocationSettings`
  /// based on the current platform.
  ///
  /// Returns the `LocationSettings` configured for Android, iOS/macOS, or
  /// default platform settings.
  LocationSettings _getLocationSettings() {
    LocationSettings locationSettings;

    if (defaultTargetPlatform == TargetPlatform.android) {
      locationSettings = AndroidSettings(
        accuracy: LocationAccuracy.high,
        // the minimum distance (measured in meters) a device must
        // move horizontally before an update event is generated;
        distanceFilter: 1,
        forceLocationManager: true,
        intervalDuration: const Duration(seconds: 10),
        foregroundNotificationConfig: ForegroundNotificationConfig(
          notificationText: S.current.appRunningInBackground,
          notificationTitle: S.current.locationService,
          enableWakeLock: true,
        ),
      );
    } else if (defaultTargetPlatform == TargetPlatform.iOS ||
        defaultTargetPlatform == TargetPlatform.macOS) {
      locationSettings = AppleSettings(
        accuracy: LocationAccuracy.high,
        activityType: ActivityType.fitness,
        distanceFilter: 100,
        pauseLocationUpdatesAutomatically: true,
        showBackgroundLocationIndicator: false,
      );
    } else {
      locationSettings = const LocationSettings(
        accuracy: LocationAccuracy.high,
        distanceFilter: 100,
      );
    }

    return locationSettings;
  }
}
