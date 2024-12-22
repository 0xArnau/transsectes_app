import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logger/logger.dart';
import 'package:transsectes_app/app/core/providers/user_provider.dart';
import 'package:transsectes_app/generated/l10n.dart';

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
    final userState = ref.read(currentUserStateProvider);
    final isUserTechnician = userState.user?.isTechnician ?? false;
    final userEmail = userState.user?.email;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      bottomNavigationBar: SafeArea(
        child: Image.asset(
          Theme.of(context).brightness == Brightness.dark
              ? 'assets/imgs/logo/GEPEC_EdC_OFICIAL_blanc.png'
              : 'assets/imgs/logo/GEPEC_EdC_OFICIAL.png',
          fit: BoxFit.fitWidth,
        ),
      ),
      body: ListView(
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
        ],
      ),
    );
  }

  /// Builds a user icon widget.
  Widget _userIcon(BuildContext context) {
    return Center(
      child: Icon(
        Icons.person,
        size: MediaQuery.of(context).size.height / 6,
        semanticLabel: 'User icon',
      ),
    );
  }

  /// Builds a widget displaying the user's role if the user is a technician.
  Widget _showRole() {
    return Center(
      child: Text(S.current.technician),
    );
  }

  /// Builds a widget to display and toggle the visibility of the user's email.
  Widget _userEmail({
    required BuildContext context,
    required bool showEmail,
    required String email,
    required VoidCallback toggle,
  }) {
    Logger().d([showEmail, email, _obfuscateString(email)]);

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
}

String _obfuscateString(String text) {
  return '*' * text.length;
}
