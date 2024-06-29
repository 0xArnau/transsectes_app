import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
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

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
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
        locale: Locale(Platform.localeName),
      ),
    );
  }
}
