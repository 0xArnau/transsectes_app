import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:logger/logger.dart';
import 'package:transsectes_app/src/auth/repositories/auth_repository.dart';
import 'package:transsectes_app/src/geolocation/bloc/geolocation_bloc.dart';
import 'package:transsectes_app/src/geolocation/controller/geolocation_controller.dart';
import 'package:transsectes_app/src/geolocation/models/geolocation_model.dart';
import 'package:transsectes_app/src/transects/models/transect_model.dart';
import 'package:transsectes_app/src/transects/repositories/transects/transect_repository.dart';

part 'transect_event.dart';
part 'transect_state.dart';

class TransectBloc extends Bloc<TransectEvent, TransectState> {
  final TransectRepository _transectRepository;
  // final GeolocationBloc _geolocationBloc;

  // StreamSubscription? _transectSubscription;
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
      // final String? userEmail = await AuthRepository().getUserEmail();

      // _transectSubscription?.cancel();
      // _transectSubscription = _transectRepository
      //     .getUserTransects(userEmail)
      //     .listen((transects) => add(UpdateTransects(transects: transects)));
      // emit(TransectInitial());
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
      final List<String> addresses = await GeolocationController()
          .getAddress(event.geolocationModel.geopoint);

      final TransectModel transect = TransectModel(
        createdAt: _createdAt ?? Timestamp.now(),
        createdBy: userEmail ?? "unknown",
        coordinates: event.geolocationModel.geopoint,
        tractor: event.tractor,
        informedPeople: event.informedPeople,
        observations: event.observations,
        administrativeAreaFirst: addresses[0],
        administrativeAreaLast: addresses[3],
        subAdministrativeAreaFirst: addresses[1],
        subAdministrativeAreaLast: addresses[4],
        localityFirst: addresses[2],
        localityLast: addresses[5],
      );

      Logger().d(transect.toDocument());

      // for (var element in event.geolocationModel.geopoint) {
      //   print("${element.latitude}, ${element.longitude}");
      // }

      _transectRepository.addTransect(transect);

      _geolocationSubscription?.cancel();
      emit(TransectInitial());
    });
  }
}
