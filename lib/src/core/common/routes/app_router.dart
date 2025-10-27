import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:smart_digital_wallet/src/core/common/di/injection_container.dart';
import 'package:smart_digital_wallet/src/core/common/routes/app_route_names.dart';
import 'package:smart_digital_wallet/src/core/features/auth/presentation/views/signin_view.dart';
import 'package:smart_digital_wallet/src/core/features/auth/presentation/views/starter_view.dart';
import 'package:smart_digital_wallet/src/core/features/dashboard/domain/entities/account_entity.dart';
import 'package:smart_digital_wallet/src/core/features/dashboard/presentation/blocs/bloc/dashboard_bloc.dart';
import 'package:smart_digital_wallet/src/core/features/dashboard/presentation/views/dashboard_view.dart';
import 'package:smart_digital_wallet/src/core/features/top_up/presentation/blocs/bloc/top_up_bloc.dart';
import 'package:smart_digital_wallet/src/core/features/top_up/presentation/views/top_up_view.dart';
import 'package:smart_digital_wallet/src/core/features/send_money/presentation/blocs/bloc/send_money_bloc.dart';
import 'package:smart_digital_wallet/src/core/features/send_money/presentation/views/send_money_view.dart';
import 'package:smart_digital_wallet/src/core/features/pay_bill/presentation/blocs/bloc/pay_bill_bloc.dart';
import 'package:smart_digital_wallet/src/core/features/pay_bill/presentation/views/pay_bill_view.dart';
import 'package:smart_digital_wallet/src/core/features/currency_exchange/presentation/blocs/bloc/currency_exchange_bloc.dart';
import 'package:smart_digital_wallet/src/core/features/currency_exchange/presentation/views/currency_exchange_view.dart';

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
    GoRoute(
      path: topUpRoute,
      builder: (context, state) {
        final extra = state.extra as Map<String, dynamic>?;
        final accounts = extra?['accounts'] as List? ?? [];

        return BlocProvider(
          create: (context) => sl<TopUpBloc>(),
          child: TopUpView(accounts: accounts.cast<AccountEntity>()),
        );
      },
    ),
    GoRoute(
      path: sendMoneyRoute,
      builder: (context, state) {
        final extra = state.extra as Map<String, dynamic>?;
        final accounts = extra?['accounts'] as List? ?? [];

        return BlocProvider(
          create: (context) => sl<SendMoneyBloc>(),
          child: SendMoneyView(accounts: accounts.cast<AccountEntity>()),
        );
      },
    ),
    GoRoute(
      path: payBillRoute,
      builder: (context, state) {
        final extra = state.extra as Map<String, dynamic>?;
        final accounts = extra?['accounts'] as List? ?? [];

        return BlocProvider(
          create: (context) => sl<PayBillBloc>(),
          child: PayBillView(accounts: accounts.cast<AccountEntity>()),
        );
      },
    ),
    GoRoute(
      path: currencyExchangeRoute,
      builder: (context, state) {
        final extra = state.extra as Map<String, dynamic>?;
        final accounts = extra?['accounts'] as List? ?? [];
        print(accounts);

        return BlocProvider(
          create: (context) => sl<CurrencyExchangeBloc>(),
          child: CurrencyExchangeView(accounts: accounts.cast<AccountEntity>()),
        );
      },
    ),
  ],
  redirect: (context, state) {
    if (state.uri.path == '/' || state.uri.path == starterRoute) {
      return starterRoute;
    }
    return null;
  },
);
