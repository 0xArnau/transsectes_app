import 'dart:io';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// A provider that holds the current language code.
///
/// The provider retrieves the language code from the system's locale by default,
/// splitting the `localeName` string and taking the first part (language code).
/// It can be updated with the `changeLanguage` function.
///
/// The state represents the language code (e.g., 'en' for English, 'es' for Spanish).
final languageProvider =
    StateProvider<String>((ref) => Platform.localeName.split('_')[0]);

/// Changes the current language by updating the [languageProvider] state.
///
/// This function allows you to change the language code used in the application.
/// It updates the provider state with the new language, which will reflect throughout
/// the app wherever the provider is being watched.
///
/// Parameters:
/// - [ref]: The [WidgetRef] instance used to read and update the provider.
/// - [language]: The new language code to set (e.g., 'en', 'es').
void changeLanguage({required WidgetRef ref, required String language}) {
  ref.read(languageProvider.notifier).state = language;
}
