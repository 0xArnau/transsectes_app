import 'package:flutter/material.dart';
import 'package:logger/logger.dart';

class CustomSnackbar {
  static void error(BuildContext context, String message) {
    Logger().d(message);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            "$message",
            style: const TextStyle(
              color: Colors.black,
            ),
            textAlign: TextAlign.center,
          ),
          duration: const Duration(seconds: 5),
          backgroundColor: Colors.red[200],
        ),
      );
    });
  }

  static void info(BuildContext context, String message) {
    Logger().d(message);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            "$message",
            style: const TextStyle(
              color: Colors.black,
            ),
            textAlign: TextAlign.center,
          ),
          duration: const Duration(seconds: 5),
        ),
      );
    });
  }
}
