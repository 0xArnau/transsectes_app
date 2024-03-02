import 'package:flutter/material.dart';

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
  final Icon prefixIcon;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: InputDecoration(
        prefixIcon: prefixIcon,
        labelText: hintText,
        // hintText: hintText,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
      ),
      obscureText: obscureText,
      controller: controller,
      onTap: onTap,
    );
  }
}
