import 'package:flutter/material.dart';
import 'package:transsectes_app/src/utils/colors.dart';

class CustomTextForm extends StatelessWidget {
  const CustomTextForm({
    super.key,
    this.controller,
    this.onTap,
    required this.hintText,
    required this.obscureText,
    required this.prefixIcon,
  });

  final TextEditingController? controller;
  final void Function()? onTap;
  final String hintText;
  final bool obscureText;
  final Icon? prefixIcon;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.all(10),
        filled: true,
        fillColor: kColorBackgroundWidthTransparency,
        prefixIcon: prefixIcon,
        labelText: hintText,
        labelStyle: const TextStyle(
          color: Colors.black,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: const BorderSide(
            color: Colors.black,
            width: 2.0,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: const BorderSide(
            color: Colors.black,
            width: 1.0,
          ),
        ),
      ),
      cursorColor: Colors.black,
      obscureText: obscureText,
      controller: controller,
      onTap: onTap,
    );
  }
}
