import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logger/logger.dart';
import 'package:transsectes_app/app/features/transects/domain/usecases/request_location_permissions_usecase.dart';
import 'package:transsectes_app/app/features/transects/presentation/providers/gps/gps_state_provider.dart';
import 'package:transsectes_app/app/features/transects/presentation/states/gps/gps_state.dart';
import 'package:transsectes_app/generated/l10n.dart';

/// ViewModel for verifying GPS permissions.
///
/// This class manages the logic for requesting GPS permissions and
/// updating the application state accordingly. It interacts with a
/// use case and updates the state through a Riverpod `gpsStateProvider`.
class VerifyGpsPermissionsViewModel {
  /// A reference to the Riverpod [Ref] used for reading and updating providers.
  final Ref ref;

  /// Use case for requesting location permissions.
  final RequestLocationPermissionsUseCase requestLocationPermissionsUseCase;

  /// Creates a new instance of [VerifyGpsPermissionsViewModel].
  ///
  /// Requires a [Ref] to manage providers and a [RequestLocationPermissionsUseCase]
  /// to perform the permission request operation.
  VerifyGpsPermissionsViewModel({
    required this.ref,
    required this.requestLocationPermissionsUseCase,
  });

  /// Requests location permissions and updates the state in the [gpsStateProvider].
  ///
  /// - If the permissions are granted, it updates the state to reflect that
  ///   the location permission is enabled.
  /// - If the permissions are denied, it updates the state with an appropriate error message.
  Future<void> requestLocationPermissions() async {
    // Indicate that the request process is ongoing.
    _updateGpsState((state) => state.copyWith(isLoading: true));

    try {
      // Execute the permission request.
      final response = await requestLocationPermissionsUseCase.execute();

      // Handle the response.
      response.fold(
        (value) {
          // On success, update the state with the granted status.
          _updateGpsState((state) => state.copyWith(
              isLoading: false, isLocationPermissionEnabled: value));
        },
        (error) {
          // On error, update the state with an error message.
          _updateGpsState((state) => state.copyWith(
                isLoading: false,
                isLocationPermissionEnabled: false,
                message: S.current.gps_service_background_disabled,
              ));
        },
      );
    } catch (e) {
      Logger().e(e.toString());
      _updateGpsState((state) => state.copyWith(
            isLoading: false,
            isLocationPermissionEnabled: false,
            message: S.current.gps_service_background_disabled,
          ));
      rethrow;
    }
  }

  /// Updates the state of the GPS through the [gpsStateProvider].
  ///
  /// Accepts a function [updateFn] that takes the current state and returns
  /// the updated state. This allows fine-grained control over state updates.
  void _updateGpsState(GpsState Function(GpsState) updateFn) {
    // Read the current state from the provider.
    final currentState = ref.read(gpsStateProvider);

    // Update the provider's state with the new values.
    ref.read(gpsStateProvider.notifier).state = updateFn(currentState);
  }
}
