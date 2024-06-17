import 'package:flutter/material.dart';
import 'package:transsectes_app/src/utils/colors.dart';

class CustomAction {
  final String text;
  final Color color;
  final Function function;

  const CustomAction({
    required this.text,
    required this.function,
    this.color = kColorTitle,
  });
}

Future customActionSheet({
  required BuildContext context,
  String? title,
  String? description,
  required CustomAction primaryAction,
  CustomAction? secondaryAction,
  CustomAction? tertiaryAction,
}) {
  return showModalBottomSheet(
    backgroundColor: Colors.transparent,
    context: context,
    builder: (context) {
      return Container(
        margin: const EdgeInsets.only(left: 10, right: 10, bottom: 50),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Container(
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(15),
                  topRight: Radius.circular(15),
                  bottomLeft: Radius.circular(15),
                  bottomRight: Radius.circular(15),
                ),
              ),
              child: Column(
                children: [
                  if (title != null || description != null) ...[
                    Container(
                      padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                      child: Column(
                        children: <Widget>[
                          if (title != null) ...[
                            Text(
                              title,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                              ),
                            ),
                          ],
                          if (description != null) ...[
                            const SizedBox(height: 8),
                            Text(
                              description,
                              style: const TextStyle(
                                color: Colors.grey,
                              ),
                            ),
                          ],
                          const SizedBox(height: 8),
                          const Divider(height: 0),
                        ],
                      ),
                    ),
                  ],
                  ListTile(
                    title: Text(
                      primaryAction.text,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: primaryAction.color,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    onTap: () {
                      primaryAction.function();
                      Navigator.pop(context);
                    },
                  ),
                  if (secondaryAction != null) ...[
                    const Divider(height: 0),
                    ListTile(
                      title: Text(
                        secondaryAction.text,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: secondaryAction.color,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      onTap: () {
                        secondaryAction.function();
                        Navigator.pop(context);
                        // Add your action code here
                      },
                    ),
                  ],
                  if (tertiaryAction != null) ...[
                    const Divider(height: 0),
                    ListTile(
                      title: Text(
                        tertiaryAction.text,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: tertiaryAction.color,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      onTap: () {
                        tertiaryAction.function();
                        Navigator.pop(context);
                        // Add your action code here
                      },
                    ),
                  ],
                ],
              ),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
                // Add your action code here
              },
              style: ElevatedButton.styleFrom(
                foregroundColor: kColorTitle,
                backgroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
              child: Container(
                alignment: Alignment.center,
                height: 52,
                child: const Text(
                  'Cancel',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    },
  );
}
