import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:transsectes_app/src/auth/repositories/auth_repository.dart';
import 'package:transsectes_app/src/transects/models/transect_model.dart';
import 'package:transsectes_app/src/transects/repositories/transect_repository.dart';

part 'transect_event.dart';
part 'transect_state.dart';

class TransectBloc extends Bloc<TransectEvent, TransectState> {
  final TransectRepository _transectRepository;
  StreamSubscription? _transectSubscription;

  TransectBloc({required TransectRepository transectRepository})
      : _transectRepository = transectRepository,
        super(TransectInitial()) {
    on<LoadTransects>((event, emit) async {
      final String? userEmail = await AuthRepository().getUserEmail();

      _transectSubscription?.cancel();
      _transectSubscription = _transectRepository
          .getUserTransects(userEmail)
          .listen((transects) => add(UpdateTransects(transects: transects)));
      // emit(TransectInitial());
    });

    on<UpdateTransects>((event, emit) {
      emit(TransectLoaded(transects: event.transects));
    });

    on<UpdateGeolocationTransect>((event, emit) {
      // start getting geolocation each minute (for example)
    });

    on<StopTransect>((event, emit) {
      // Save to firestore
    });
  }
}
