part of 'geolocation_bloc.dart';

sealed class GeolocationEvent extends Equatable {
  const GeolocationEvent();

  @override
  List<Object> get props => [];
}

final class LoadGeolocation extends GeolocationEvent {}

final class ResetGeolocation extends GeolocationEvent {}

final class StartBackgroundGeolocation extends GeolocationEvent {}

final class AddGeolocationPoint extends GeolocationEvent {
  final GeoPoint geoPoint;

  const AddGeolocationPoint({required this.geoPoint});

  @override
  List<Object> get props => [geoPoint];
}

final class AddCurrentGeolocationPoint extends GeolocationEvent {}

final class CheckoutGeolocationService extends GeolocationEvent {}

final class RequestForegroundGeolocation extends GeolocationEvent {}

final class RequestBackgroundGeolocation extends GeolocationEvent {}
