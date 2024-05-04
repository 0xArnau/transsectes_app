import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:geolocator/geolocator.dart';
import 'package:logger/logger.dart';
import 'package:transsectes_app/src/geolocation/controller/geolocation_controller.dart';
import 'package:transsectes_app/src/geolocation/models/geolocation_model.dart';

part 'geolocation_event.dart';
part 'geolocation_state.dart';

class GeolocationBloc extends Bloc<GeolocationEvent, GeolocationState> {
  // Add some subscription to location change/background
  bool _foregroundPermission = false, _backgroundPermission = false;
  StreamSubscription? _geolocationBackground;

  GeolocationBloc() : super(const GeolocationInitial()) {
    on<LoadGeolocation>((event, emit) async {
      Logger().d("Bloc (LoadGeolocation) event");

      await GeolocationController.initialize().whenComplete(() async {
        Logger().d("whenComplete");
        final permissions =
            await GeolocationController.checkGeolocationPermissions();

        _foregroundPermission = permissions[0];
        _backgroundPermission = permissions[1];

        return emit(GeolocationLoaded(
          foregroundPermission: _foregroundPermission,
          backgroundPermission: _backgroundPermission,
        ));
      }).onError((error, stackTrace) async {
        Logger().d("onError");

        final permissions =
            await GeolocationController.checkGeolocationPermissions();

        _foregroundPermission = permissions[0];
        _backgroundPermission = permissions[1];

        return emit(GeolocationServiceDisabled(
          foregroundPermission: _foregroundPermission,
          backgroundPermission: _backgroundPermission,
        ));
      });
    });

    on<AddCurrentGeolocationPoint>((event, emit) async {
      add(AddGeolocationPoint(
          geoPoint: await GeolocationController.getLocation()));
    });

    on<AddGeolocationPoint>((event, emit) async {
      Logger().d(
          "Bloc (LoadGeolocation) event: ${event.geoPoint.latitude},${event.geoPoint.longitude}");

      emit(GeolocationLoaded(
        geolocation: GeolocationModel(
          geopoint: List.from((state as GeolocationLoaded).geolocation.geopoint)
            ..add(event.geoPoint),
        ),
        foregroundPermission: _foregroundPermission,
        backgroundPermission: _backgroundPermission,
      ));
    });
    on<ResetGeolocation>((event, emit) {
      Logger().d("Bloc (ResetGeolocation) event");

      _stopGeolocationSubscription();

      emit(GeolocationLoaded(
        geolocation: const GeolocationModel(),
        foregroundPermission: _foregroundPermission,
        backgroundPermission: _backgroundPermission,
      ));
    });

    on<RequestForegroundGeolocation>((event, emit) async {
      Logger().d("Request foreground geolocation");

      final status =
          await GeolocationController.foregroundGeolocationPermission();

      _foregroundPermission = status;

      emit(GeolocationLoaded(
        geolocation: GeolocationModel(
          geopoint:
              List.from((state as GeolocationLoaded).geolocation.geopoint),
        ),
        foregroundPermission: _foregroundPermission,
        backgroundPermission: _backgroundPermission,
      ));
    });

    on<RequestBackgroundGeolocation>((event, emit) async {
      Logger().d("Request background geolocation");

      final status =
          await GeolocationController.backgroundGeolocationPermission();

      _backgroundPermission = status;

      emit(GeolocationLoaded(
        geolocation: GeolocationModel(
          geopoint:
              List.from((state as GeolocationLoaded).geolocation.geopoint),
        ),
        foregroundPermission: _foregroundPermission,
        backgroundPermission: _backgroundPermission,
      ));
    });

    on<StartBackgroundGeolocation>((event, emit) {
      Logger().d("StartBackgroundGeolocation event");
      if (_backgroundPermission) {
        _startGeolocationSubscription();
      }
    });
  }

  void _startGeolocationSubscription() {
    Logger().d("_startGeolocationSubscription");

    _geolocationBackground?.cancel();
    _geolocationBackground = GeolocationController()
        .positionStream()
        .listen((Position position) => add(
              AddGeolocationPoint(
                geoPoint: GeoPoint(position.latitude, position.longitude),
              ),
            ));
  }

  void _stopGeolocationSubscription() {
    Logger().d("_stopGeolocationSubscription");

    _geolocationBackground?.cancel();
  }
}
