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
  TransectModel transect;

  String observations;
  Timestamp createdAt;
  String createdBy;
  List<GeoPoint> coordinates;
  bool tractor;
  int informedPeople;

  TransectStopped({
    required this.observations,
    required this.createdAt,
    required this.createdBy,
    required this.coordinates,
    required this.tractor,
    required this.informedPeople,
  }) : this.transect = TransectModel(
          createdAt: createdAt,
          createdBy: createdBy,
          coordinates: coordinates,
          tractor: tractor,
          informedPeople: informedPeople,
          observations: observations,
        );

  @override
  List<Object> get props => [transect];
}

/// Loads the previous transect
final class TransectLoaded extends TransectState {
  final List<TransectModel> transects;

  TransectLoaded({required this.transects});

  @override
  List<Object> get props => [transects];
}
