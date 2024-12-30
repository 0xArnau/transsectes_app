import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:transsectes_app/app/core/providers/use_case_providers.dart';
import 'package:transsectes_app/app/features/transects/presentation/viewmodels/gps/verify_gps_permissions_view_model.dart';

/// Provider for [VerifyGpsPermissionsViewModel], which is responsible for managing
/// the state and logic related to verifying GPS permissions.
///
/// This provider injects the [RequestLocationPermissionsUseCase] into the
/// [VerifyGpsPermissionsViewModel], which allows the view model to handle
/// the logic of requesting location permissions.
///
/// The provider can be used in the widget tree to access the view model.
final verifyGpsPermissionsViewModelProvider =
    Provider<VerifyGpsPermissionsViewModel>((ref) {
  // Retrieve the use case for requesting location permissions from the container.
  final requestLocationPermissionsUseCase =
      ref.read(requestLocationPermissionsUseCaseProvider);

  // Return an instance of VerifyGpsPermissionsViewModel with the required use case.
  return VerifyGpsPermissionsViewModel(
    ref: ref,
    requestLocationPermissionsUseCase: requestLocationPermissionsUseCase,
  );
});
