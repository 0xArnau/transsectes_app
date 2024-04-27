part of 'transect_bloc.dart';

sealed class TransectEvent extends Equatable {
  const TransectEvent();

  @override
  List<Object> get props => [];
}

class UpdateGeolocationTransect extends TransectEvent {
  final List<GeoPoint> coordinates;

  const UpdateGeolocationTransect({this.coordinates = const <GeoPoint>[]});

  @override
  List<Object> get props => coordinates;
}

class StartTransect extends TransectEvent {}

class CancelTransect extends TransectEvent {}

class StopTransect extends TransectEvent {
  final TransectModel transect;

  const StopTransect({required this.transect});

  @override
  List<Object> get props => [transect];
}

class LoadTransects extends TransectEvent {}

class UpdateTransects extends TransectEvent {
  final List<TransectModel> transects;

  const UpdateTransects({required this.transects});

  @override
  List<Object> get props => [transects];
}
