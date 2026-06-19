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
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final accepted = await _showBackgroundLocationDisclosure();
      if (accepted && mounted) {
        _onRequestPermissionPressed();
      }
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
        title: Text(S.current.requestingGpsPermissions),
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
        title: Text(S.current.gpsPermissionDenied),
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
                final accepted = await _showBackgroundLocationDisclosure();
                if (accepted && mounted) {
                  _onRequestPermissionPressed();
                }
              },
              child: Text(S.current.reload),
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

  /// Shows a prominent disclosure dialog explaining background location usage,
  /// as required by Google Play's User Data policy.
  /// Returns true if the user accepted, false otherwise.
  Future<bool> _showBackgroundLocationDisclosure() async {
    if (!mounted) return false;
    final result = await showDialog<bool>(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        title: Text(S.current.background_location_disclosure_title),
        content: SingleChildScrollView(
          child: Text(S.current.background_location_disclosure_body),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: Text(S.current.cancel),
          ),
          ElevatedButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: Text(S.current.accept),
          ),
        ],
      ),
    );
    return result ?? false;
  }

  /// Handles the button press to request location permissions again.
  ///
  /// This method attempts to request location permissions. It delegates the handling
  /// of specific exceptions to external functions to reduce complexity and improve clarity.
  void _onRequestPermissionPressed() async {
    try {
      // Request location permissions from the ViewModel
      await ref
          .read(verifyGpsPermissionsViewModelProvider)
          .requestLocationPermissions();
    } on GpsServiceDisabled catch (e) {
      Logger().e(e);
      _handleGpsServiceDisabled();
    } on PermanentlyDeniedException catch (e) {
      Logger().e(e);
      _handlePermanentlyDeniedException(e);
    } catch (e, stackTrace) {
      // Log any unexpected exceptions for debugging purposes
      Logger().e(['Unexpected exception', e, stackTrace]);
    }
  }

  /// Handles the case when the GPS service is disabled.
  ///
  /// Displays an alert dialog to inform the user that GPS needs to be enabled.
  Future<void> _handleGpsServiceDisabled() async {
    if (!mounted) return; // Ensure the widget is still mounted
    await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(S.current.gpsServiceDisabled),
          content: Text(
            S.current.gpsServiceDisabledMessage,
          ),
          actions: [
            // Close button to dismiss the dialog
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text(S.current.ok),
            ),
          ],
        );
      },
    );
  }

  /// Handles the case when location permissions are permanently denied.
  ///
  /// Displays an alert dialog to guide the user to the app settings.
  Future<void> _handlePermanentlyDeniedException(
      PermanentlyDeniedException e) async {
    if (!mounted) return; // Ensure the widget is still mounted
    await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(e.message),
          // TODO: revisar este cambio
          content: Text(
            '${S.current.locationPermissionsPermanentlyDenied} ${S.current.locationPermissionsSettingsMessage}',
          ),
          actions: [
            // Close button to dismiss the dialog
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text(S.current.close),
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
  }
}
