import 'package:flutter/material.dart';
import 'package:transsectes_app/src/utils/colors.dart';

class CustomButtonTrailing extends StatefulWidget {
  const CustomButtonTrailing({
    super.key,
    required this.hint,
    required this.trailing,
  });

  final String hint;
  final Widget trailing;

  @override
  State<CustomButtonTrailing> createState() => _CustomButtonTrailingState();
}

class _CustomButtonTrailingState extends State<CustomButtonTrailing> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            height: 40,
            decoration: BoxDecoration(
              border: Border.all(color: kColorButtons),
              color: kColorButtons,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(widget.hint),
            ),
          ),
        ),
        widget.trailing,
      ],
    );
  }
}
