import 'package:cloud_firestore/cloud_firestore.dart';

/// Entity representing geographical coordinates.
class GeoPointEntity {
  /// The latitude of the geographical point.
  final double latitude;

  /// The longitude of the geographical point.
  final double longitude;

  /// Constructor for creating a [GeoPointEntity].
  GeoPointEntity({required this.latitude, required this.longitude});

  /// Converts a list of [GeoPointEntity] to a list of [GeoPoint].
  static List<GeoPoint> toGeoPointList(List<GeoPointEntity> geopoints) {
    return geopoints.map((e) => GeoPoint(e.latitude, e.longitude)).toList();
  }

  /// Converts the current [GeoPointEntity] instance to a [GeoPoint].
  GeoPoint toGeoPoint() {
    return GeoPoint(latitude, longitude);
  }
}
