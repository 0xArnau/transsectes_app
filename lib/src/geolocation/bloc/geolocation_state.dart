part of 'geolocation_bloc.dart';

sealed class GeolocationState extends Equatable {
  const GeolocationState();
  
  @override
  List<Object> get props => [];
}

final class GeolocationInitial extends GeolocationState {}
