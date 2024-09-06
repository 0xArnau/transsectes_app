import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_config/flutter_config.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:logger/logger.dart';
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

  await FlutterConfig.loadEnvVariables();
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
  var language = Locale(Platform.localeName.split("_")[0]);

  void changeLanguage(String code) {
    if (mounted) {
      setState(() {
        language = Locale(code);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    Logger().d(Platform.localeName);

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
      child: MaterialApp.router(
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
      ),
    );
  }
}
