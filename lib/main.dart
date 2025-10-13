import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_digital_wallet/src/core/common/di/injection_container.dart';
import 'package:smart_digital_wallet/src/core/common/routes/app_router.dart';
import 'package:smart_digital_wallet/src/core/features/auth/presentation/bloc/bloc/auth_bloc.dart';

void main() {
  init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<AuthBloc>(),
      child: MaterialApp.router(
        title: 'Smart Digital Wallet',
        theme: ThemeData(useMaterial3: true),
        debugShowCheckedModeBanner: false,
        routerConfig: appRouter,
      ),
    );
  }
}
