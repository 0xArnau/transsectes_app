import 'package:go_router/go_router.dart';
import 'package:transsectes_app/src/utils/routes/custom_transition_route.dart';

import '../home/views/home_view.dart';

GoRouter router = GoRouter(routes: [
  GoRoute(
    path: HomeView.path,
    pageBuilder: (context, state) {
      return CustomTransitionRoute.transition(view: const HomeView());
    },
  ),
]);
