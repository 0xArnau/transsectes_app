import 'package:flutter/material.dart';
import 'package:transsectes_app/app/features/contact/presentation/views/contact_view.dart';
import 'package:transsectes_app/app/features/how-to/presentation/views/how_to_view.dart';
import 'package:transsectes_app/app/features/settings/presentation/views/settings_view.dart';
import 'package:transsectes_app/app/features/transects/presentation/views/gps/verify_gps_permissions_view.dart';
import 'package:transsectes_app/app/features/transects/presentation/views/records/record_view.dart';
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
            icon: Icon(
              Icons.settings,
              color: Theme.of(context).colorScheme.secondaryContainer,
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomAppBar(
        child: Image.asset(
          Theme.of(context).brightness == Brightness.dark
              ? 'assets/imgs/logo/GEPEC_EdC_OFICIAL_blanc.png'
              : 'assets/imgs/logo/GEPEC_EdC_OFICIAL.png',
          fit: BoxFit.contain,
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
            onTap: () {
              _navigateToView(context, (context) => const HowToView());
            },
          ),
          _buildRowWidget(
            context: context,
            imgSrc: 'assets/imgs/icons/route.png',
            imgSize: MediaQuery.of(context).size.width / 2,
            text: S.of(context).start_transect,
            textFirst: true,
            onTap: () {
              _navigateToView(
                  context, (context) => const VerifyGpsPermissionsView());
            },
          ),
          _buildRowWidget(
            context: context,
            imgSrc: 'assets/imgs/icons/book.png',
            imgSize: MediaQuery.of(context).size.width / 2.5,
            text: S.of(context).transect_records,
            textFirst: false,
            onTap: () {
              _navigateToView(context, (context) => const RecordView());
            },
          ),
          _buildRowWidget(
            context: context,
            imgSrc: 'assets/imgs/icons/contact.png',
            imgSize: MediaQuery.of(context).size.width / 3.5,
            text: S.of(context).contact,
            textFirst: true,
            onTap: () {
              _navigateToView(context, (context) => ContactView());
            },
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

  /// Navigates to a new view by pushing a [MaterialPageRoute] onto the navigation stack.
  ///
  /// This function is a helper for navigating to a new screen in the app. It creates
  /// a new `MaterialPageRoute` using the provided [builder] function and pushes it
  /// onto the navigation stack.
  ///
  /// Example usage:
  /// ```dart
  /// _navigateToView(context, (context) => MyNewScreen());
  /// ```
  ///
  /// - [context]: The `BuildContext` of the current widget.
  /// - [builder]: A function that returns the widget to display as the new screen.
  ///
  /// Parameters:
  /// * [BuildContext] context: The current widget's build context.
  /// * [Widget Function(BuildContext)] builder: A callback that builds the target widget.
  ///
  /// Returns:
  /// This method doesn't return a value. It triggers navigation to the target view.
  void _navigateToView(
      BuildContext context, Widget Function(BuildContext) builder) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: builder),
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
        color: Theme.of(context).colorScheme.onSurface,
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
