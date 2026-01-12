import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:ieee_app/core/theme/app_colors.dart';
import 'package:ieee_app/widgets/bottom_navbar.dart';
import 'package:ieee_app/widgets/app_drawer.dart';

class AppScaffold extends StatelessWidget {
  final Widget child;

  const AppScaffold({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    // Get current location from GoRouter state
    final String location = GoRouterState.of(context).uri.toString();

    return Scaffold(
      backgroundColor: AppColors.lightBackground, // Or context.theme.scaffoldBackgroundColor
      appBar: AppBar(
        title: const Text('IEEE VESIT'), // Dynamic title logic can be added later
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_outlined),
            onPressed: () {},
          ),
        ],
      ),
      drawer: const AppDrawer(),
      body: child,
      bottomNavigationBar: BottomNavBar(location: location),
    );
  }
}
