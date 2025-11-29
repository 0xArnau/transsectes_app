import 'package:flutter_riverpod/legacy.dart';
import 'package:transsectes_app/app/features/transects/presentation/states/start-stop/transect_coordinates_state.dart';

/// A [StateProvider] that manages the state of the transect coordinates.
///
/// This provider holds the `TransectCoordinatesState` which includes information about the coordinates,
/// whether the transect is started or stopped, loading status, and any messages related to errors or success.
final transectCoordinatesStateProvider =
    StateProvider((ref) => TransectCoordinatesState.initial());
