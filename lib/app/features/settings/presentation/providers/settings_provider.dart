import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:transsectes_app/app/core/providers/use_case_providers.dart';
import 'package:transsectes_app/app/features/settings/presentation/viewmodels/settings_view_model.dart';

/// A provider that creates and provides the [SettingsViewModel].
///
/// This provider is used to manage the logic and state related to the settings view.
/// It creates an instance of [SettingsViewModel] and provides it to the widgets
/// that depend on this provider. It also ensures that the [SettingsViewModel] has
/// access to the necessary use case (`SignOutUseCase`), which handles the sign-out logic.
final settingsViewModelProvider = Provider<SettingsViewModel>((ref) {
  // Get the SignOutUseCase from the use case provider
  final signOutUseCase = ref.read(signOutUseCaseProvider);

  // Return an instance of SettingsViewModel with necessary dependencies
  return SettingsViewModel(
    ref: ref,
    signOutUseCase: signOutUseCase,
  );
});
