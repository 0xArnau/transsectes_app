import 'package:flutter/material.dart';

Widget customButton({
  required String text,
  required Function onTap,
}) {
  return ElevatedButton(
    onPressed: () {
      onTap();
    },
    style: ButtonStyle(
      padding: WidgetStateProperty.all<EdgeInsets>(
        const EdgeInsets.all(10.0),
      ),
      backgroundColor: WidgetStateProperty.all<Color>(Colors.black),
      shape: WidgetStateProperty.all<RoundedRectangleBorder>(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
      ),
    ),
    child: Center(
      child: Text(
        text,
        style: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w600,
          color: Colors.white,
        ),
      ),
    ),
  );
}
