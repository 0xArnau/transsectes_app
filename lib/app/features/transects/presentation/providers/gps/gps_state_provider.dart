import 'package:flutter_riverpod/legacy.dart';
import 'package:transsectes_app/app/features/transects/presentation/states/gps/gps_state.dart';

/// A Riverpod provider for managing the state of GPS permissions and services.
///
/// This provider uses [StateProvider] to hold a [GpsState] object, allowing
/// other parts of the application to read or modify the GPS state reactively.
final gpsStateProvider = StateProvider<GpsState>((ref) => GpsState.initial());
