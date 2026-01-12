import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ieee_app/core/constants/app_constants.dart';
import 'package:ieee_app/widgets/app_scaffold.dart';
import 'package:ieee_app/screens/home/home_screen.dart';
import 'package:ieee_app/screens/members/members_screen.dart';
import 'package:ieee_app/screens/events/events_screen.dart';
import 'package:ieee_app/screens/magazine/magazine_screen.dart';
import 'package:ieee_app/screens/profile/profile_screen.dart';
import 'package:ieee_app/screens/about/about_screen.dart';
import 'package:ieee_app/screens/login_screen.dart';
import 'package:ieee_app/screens/register_screen.dart';

final _rootNavigatorKey = GlobalKey<NavigatorState>();
final _shellNavigatorKey = GlobalKey<NavigatorState>();

final goRouterProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    navigatorKey: _rootNavigatorKey,
    initialLocation: AppConstants.homePath,
    debugLogDiagnostics: true,
    routes: [
      ShellRoute(
        navigatorKey: _shellNavigatorKey,
        builder: (context, state, child) {
          return AppScaffold(child: child); 
        },
        routes: [
          GoRoute(
            path: AppConstants.homePath,
            pageBuilder: (context, state) => const NoTransitionPage(
              child: HomeScreen(),
            ),
          ),
          GoRoute(
            path: AppConstants.membersPath,
            pageBuilder: (context, state) => const NoTransitionPage(
              child: MembersScreen(),
            ),
          ),
          GoRoute(
            path: AppConstants.eventsPath,
            pageBuilder: (context, state) => const NoTransitionPage(
              child: EventsScreen(),
            ),
          ),
          GoRoute(
            path: AppConstants.magazinePath,
            pageBuilder: (context, state) => const NoTransitionPage(
              child: MagazineScreen(),
            ),
          ),
          GoRoute(
            path: AppConstants.profilePath,
            pageBuilder: (context, state) => const NoTransitionPage(
              child: ProfileScreen(),
            ),
          ),
          GoRoute(
            path: AppConstants.aboutPath,
            pageBuilder: (context, state) => const NoTransitionPage(
              child: AboutScreen(),
            ),
          ),
        ],
      ),
      GoRoute(
        path: AppConstants.loginPath,
        builder: (context, state) => const LoginScreen(),
      ),
      GoRoute(
        path: AppConstants.registerPath,
        builder: (context, state) => const RegisterScreen(),
      ),
    ],
  );
});
