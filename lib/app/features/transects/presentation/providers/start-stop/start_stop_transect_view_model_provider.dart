import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:transsectes_app/app/core/providers/use_case_providers.dart';
import 'package:transsectes_app/app/features/transects/presentation/viewmodels/start-stop/start_stop_transect_view_model.dart';

/// A [Provider] that provides an instance of [StartStopTransectViewModel].
///
/// This provider initializes the [StartStopTransectViewModel] using the `getLocationStreamUseCase`
/// to interact with the location stream and manage the start/stop logic of the transect.
final startStopTransectViewModelProvider =
    Provider<StartStopTransectViewModel>((ref) {
  final getLocationStreamUseCase = ref.read(getLocationStreamUseCaseProvider);
  final getCurrentPositionUseCase = ref.read(getCurrentPositionUseCaseProvider);

  return StartStopTransectViewModel(
    ref: ref,
    getLocationStreamUseCase: getLocationStreamUseCase,
    getCurrentPositionUseCase: getCurrentPositionUseCase,
  );
});
