import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:logger/logger.dart';
import 'package:transsectes_app/src/auth/repositories/auth_repository.dart';
import 'package:transsectes_app/src/geolocation/bloc/geolocation_bloc.dart';
import 'package:transsectes_app/src/geolocation/models/geolocation_model.dart';
import 'package:transsectes_app/src/transects/models/transect_model.dart';
import 'package:transsectes_app/src/transects/repositories/transect_repository.dart';

part 'transect_event.dart';
part 'transect_state.dart';

class TransectBloc extends Bloc<TransectEvent, TransectState> {
  final TransectRepository _transectRepository;
  // final GeolocationBloc _geolocationBloc;

  StreamSubscription? _transectSubscription;
  StreamSubscription? _geolocationSubscription;

  Timestamp? _createdAt;
  // GeolocationModel? _geolocationModel;

  TransectBloc({
    required TransectRepository transectRepository,
    required GeolocationBloc geoloctionBloc,
  })  : _transectRepository = transectRepository,
        // _geolocationBloc = geoloctionBloc,
        super(TransectInitial()) {
    on<LoadTransects>((event, emit) async {
      Logger().d("Bloc (LoadTransects) event");
      final String? userEmail = await AuthRepository().getUserEmail();

      _transectSubscription?.cancel();
      _transectSubscription = _transectRepository
          .getUserTransects(userEmail)
          .listen((transects) => add(UpdateTransects(transects: transects)));
      // emit(TransectInitial());
    });

    on<UpdateTransects>((event, emit) {
      Logger().d("Bloc (UpdateTransects) event");
      emit(TransectLoaded(transects: event.transects));
    });

    on<StartTransect>((event, emit) {
      Logger().d("Bloc (StartTransect) event");
      _createdAt = Timestamp.now();

      // _geolocationSubscription?.cancel();
      // _geolocationSubscription = _geolocationBloc.stream.listen((state) {
      //   if (state is GeolocationLoaded) {
      //     // Asegúrate de que el evento se despacha correctamente
      //     add(UpdateGeolocationTransect(coordinates: state.geolocation));
      //   }
      // });

      emit(TransectStarted());
    });

    on<CancelTransect>((event, emit) {
      Logger().d("Bloc (CancelTransect) event");

      _createdAt = null;
      // _geolocationModel = null;
      _geolocationSubscription?.cancel();

      emit(TransectInitial());
    });

    on<UpdateGeolocationTransect>((event, emit) {
      Logger().d("Bloc (UpdateGeolocationTransect) event");
      // start getting geolocation each minute (for example)
      // _geolocationModel = event.coordinates;
    });

    on<StopTransect>((event, emit) async {
      Logger().d("Bloc (StopTransect) event");

      final String? userEmail = await AuthRepository().getUserEmail();

      Logger().d([
        _createdAt ?? Timestamp.now(),
        userEmail ?? "unknown",
        event.geolocationModel.geopoint,
        event.tractor,
        event.informedPeople,
        event.observations,
      ]);

      for (var element in event.geolocationModel.geopoint) {
        print("${element.latitude}, ${element.longitude}");
      }

      // _transectRepository.addTransect(TransectModel(
      //   createdAt: _createdAt ?? Timestamp.now(),
      //   createdBy: userEmail ?? "unknown",
      //   coordinates: _geolocationModel?.geopoint ?? <GeoPoint>[],
      //   tractor: event.tractor,
      //   informedPeople: event.informedPeople,
      //   observations: event.observations,
      // ));
    });
  }
}
