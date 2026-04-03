import 'dart:io';
import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ieee_app/screens/settings/edit_profile_page.dart';
import 'package:ieee_app/screens/settings/language_page.dart';
import 'package:ieee_app/screens/settings/notification_page.dart';
import 'package:ieee_app/core/theme/app_colors.dart';
import 'package:ieee_app/widgets/animated_action_card.dart';
import 'package:ieee_app/widgets/custom_animated_toggle.dart';
import 'package:go_router/go_router.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ieee_app/core/providers/theme_provider.dart';
import 'package:ieee_app/core/auth/auth_provider.dart';
import 'package:ieee_app/core/auth/auth_controller.dart';
import 'package:ieee_app/core/constants/app_constants.dart';

class SettingsPage extends ConsumerStatefulWidget {
  const SettingsPage({super.key});

  @override
  ConsumerState<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends ConsumerState<SettingsPage> with TickerProviderStateMixin {
  bool notificationsOn = true;
  String selectedLanguage = 'English (UK)';

  File? _avatarImage;
  final ImagePicker _picker = ImagePicker();

  late AnimationController _glowController;
  late AnimationController _floatController;
  late AnimationController _editBadgeController;

  @override
  void initState() {
    super.initState();
    _glowController = AnimationController(vsync: this, duration: const Duration(seconds: 4))..repeat();
    _floatController = AnimationController(vsync: this, duration: const Duration(seconds: 3))..repeat(reverse: true);
    _editBadgeController = AnimationController(vsync: this, duration: const Duration(milliseconds: 200));
  }

  @override
  void dispose() {
    _glowController.dispose();
    _floatController.dispose();
    _editBadgeController.dispose();
    super.dispose();
  }

  String _getUserName() {
    final user = ref.read(authRepositoryProvider).currentUser;
    final displayName = user?.displayName?.trim();
    if (displayName != null && displayName.isNotEmpty) {
      return displayName;
    }
    return 'User';
  }

  String _getUserEmail() {
    final user = ref.read(authRepositoryProvider).currentUser;
    return user?.email ?? 'No email';
  }

  // ===== COLOR SYSTEM =====
  bool get isDarkMode {
    final themeMode = ref.watch(themeProvider);
    if (themeMode == ThemeMode.system) {
      return MediaQuery.of(context).platformBrightness == Brightness.dark;
    }
    return themeMode == ThemeMode.dark;
  }
  
  Color get bgColor => isDarkMode ? AppColors.darkBackground : AppColors.lightBackground;
  Color get cardColor => isDarkMode ? AppColors.profileCardDark : AppColors.profileCardLight;
  Color get textColor => isDarkMode ? AppColors.profileTextDark : AppColors.profileTextLight;
  Color get subTextColor => isDarkMode ? AppColors.profileSubtextDark : AppColors.profileSubtextLight;
  Color get accentBlue => AppColors.profileAccent;

  Future<void> _pickAvatar() async {
    _editBadgeController.forward().then((_) => _editBadgeController.reverse());
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);

    if (image != null) {
      setState(() {
        _avatarImage = File(image.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            // ===== HEADER =====
            TweenAnimationBuilder<double>(
              tween: Tween(begin: 0.0, end: 1.0),
              duration: const Duration(milliseconds: 600),
              curve: Curves.easeOutCubic,
              builder: (context, value, child) {
                return Transform.translate(
                  offset: Offset(0, 20 * (1 - value)),
                  child: Opacity(opacity: value, child: child),
                );
              },
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 400),
                padding: const EdgeInsets.only(top: 48, bottom: 32),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: _pickAvatar,
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          AnimatedBuilder(
                            animation: _floatController,
                            builder: (context, child) {
                              return Transform.translate(
                                offset: Offset(0, -6 * _floatController.value),
                                child: child,
                              );
                            },
                            child: AnimatedBuilder(
                              animation: _glowController,
                              builder: (context, child) {
                                return Container(
                                  width: 144,
                                  height: 144,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    gradient: SweepGradient(
                                      transform: GradientRotation(_glowController.value * 2 * math.pi),
                                      colors: [
                                        accentBlue,
                                        const Color(0xFF8B5CF6),
                                        const Color(0xFFEC4899),
                                        accentBlue,
                                      ],
                                    ),
                                    boxShadow: [
                                      BoxShadow(
                                        color: accentBlue.withOpacity(0.4),
                                        blurRadius: 24,
                                        spreadRadius: 2,
                                      ),
                                    ],
                                  ),
                                  padding: const EdgeInsets.all(4),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: bgColor,
                                    ),
                                    padding: const EdgeInsets.all(4),
                                    child: CircleAvatar(
                                      radius: 64,
                                      backgroundColor: accentBlue.withOpacity(0.2),
                                      child: Text(
                                        _getUserName().isEmpty 
                                          ? '?' 
                                          : _getUserName()[0].toUpperCase(),
                                        style: TextStyle(
                                          fontSize: 48,
                                          fontWeight: FontWeight.w800,
                                          color: accentBlue,
                                          letterSpacing: -1,
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                          AnimatedBuilder(
                            animation: _floatController,
                            builder: (context, child) {
                              return Positioned(
                                bottom: 6 - (6 * _floatController.value),
                                right: 6,
                                child: ScaleTransition(
                                  scale: Tween<double>(begin: 1.0, end: 0.9).animate(_editBadgeController),
                                  child: child,
                                ),
                              );
                            },
                            child: Container(
                              padding: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  colors: [accentBlue, const Color(0xFF8B5CF6)],
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                ),
                                shape: BoxShape.circle,
                                border: Border.all(color: bgColor, width: 3),
                                boxShadow: [
                                  BoxShadow(
                                    color: accentBlue.withOpacity(0.5),
                                    blurRadius: 10,
                                    offset: const Offset(0, 4),
                                  ),
                                ],
                              ),
                              child: const Icon(
                                Icons.edit_rounded,
                                size: 18,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),
                    Text(
                      _getUserName(),
                      style: TextStyle(
                          color: textColor,
                          fontWeight: FontWeight.w800,
                          fontSize: 22,
                          letterSpacing: -0.5),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      _getUserEmail(),
                      style: TextStyle(color: subTextColor, fontSize: 13, fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 16),

            // ===== MAIN SETTINGS LIST =====
            TweenAnimationBuilder<double>(
              tween: Tween(begin: 0.0, end: 1.0),
              duration: const Duration(milliseconds: 700),
              curve: Curves.easeOutCubic,
              builder: (context, value, child) {
                return Opacity(
                  opacity: value,
                  child: Transform.translate(
                    offset: Offset(0, 30 * (1 - value)),
                    child: child,
                  ),
                );
              },
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 24, bottom: 8),
                    child: Text(
                      'Account Settings',
                      style: TextStyle(
                        color: subTextColor,
                        fontWeight: FontWeight.w700,
                        fontSize: 12,
                        letterSpacing: 1.2,
                        textBaseline: TextBaseline.alphabetic,
                      ),
                    ),
                  ),
                  AnimatedActionCard(
                    icon: Icons.person_outline_rounded,
                    title: 'Personal Information',
                    subtitle: 'Manage your name, email and phone',
                    isDarkMode: isDarkMode,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => const EditProfilePage()),
                      );
                    },
                  ),
                  AnimatedActionCard(
                    icon: Icons.notifications_none_rounded,
                    title: 'Notifications',
                    subtitle: 'Configure app alerts',
                    accentColor: const Color(0xFFF59E0B),
                    isDarkMode: isDarkMode,
                    trailing: CustomAnimatedToggle(
                      value: notificationsOn,
                      activeColor: const Color(0xFFF59E0B),
                      onChanged: (v) {
                        setState(() => notificationsOn = v);
                      },
                    ),
                    onTap: () async {
                      final result = await Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => const NotificationPage()),
                      );
                      if (result != null) {
                        setState(() {
                          notificationsOn = result['general'];
                        });
                      }
                    },
                  ),
                  AnimatedActionCard(
                    icon: Icons.translate_rounded,
                    title: 'Language',
                    subtitle: selectedLanguage,
                    accentColor: const Color(0xFF10B981),
                    isDarkMode: isDarkMode,
                    onTap: () async {
                      final result = await Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => const LanguagePage()),
                      );
                      if (result != null) {
                        setState(() => selectedLanguage = result);
                      }
                    },
                  ),
                  const SizedBox(height: 24),
                  Padding(
                    padding: const EdgeInsets.only(left: 24, bottom: 8),
                    child: Text(
                      'Preferences',
                      style: TextStyle(
                        color: subTextColor,
                        fontWeight: FontWeight.w700,
                        fontSize: 12,
                        letterSpacing: 1.2,
                      ),
                    ),
                  ),
                  AnimatedActionCard(
                    icon: Icons.palette_outlined,
                    title: 'Theme',
                    subtitle: isDarkMode ? 'Dark Mode' : 'Light Mode',
                    accentColor: const Color(0xFF8B5CF6),
                    isDarkMode: isDarkMode,
                    trailing: CustomAnimatedToggle(
                      value: isDarkMode,
                      activeColor: const Color(0xFF8B5CF6),
                      onChanged: (v) {
                          ref.read(themeProvider.notifier).toggleTheme(v);
                      },
                    ),
                    onTap: () {
                      ref.read(themeProvider.notifier).toggleTheme(!isDarkMode);
                    },
                  ),
                  const SizedBox(height: 40),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: TextButton.icon(
                      style: TextButton.styleFrom(
                        foregroundColor: AppColors.error,
                        padding: const EdgeInsets.symmetric(vertical: 18),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        backgroundColor: AppColors.error.withOpacity(0.1),
                      ),
                      onPressed: () async {
                        try {
                          await ref.read(authControllerProvider.notifier).signOut();
                          if (!context.mounted) return;
                          context.go(AppConstants.loginPath);
                        } catch (e) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('Logout failed: $e')),
                          );
                        }
                      },
                      icon: const Icon(Icons.logout_rounded, size: 22),
                      label: const Center(
                        child: Text(
                          'Log Out', 
                          style: TextStyle(
                            fontSize: 16, 
                            fontWeight: FontWeight.w700,
                            letterSpacing: -0.2,
                          )
                        )
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 48),
          ],
        ),
      ),
    );
  }
}
