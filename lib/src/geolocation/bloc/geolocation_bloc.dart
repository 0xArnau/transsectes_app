import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'geolocation_event.dart';
part 'geolocation_state.dart';

class GeolocationBloc extends Bloc<GeolocationEvent, GeolocationState> {
  GeolocationBloc() : super(GeolocationInitial()) {
    on<GeolocationEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
