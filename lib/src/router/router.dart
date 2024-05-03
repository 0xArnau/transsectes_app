import 'package:go_router/go_router.dart';
import 'package:transsectes_app/src/auth/views/forgot_password_view.dart';
import 'package:transsectes_app/src/auth/views/login_view.dart';
import 'package:transsectes_app/src/auth/views/sign_up_view.dart';
import 'package:transsectes_app/src/auth/widget_tree.dart';
import 'package:transsectes_app/src/contact/views/contact_view.dart';
import 'package:transsectes_app/src/geolocation/views/geolocation_disabled_view.dart';
import 'package:transsectes_app/src/geolocation/views/geolocation_view.dart';
import 'package:transsectes_app/src/how_to_transect/views/how_to_transect_view.dart';
import 'package:transsectes_app/src/splash/views/splash_view.dart';
import 'package:transsectes_app/src/transects/views/form_view.dart';
import 'package:transsectes_app/src/transects/views/start_stop_transecte_view.dart';
import 'package:transsectes_app/src/transects/views/transect_records_view.dart';
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
      path: FormView.path,
      pageBuilder: (context, state) {
        return CustomTransitionRoute.transition(
          view: const FormView(),
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
          view: ContactView(),
        );
      },
    ),
    GoRoute(
      path: GeolocationView.path,
      pageBuilder: (context, state) {
        return CustomTransitionRoute.transition(
          view: const GeolocationView(),
        );
      },
    ),
    GoRoute(
      path: GeolocationDisabledView.path,
      pageBuilder: (context, state) {
        return CustomTransitionRoute.transition(
          view: const GeolocationDisabledView(),
        );
      },
    ),
    // GoRoute(
    //   path: LegalView.path,
    //   pageBuilder: (context, state) {
    //     return CustomTransitionRoute.transition(
    //       view: const LegalView(),
    //     );
    //   },
    // ),
  ],
  // initialLocation: GeolocationView.path,
  // overridePlatformDefaultLocation: true,
);
