import 'package:cloud_firestore/cloud_firestore.dart';

/// Represents a transect entity containing geographical and contextual data
/// about an observation or event.
class TransectEntity {
  /// Observations or notes related to the transect.
  final String observations;

  /// The timestamp when the transect was created.
  final Timestamp createdAt;

  /// The timestamp when the transect was last updated, if any.
  final Timestamp? updatedAt;

  /// The identifier of the user who created the transect.
  final String createdBy;

  /// A list of geographical points representing the transect path.
  final List<GeoPoint> coordinates;

  /// Indicates whether a tractor was used in the transect.
  final bool tractor;

  /// The number of people informed during the transect.
  final int informedPeople;

  /// The first administrative area related to the transect's start point.
  final String administrativeAreaFirst;

  /// The first sub-administrative area related to the transect's start point.
  final String subAdministrativeAreaFirst;

  /// The locality related to the transect's start point.
  final String localityFirst;

  /// The last administrative area related to the transect's end point.
  final String administrativeAreaLast;

  /// The last sub-administrative area related to the transect's end point.
  final String subAdministrativeAreaLast;

  /// The locality related to the transect's end point.
  final String localityLast;

  /// Constructs a [TransectEntity] with the provided data.
  TransectEntity({
    required this.createdAt,
    this.updatedAt,
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

  /// Creates a [TransectEntity] from a Firestore document snapshot.
  ///
  /// This method converts Firestore data into a [TransectEntity] object.
  /// It parses the coordinates as a list of [GeoPoint].
  ///
  /// - [documentSnapshot]: The Firestore document snapshot.
  static TransectEntity fromSnapshot(DocumentSnapshot documentSnapshot) {
    var points = <GeoPoint>[];

    for (var element in documentSnapshot['coordinates']) {
      points.add(GeoPoint(element.latitude, element.longitude));
    }

    return TransectEntity(
      createdAt: documentSnapshot['createdAt'],
      // updatedAt: documentSnapshot['updatedAt'], // Ignorar temporalmente porque los transects que hay en la db no contienen esto y peta
      createdBy: documentSnapshot['createdBy'],
      coordinates: points,
      tractor: documentSnapshot['tractor'],
      informedPeople: documentSnapshot['informedPeople'],
      observations: documentSnapshot['observations'],
      administrativeAreaFirst: documentSnapshot['administrativeAreaFirst'],
      administrativeAreaLast: documentSnapshot['administrativeAreaLast'],
      localityFirst: documentSnapshot['localityFirst'],
      localityLast: documentSnapshot['localityLast'],
      subAdministrativeAreaFirst:
          documentSnapshot['subAdministrativeAreaFirst'],
      subAdministrativeAreaLast: documentSnapshot['subAdministrativeAreaLast'],
    );
  }

  /// Converts the [TransectEntity] into a Firestore-compatible document.
  ///
  /// Returns a map representation of the transect that can be stored
  /// in Firestore.
  Map<String, Object?> toDocument() {
    return {
      'createdAt': createdAt,
      'updatedAt': updatedAt,
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
