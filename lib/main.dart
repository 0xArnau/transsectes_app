import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_config/flutter_config.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:logger/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:transsectes_app/firebase_options.dart';
import 'package:transsectes_app/generated/l10n.dart';
import 'package:transsectes_app/l10n/l10n.dart';
import 'package:transsectes_app/src/geolocation/bloc/geolocation_bloc.dart';
import 'package:transsectes_app/src/transects/bloc/transect_bloc.dart';
import 'package:transsectes_app/src/transects/repositories/transects/transect_repository.dart';
import 'package:transsectes_app/src/utils/colors.dart';

import 'src/router/router.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);

  //Setting SystmeUIMode
  SystemChrome.setEnabledSystemUIMode(
    SystemUiMode.edgeToEdge,
    overlays: [SystemUiOverlay.top],
  );

  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle(
      systemNavigationBarColor: Colors.black.withOpacity(0.002),
      systemNavigationBarIconBrightness: Brightness.dark,
      statusBarIconBrightness: Brightness.dark,
    ),
  );

  // await FlutterConfig.loadEnvVariables();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  static void changeLanguage(BuildContext context, String code) {
    _MyAppState? state = context.findAncestorStateOfType<_MyAppState>();
    if (state != null) {
      state.changeLanguage(code);
    }
  }

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late SharedPreferences prefs;

  Locale language = Locale(Platform.localeName.split("_")[0]);

  @override
  void initState() {
    super.initState();
    initializeSharedPreferences();
  }

  void initializeSharedPreferences() async {
    SharedPreferences instance = await SharedPreferences.getInstance();
    if (mounted) {
      setState(() {
        prefs = instance;
      });
    }

    String? savedLanguage = await getLanguageSharedPreference();

    if (mounted) {
      setState(() {
        language = Locale(savedLanguage ?? Platform.localeName.split("_")[0]);
      });
    }
  }

  Future<String?> getLanguageSharedPreference() async {
    return prefs.getString('language');
  }

  void setLanguageSharedPreference(String locale) async {
    await prefs.setString('language', locale);
  }

  void changeLanguage(String code) {
    if (mounted) {
      setState(() {
        language = Locale(code);
        setLanguageSharedPreference(language.toString());
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final isIOS = Platform.isIOS;

    Logger().d("is iOS?  $isIOS");

    final app = isIOS
        ? CupertinoApp.router(
            routerConfig: router,
            theme: const CupertinoThemeData(
              primaryColor: CupertinoColors.systemBlue,
              // primaryColor: kColorTitle,
            ),
            supportedLocales: L10n.all,
            localizationsDelegates: const [
              S.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
            ],
            locale: language,
          )
        : MaterialApp.router(
            routerConfig: router,
            theme: ThemeData(
              colorScheme: ColorScheme.fromSeed(seedColor: kColorTitle),
              useMaterial3: true,
            ),
            supportedLocales: L10n.all,
            localizationsDelegates: const [
              S.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
            ],
            locale: language,
          );
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => TransectBloc(
            transectRepository: TransectRepository(),
            geoloctionBloc: GeolocationBloc(),
          ),
        ),
        BlocProvider(
          create: (_) => GeolocationBloc()..add(LoadGeolocation()),
        ),
      ],
      child: app,
    );
  }
}
