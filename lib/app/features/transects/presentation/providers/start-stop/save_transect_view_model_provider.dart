import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:transsectes_app/app/core/providers/use_case_providers.dart';
import 'package:transsectes_app/app/features/transects/presentation/viewmodels/start-stop/save_transect_view_model.dart';

/// Provider for the [SaveTransectViewModel].
///
/// This provider initializes the view model by injecting the required use cases:
/// - [AddTransectUseCase]: For saving a transect.
/// - [GetAddressFromCoordinatesUseCase]: For retrieving address details from coordinates.
final saveTransectViewModelProvider = Provider<SaveTransectViewModel>((ref) {
  final addTransectUseCase = ref.read(addTransectUseCaseProvider);
  final getAddressFromCoordinatesUseCase =
      ref.read(getAddressFromCoordinatesUseCaseProvider);

  return SaveTransectViewModel(
    ref: ref,
    addTransectUseCase: addTransectUseCase,
    getAddressFromCoordinatesUseCase: getAddressFromCoordinatesUseCase,
  );
});
