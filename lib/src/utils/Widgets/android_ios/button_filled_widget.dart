import 'dart:io' show Platform;

import 'package:flutter/cupertino.dart' show BorderRadius, CupertinoButton;
import 'package:flutter/material.dart'
    show
        BuildContext,
        ElevatedButton,
        Icon,
        MainAxisSize,
        Row,
        SizedBox,
        StatelessWidget,
        Text,
        Widget;
import 'package:transsectes_app/src/utils/colors.dart';

class ButtonFilledWidget extends StatelessWidget {
  final String text;
  final Function action;
  final Icon? icon;

  const ButtonFilledWidget({
    super.key,
    required this.text,
    required this.action,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Platform.isIOS
        ? _ios(text: text, action: action, icon: icon)
        : _android(text: text, action: action, icon: icon);
  }

  Widget _android({
    required String text,
    required Function action,
    Icon? icon,
  }) {
    return ElevatedButton(
      onPressed: () => action(),
      style: ElevatedButton.styleFrom(
        foregroundColor: kColorTitle,
        surfaceTintColor: kColorTitle,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (icon != null) ...[
            icon,
            const SizedBox(width: 8),
          ],
          Text(text),
        ],
      ),
    );
  }

  Widget _ios({
    required String text,
    required Function action,
    Icon? icon,
  }) {
    return CupertinoButton.filled(
      onPressed: () => action(),
      borderRadius: BorderRadius.circular(30.0),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (icon != null) ...[
            icon,
            const SizedBox(width: 8),
          ],
          Text(text),
        ],
      ),
    );
  }
}
