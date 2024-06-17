import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:transsectes_app/src/utils/colors.dart';

class CustomAlertDialogWidget extends StatelessWidget {
  final String title;
  final String content;

  final String primaryText;
  final Function() primaryFunction;
  final String secondaryText;
  final Function() secondaryFunction;

  const CustomAlertDialogWidget({
    super.key,
    required this.title,
    required this.content,
    required this.primaryText,
    required this.primaryFunction,
    required this.secondaryText,
    required this.secondaryFunction,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.grey[350],
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(15),
            topRight: Radius.circular(15),
            bottomLeft: Radius.circular(15),
            bottomRight: Radius.circular(15),
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    title,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    content,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 16,
                      color: Colors.black54,
                    ),
                  ),
                ],
              ),
            ),
            const Divider(height: 1),
            Row(
              children: [
                Expanded(
                  child: ListTile(
                    onTap: () {
                      try {
                        secondaryFunction();
                        Navigator.pop(context);
                      } catch (e) {
                        Logger().e(e.toString());
                      }
                    },
                    title: Text(
                      secondaryText,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        color: kColorTitle,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: ListTile(
                    onTap: () {
                      try {
                        primaryFunction();
                        Navigator.pop(context);
                      } catch (e) {
                        Logger().e(e.toString());
                      }
                    },
                    title: Text(
                      primaryText,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        color: Colors.red,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
