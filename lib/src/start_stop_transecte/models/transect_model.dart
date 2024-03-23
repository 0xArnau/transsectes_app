import 'package:google_maps_flutter/google_maps_flutter.dart';

class TransectModel {
  String observations;

  String createdAt;

  String createdBy;

  List<LatLng> coordinates;

  bool tractor;

  int informedPeople;

  TransectModel({
    required this.createdAt,
    required this.createdBy,
    required this.coordinates,
    required this.tractor,
    required this.informedPeople,
    required this.observations,
  });
}
