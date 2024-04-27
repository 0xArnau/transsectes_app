part of 'geolocation_bloc.dart';

sealed class GeolocationState extends Equatable {
  const GeolocationState();

  @override
  List<Object> get props => [];
}

final class GeolocationInitial extends GeolocationState {}

final class GeolocationLoaded extends GeolocationState {
  final GeolocationModel geolocation;

  const GeolocationLoaded({this.geolocation = const GeolocationModel()});

  @override
  List<Object> get props => [geolocation];
}

final class GeolocationError extends GeolocationState {}
