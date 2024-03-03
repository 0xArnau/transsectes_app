import 'package:go_router/go_router.dart';
import 'package:transsectes_app/src/auth/views/forgot_password_view.dart';
import 'package:transsectes_app/src/auth/views/login_view.dart';
import 'package:transsectes_app/src/auth/views/sign_up_view.dart';
import 'package:transsectes_app/src/splash/views/splash_view.dart';
import 'package:transsectes_app/src/utils/routes/custom_transition_route.dart';

import '../home/views/home_view.dart';

GoRouter router = GoRouter(
  routes: [
    GoRoute(
      path: HomeView.path,
      pageBuilder: (context, state) {
        return CustomTransitionRoute.transition(view: const HomeView());
      },
    ),
    GoRoute(
      path: SplashView.path,
      pageBuilder: (context, state) {
        return CustomTransitionRoute.transition(view: const SplashView());
      },
    ),
    GoRoute(
      path: LoginView.path,
      pageBuilder: (context, state) {
        return CustomTransitionRoute.transition(view: const LoginView());
      },
    ),
    GoRoute(
      path: SignUpView.path,
      pageBuilder: (context, state) {
        return CustomTransitionRoute.transition(view: const SignUpView());
      },
    ),
    GoRoute(
      path: ForgotPasswordView.path,
      pageBuilder: (context, state) {
        return CustomTransitionRoute.transition(
          view: const ForgotPasswordView(),
        );
      },
    ),
  ],
  initialLocation: '/login',
  overridePlatformDefaultLocation: true,
);
