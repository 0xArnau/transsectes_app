import 'package:flutter/material.dart';

ThemeData lightMode = ThemeData(
  useMaterial3: true,
  brightness: Brightness.light,
  colorScheme: const ColorScheme.light(
    onPrimaryContainer: Color.fromARGB(255, 255, 255, 255),
    primaryContainer: Color.fromARGB(255, 0, 0, 0),
    surfaceContainer: Color.fromRGBO(76, 26, 221, 1),
    primary: Color.fromRGBO(78, 101, 245, 1),
    secondary: Color.fromRGBO(135, 105, 83, 1),
    tertiary: Color.fromRGBO(246, 199, 62, 1),
  ),
);

ThemeData darkMode = ThemeData(
  useMaterial3: true,
  brightness: Brightness.dark,
  colorScheme: const ColorScheme.dark(
    onPrimaryContainer: Color.fromARGB(255, 0, 0, 0),
    primaryContainer: Color.fromARGB(255, 255, 255, 255),
    surfaceContainer: Color.fromRGBO(76, 26, 221, 1),
    primary: Color.fromRGBO(78, 101, 245, 1),
    secondary: Color.fromRGBO(135, 105, 83, 1),
    tertiary: Color.fromRGBO(246, 199, 62, 1),
  ),
);
