import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:smart_digital_wallet/src/core/common/di/injection_container.dart';
import 'package:smart_digital_wallet/src/core/common/routes/app_route_names.dart';
import 'package:smart_digital_wallet/src/core/features/auth/presentation/views/signin_view.dart';
import 'package:smart_digital_wallet/src/core/features/auth/presentation/views/starter_view.dart';
import 'package:smart_digital_wallet/src/core/features/dashboard/presentation/blocs/bloc/dashboard_bloc.dart';
import 'package:smart_digital_wallet/src/core/features/dashboard/presentation/views/dashboard_view.dart';

final GoRouter appRouter = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(path: signInRoute, builder: (context, state) => const SignInView()),
    GoRoute(
      path: starterRoute,
      builder: (context, state) => const StarterView(),
    ),
    GoRoute(
      path: dashboardRoute,
      builder: (context, state) => BlocProvider(
        create: (context) => sl<DashboardBloc>()..add(GetAccountsEvent()),
        child: const DashboardView(),
      ),
    ),
  ],
  redirect: (context, state) {
    if (state.uri.path == '/' || state.uri.path == dashboardRoute) {
      return dashboardRoute;
    }
    return null;
  },
);
