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

  GeolocationBloc() : super(GeolocationInitial()) {
    on<LoadGeolocation>((event, emit) async {
      Logger().d("Bloc (LoadGeolocation) event");

      await GeolocationController.initialize()
          .whenComplete(() => emit(GeolocationLoaded()))
          .onError((error, stackTrace) => emit(GeolocationError()));
    });
    on<AddGeolocationPoint>((event, emit) {
      Logger().d("Bloc (LoadGeolocation) event");

      emit(GeolocationLoaded(
        geolocation: GeolocationModel(
          geopoint:
              List.from((this.state as GeolocationLoaded).geolocation.geopoint)
                ..add(event.geoPoint),
        ),
      ));
    });
    on<ResetGeolocation>((event, emit) {
      Logger().d("Bloc (ResetGeolocation) event");

      emit(GeolocationLoaded(geolocation: GeolocationModel()));
    });
  }
}
