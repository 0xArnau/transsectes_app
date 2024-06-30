import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:transsectes_app/src/transects/repositories/transects/transect_repository.dart';
import 'package:transsectes_app/src/utils/Widgets/custom_alert_dialog_widget.dart';

class RemoveTransectsView extends StatelessWidget {
  const RemoveTransectsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ElevatedButton(
            onPressed: () async {
              await showDialog<String>(
                context: context,
                builder: (BuildContext context) {
                  return CustomAlertDialogWidget(
                    title: 'Remove all transects',
                    content: 'Tis action cannot be undone!!!',
                    primaryText: 'Delete',
                    primaryFunction: () {
                      Logger().d("onPressedAccept");
                      TransectRepository().removeAllTransects();
                    },
                    secondaryText: 'Cancel',
                    secondaryFunction: () {},
                  );
                },
              );
            },
            child: const Text("Remove all transects"),
          ),
          const SizedBox(height: 10),
          const Text(
            "This action cannot be undone, be careful!",
            style: TextStyle(color: Colors.grey),
          ),
        ],
      ),
    );
  }
}
