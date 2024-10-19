import 'dart:io' show Platform;

import 'package:flutter/cupertino.dart'
    show CupertinoAlertDialog, CupertinoDialogAction, showCupertinoDialog;
import 'package:flutter/material.dart'
    show
        AlertDialog,
        TextButton,
        showDialog,
        Text,
        BuildContext,
        Navigator,
        Widget;

class AlertDialogWidget {
  static void showAlertDialog({
    required BuildContext context,
    required String title,
    String? content,
    required String primaryText,
    required Function() primaryFunction,
    String? secondaryText,
    Function()? secondaryFunction,
  }) {
    if (Platform.isIOS) {
      _alertDialogIos(
        context: context,
        title: title,
        content: content,
        primaryText: primaryText,
        primaryFunction: primaryFunction,
        secondaryText: secondaryText,
        secondaryFunction: secondaryFunction,
      );
    } else {
      _alertDialogAndroid(
        context: context,
        title: title,
        content: content,
        primaryText: primaryText,
        primaryFunction: primaryFunction,
        secondaryText: secondaryText,
        secondaryFunction: secondaryFunction,
      );
    }
  }

  static void _alertDialogIos({
    required BuildContext context,
    required String title,
    String? content,
    required String primaryText,
    required Function() primaryFunction,
    String? secondaryText,
    Function()? secondaryFunction,
  }) {
    showCupertinoDialog<void>(
      context: context,
      builder: (BuildContext context) => CupertinoAlertDialog(
        title: Text(title),
        content: content != null ? Text(content) : null,
        actions: <CupertinoDialogAction>[
          if (secondaryText != null && secondaryFunction != null)
            CupertinoDialogAction(
              onPressed: () {
                secondaryFunction();
                Navigator.pop(context);
              },
              child: Text(secondaryText),
            ),
          CupertinoDialogAction(
            isDefaultAction: true,
            onPressed: () {
              primaryFunction();
              Navigator.pop(context);
            },
            child: Text(primaryText),
          ),
        ],
      ),
    );
  }

  static void _alertDialogAndroid({
    required BuildContext context,
    required String title,
    String? content,
    required String primaryText,
    required Function() primaryFunction,
    String? secondaryText,
    Function()? secondaryFunction,
  }) {
    showDialog<String>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: Text(title),
        content: content != null ? Text(content) : null,
        actions: <Widget>[
          if (secondaryText != null && secondaryFunction != null)
            TextButton(
              onPressed: () {
                secondaryFunction();
                Navigator.pop(context);
              },
              child: Text(secondaryText),
            ),
          TextButton(
            onPressed: () {
              primaryFunction();
              Navigator.pop(context);
            },
            child: Text(primaryText),
          ),
        ],
      ),
    );
  }
}
