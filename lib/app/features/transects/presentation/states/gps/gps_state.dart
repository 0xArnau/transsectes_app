import 'package:freezed_annotation/freezed_annotation.dart';

part 'gps_state.freezed.dart';

/// Represents the state of the GPS permissions and services.
///
/// This state is used to track:
/// - Whether a GPS-related operation is currently loading.
/// - Whether location permissions are granted.
/// - Any error or informational message related to GPS.
@freezed
class GpsState with _$GpsState {
  /// Creates a new [GpsState].
  ///
  /// Parameters:
  /// - [isLoading]: Indicates if a GPS operation is in progress.
  /// - [isLocationPermissionEnabled]: Indicates if location permission is granted.
  /// - [message]: An optional message, such as an error or informational message.
  const factory GpsState({
    required bool isLoading,
    required bool isLocationPermissionEnabled,
    required String? message,
  }) = _GpsState;

  /// Factory method for creating the initial state of GPS.
  ///
  /// Sets default values:
  /// - [isLoading]: `false`.
  /// - [isLocationPermissionEnabled]: `false`.
  /// - [message]: `null`.
  factory GpsState.initial() => const GpsState(
        isLoading: false,
        isLocationPermissionEnabled: false,
        message: null,
      );
}
