import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logger/logger.dart';
import 'package:transsectes_app/app/features/auth/presentation/providers/auth_view_model_provider.dart';
import 'package:transsectes_app/app/features/auth/presentation/views/sign_in_view.dart';
import 'package:transsectes_app/app/core/providers/user_provider.dart';
import 'package:transsectes_app/app/features/auth/presentation/views/verify_email_view.dart';
import 'package:transsectes_app/app/features/home/presentation/views/home_view.dart';
import 'package:transsectes_app/generated/l10n.dart';

/// A widget responsible for displaying the authentication state of the user.
///
/// This widget listens to the changes in the authentication state and:
/// - Shows a loading screen while authentication is in progress.
/// - Navigates to the appropriate screen based on the authentication status:
///   - SignInView if no user is authenticated.
///   - HomeView if the user is authenticated and email is verified.
///   - VerifyEmailView if the user is authenticated but email is not verified.
class AuthView extends ConsumerStatefulWidget {
  const AuthView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _AuthViewState();
}

class _AuthViewState extends ConsumerState<AuthView> {
  @override
  void initState() {
    super.initState();
    // Initialize the AuthViewModel when the widget is created
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // Calling initialize on AuthViewModel
      ref.read(authViewModelProvider).initialize();
    });
  }

  @override
  Widget build(BuildContext context) {
    final userState = ref.watch(currentUserStateProvider);

    Logger().d(userState);

    // Show loading if the state is loading
    if (userState.isLoading) {
      return const Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    // Handle navigation based on user state
    if (userState.user == null) {
      // If no user is authenticated, navigate to the SignInView
      return const SignInView();
    }

    // If the user is authenticated but email is not verified, navigate to VerifyEmailView
    if (userState.user!.isAuthenticated && !userState.user!.isEmailVerified) {
      return const VerifyEmailView();
    }

    // If the user is authenticated and email is verified, navigate to HomeView
    if (userState.user!.isAuthenticated && userState.user!.isEmailVerified) {
      return const HomeView();
    }

    // In case no conditions match (shouldn't reach here normally)
    return Scaffold(
      body: Center(
        child: Text(S.current.unexpectedErrorOccurred),
      ),
    );
  }
}
