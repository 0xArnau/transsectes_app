import 'package:cloud_firestore/cloud_firestore.dart';

class TransectModel {
  String observations;

  Timestamp createdAt;

  String createdBy;

  List<GeoPoint> coordinates;

  bool tractor;

  int informedPeople;

  /// The administrative area where the report was made.
  String administrativeAreaFirst;

  /// The sub-administrative area where the report was made.
  String subAdministrativeAreaFirst;

  /// The locality where the report was made.
  String localityFirst;

  /// The administrative area where the report was made.
  String administrativeAreaLast;

  /// The sub-administrative area where the report was made.
  String subAdministrativeAreaLast;

  /// The locality where the report was made.
  String localityLast;

  TransectModel({
    required this.createdAt,
    required this.createdBy,
    required this.coordinates,
    required this.tractor,
    required this.informedPeople,
    required this.observations,
    required this.administrativeAreaFirst,
    required this.administrativeAreaLast,
    required this.localityFirst,
    required this.localityLast,
    required this.subAdministrativeAreaFirst,
    required this.subAdministrativeAreaLast,
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
      administrativeAreaFirst: snap['administrativeAreaFirst'],
      administrativeAreaLast: snap['administrativeAreaLast'],
      localityFirst: snap['localityFirst'],
      localityLast: snap['localityLast'],
      subAdministrativeAreaFirst: snap['subAdministrativeAreaFirst'],
      subAdministrativeAreaLast: snap['subAdministrativeAreaLast'],
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
      'administrativeAreaFirst': administrativeAreaFirst,
      'administrativeAreaLast': administrativeAreaLast,
      'subAdministrativeAreaFirst': subAdministrativeAreaFirst,
      'subAdministrativeAreaLast': subAdministrativeAreaLast,
      'localityFirst': localityFirst,
      'localityLast': localityLast,
    };
  }
}
