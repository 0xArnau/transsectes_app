import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:transsectes_app/app/config/theme/theme.dart';
import 'package:transsectes_app/app/core/providers/language_provider.dart';
import 'package:transsectes_app/app/features/splash/presentation/views/splash_view.dart';
import 'package:transsectes_app/generated/l10n.dart';
import 'package:transsectes_app/l10n/l10n.dart';

/// The entry point of the application that initializes Firebase and sets up the app.
///
/// This widget is wrapped inside a `ProviderScope` to enable state management using Riverpod.
/// It loads the preferred language from shared preferences or defaults to the system's locale.
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);
  await Firebase.initializeApp();

  runApp(const ProviderScope(child: MainApp()));
}

/// The main app widget that manages the language state and app theme.
///
/// This widget is a `ConsumerStatefulWidget` that listens to the language provider
/// and adjusts the language of the app dynamically. It also loads the language preference
/// from `SharedPreferences` and updates it accordingly.
class MainApp extends ConsumerStatefulWidget {
  const MainApp({super.key});

  @override
  ConsumerState<MainApp> createState() => _MainAppState();
}

class _MainAppState extends ConsumerState<MainApp> {
  /// The current language code, initially set to the system's locale language code.
  late String languageCode = Platform.localeName.split('_')[0];

  @override
  void initState() {
    super.initState();
    _loadLanguagePreference();
  }

  /// Loads the preferred language from [SharedPreferences] and sets it to the language code.
  ///
  /// If no language preference is found in [SharedPreferences], it falls back to
  /// the language provided by the [languageProvider] or the system's locale.
  Future<void> _loadLanguagePreference() async {
    final preferences = await SharedPreferences.getInstance();

    // Retrieve the language from SharedPreferences or fallback to the default language provider.
    final locale = preferences.getString('language') ??
        ref.read(languageProvider) ??
        languageCode;

    _setLanguageSharedPreference(locale);
  }

  /// Sets the language preference in [SharedPreferences] and updates the language code.
  ///
  /// This method ensures that the language is persisted in [SharedPreferences] and reflects
  /// in the app. It also updates the [languageProvider] with the new language code.
  ///
  /// Parameters:
  /// - [locale]: The language code to set, such as 'en' or 'es'.
  Future<void> _setLanguageSharedPreference(String locale) async {
    final preferences = await SharedPreferences.getInstance();

    // Update the state with the new language code if the widget is still mounted.
    if (mounted) {
      setState(() {
        languageCode = locale;
      });
    }

    // Save the selected language to SharedPreferences.
    await preferences.setString('language', locale);

    // Update the language in the app using the languageProvider.
    changeLanguage(ref: ref, language: languageCode);
  }

  @override
  Widget build(BuildContext context) {
    final currentLanguage = ref.watch(languageProvider);

    // If the language has changed in the languageProvider, update SharedPreferences.
    if (currentLanguage != languageCode) {
      _setLanguageSharedPreference(currentLanguage);
    }

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const SplashView(),
      theme: lightMode,
      darkTheme: darkMode,
      locale: Locale(languageCode), // Use the languageCode variable for locale.
      supportedLocales: L10n.all, // Define all supported locales.
      localizationsDelegates: const [
        S.delegate, // Localizations delegate for generated translations.
        GlobalMaterialLocalizations.delegate, // Material-specific localization.
        GlobalCupertinoLocalizations
            .delegate, // Cupertino-specific localization.
        GlobalWidgetsLocalizations.delegate, // Widgets-specific localization.
      ],
    );
  }
}
