import 'package:flutter/material.dart';

/// A customizable text form field widget that integrates with Flutter's `TextFormField`.
///
/// This widget provides a consistent design for input fields, including a label, optional
/// prefix icon, and support for obscure text (e.g., for passwords).
///
/// Example usage:
/// ```dart
/// CustomTextForm(
///   controller: myController,
///   hintText: 'Enter your email',
///   obscureText: false,
///   prefixIcon: Icon(Icons.email),
/// )
/// ```
class CustomTextForm extends StatelessWidget {
  /// Creates a `CustomTextForm`.
  ///
  /// [hintText] is required and specifies the placeholder text for the input field.
  /// [obscureText] is required and determines if the text is obscured (e.g., for passwords).
  /// [prefixIcon] is optional and specifies an icon to display at the beginning of the field.
  /// [controller] and [onTap] are optional and provide additional customization.
  const CustomTextForm({
    super.key,
    this.controller,
    this.onTap,
    required this.hintText,
    required this.obscureText,
    required this.prefixIcon,
  });

  /// The controller for managing the text input.
  final TextEditingController? controller;

  /// The callback function triggered when the field is tapped.
  final void Function()? onTap;

  /// The placeholder text displayed in the field.
  final String hintText;

  /// Whether the text input should be obscured (e.g., for passwords).
  final bool obscureText;

  /// An optional icon displayed at the beginning of the field.
  final Icon? prefixIcon;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.all(10),
        filled: true,
        fillColor: Theme.of(context).colorScheme.surface.withAlpha(200),
        prefixIcon: prefixIcon,
        labelText: hintText,
        labelStyle: TextStyle(
          color: Theme.of(context).colorScheme.onSurface,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: BorderSide(
            color: Theme.of(context).colorScheme.onSurface,
            width: 2.0,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: BorderSide(
            color: Theme.of(context).colorScheme.onSurface,
            width: 1.0,
          ),
        ),
      ),
      cursorColor: Theme.of(context).colorScheme.onSurface,
      obscureText: obscureText,
      controller: controller,
      onTap: onTap,
    );
  }
}
