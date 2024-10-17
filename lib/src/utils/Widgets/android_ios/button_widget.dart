import 'dart:io' show Platform;

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:transsectes_app/src/utils/Widgets/android_ios/icon_widget.dart';
import 'package:transsectes_app/src/utils/colors.dart';

class ButtonWidget extends StatelessWidget {
  final String text;
  final Function action;
  final IconWidget? icon;

  const ButtonWidget({
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
    IconWidget? icon,
  }) {
    return TextButton(
      onPressed: () => action(),
      style: TextButton.styleFrom(
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
    IconWidget? icon,
  }) {
    return CupertinoButton(
      onPressed: () => action(),
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
