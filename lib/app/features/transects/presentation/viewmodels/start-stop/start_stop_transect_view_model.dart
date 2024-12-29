import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logger/logger.dart';
import 'package:transsectes_app/app/features/transects/domain/entities/geo_point_entity.dart';
import 'package:transsectes_app/app/features/transects/domain/usecases/get_location_stream_usecase.dart';
import 'package:transsectes_app/app/features/transects/presentation/providers/start-stop/transect_coordinates_state_provider.dart';
import 'package:transsectes_app/app/features/transects/presentation/states/start-stop/transect_coordinates_state.dart';

/// ViewModel that manages the start and stop of a transect, including subscribing to
/// location updates and updating the state with coordinates.
class StartStopTransectViewModel {
  final Ref ref;
  final GetLocationStreamUseCase getLocationStreamUseCase;
  StreamSubscription<GeoPointEntity?>? _coordinatesSubscription;

  StartStopTransectViewModel({
    required this.ref,
    required this.getLocationStreamUseCase,
  });

  /// Starts the transect by subscribing to the location stream.
  ///
  /// This method initializes the state, subscribes to the location stream provided by
  /// [getLocationStreamUseCase], and listens for new coordinates to add to the state.
  /// When the stream emits coordinates, they are added to the list in the state.
  /// If an error occurs, the state is updated with an error message.
  Future<void> startTransect() async {
    // Reset the state to initial before starting the transect
    _updateTransectCoordinatesState(
        (state) => TransectCoordinatesState.initial());
    _updateTransectCoordinatesState((state) => state.copyWith(isLoading: true));

    // Get the location stream
    final response = await getLocationStreamUseCase.execute();

    response.fold(
      (stream) {
        // Subscribe to the stream and add coordinates to the list
        _coordinatesSubscription = stream.listen(
          (coordinate) {
            if (coordinate != null) {
              // Add coordinates to the list in the state
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
          },
          onDone: () {
            // Called when the stream is done
            Logger().d('Stream closed');
          },
        );

        // Update the state to indicate the transect has started
        _updateTransectCoordinatesState(
          (state) => state.copyWith(
            isLoading: false,
            isStarted: true,
            isStopped: false,
            okMessage: 'Started a transect',
          ),
        );
      },
      (error) {
        // If there was an error, update the state
        _updateTransectCoordinatesState(
          (state) => state.copyWith(
            coordinates: [],
            isLoading: false,
            isStarted: false,
            isStopped: false,
            errorMessage: 'Error while starting a transect',
          ),
        );
      },
    );
  }

  /// Stops the transect, cancels the subscription, and updates the state.
  ///
  /// This method cancels the location stream subscription and updates the state to
  /// reflect that the transect has stopped. The list of coordinates will no longer
  /// be updated.
  Future<void> stopTransect() async {
    _updateTransectCoordinatesState(
      (state) => state.copyWith(
        isLoading: true,
        okMessage: 'Transect stopped',
      ),
    );
    Logger().d('stopTransect');

    // Cancel the stream subscription
    await _coordinatesSubscription?.cancel();

    // Update the state to reflect the transect has stopped
    _updateTransectCoordinatesState(
      (state) => state.copyWith(
        isLoading: false,
        isStarted: false,
        isStopped: true,
        okMessage: 'Transect stopped',
      ),
    );
  }

  /// Updates the state of the transect coordinates in the provider.
  ///
  /// This method reads the current state from the provider and updates it by
  /// applying the function [updateFn] passed as an argument. It is used to modify
  /// the state, such as adding coordinates to the list or updating other flags.
  void _updateTransectCoordinatesState(
      TransectCoordinatesState Function(TransectCoordinatesState) updateFn) {
    final currentState = ref.read(transectCoordinatesStateProvider);
    ref.read(transectCoordinatesStateProvider.notifier).state =
        updateFn(currentState);
  }
}
