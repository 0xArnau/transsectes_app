import 'package:flutter/material.dart';
import 'package:transsectes_app/app/features/settings/presentation/views/settings_view.dart';
import 'package:transsectes_app/generated/l10n.dart';

/// HomeView represents the main screen of the application.
/// It displays a list of options with associated images and navigates to specific actions.
class HomeView extends StatefulWidget {
  const HomeView({super.key});

  static const path = '/home';

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Transsectes APP'),
        actions: [
          IconButton(
            onPressed: () {
              _navigateToSettings(context);
            },
            icon: const Icon(Icons.settings),
          ),
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
      body: ListView(
        children: [
          _buildRowWidget(
            context: context,
            imgSrc: 'assets/imgs/icons/walk.png',
            imgSize: MediaQuery.of(context).size.width / 3,
            text: S.of(context).how2transect,
            textFirst: false,
            onTap: () {},
          ),
          _buildRowWidget(
            context: context,
            imgSrc: 'assets/imgs/icons/route.png',
            imgSize: MediaQuery.of(context).size.width / 2,
            text: S.of(context).start_transect,
            textFirst: true,
            onTap: () {},
          ),
          _buildRowWidget(
            context: context,
            imgSrc: 'assets/imgs/icons/book.png',
            imgSize: MediaQuery.of(context).size.width / 2.5,
            text: S.of(context).transect_records,
            textFirst: false,
            onTap: () {},
          ),
          _buildRowWidget(
            context: context,
            imgSrc: 'assets/imgs/icons/contact.png',
            imgSize: MediaQuery.of(context).size.width / 3.5,
            text: S.of(context).contact,
            textFirst: true,
            onTap: () {},
          ),
        ],
      ),
    );
  }

  /// Navigates to the SettingsView.
  void _navigateToSettings(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const SettingsView()),
    );
  }
}

/// Builds a flexible row widget that can display an image and text.
/// The order of the image and text can be controlled using [textFirst].
///
/// Parameters:
/// - [context]: Build context.
/// - [imgSrc]: Path to the image asset.
/// - [imgSize]: Size of the image.
/// - [text]: Text to display alongside the image.
/// - [textFirst]: If true, the text appears before the image; otherwise, the image appears first.
/// - [onTap]: Function to execute when the row is tapped.
Widget _buildRowWidget({
  required BuildContext context,
  required String imgSrc,
  required double imgSize,
  required String text,
  required bool textFirst,
  required VoidCallback? onTap,
}) {
  final textWidget = Flexible(
    child: Text(
      text,
      style: TextStyle(
        fontSize: 20,
        color: Theme.of(context).colorScheme.tertiary,
      ),
      overflow: TextOverflow.clip,
    ),
  );

  final imageWidget = Image.asset(
    imgSrc,
    width: imgSize,
  );

  return InkWell(
    onTap: onTap,
    child: Container(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      width: double.infinity,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: textFirst
            ? [textWidget, const SizedBox(width: 10), imageWidget]
            : [imageWidget, const SizedBox(width: 10), textWidget],
      ),
    ),
  );
}
