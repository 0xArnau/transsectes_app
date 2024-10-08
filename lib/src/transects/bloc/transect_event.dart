part of 'transect_bloc.dart';

sealed class TransectEvent extends Equatable {
  const TransectEvent();

  @override
  List<Object> get props => [];
}

class UpdateGeolocationTransect extends TransectEvent {
  final GeolocationModel coordinates;

  const UpdateGeolocationTransect({required this.coordinates});

  @override
  List<Object> get props => [coordinates];
}

class StartTransect extends TransectEvent {}

class CancelTransect extends TransectEvent {}

class StopTransect extends TransectEvent {
  final bool tractor;
  final int informedPeople;
  final String observations;
  final GeolocationModel geolocationModel;
  final BuildContext context;

  const StopTransect({
    required this.context,
    required this.tractor,
    required this.informedPeople,
    required this.observations,
    required this.geolocationModel,
  });

  @override
  List<Object> get props => [tractor, informedPeople, observations];
}

class LoadTransects extends TransectEvent {}
