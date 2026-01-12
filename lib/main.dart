import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ieee_app/core/theme/app_theme.dart';
import 'package:ieee_app/core/constants/app_constants.dart';
import 'package:ieee_app/routes/app_routes.dart';

void main() {
  runApp(const ProviderScope(child: IEEEApp()));
}

class IEEEApp extends ConsumerWidget {
  const IEEEApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final goRouter = ref.watch(goRouterProvider);

    return MaterialApp.router(
      title: AppConstants.appName,
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.system, // Supports system theme
      routerConfig: goRouter,
    );
  }
}
