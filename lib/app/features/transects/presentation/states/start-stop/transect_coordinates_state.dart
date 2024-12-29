import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:transsectes_app/app/features/transects/domain/entities/geo_point_entity.dart';

part 'transect_coordinates_state.freezed.dart';

/// A state class that holds information about the transect's coordinates and related flags.
///
/// This class holds the list of coordinates, loading and stop/start status, as well as
/// any error or success messages related to the transect.
@freezed
class TransectCoordinatesState with _$TransectCoordinatesState {
  /// A factory constructor that defines the state of the transect coordinates.
  ///
  /// [coordinates] - A list of `GeoPointEntity` that holds the latitude and longitude.
  /// [isStarted] - A boolean flag indicating if the transect has started.
  /// [isStopped] - A boolean flag indicating if the transect has stopped.
  /// [isLoading] - A boolean flag that is `true` if the system is currently loading data.
  /// [errorMessage] - An optional string to hold any error messages that occur during the process.
  /// [okMessage] - An optional string to hold any success messages that occur.
  const factory TransectCoordinatesState({
    required List<GeoPointEntity> coordinates,
    required bool isStarted,
    required bool isStopped,
    required bool isLoading,
    required String? errorMessage,
    required String? okMessage,
  }) = _TransectCoordinatesState;

  /// Provides an initial state for the transect, with empty coordinates and default values.
  ///
  /// Returns the initial state with all flags set to `false`, no error or success message,
  /// and an empty list for the coordinates.
  factory TransectCoordinatesState.initial() => const TransectCoordinatesState(
        coordinates: [],
        isStarted: false,
        isStopped: false,
        isLoading: false,
        errorMessage: null,
        okMessage: null,
      );
}
