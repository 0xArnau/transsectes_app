import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:transsectes_app/app/core/widgets/custom_button.dart';
import 'package:transsectes_app/app/core/widgets/custom_text_form.dart';
import 'package:transsectes_app/app/features/auth/presentation/providers/sign_up_view_model_provider.dart';
import 'package:transsectes_app/app/features/auth/presentation/viewmodels/sign_up_view_model.dart';
import 'package:transsectes_app/generated/l10n.dart';

/// A stateful widget that represents the sign-up screen of the application.
/// This widget is divided into two phases:
/// 1. Collecting email and password information.
/// 2. Accepting terms and finalizing account creation.
class SignUpView extends ConsumerStatefulWidget {
  const SignUpView({super.key});

  /// The route path for the sign-up screen.
  static const path = '/sign-up';

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SignUpViewState();
}

class _SignUpViewState extends ConsumerState<SignUpView> {
  final _emailController = TextEditingController();
  final _emailConfirmController = TextEditingController();
  final _passwordController = TextEditingController();
  final _passwordConfirmController = TextEditingController();

  /// Tracks the current phase of the sign-up process.
  bool _isFirstPhase = true;

  /// Tracks whether the user has accepted the terms and conditions.
  bool _termsAccepted = false;

  @override
  void dispose() {
    _emailController.dispose();
    _emailConfirmController.dispose();
    _passwordController.dispose();
    _passwordConfirmController.dispose();
    super.dispose();
  }

  /// Handles the transition from the first to the second phase by validating
  /// the user's input credentials.
  ///
  /// Throws an error if validation fails and displays a message.
  void _goToNextPhase(SignUpViewModel viewModel) {
    try {
      viewModel.validateCredentials(
        email: _emailController.text,
        emailCopy: _emailConfirmController.text,
        password: _passwordController.text,
        passwordCopy: _passwordConfirmController.text,
      );
      setState(() {
        _isFirstPhase = false;
      });
    } catch (e) {
      _showSnackBar(e.toString(), true);
    }
  }

  /// Handles the final sign-up action by validating terms acceptance and
  /// interacting with the view model to create an account.
  Future<void> _onSignUp(SignUpViewModel viewModel) async {
    if (!_termsAccepted) {
      _showSnackBar('You must accept the terms and conditions', true);
      return;
    }

    try {
      await viewModel.createAccount();
      _showSnackBar('Sign up successful', false);
    } catch (e) {
      _showSnackBar('Failed to sign up: $e', true);
    }
  }

  /// Displays a message in a `SnackBar`.
  ///
  /// [message]: The message to display.
  /// [isError]: Whether the message is an error or not.
  void _showSnackBar(String message, bool isError) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          message,
          style: TextStyle(
            color: isError
                ? Theme.of(context).colorScheme.onError
                : Theme.of(context).colorScheme.surface,
          ),
        ),
        backgroundColor: isError
            ? Theme.of(context).colorScheme.error
            : Theme.of(context).colorScheme.onSurface,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final signUpViewModel = ref.watch(signUpViewModelProvider);

    return Scaffold(
      appBar: AppBar(title: Text(S.current.signup)),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: _isFirstPhase
            ? _buildFirstPhase(signUpViewModel)
            : _buildSecondPhase(signUpViewModel),
      ),
    );
  }

  /// Builds the first phase UI where the user inputs email and password.
  Widget _buildFirstPhase(SignUpViewModel viewModel) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        CustomTextForm(
          controller: _emailController,
          hintText: 'Email',
          obscureText: false,
          prefixIcon: const Icon(Icons.email_outlined),
        ),
        const SizedBox(height: 16),
        CustomTextForm(
          controller: _emailConfirmController,
          hintText: 'Confirm Email',
          obscureText: false,
          prefixIcon: const Icon(Icons.email_outlined),
        ),
        const SizedBox(height: 16),
        CustomTextForm(
          controller: _passwordController,
          hintText: 'Password',
          obscureText: true,
          prefixIcon: const Icon(Icons.lock_outline),
        ),
        const SizedBox(height: 16),
        CustomTextForm(
          controller: _passwordConfirmController,
          hintText: 'Confirm Password',
          obscureText: true,
          prefixIcon: const Icon(Icons.lock_outline),
        ),
        const SizedBox(height: 16),
        CustomButton(
          text: 'Next',
          onTap: () => _goToNextPhase(viewModel),
        ),
      ],
    );
  }

  /// Builds the second phase UI where the user accepts terms and finalizes sign-up.
  Widget _buildSecondPhase(SignUpViewModel viewModel) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        CheckboxListTile(
          value: _termsAccepted,
          onChanged: (value) {
            setState(() {
              _termsAccepted = value ?? false;
            });
          },
          title: const Text('I accept the terms and conditions'), // TODO
        ),
        const SizedBox(height: 16),
        CustomButton(
          text: 'Sign Up',
          onTap: () => _onSignUp(viewModel),
          isMainAction: true,
        ),
        const SizedBox(height: 16),
        CustomButton(
          text: 'Back',
          onTap: () {
            setState(() {
              _isFirstPhase = true;
            });
          },
        ),
      ],
    );
  }
}
