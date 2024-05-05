part of 'transect_bloc.dart';

sealed class TransectState extends Equatable {
  const TransectState();

  @override
  List<Object> get props => [];
}

final class TransectInitial extends TransectState {}

/// Start a new transect
final class TransectStarted extends TransectState {}

/// Stop the current transect
final class TransectStopped extends TransectState {
  final TransectModel transect;

  final String observations;
  final Timestamp createdAt;
  final String createdBy;
  final List<GeoPoint> coordinates;
  final bool tractor;
  final int informedPeople;

  // First:
  //  (0) - administrativeArea
  //  (1) - subAdministrativeArea
  //  (2) - locality
  // Last:
  //  (3) - administrativeArea
  //  (4) - subAdministrativeArea
  //  (5) - locality
  final List<String> addresses;

  TransectStopped({
    required this.observations,
    required this.createdAt,
    required this.createdBy,
    required this.coordinates,
    required this.tractor,
    required this.informedPeople,
    required this.addresses,
  }) : transect = TransectModel(
          createdAt: createdAt,
          createdBy: createdBy,
          coordinates: coordinates,
          tractor: tractor,
          informedPeople: informedPeople,
          observations: observations,
          administrativeAreaFirst: addresses[0],
          administrativeAreaLast: addresses[3],
          subAdministrativeAreaFirst: addresses[1],
          subAdministrativeAreaLast: addresses[4],
          localityFirst: addresses[2],
          localityLast: addresses[5],
        );

  @override
  List<Object> get props => [transect];
}
