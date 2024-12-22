import 'package:flutter/material.dart';
import 'package:transsectes_app/app/core/widgets/custom_button.dart';
import 'package:transsectes_app/app/core/widgets/custom_text_form.dart';
import 'package:transsectes_app/app/core/widgets/wave_shape_widget.dart';
import 'package:transsectes_app/generated/l10n.dart';

/// SignInView is the main view for the sign-in screen.
/// It provides a user interface for email and password input, and navigation to
/// forgot password and sign-up screens.
class SignInView extends StatefulWidget {
  const SignInView({super.key});

  static const path = "/sign-in";

  @override
  State<SignInView> createState() => _SignInViewState();
}

class _SignInViewState extends State<SignInView> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Center(
        child: Column(
          children: [
            _buildHeader(context),
            const Spacer(),
            _buildBody(context),
          ],
        ),
      ),
    );
  }

  /// Builds the header with a circular decoration and title text.
  Widget _buildHeader(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: MediaQuery.of(context).size.height / 4 + 10,
      child: Stack(
        alignment: Alignment.topCenter,
        children: [
          Positioned(
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
          ),
          SafeArea(
            child: Text(
              'Transsectes APP',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 48,
                fontWeight: FontWeight.bold,
                color: Theme.of(context).colorScheme.onSurface,
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// Builds the main body containing input fields, buttons, and decorations.
  Widget _buildBody(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        const WaveShapeWidget(),
        Align(
          alignment: Alignment.bottomRight,
          child: SafeArea(
            child: Image.asset(
              'assets/imgs/background/imatge_tortuga.png',
              fit: BoxFit.fitWidth,
              height: MediaQuery.of(context).size.width / 1.12,
            ),
          ),
        ),
        Positioned(
          top: 0,
          child: Container(
            padding: const EdgeInsets.all(10.0),
            width: MediaQuery.of(context).size.width,
            child: Column(
              children: [
                _buildEmailField(),
                const SizedBox(height: 20),
                _buildPasswordField(),
                _buildForgotPasswordButton(context),
              ],
            ),
          ),
        ),
        Positioned(
          bottom: 0,
          child: Container(
            padding: const EdgeInsets.all(10.0),
            width: MediaQuery.of(context).size.width,
            child: Column(
              children: [
                _buildActionButtons(context),
                _buildFooterImage(),
              ],
            ),
          ),
        ),
      ],
    );
  }

  /// Builds the email input field.
  Widget _buildEmailField() {
    return CustomTextForm(
      controller: _emailController,
      hintText: S.current.email,
      obscureText: false,
      prefixIcon: const Icon(Icons.email_outlined),
    );
  }

  /// Builds the password input field.
  Widget _buildPasswordField() {
    return CustomTextForm(
      controller: _passwordController,
      hintText: S.current.password,
      obscureText: true,
      prefixIcon: const Icon(Icons.password_outlined),
    );
  }

  /// Builds the forgot password button.
  Widget _buildForgotPasswordButton(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: TextButton(
        onPressed: () {
          // Navigate to the forgot password screen.
        },
        child: Container(
          padding: const EdgeInsets.fromLTRB(17, 3, 17, 3),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            gradient: LinearGradient(
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
              colors: List.filled(
                4,
                Theme.of(context).colorScheme.onSurface.withAlpha(150),
              ),
            ),
          ),
          child: Text(
            S.current.forgot_password,
            style: TextStyle(
              color: Theme.of(context).colorScheme.surface,
              decoration: TextDecoration.underline,
              decorationColor: Theme.of(context).colorScheme.surface,
            ),
          ),
        ),
      ),
    );
  }

  /// Builds the login and sign-up action buttons.
  Widget _buildActionButtons(BuildContext context) {
    return Column(
      children: [
        CustomButton(
          text: S.current.login,
          onTap: () {
            // Handle login action.
          },
        ),
        TextButton(
          onPressed: () {
            // Navigate to the sign-up screen.
          },
          child: Container(
            padding: const EdgeInsets.fromLTRB(17, 3, 17, 3),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              gradient: LinearGradient(
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
                colors: List.filled(
                  4,
                  Theme.of(context).colorScheme.onSurface.withAlpha(150),
                ),
              ),
            ),
            child: Text(
              '${S.current.no_account} ${S.current.signup}',
              style: TextStyle(
                color: Theme.of(context).colorScheme.surface,
                decoration: TextDecoration.underline,
                decorationColor: Theme.of(context).colorScheme.surface,
              ),
            ),
          ),
        ),
      ],
    );
  }

  /// Builds the footer image for the app logo.
  Widget _buildFooterImage() {
    return SafeArea(
      child: SizedBox(
        width: double.infinity,
        child: Image.asset(
          'assets/imgs/logo/GEPEC_EdC_OFICIAL_blanc.png',
          fit: BoxFit.fitWidth,
        ),
      ),
    );
  }
}
