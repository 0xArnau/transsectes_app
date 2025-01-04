import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logger/logger.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:transsectes_app/app/features/transects/domain/exceptions/gps_exception.dart';
import 'package:transsectes_app/app/features/transects/presentation/providers/gps/gps_state_provider.dart';
import 'package:transsectes_app/app/features/transects/presentation/providers/gps/verify_gps_permissions_view_model_provider.dart';
import 'package:transsectes_app/app/features/transects/presentation/states/gps/gps_state.dart';
import 'package:transsectes_app/app/features/transects/presentation/views/start-stop/start_stop_transect_view.dart';
import 'package:transsectes_app/generated/l10n.dart';

/// A view that displays the current GPS permissions status and reacts to changes
/// in the GPS state managed by the ViewModel and `gpsStateProvider`.
class VerifyGpsPermissionsView extends ConsumerStatefulWidget {
  const VerifyGpsPermissionsView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _VerifyGpsPermissionsViewState();
}

class _VerifyGpsPermissionsViewState
    extends ConsumerState<VerifyGpsPermissionsView> {
  @override
  void initState() {
    super.initState();
    // Request location permissions on view load
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _onRequestPermissionPressed();
    });
  }

  @override
  Widget build(BuildContext context) {
    // Listen to changes in the GPS state
    final gpsState = ref.watch(gpsStateProvider);

    Logger().d([
      gpsState.isLoading,
      gpsState.isLocationPermissionEnabled,
      gpsState.message,
    ]);

    return _buildContent(gpsState);
  }

  /// Builds the appropriate content based on the GPS state.
  Widget _buildContent(GpsState state) {
    if (state.isLoading) {
      return _buildLoadingView();
    } else if (!state.isLocationPermissionEnabled) {
      return _buildPermissionDeniedView(state.message);
    } else {
      // TODO: go to start/stop transect
      return _buildPermissionGrantedView();
    }
  }

  /// Builds a view with a loading indicator.
  Widget _buildLoadingView() {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Requesting GPS Permissions'),
      ),
      body: const Center(
        child: CircularProgressIndicator(),
      ),
    );
  }

  /// Builds a view shown when location permission is denied.
  Widget _buildPermissionDeniedView(String? message) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('GPS Permission Denied'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.error, color: Colors.red, size: 80),
            const SizedBox(height: 20),
            Text(
              message ?? S.current.gps_service_background_disabled,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                _onRequestPermissionPressed();
              },
              child: const Text('Reload'),
            ),
          ],
        ),
      ),
    );
  }

  /// Builds a view shown when location permission is granted.
  Widget _buildPermissionGrantedView() {
    return const StartStopTransectView();
  }

  /// Handles the button press to request location permissions again.
  ///
  /// This method attempts to request location permissions. If the permissions
  /// are permanently denied, it catches the `PermanentlyDeniedException` and
  /// displays an alert dialog to guide the user to the app settings.
  void _onRequestPermissionPressed() async {
    try {
      // Request location permissions from the ViewModel
      await ref
          .read(verifyGpsPermissionsViewModelProvider)
          .requestLocationPermissions();
    } on PermanentlyDeniedException catch (e) {
      // Log the exception details for debugging
      Logger().e(e);

      // Ensure the widget is still mounted before interacting with the context
      if (!mounted) return;

      // Show an alert dialog to inform the user about the permanently denied permission
      await showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text(e.message),
            content: const Text(
              'Location permissions are permanently denied. '
              'Please go to the settings and enable "Always" for location access.',
            ),
            actions: [
              // Close button to dismiss the dialog
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('Close'),
              ),
              // Button to open app settings
              TextButton(
                onPressed: () async {
                  Navigator.of(context).pop(); // Close the dialog
                  await openAppSettings(); // Open app settings
                  Logger().d('after await');
                },
                child: Text(
                  S.current.open_system_settings,
                  style: TextStyle(color: Theme.of(context).colorScheme.error),
                ),
              ),
            ],
          );
        },
      );
    } catch (e, stackTrace) {
      // Log any unexpected exceptions for debugging purposes
      Logger().e(['Unexpected exception', e, stackTrace]);
    }
  }
}
