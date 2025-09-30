import 'package:flutter/material.dart';
import 'package:smart_digital_wallet/src/core/common/di/injection_container.dart';
import 'package:smart_digital_wallet/src/core/common/routes/app_router.dart';

void main() {
  init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Smart Digital Wallet',
      theme: ThemeData(useMaterial3: true),
      debugShowCheckedModeBanner: false,
      routerConfig: appRouter,
    );
  }
}
