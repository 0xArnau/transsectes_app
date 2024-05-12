import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:transsectes_app/generated/l10n.dart';
import 'package:transsectes_app/src/utils/colors.dart';

class CustomAlertDialogWidget extends StatelessWidget {
  final String title;
  final String content;
  final Function()? onPressedCancel;
  final Function()? onPressedAccept;

  const CustomAlertDialogWidget({
    super.key,
    required this.title,
    required this.content,
    this.onPressedAccept,
    this.onPressedCancel,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: kColorBackground,
      title: Text(title),
      content: Text(content),
      actionsAlignment: MainAxisAlignment.spaceBetween,
      actions: <Widget>[
        TextButton(
          style: TextButton.styleFrom(
            foregroundColor: kColorTitle,
          ),
          child: Text(S.current.cancel),
          onPressed: () {
            if (onPressedCancel != null) onPressedCancel!();
            context.pop();
          },
        ),
        TextButton(
          style: TextButton.styleFrom(
            foregroundColor: kColorTitle,
          ),
          child: const Text('Accept'),
          onPressed: () {
            if (onPressedAccept != null) onPressedAccept!();
            context.pop();
          },
        ),
      ],
    );
  }
}
