import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logger/logger.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:transsectes_app/app/core/exceptions/exception.dart';
import 'package:transsectes_app/app/core/providers/user_provider.dart';
import 'package:transsectes_app/app/core/states/user_state.dart';
import 'package:transsectes_app/app/core/widgets/custom_button.dart';
import 'package:transsectes_app/app/core/widgets/float_snackbar.dart';
import 'package:transsectes_app/app/core/widgets/language_picker.dart';
import 'package:transsectes_app/app/features/settings/presentation/providers/settings_provider.dart';
import 'package:transsectes_app/app/features/settings/presentation/widgets/app_info_widget.dart';
import 'package:transsectes_app/generated/l10n.dart';

/// A view that provides settings for the user, including sign-out functionality,
/// user information display, and access to app-related settings.
class SettingsView extends ConsumerStatefulWidget {
  const SettingsView({super.key});

  static const path = '/settings';

  @override
  ConsumerState<SettingsView> createState() => _SettingsViewState();
}

class _SettingsViewState extends ConsumerState<SettingsView> {
  bool showEmail = false;

  @override
  Widget build(BuildContext context) {
    // Listen to changes in the user state and show appropriate messages or actions.
    ref.listen<UserState>(currentUserStateProvider, (prev, next) {
      if (next.errorMessage != null && next.errorMessage!.isNotEmpty) {
        floatSnackbar(
          context: context,
          message: next.errorMessage!,
          isError: true,
        );

        // Clear any error messages after showing them.
        ref.read(settingsViewModelProvider).clearMessages();
      }

      // If user is null (sign out has been successful),
      // in order to go to login view, es necessary to pop the settings view.
      if (next.user == null) {
        Navigator.pop(context);
      }
    });

    final userState = ref.read(currentUserStateProvider);
    final isUserTechnician = userState.user?.isTechnician ?? false;
    final userEmail = userState.user?.email;

    return Scaffold(
      appBar: AppBar(
        title: Text(S.current.settings),
        actions: const [
          AppInfoWidget(),
        ],
      ),
      bottomNavigationBar: BottomAppBar(
        child: Image.asset(
          Theme.of(context).brightness == Brightness.dark
              ? 'assets/imgs/logo/GEPEC_EdC_OFICIAL_blanc.png'
              : 'assets/imgs/logo/GEPEC_EdC_OFICIAL.png',
          fit: BoxFit.fitWidth,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 16.0, right: 16.0),
        child: Column(
          children: [
            Expanded(
              child: ListView(
                children: [
                  _userIcon(context),
                  if (isUserTechnician) _showRole(),
                  if (userEmail != null)
                    _userEmail(
                      context: context,
                      showEmail: showEmail,
                      email: userEmail,
                      toggle: () {
                        if (mounted) {
                          setState(() {
                            showEmail = !showEmail;
                            Logger().d(showEmail);
                          });
                        }
                      },
                    ),
                  _openSettings(),
                  const SizedBox(height: 16),
                  _language(context),
                ],
              ),
            ),
            const SizedBox(height: 16),
            CustomButton(
              text: S.current.delete_account,
              isADestructiveAction: true,
              onTap: () {
                _showConfirmationDialog(context, ref);
              },
            ),
            const SizedBox(height: 16),
            CustomButton(
              text: S.current.signOut,
              onTap: () {
                ref.read(settingsViewModelProvider).signOut();
              },
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }

  /// Builds a widget that displays the user's icon.
  ///
  /// This icon represents the user and is displayed at the top of the settings page.
  /// The size of the icon is dynamically calculated based on the screen height.
  Widget _userIcon(BuildContext context) {
    return Center(
      child: Icon(
        Icons.person,
        size: MediaQuery.of(context).size.height / 6,
        semanticLabel: S.current.userIcon,
      ),
    );
  }

  /// Displays the user's role as "Technician" if the user is a technician.
  ///
  /// This widget is conditionally displayed based on whether the user has a technician role.
  Widget _showRole() {
    return Center(
      child: Text(S.current.technician),
    );
  }

  /// Displays the user's email and allows toggling the visibility of the email address.
  ///
  /// If the `showEmail` flag is true, the full email is displayed. Otherwise, the email is obfuscated
  /// (replaced with asterisks) for privacy. The visibility can be toggled by tapping the visibility icon.
  Widget _userEmail({
    required BuildContext context,
    required bool showEmail,
    required String email,
    required VoidCallback toggle,
  }) {
    return ListTile(
      title: Text(
        showEmail ? email : _obfuscateString(email),
        textAlign: TextAlign.center,
        overflow: TextOverflow.ellipsis,
      ),
      leading: const Icon(Icons.email),
      trailing: GestureDetector(
        onTap: toggle,
        child: Icon(
          showEmail ? Icons.visibility_off : Icons.visibility,
        ),
      ),
    );
  }

  /// Creates a widget that displays a list tile for changing the app's language.
  ///
  /// This widget consists of a `ListTile` with a centered title, a language icon on the left,
  /// and a chevron icon on the right that opens a modal for language selection.
  ///
  /// Parameters:
  /// - [context]: The current `BuildContext`, required to display the modal.
  ///
  /// Returns:
  /// A [ListTile] widget for accessing the language change option.
  Widget _language(BuildContext context) {
    return ListTile(
      title: Text(
        S.current.language_change_2,
        textAlign: TextAlign.center,
        overflow: TextOverflow.ellipsis,
      ),
      leading: const Icon(Icons.language),
      trailing: GestureDetector(
        onTap: () {
          languagePickerModal(context);
        },
        child: const Icon(Icons.chevron_right),
      ),
    );
  }

  Widget _openSettings() {
    return Center(
      child: ListTile(
        leading: const Icon(Icons.open_in_new),
        title: Text(S.current.open_system_settings),
        onTap: () {
          openAppSettings();
        },
      ),
    );
  }
}

/// A helper function that obfuscates an email string by replacing all characters with asterisks.
///
/// This function ensures that the email is hidden for privacy unless the user explicitly requests to view it.
String _obfuscateString(String text) {
  return '*' * text.length;
}

// Function to show the confirmation dialog
Future<void> _showConfirmationDialog(
    BuildContext context, WidgetRef ref) async {
  return showDialog<void>(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext ctx) {
      return AlertDialog(
        title: Text(S.current.delete_account),
        content: Text(S.current.delete_account_content),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.of(ctx).pop();
            },
            child: Text(S.current.cancel),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(ctx).pop();
              _handleDeleteAccount(context, ref);
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

/// Handles the logic for deleting the user account.
///
/// This function interacts with the ViewModel to delete the account and provides
/// appropriate feedback to the user via SnackBars based on the type of error.
///
/// Parameters:
/// - [BuildContext] context: The context for showing SnackBars.
/// - [WidgetRef] ref: The Riverpod ref to access the ViewModel.
void _handleDeleteAccount(BuildContext context, WidgetRef ref) async {
  try {
    await ref.read(settingsViewModelProvider).deleteUserAccount();

    // Show success snackbar
    if (context.mounted) {
      floatSnackbar(
        context: context,
        message: S.current.accountRemoved,
        isSuccess: true,
      );
    }
  } on RequiresNonTechnicianException catch (_) {
    // Show snackbar for unexpected account deletion error
    if (context.mounted) {
      floatSnackbar(
        context: context,
        message:
            S.current.requiresNonTechnician,
        isError: true,
      );
    }
  } on RequiresRecentLoginException catch (_) {
    // Show snackbar for reauthentication requirement
    if (context.mounted) {
      floatSnackbar(
        context: context,
        message: S.current.snackbar_error_requires_recent_login,
        isAlert: true,
      );
    }
  } on DeleteUserAccountException catch (_) {
    // Show snackbar for unexpected account deletion error
    if (context.mounted) {
      floatSnackbar(
        context: context,
        message: S.current.unexpectedErrorWhileDeletingAccount,
        isError: true,
      );
    }
  } catch (_) {
    // Show generic error snackbar
    if (context.mounted) {
      floatSnackbar(
        context: context,
        message: S.current.unexpectedErrorOccurred,
        isError: true,
      );
    }
  }
}
