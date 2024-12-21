import 'package:flutter/material.dart';
import 'package:transsectes_app/app/features/splash/presentation/views/splash_view.dart';
import 'package:transsectes_app/app/theme/theme.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const SplashView(),
      theme: lightMode,
      darkTheme: darkMode,
    );
  }
}
