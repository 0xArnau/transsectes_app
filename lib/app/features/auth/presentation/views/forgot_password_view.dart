import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:transsectes_app/app/core/widgets/custom_button.dart';
import 'package:transsectes_app/app/core/widgets/custom_text_form.dart';
import 'package:transsectes_app/app/features/auth/presentation/providers/forgot_password_view_model_provider.dart';
import 'package:transsectes_app/generated/l10n.dart';

/// A view that allows the user to initiate the password recovery process by entering their email.
class ForgotPasswordView extends ConsumerStatefulWidget {
  const ForgotPasswordView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _ForgotPasswordViewState();
}

class _ForgotPasswordViewState extends ConsumerState<ForgotPasswordView> {
  final _emailController = TextEditingController();
  bool _isLoading = false;

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  /// Toggles the loading state to provide feedback during asynchronous operations.
  ///
  /// This method updates the UI by switching between loading and ready states.
  void _setLoading(bool value) {
    if (mounted) {
      setState(() {
        _isLoading = value;
      });
    }
  }

  /// Handles the async operation and displays the result in a SnackBar.
  ///
  /// [context] The context used to display the SnackBar.
  /// [action] The async action to perform (e.g., sending the password reset email).
  /// [successMessage] Message to display on success.
  /// [errorMessage] Message to display if an error occurs.
  Future<void> _handleAsyncAction(
    BuildContext context,
    Future<void> action,
    String successMessage,
    String errorMessage,
  ) async {
    _setLoading(true);
    try {
      await action;
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(successMessage)),
        );
      }
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(errorMessage)),
        );
      }
    } finally {
      _setLoading(false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = ref.read(forgotPasswordViewModelProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text(S.current.forgot_password),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Center(
          child: _isLoading
              ? const CircularProgressIndicator() // Show loading spinner during async actions
              : Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CustomTextForm(
                      controller: _emailController,
                      hintText: S.current.email,
                      obscureText: false,
                      prefixIcon: const Icon(Icons.email_outlined),
                    ),
                    const SizedBox(height: 16),
                    CustomButton(
                      text: 'Send Verification Email',
                      onTap: () {
                        _handleAsyncAction(
                          context,
                          viewModel.sendEmail(_emailController.text),
                          'Email sent',
                          'Error sending the email',
                        );
                      },
                    ),
                  ],
                ),
        ),
      ),
    );
  }
}
