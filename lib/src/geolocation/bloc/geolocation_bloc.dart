import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:logger/logger.dart';
import 'package:transsectes_app/src/geolocation/controller/geolocation_controller.dart';
import 'package:transsectes_app/src/geolocation/models/geolocation_model.dart';

part 'geolocation_event.dart';
part 'geolocation_state.dart';

class GeolocationBloc extends Bloc<GeolocationEvent, GeolocationState> {
  // Add some subscription to location change/background
  bool? foregrounPermission, backgroundPermision;

  GeolocationBloc() : super(const GeolocationInitial()) {
    on<LoadGeolocation>((event, emit) async {
      Logger().d("Bloc (LoadGeolocation) event");

      await GeolocationController.initialize().whenComplete(() async {
        Logger().d("whenComplete");
        final permissions =
            await GeolocationController.checkGeolocationPermissions();

        foregrounPermission = permissions[0];
        backgroundPermision = permissions[1];

        return emit(GeolocationLoaded(
          foregroundPermission: foregrounPermission ?? false,
          backgroundPermission: backgroundPermision ?? false,
        ));
      }).onError((error, stackTrace) async {
        Logger().d("onError");

        final permissions =
            await GeolocationController.checkGeolocationPermissions();

        foregrounPermission = permissions[0];
        backgroundPermision = permissions[1];

        return emit(GeolocationServiceDisabled(
          foregroundPermission: foregrounPermission ?? false,
          backgroundPermission: backgroundPermision ?? false,
        ));
      });
    });
    on<AddGeolocationPoint>((event, emit) async {
      Logger().d("Bloc (LoadGeolocation) event");

      emit(GeolocationLoaded(
        geolocation: GeolocationModel(
          geopoint: List.from((state as GeolocationLoaded).geolocation.geopoint)
            ..add(event.geoPoint),
        ),
        foregroundPermission: foregrounPermission ?? false,
        backgroundPermission: backgroundPermision ?? false,
      ));
    });
    on<ResetGeolocation>((event, emit) {
      Logger().d("Bloc (ResetGeolocation) event");

      emit(GeolocationLoaded(
        geolocation: const GeolocationModel(),
        foregroundPermission: foregrounPermission ?? false,
        backgroundPermission: backgroundPermision ?? false,
      ));
    });

    on<RequestForegroundGeolocation>((event, emit) async {
      Logger().d("Request foreground geolocation");

      final status =
          await GeolocationController.foregroundGeolocationPermission();

      foregrounPermission = status;

      emit(GeolocationLoaded(
        geolocation: GeolocationModel(
          geopoint:
              List.from((state as GeolocationLoaded).geolocation.geopoint),
        ),
        foregroundPermission: foregrounPermission ?? false,
        backgroundPermission: backgroundPermision ?? false,
      ));
    });

    on<RequestBackgroundGeolocation>((event, emit) async {
      Logger().d("Request background geolocation");

      final status =
          await GeolocationController.backgroundGeolocationPermission();

      foregrounPermission = status;

      emit(GeolocationLoaded(
        geolocation: GeolocationModel(
          geopoint:
              List.from((state as GeolocationLoaded).geolocation.geopoint),
        ),
        foregroundPermission: foregrounPermission ?? false,
        backgroundPermission: backgroundPermision ?? false,
      ));
    });
  }
}
