import 'package:flutter/material.dart';

ThemeData lightMode = ThemeData(
  useMaterial3: true,
  brightness: Brightness.light,
  colorScheme: const ColorScheme.light(
    onPrimaryContainer: Color.fromARGB(255, 255, 255, 255),
    primaryContainer: Color.fromARGB(255, 0, 0, 0),
  ),
);

ThemeData darkMode = ThemeData(
  useMaterial3: true,
  brightness: Brightness.dark,
  colorScheme: const ColorScheme.dark(
    onPrimaryContainer: Color.fromARGB(255, 0, 0, 0),
    primaryContainer: Color.fromARGB(255, 255, 255, 255),
  ),
);
