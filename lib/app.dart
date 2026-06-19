import 'package:flutter/material.dart';
import 'app_router.dart';
import 'core/constants/app_strings.dart';
import 'core/theme/app_theme.dart';

class PayEaseApp extends StatelessWidget {
  const PayEaseApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: AppStrings.appName,
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.light,
      routerConfig: AppRouter.router,
      builder: (context, child) {
        // Limit max width for web/desktop responsiveness
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(textScaler: TextScaler.linear(1.0)),
          child: child!,
        );
      },
    );
  }
}