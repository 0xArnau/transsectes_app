import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:transsectes_app/app/core/widgets/custom_button.dart';
import 'package:transsectes_app/app/core/widgets/custom_text_form.dart';
import 'package:transsectes_app/app/core/widgets/float_snackbar.dart';
import 'package:transsectes_app/app/core/widgets/pdf_viewer_widget.dart';
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
  bool _avisLegal = false;
  bool _clausulaInformativa = false;
  bool _privacitat = false;

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
  Future<void> _onSignUp(
    SignUpViewModel viewModel,
    BuildContext context,
  ) async {
    try {
      viewModel.validateLegal(
        _avisLegal,
        _clausulaInformativa,
        _clausulaInformativa,
      );

      await viewModel.createAccount(
        email: _emailController.text,
        emailCopy: _emailConfirmController.text,
        password: _passwordController.text,
        passwordCopy: _passwordConfirmController.text,
        avis: _avisLegal,
        clausulaInformativa: _clausulaInformativa,
        privacitat: _privacitat,
      );
      _showSnackBar(
          S.current.signUpSuccessfulClickToSendVerificationEmail, false);

      if (context.mounted && Navigator.canPop(context)) {
        Navigator.pop(context);
      }
    } catch (e) {
      _showSnackBar(e.toString(), true);
    }
  }

  /// Displays a message in a `SnackBar`.
  ///
  /// [message]: The message to display.
  /// [isError]: Whether the message is an error or not.
  void _showSnackBar(String message, bool isError) {
    floatSnackbar(
      context: context,
      message: message,
      isError: isError,
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
          hintText: S.current.email,
          obscureText: false,
          prefixIcon: const Icon(Icons.email_outlined),
        ),
        const SizedBox(height: 16),
        CustomTextForm(
          controller: _emailConfirmController,
          hintText: S.current.confirm_email,
          obscureText: false,
          prefixIcon: const Icon(Icons.email_outlined),
        ),
        const SizedBox(height: 16),
        CustomTextForm(
          controller: _passwordController,
          hintText: S.current.password,
          obscureText: true,
          prefixIcon: const Icon(Icons.lock_outline),
        ),
        const SizedBox(height: 16),
        CustomTextForm(
          controller: _passwordConfirmController,
          hintText: S.current.confirm_password,
          obscureText: true,
          prefixIcon: const Icon(Icons.lock_outline),
        ),
        const SizedBox(height: 16),
        CustomButton(
          text: S.current.next,
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
        _checkboxPdfTile(
          context: context,
          checkbox: _avisLegal,
          onChanged: (value) {
            if (mounted) {
              setState(() {
                _avisLegal = value;
              });
            }
          },
          text: S.current.legalNotice,
          path: 'assets/docs/legal/avis-legal.pdf',
          value: _avisLegal,
        ),
        _checkboxPdfTile(
          context: context,
          checkbox: _clausulaInformativa,
          onChanged: (value) {
            if (mounted) {
              setState(() {
                _clausulaInformativa = value;
              });
            }
          },
          text: S.current.informativeClause,
          path: 'assets/docs/legal/clausula-informativa.pdf',
          value: _clausulaInformativa,
        ),
        _checkboxPdfTile(
          context: context,
          checkbox: _privacitat,
          onChanged: (value) {
            if (mounted) {
              setState(() {
                _privacitat = value;
              });
            }
          },
          text: S.current.privacy,
          path: 'assets/docs/legal/privacitat.pdf',
          value: _privacitat,
        ),
        const SizedBox(height: 16),
        CustomButton(
          text: S.current.signup,
          onTap: () => _onSignUp(viewModel, context),
          isMainAction: true,
        ),
        const SizedBox(height: 16),
        CustomButton(
          text: S.current.back,
          onTap: () {
            setState(() {
              _isFirstPhase = true;
            });
          },
        ),
      ],
    );
  }

  Widget _checkboxPdfTile({
    required BuildContext context,
    required bool checkbox,
    required Function(bool) onChanged,
    required String text,
    required String path,
    required bool value,
  }) {
    return ListTile(
      leading: Semantics(
        label: text,
        value: value ? 'Marcado' : 'Desmarcado',
        child: Checkbox(
          activeColor: Theme.of(context).colorScheme.primary,
          value: checkbox,
          onChanged: (value) => onChanged(value ?? false),
        ),
      ),
      title: TextButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => PdfViewerWidget(
                title: text,
                asset: path,
                fileName: text,
              ),
            ),
          );
        },
        style: ElevatedButton.styleFrom(
          foregroundColor: Theme.of(context).colorScheme.primary,
          surfaceTintColor: Theme.of(context).colorScheme.primary,
        ),
        child: Text(
          text,
        ),
      ),
      trailing: const Icon(Icons.picture_as_pdf),
    );
  }
}
