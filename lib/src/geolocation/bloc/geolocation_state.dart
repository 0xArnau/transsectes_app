part of 'geolocation_bloc.dart';

sealed class GeolocationState extends Equatable {
  final bool foregroundPermission, backgroundPermission;

  const GeolocationState({
    required this.foregroundPermission,
    required this.backgroundPermission,
  });

  @override
  List<Object> get props => [
        foregroundPermission,
        backgroundPermission,
      ];
}

final class GeolocationInitial extends GeolocationState {
  const GeolocationInitial({
    super.foregroundPermission = false,
    super.backgroundPermission = false,
  });
  @override
  List<Object> get props => [
        super.foregroundPermission,
        super.backgroundPermission,
      ];
}

final class GeolocationLoaded extends GeolocationState {
  final GeolocationModel geolocation;

  const GeolocationLoaded({
    this.geolocation = const GeolocationModel(),
    required super.foregroundPermission,
    required super.backgroundPermission,
  });

  @override
  List<Object> get props => [
        geolocation,
        super.foregroundPermission,
        super.backgroundPermission,
      ];
}

final class GeolocationError extends GeolocationState {
  const GeolocationError({
    required super.foregroundPermission,
    required super.backgroundPermission,
  });

  @override
  List<Object> get props => [
        super.foregroundPermission,
        super.backgroundPermission,
      ];
}
