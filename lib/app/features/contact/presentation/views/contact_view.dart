import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:transsectes_app/app/core/widgets/float_snackbar.dart';
import 'package:transsectes_app/generated/l10n.dart';
import 'package:url_launcher/url_launcher.dart';

/// A view to display contact information for the GEPEC organization.
/// This includes emergency contacts, email addresses, and a website link.
class ContactView extends StatelessWidget {
  ContactView({super.key});

  static const path = '/contact';

  /// GEPEC's website URL.
  final Uri _url = Uri(scheme: 'https', path: 'gepec.cat');

  /// GEPEC's email.
  final Uri _emailLaunchUri = Uri(scheme: 'mailto', path: 'especies@gepec.cat');

  /// GEPEC's volunteer email.
  final Uri _emailVolunteerLaunchUri =
      Uri(scheme: 'mailto', path: 'voluntariat@gepec.cat');

  /// GEPEC's emergency phone number.
  final Uri _phoneLaunchUri = Uri(scheme: 'tel', path: '622651374');

  /// Spain's general emergency phone number.
  final Uri _emergencyPhoneLaunchUri = Uri(scheme: 'tel', path: '112');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(S.current.contact),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: ListView(
            children: [
              _buildSectionTitle(S.current.contact_1),
              _buildInteractiveText(
                context: context,
                uri: _emergencyPhoneLaunchUri,
                errorMessage: S.current.contact_error_phone,
                clipboardMessage: S.current.contact_clipboard_phone,
                fontSize: 46,
              ),
              _spacer(context),
              _buildSectionTitle(S.current.contact_2),
              _buildInteractiveText(
                context: context,
                uri: _emailLaunchUri,
                errorMessage: S.current.contact_error_email,
                clipboardMessage: S.current.contact_clipboard_email,
              ),
              _buildInteractiveText(
                context: context,
                uri: _emailVolunteerLaunchUri,
                errorMessage: S.current.contact_error_email,
                clipboardMessage: S.current.contact_clipboard_email,
              ),
              _spacer(context),
              _buildSectionTitle(S.current.contact_3),
              _buildInteractiveText(
                context: context,
                uri: _phoneLaunchUri,
                errorMessage: S.current.contact_error_phone,
                clipboardMessage: S.current.contact_clipboard_phone,
              ),
              _spacer(context),
              _buildSectionTitle(S.current.contact_4),
              _buildInteractiveText(
                context: context,
                uri: _url,
                errorMessage: S.current.contact_error_website,
                clipboardMessage: S.current.contact_clipboard_website,
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// Builds a title section with the given text.
  Widget _buildSectionTitle(String text) {
    return Text(
      text,
      textAlign: TextAlign.center,
      style: const TextStyle(fontSize: 18),
    );
  }

  /// Builds an interactive text widget that allows the user to tap to launch a URL
  /// or long-press to copy the associated text to the clipboard.
  Widget _buildInteractiveText({
    required BuildContext context,
    required Uri uri,
    required String errorMessage,
    required String clipboardMessage,
    double fontSize = 30,
  }) {
    return GestureDetector(
      onTap: () => _launchUrl(uri, errorMessage, context),
      onLongPress: () async {
        Clipboard.setData(ClipboardData(text: uri.path)).then((_) {
          if (context.mounted) {
            floatSnackbar(
              context: context,
              message: clipboardMessage,
            );
          }
        });
      },
      child: Text(
        uri.path,
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: fontSize,
          color: Theme.of(context).colorScheme.tertiary,
        ),
      ),
    );
  }

  /// Creates a vertical spacer proportional to the screen height.
  Widget _spacer(BuildContext context) {
    return SizedBox(height: MediaQuery.of(context).size.height / 16);
  }

  /// Attempts to launch the provided URL and shows an error message if it fails.
  Future<void> _launchUrl(
      Uri url, String errorMessage, BuildContext context) async {
    if (!await launchUrl(url)) {
      if (context.mounted) {
        floatSnackbar(
          context: context,
          message: errorMessage,
          isError: true,
        );
      }
    }
  }
}
