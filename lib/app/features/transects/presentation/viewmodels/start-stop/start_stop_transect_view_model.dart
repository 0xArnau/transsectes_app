import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logger/logger.dart';
import 'package:transsectes_app/app/features/transects/domain/entities/geo_point_entity.dart';
import 'package:transsectes_app/app/features/transects/domain/usecases/get_current_position_usecase.dart';
import 'package:transsectes_app/app/features/transects/domain/usecases/get_location_stream_usecase.dart';
import 'package:transsectes_app/app/features/transects/presentation/providers/start-stop/transect_coordinates_state_provider.dart';
import 'package:transsectes_app/app/features/transects/presentation/states/start-stop/transect_coordinates_state.dart';
import 'package:transsectes_app/generated/l10n.dart';

/// ViewModel that manages the start and stop of a transect, including subscribing to
/// location updates and updating the state with coordinates.
class StartStopTransectViewModel {
  final Ref _ref;
  final GetLocationStreamUseCase _getLocationStreamUseCase;
  final GetCurrentPositionUseCase _getCurrentPositionUseCase;

  StreamSubscription<GeoPointEntity?>? _coordinatesSubscription;

  StartStopTransectViewModel({
    required Ref ref,
    required GetLocationStreamUseCase getLocationStreamUseCase,
    required GetCurrentPositionUseCase getCurrentPositionUseCase,
  })  : _ref = ref,
        _getLocationStreamUseCase = getLocationStreamUseCase,
        _getCurrentPositionUseCase = getCurrentPositionUseCase;

  /// Starts the transect by subscribing to the location stream.
  ///
  /// This method initializes the state, subscribes to the location stream, and listens for
  /// new coordinates. Coordinates are added to the state, and the state is updated accordingly.
  Future<void> startTransect() async {
    _setLoadingState(true);
    await _startCurrentLocation();
    await _subscribeToLocationStream();
  }

  /// Stops the transect, cancels the subscription, and updates the state.
  ///
  /// This method cancels the location stream subscription and updates the state to reflect that
  /// the transect has stopped.
  Future<void> stopTransect() async {
    _setLoadingState(true);
    Logger().d('stopTransect');
    await _cancelLocationStreamSubscription();
    _updateStateOnStop();
  }

  /// Initializes the transect by resetting the state and setting it to loading.
  void initializeTransect() {
    _setLoadingState(true);
    _updateTransectCoordinatesState((_) => TransectCoordinatesState.initial());
    _setLoadingState(false);
  }

  /// Starts fetching the current position and adds it to the state.
  ///
  /// If successful, it adds the current position to the state. If an error occurs, the state is updated
  /// with an error message.
  Future<void> _startCurrentLocation() async {
    final responseCurrent = await _getCurrentPositionUseCase.execute();

    responseCurrent.fold(
      (value) => _addCoordinateToState(value),
      (error) => _updateStateOnError(S.current.errorWhileStartingTransect),
    );
  }

  /// Subscribes to the location stream and listens for new coordinates.
  ///
  /// It adds each new coordinate to the state. If the stream ends, it logs the stream closure.
  Future<void> _subscribeToLocationStream() async {
    final responseStream = await _getLocationStreamUseCase.execute();

    responseStream.fold(
      (stream) {
        _coordinatesSubscription = stream.listen(
          (coordinate) {
            if (coordinate != null) {
              _addCoordinateToState(coordinate);
            }
          },
          onDone: _logStreamClosed,
        );
        _updateStateOnStart();
      },
      (error) => _updateStateOnError(S.current.errorWhileStartingTransect),
    );
  }

  /// Adds a new coordinate to the state and logs it.
  void _addCoordinateToState(GeoPointEntity coordinate) {
    Logger().d([
      DateTime.now().toIso8601String(),
      coordinate.latitude,
      coordinate.longitude,
    ]);
    _updateTransectCoordinatesState(
      (state) => state.copyWith(
        coordinates: List.from(state.coordinates)..add(coordinate),
      ),
    );
  }

  /// Logs when the location stream is closed.
  void _logStreamClosed() {
    Logger().d('Stream closed');
  }

  /// Updates the state to indicate that the transect has started.
  void _updateStateOnStart() {
    _updateTransectCoordinatesState(
      (state) => state.copyWith(
        isLoading: false,
        isStarted: true,
        isStopped: false,
        okMessage: S.current.startedATransect
      ),
    );
  }

  /// Updates the state to reflect that an error occurred while starting a transect.
  void _updateStateOnError(String errorMessage) {
    _updateTransectCoordinatesState(
      (state) => state.copyWith(
        coordinates: [],
        isLoading: false,
        isStarted: false,
        isStopped: false,
        errorMessage: errorMessage,
      ),
    );
  }

  /// Cancels the location stream subscription.
  Future<void> _cancelLocationStreamSubscription() async {
    await _coordinatesSubscription?.cancel();
  }

  /// Updates the state of the transect coordinates in the provider.
  ///
  /// [updateFn] is a function that takes the current state and returns the updated state.
  void _updateTransectCoordinatesState(
      TransectCoordinatesState Function(TransectCoordinatesState) updateFn) {
    final currentState = _ref.read(transectCoordinatesStateProvider);
    _ref.read(transectCoordinatesStateProvider.notifier).state =
        updateFn(currentState);
  }

  /// Sets the loading state of the transect.
  ///
  /// This method sets the loading state of the transect, showing a loading spinner when the
  /// transect is in progress.
  void _setLoadingState(bool isLoading) {
    _updateTransectCoordinatesState(
      (state) => state.copyWith(
        isLoading: isLoading,
      ),
    );
  }

  /// Updates the state to reflect that the transect has stopped.
  void _updateStateOnStop() {
    _updateTransectCoordinatesState(
      (state) => state.copyWith(
        isLoading: false,
        isStarted: false,
        isStopped: true,
        okMessage: S.current.transectStopped,
      ),
    );
  }
}
