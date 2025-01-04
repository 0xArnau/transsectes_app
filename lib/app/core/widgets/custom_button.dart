import 'package:flutter/material.dart';

/// A customizable button widget that uses Flutter's `ElevatedButton`.
///
/// This button is designed to be flexible and reusable, allowing you to specify
/// the button text and a tap action via the [text] and [onTap] parameters.
///
/// Example usage:
/// ```dart
/// CustomButton(
///   text: 'Submit',
///   onTap: () {
///     print('Button pressed');
///   },
/// )
/// ```
class CustomButton extends StatelessWidget {
  /// Creates a `CustomButton`.
  ///
  /// [text] is required and specifies the button's label.
  /// [onTap] is required and specifies the function to execute when the button is pressed.
  const CustomButton({
    super.key,
    required String text,
    required Function onTap,
    bool isADestructiveAction = false,
    bool isMainAction = false,
    this.minWidth = 150.0, // Default minimum width
  })  : _text = text,
        _onTap = onTap,
        _isADestructiveAction = isADestructiveAction,
        _isMainAction = isMainAction;

  /// The text displayed on the button.
  final String _text;

  /// The callback executed when the button is pressed.
  final Function _onTap;

  /// Determines if the button represents a destructive action.
  final bool _isADestructiveAction;

  /// Determines if the button represents the main action.
  final bool _isMainAction;

  /// The minimum width of the button.
  final double minWidth;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        _onTap();
      },
      style: ButtonStyle(
        padding: WidgetStateProperty.all<EdgeInsets>(
          const EdgeInsets.all(8.0),
        ),
        backgroundColor: _isADestructiveAction
            ? WidgetStateProperty.all<Color>(
                Theme.of(context).colorScheme.error)
            : _isMainAction
                ? WidgetStateProperty.all<Color>(
                    Theme.of(context).colorScheme.primary)
                : WidgetStateProperty.all<Color>(
                    Theme.of(context).colorScheme.surfaceContainer),
        shape: WidgetStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(32.0),
          ),
        ),
        minimumSize: WidgetStateProperty.all<Size>(Size(minWidth, 50)),
      ),
      child: Center(
        child: Text(
          _text,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: _isADestructiveAction
                ? Theme.of(context).colorScheme.onError
                : _isMainAction
                    ? Theme.of(context).colorScheme.onPrimary
                    : Theme.of(context).colorScheme.onPrimaryContainer,
          ),
        ),
      ),
    );
  }
}
