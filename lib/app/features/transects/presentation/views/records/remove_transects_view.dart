import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:transsectes_app/app/core/providers/use_case_providers.dart';
import 'package:transsectes_app/app/core/widgets/custom_button.dart';
import 'package:transsectes_app/app/core/widgets/float_snackbar.dart';
import 'package:transsectes_app/generated/l10n.dart';

class RemoveTransectsView extends ConsumerStatefulWidget {
  const RemoveTransectsView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _RemoveTransectsViewState();
}

class _RemoveTransectsViewState extends ConsumerState<RemoveTransectsView> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        height: 85,
        padding: const EdgeInsets.all(16.0),
        child: CustomButton(
          text: S.current.delete_all_transects,
          onTap: _showConfirmationDialog,
          isADestructiveAction: true,
          minWidth: 50,
        ),
      ),
    );
  }

  // Function to show the confirmation dialog
  Future<void> _showConfirmationDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(S.current.delete_all_transects),
          content: Text(S.current.delete_all_transects_content),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text(S.current.cancel),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                _deleteAllTransects();
              },
              child: Text(
                S.current.remove,
                style: TextStyle(color: Theme.of(context).colorScheme.error),
              ),
            ),
          ],
        );
      },
    );
  }

  // Function to handle the deletion logic (can be replaced with actual deletion logic)
  void _deleteAllTransects() async {
    final usecase = ref.read(removeAllTransectsUseCaseProvider);
    final response = await usecase.execute();

    response.fold(
      (_) => floatSnackbar(
        context: context,
        message: 'All transects deleted successfully!',
        isSuccess: true,
      ),
      (_) => floatSnackbar(
        context: context,
        message: 'An error occurred while deleting transects!',
        isError: true,
      ),
    );
  }
}
