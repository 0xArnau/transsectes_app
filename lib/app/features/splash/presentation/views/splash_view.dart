import 'package:flutter/material.dart';
import 'package:transsectes_app/app/core/widgets/wave_shape_widget.dart';
import 'package:transsectes_app/app/features/auth/presentation/views/auth_view.dart';

/// A Splash screen view that shows the app's logo and a background animation.
class SplashView extends StatefulWidget {
  const SplashView({super.key});

  static const String path = '/';

  @override
  State<StatefulWidget> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  @override
  void initState() {
    super.initState();
    _navigateToAuthView();
  }

  /// Navigate to AuthView after a delay of 1 second
  Future<void> _navigateToAuthView() async {
    await Future.delayed(const Duration(seconds: 1));

    if (mounted) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const AuthView()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: Center(
        child: Column(
          children: [
            _buildHeader(context),
            const Spacer(),
            _buildFooter(context),
          ],
        ),
      ),
    );
  }

  /// Builds the top part of the splash screen, including the app logo and circular background.
  Widget _buildHeader(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: MediaQuery.of(context).size.height / 4 + 10,
      child: Stack(
        alignment: Alignment.topCenter,
        children: [
          _buildCircleBackground(context),
          _buildAppTitle(context),
        ],
      ),
    );
  }

  /// Builds the circular background element on the top-right.
  Widget _buildCircleBackground(BuildContext context) {
    return Positioned(
      top: 0,
      right: 0,
      child: Container(
        margin: const EdgeInsets.all(10.0),
        width: MediaQuery.of(context).size.height / 4,
        height: MediaQuery.of(context).size.height / 4,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Theme.of(context).colorScheme.tertiary,
        ),
      ),
    );
  }

  /// Builds the title of the app centered at the top of the splash screen.
  Widget _buildAppTitle(BuildContext context) {
    return SafeArea(
      child: Text(
        'Transsectes APP',
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: 48,
          fontWeight: FontWeight.bold,
          color: Theme.of(context).colorScheme.primary,
        ),
      ),
    );
  }

  /// Builds the footer section of the splash screen, including wave and logo images.
  Widget _buildFooter(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        const WaveShapeWidget(),
        _buildTurtleImage(context),
        _buildLogoImage(context),
      ],
    );
  }

  /// Builds the turtle image positioned at the bottom right.
  Widget _buildTurtleImage(BuildContext context) {
    return Align(
      alignment: Alignment.bottomRight,
      child: SafeArea(
        child: Image.asset(
          'assets/imgs/background/imatge_tortuga.png',
          fit: BoxFit.contain,
          height: MediaQuery.of(context).size.height / 2.3,
        ),
      ),
    );
  }

  /// Builds the main logo image centered at the bottom.
  Widget _buildLogoImage(BuildContext context) {
    return SafeArea(
      child: SizedBox(
        width: double.infinity,
        child: Image.asset(
          Theme.of(context).brightness == Brightness.dark
              ? 'assets/imgs/logo/GEPEC_EdC_OFICIAL_blanc.png'
              : 'assets/imgs/logo/GEPEC_EdC_OFICIAL.png',
          fit: BoxFit.contain,
        ),
      ),
    );
  }
}
