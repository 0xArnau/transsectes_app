import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:transsectes_app/generated/l10n.dart';
import 'package:transsectes_app/src/utils/Widgets/android_ios/scaffold_widget.dart';
import 'package:transsectes_app/src/utils/colors.dart';
import 'package:transsectes_app/src/utils/custom_snackbar.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactView extends StatelessWidget {
  ContactView({super.key});

  static const path = '/contact';

  /// Gepec's url website.
  final Uri _url = Uri.parse('https://gepec.cat');

  /// Gepec's email.
  final Uri _emailLaunchUri = Uri(scheme: 'mailto', path: 'especies@gepec.cat');

  /// Gepec's volunteer email.
  final Uri _emailVolunteerLaunchUri =
      Uri(scheme: 'mailto', path: 'voluntariat@gepec.cat');

  /// Gepec's emergency phone.
  final Uri _phoneLaunchUri = Uri(scheme: 'tel', path: '622651374');

  /// Spain emergency phone.
  final Uri _emergencyPhoneLaunchUri = Uri(scheme: 'tel', path: '112');

  @override
  Widget build(BuildContext context) {
    return scaffoldWidget(
      context: context,
      title: S.current.contact,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
          child: ListView(
            children: [
              Text(
                S.current.contact_1,
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 18),
              ),
              GestureDetector(
                onTap: () => _launchUrl(
                  context,
                  _emergencyPhoneLaunchUri,
                  S.current.contact_error_phone,
                ),
                onLongPress: () async {
                  Clipboard.setData(
                    ClipboardData(text: _emergencyPhoneLaunchUri.path),
                  ).then(
                    (_) => CustomSnackbar.info(
                      context,
                      S.current.contact_clipboard_phone,
                    ),
                  );
                },
                child: Text(
                  _emergencyPhoneLaunchUri.path,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 46,
                    color: kColorTextAccent,
                  ),
                ),
              ),
              SizedBox(height: MediaQuery.of(context).size.height / 16),
              Text(
                S.current.contact_2,
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 18),
              ),
              // Emails
              GestureDetector(
                onTap: () => _launchUrl(
                  context,
                  _emailLaunchUri,
                  S.current.contact_error_email,
                ),
                onLongPress: () async {
                  Clipboard.setData(
                    ClipboardData(text: _emailLaunchUri.path),
                  ).then(
                    (_) => CustomSnackbar.info(
                      context,
                      S.current.contact_clipboard_email,
                    ),
                  );
                },
                child: Text(
                  _emailLaunchUri.path,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 30,
                    color: kColorTextAccent,
                  ),
                ),
              ),
              GestureDetector(
                onTap: () => _launchUrl(
                  context,
                  _emailVolunteerLaunchUri,
                  S.current.contact_error_email,
                ),
                onLongPress: () async {
                  Clipboard.setData(
                    ClipboardData(text: _emailVolunteerLaunchUri.path),
                  ).then(
                    (_) => CustomSnackbar.info(
                      context,
                      S.current.contact_clipboard_email,
                    ),
                  );
                },
                child: Text(
                  _emailVolunteerLaunchUri.path,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 30,
                    color: kColorTextAccent,
                  ),
                ),
              ),
              SizedBox(height: MediaQuery.of(context).size.height / 16),
              Text(
                S.current.contact_3,
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 18),
              ),
              // Phone number
              GestureDetector(
                onTap: () => _launchUrl(
                  context,
                  _phoneLaunchUri,
                  S.current.contact_error_phone,
                ),
                onLongPress: () async {
                  Clipboard.setData(
                    ClipboardData(text: _phoneLaunchUri.path),
                  ).then(
                    (_) => CustomSnackbar.info(
                      context,
                      S.current.contact_clipboard_phone,
                    ),
                  );
                },
                child: Text(
                  _phoneLaunchUri.path,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 30,
                    color: kColorTextAccent,
                  ),
                ),
              ),
              SizedBox(height: MediaQuery.of(context).size.height / 16),
              // webpage
              Text(
                S.current.contact_4,
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 18),
              ),
              GestureDetector(
                onTap: () => _launchUrl(
                  context,
                  _url,
                  S.current.contact_error_website,
                ),
                onLongPress: () async {
                  Clipboard.setData(
                    ClipboardData(text: _url.path),
                  ).then(
                    (_) => CustomSnackbar.info(
                      context,
                      S.current.contact_clipboard_website,
                    ),
                  );
                },
                child: Text(
                  _url.toString(),
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 30,
                    color: kColorTextAccent,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _launchUrl(BuildContext context, Uri url, String error) async {
    if (!await launchUrl(url)) {
      CustomSnackbar.error(context, error);
    }
  }
}
