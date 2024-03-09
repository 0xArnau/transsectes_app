import 'package:go_router/go_router.dart';
import 'package:transsectes_app/src/auth/views/forgot_password_view.dart';
import 'package:transsectes_app/src/auth/views/login_view.dart';
import 'package:transsectes_app/src/auth/views/sign_up_view.dart';
import 'package:transsectes_app/src/auth/widget_tree.dart';
import 'package:transsectes_app/src/contact/views/contact_view.dart';
import 'package:transsectes_app/src/how_to_transect/views/how_to_transect_view.dart';
import 'package:transsectes_app/src/splash/views/splash_view.dart';
import 'package:transsectes_app/src/start_stop_transecte/views/start_stop_transecte_view.dart';
import 'package:transsectes_app/src/transect_records/views/transect_records_view.dart';
import 'package:transsectes_app/src/utils/routes/custom_transition_route.dart';

import '../home/views/home_view.dart';

GoRouter router = GoRouter(
  routes: [
    GoRoute(
      path: WidgetTree.path,
      pageBuilder: (context, state) {
        return CustomTransitionRoute.transition(view: const WidgetTree());
      },
    ),
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
    GoRoute(
      path: HowToTransectView.path,
      pageBuilder: (context, state) {
        return CustomTransitionRoute.transition(
          view: const HowToTransectView(),
        );
      },
    ),
    GoRoute(
      path: StartStopTransecteView.path,
      pageBuilder: (context, state) {
        return CustomTransitionRoute.transition(
          view: const StartStopTransecteView(),
        );
      },
    ),
    GoRoute(
      path: TransectRecordsView.path,
      pageBuilder: (context, state) {
        return CustomTransitionRoute.transition(
          view: const TransectRecordsView(),
        );
      },
    ),
    GoRoute(
      path: ContactView.path,
      pageBuilder: (context, state) {
        return CustomTransitionRoute.transition(
          view: const ContactView(),
        );
      },
    ),
  ],
  // initialLocation: '/splash',
  // overridePlatformDefaultLocation: true,
);
