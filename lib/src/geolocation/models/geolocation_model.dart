import 'package:cloud_firestore/cloud_firestore.dart';

class GeolocationModel {
  final List<GeoPoint> geopoint;

  const GeolocationModel({this.geopoint = const <GeoPoint>[]});
}
