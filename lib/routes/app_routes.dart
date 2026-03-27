import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ieee_app/core/constants/app_constants.dart';
import 'package:ieee_app/core/auth/auth_provider.dart';
import 'package:ieee_app/widgets/app_scaffold.dart';
import 'package:ieee_app/screens/home/home_screen.dart';
import 'package:ieee_app/screens/members/members_screen.dart';
import 'package:ieee_app/screens/events/events_screen.dart';
import 'package:ieee_app/screens/magazine/magazine_screen.dart';
import 'package:ieee_app/screens/profile/profile_screen.dart';
import 'package:ieee_app/screens/about/about_screen.dart';
import 'package:ieee_app/screens/onboarding_screen.dart';
import 'package:ieee_app/screens/login_screen.dart';
import 'package:ieee_app/screens/register_screen.dart';
import 'package:ieee_app/screens/forgot_password_screen.dart';
import 'package:ieee_app/screens/verify_email_screen.dart';
import 'package:ieee_app/screens/wie/wie_page.dart';
import 'package:ieee_app/screens/home/micro_skill_detail_screen.dart';
import 'package:ieee_app/models/micro_skill_model.dart';

final _rootNavigatorKey = GlobalKey<NavigatorState>();
final _shellNavigatorKey = GlobalKey<NavigatorState>();

final goRouterProvider = Provider<GoRouter>((ref) {
  final refreshListenable = ref.watch(goRouterRefreshListenableProvider);

  return GoRouter(
    navigatorKey: _rootNavigatorKey,
    initialLocation: AppConstants.onboardingPath,
    debugLogDiagnostics: true,
    refreshListenable: refreshListenable,
    redirect: (context, state) {
      final user = ref.read(authRepositoryProvider).currentUser;
      final path = state.uri.path;

      final isAuthRoute = path == AppConstants.loginPath ||
          path == AppConstants.registerPath ||
          path == AppConstants.forgotPasswordPath;
      final isOnboardingRoute = path == AppConstants.onboardingPath;
      final isVerifyRoute = path == AppConstants.verifyEmailPath;
      final isLoggedIn = user != null;
      final isVerified = user?.emailVerified ?? false;

      if (!isLoggedIn) {
        if (isAuthRoute || isOnboardingRoute) {
          return null;
        }
        return AppConstants.loginPath;
      }

      if (isLoggedIn && !isVerified && !isVerifyRoute) {
        return AppConstants.verifyEmailPath;
      }

      if (isLoggedIn && isVerified && (isAuthRoute || isVerifyRoute || isOnboardingRoute)) {
        return AppConstants.homePath;
      }

      return null;
    },
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
          GoRoute(
            path: AppConstants.wiePath,
            pageBuilder: (context, state) => const NoTransitionPage(
              child: WiePage(),
            ),
          ),
          GoRoute(
            path: '/micro-skill/:id',
            builder: (context, state) {
              // You'll need to pass the MicroSkill object via extra
              final microSkill = state.extra as MicroSkill;
              return MicroSkillDetailScreen(microSkill: microSkill);
            },
          ),
        ],
      ),
      GoRoute(
        path: AppConstants.onboardingPath,
        builder: (context, state) => const OnboardingScreen(),
      ),
      GoRoute(
        path: AppConstants.loginPath,
        builder: (context, state) => const LoginScreen(),
      ),
      GoRoute(
        path: AppConstants.registerPath,
        builder: (context, state) => const RegisterScreen(),
      ),
      GoRoute(
        path: AppConstants.forgotPasswordPath,
        builder: (context, state) => const ForgotPasswordScreen(),
      ),
      GoRoute(
        path: AppConstants.verifyEmailPath,
        builder: (context, state) => const VerifyEmailScreen(),
      ),
    ],
  );
});
