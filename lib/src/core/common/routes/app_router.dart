import 'package:go_router/go_router.dart';
import 'package:smart_digital_wallet/src/core/common/routes/app_route_names.dart';
import 'package:smart_digital_wallet/src/core/features/auth/presentation/views/signin_view.dart';
import 'package:smart_digital_wallet/src/core/features/auth/presentation/views/starter_view.dart';

final GoRouter appRouter = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(path: signInRoute, builder: (context, state) => const SignInView()),
    GoRoute(
      path: starterRoute,
      builder: (context, state) => const StarterView(),
    ),
  ],
  redirect: (context, state) {
    if (state.uri.path == '/' || state.uri.path == starterRoute) {
      return starterRoute;
    }
    return null;
  },
);
