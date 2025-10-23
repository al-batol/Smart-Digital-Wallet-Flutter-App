import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:smart_digital_wallet/src/core/common/di/injection_container.dart';
import 'package:smart_digital_wallet/src/core/common/localization/cubit/localization_cubit.dart';
import 'package:smart_digital_wallet/src/core/common/localization/localization_service.dart';
import 'package:smart_digital_wallet/src/core/common/models/transaction_model.dart';
import 'package:smart_digital_wallet/src/core/common/routes/app_router.dart';
import 'package:smart_digital_wallet/src/core/features/auth/presentation/bloc/bloc/auth_bloc.dart';
import 'package:smart_digital_wallet/src/core/features/top_up/data/models/top_up_model.dart';
import 'package:smart_digital_wallet/src/core/features/send_money/data/models/transfer_model.dart';
import 'package:smart_digital_wallet/src/core/features/pay_bill/data/models/payment_model.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter();
  Hive.registerAdapter(TransactionModelAdapter());
  Hive.registerAdapter(TopUpModelAdapter());
  Hive.registerAdapter(TransferModelAdapter());
  Hive.registerAdapter(PaymentModelAdapter());

  await init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<LocalizationCubit>(
          create: (context) => sl<LocalizationCubit>()..getSavedLocale(),
        ),
        BlocProvider<AuthBloc>(create: (context) => sl<AuthBloc>()),
      ],
      child: BlocBuilder<LocalizationCubit, LocalizationState>(
        buildWhen: (previous, current) => previous.locale != current.locale,
        builder: (context, state) {
          return MaterialApp.router(
            title: 'Smart Digital Wallet',
            theme: ThemeData(useMaterial3: true),
            debugShowCheckedModeBanner: false,
            supportedLocales: AppLocalization.supportedLanguages,
            locale: state.locale,
            routerConfig: appRouter,
            localizationsDelegates: const [
              AppLocalization.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
          );
        },
      ),
    );
  }
}
