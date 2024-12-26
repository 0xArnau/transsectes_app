import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logger/logger.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:transsectes_app/app/core/providers/user_provider.dart';
import 'package:transsectes_app/app/core/states/user_state.dart';
import 'package:transsectes_app/app/core/widgets/custom_button.dart';
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
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(next.errorMessage!),
            backgroundColor: Colors.redAccent,
          ),
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
        title: const Text('Settings'),
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

                  _openSettings()

                  // TODO: change language
                ],
              ),
            ),

            // TODO: delete account
            const SizedBox(height: 16),
            CustomButton(
              text: S.current.delete_account,
              isADestructiveAction: true,
              onTap: () {},
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
        semanticLabel: 'User icon',
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
