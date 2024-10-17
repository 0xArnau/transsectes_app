import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:transsectes_app/generated/l10n.dart';
import 'package:transsectes_app/src/transects/repositories/transects/transect_repository.dart';
import 'package:transsectes_app/src/utils/Widgets/android_ios/alert_dialog_widget.dart';
import 'package:transsectes_app/src/utils/Widgets/android_ios/button_filled_widget.dart';

class RemoveTransectsView extends StatelessWidget {
  const RemoveTransectsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ButtonFilledWidget(
            action: () => AlertDialogWidget.showAlertDialog(
              context: context,
              title: S.current.delete_all_transects,
              content: S.current.delete_all_transects_content,
              primaryText: S.current.delete,
              primaryFunction: () {
                Logger().d("onPressedAccept");
                TransectRepository().removeAllTransects();
              },
              secondaryText: S.current.cancel,
              secondaryFunction: () {},
            ),
            text: S.current.delete_all_transects,
          ),
          const SizedBox(height: 10),
          Text(
            S.current.delete_all_transects_content,
            style: const TextStyle(color: Colors.grey),
          ),
        ],
      ),
    );
  }
}
