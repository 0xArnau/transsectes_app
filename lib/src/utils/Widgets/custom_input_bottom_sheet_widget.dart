import 'package:flutter/material.dart';
import 'package:transsectes_app/src/utils/colors.dart';

class CustomInputBottomSheetWidget extends StatelessWidget {
  final Function(String) onAccept;
  final Function() onCancel;

  const CustomInputBottomSheetWidget(
      {super.key, required this.onAccept, required this.onCancel});

  @override
  Widget build(BuildContext context) {
    String inputText = '';

    return Container(
      decoration: BoxDecoration(
        color: Colors.grey[350],
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(15),
          topRight: Radius.circular(15),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              'Buscar',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 8),
            TextField(
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                fillColor: Colors.white,
                filled: true,
                hintText: 'Ciutat o Data...',
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: kColorTitle,
                  ),
                ),
              ),
              cursorColor: kColorTitle,
              onChanged: (value) {
                inputText = value;
              },
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: TextButton(
                    style: TextButton.styleFrom(
                      foregroundColor: kColorTitle,
                    ),
                    child: const Text('Cancelar'),
                    onPressed: () {
                      onCancel();
                      Navigator.of(context).pop();
                    },
                  ),
                ),
                Expanded(
                  child: TextButton(
                    style: TextButton.styleFrom(
                      foregroundColor: kColorTitle,
                    ),
                    child: const Text('Acceptar'),
                    onPressed: () {
                      onAccept(inputText);
                      Navigator.of(context).pop();
                    },
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
