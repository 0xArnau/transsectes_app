import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:transsectes_app/app/core/providers/use_case_providers.dart';
import 'package:transsectes_app/app/features/transects/presentation/viewmodels/transect_view_model.dart';

/// A provider for the Transect ViewModel.
///
/// This provider is responsible for providing an instance of [TransectViewModel],
/// which handles the logic of the view related to transects. It uses various
/// use cases such as updating, deleting, and retrieving transects to interact
/// with the domain layer of the application.
final transectViewModelProvider = Provider<TransectViewModel>((ref) {
  // Reading the required use cases from the Riverpod container.
  final updateTransectUseCase = ref.read(updateTransectUseCaseProvider);
  final removeAllTransectsUseCase = ref.read(removeAllTransectsUseCaseProvider);

  // Returning a new instance of [TransectViewModel] with the injected use cases.
  return TransectViewModel(
    ref: ref,
    updateTransectUseCase: updateTransectUseCase,
    removeAllTransectsUseCase: removeAllTransectsUseCase,
  );
});
