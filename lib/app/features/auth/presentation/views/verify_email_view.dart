import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:transsectes_app/app/core/widgets/float_snackbar.dart';
import 'package:transsectes_app/app/features/auth/presentation/providers/verify_email_view_model_provider.dart';
import 'package:transsectes_app/app/core/widgets/custom_button.dart';

class VerifyEmailView extends ConsumerStatefulWidget {
  const VerifyEmailView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _VerifyEmailViewState();
}

class _VerifyEmailViewState extends ConsumerState<VerifyEmailView> {
  bool _isLoading = false;

  /// Toggles the loading state to show feedback during async operations.
  void _setLoading(bool value) {
    if (mounted) {
      setState(() {
        _isLoading = value;
      });
    }
  }

  /// Handles the async operation and displays the result in a SnackBar.
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
        floatSnackbar(
          context: context,
          message: successMessage,
        );
      }
    } catch (e) {
      if (context.mounted) {
        // TODO: revisar este cambio
        floatSnackbar(
          context: context,
          message: errorMessage,
          isError: true,
        );
      }
    } finally {
      _setLoading(false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = ref.read(verifyEmailViewModelProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Verify Email'),
        actions: [
          TextButton(
            onPressed: () {
              _handleAsyncAction(
                context,
                viewModel.signOut(),
                'Sign out successfully!',
                'Error, cannot sign out',
              );
            },
            child: Text(
              'Exit',
              style: TextStyle(color: Colors.red),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Center(
          child: _isLoading
              ? const CircularProgressIndicator() // Show loading spinner during async actions
              : Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    CustomButton(
                      text: 'Send Verification Email',
                      onTap: () {
                        _handleAsyncAction(
                          context,
                          viewModel.sendEmail(),
                          'Verification email sent!',
                          'Error sending verification email',
                        );
                      },
                      isMainAction: true,
                    ),
                    const SizedBox(height: 16), // Space between buttons
                    CustomButton(
                      text: 'Reload',
                      onTap: () {
                        _handleAsyncAction(
                          context,
                          viewModel.reload(),
                          'Email status reloaded!',
                          'Error reloading email status',
                        );
                      },
                      isMainAction: false,
                    ),
                  ],
                ),
        ),
      ),
    );
  }
}
