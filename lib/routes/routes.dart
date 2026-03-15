import 'package:flutter/material.dart';
import 'package:ieee_app/screens/profile/profile_screen.dart';

class AppRoutes {
  static const profile = '/';

  static Map<String, WidgetBuilder> routes = {
    profile: (context) => const ProfileScreen(),
  };
}
