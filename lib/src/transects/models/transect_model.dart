import 'package:cloud_firestore/cloud_firestore.dart';

class TransectModel {
  String observations;

  Timestamp createdAt;

  String createdBy;

  List<GeoPoint> coordinates;

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

  static TransectModel fromSnapshot(DocumentSnapshot snap) {
    var points = <GeoPoint>[];

    for (var element in snap['coordinates']) {
      points.add(GeoPoint(element.latitude, element.longitude));
    }

    TransectModel data = TransectModel(
      createdAt: snap['createdAt'],
      createdBy: snap['createdBy'],
      coordinates: points,
      tractor: snap['tractor'],
      informedPeople: snap['informedPeople'],
      observations: snap['observations'],
    );

    return data;
  }

  Map<String, Object> toDocument() {
    return {
      'createdAt': createdAt,
      'createdBy': createdBy,
      'coordinates': coordinates,
      'tractor': tractor,
      'informedPeople': informedPeople,
      'observations': observations,
    };
  }
}
