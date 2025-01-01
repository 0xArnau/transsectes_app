import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:transsectes_app/app/features/auth/presentation/viewmodels/verify_email_view_model.dart';
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
    setState(() {
      _isLoading = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = ref.read(verifyEmailViewModelProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Verify Email'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Center(
          child: _isLoading
              ? const CircularProgressIndicator() // Show loading spinner during async actions
              : Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    CustomButton(
                      text: 'Send Verification Email',
                      onTap: () async {
                        _setLoading(true);
                        try {
                          await viewModel.sendEmail();
                          if (context.mounted) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Verification email sent!'),
                              ),
                            );
                          }
                        } catch (e) {
                          if (context.mounted) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text('Error: $e'),
                              ),
                            );
                          }
                        } finally {
                          _setLoading(false);
                        }
                      },
                      isMainAction: true,
                    ),
                    const SizedBox(height: 16), // Space between buttons
                    CustomButton(
                      text: 'Reload',
                      onTap: () async {
                        _setLoading(true);
                        try {
                          await viewModel.reload();
                          if (context.mounted) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Email status reloaded!'),
                              ),
                            );
                          }
                        } catch (e) {
                          if (context.mounted) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text('Error: $e'),
                              ),
                            );
                          }
                        } finally {
                          _setLoading(false);
                        }
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
