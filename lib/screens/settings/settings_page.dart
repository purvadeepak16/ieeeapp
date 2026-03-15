import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ieee_app/screens/settings/edit_profile_page.dart';
import 'package:ieee_app/screens/settings/language_page.dart';
import 'package:ieee_app/screens/settings/notification_page.dart';
import 'package:ieee_app/core/theme/app_colors.dart';
import 'package:ieee_app/widgets/animated_action_card.dart';
import 'package:ieee_app/widgets/custom_animated_toggle.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ieee_app/core/providers/theme_provider.dart';

class SettingsPage extends ConsumerStatefulWidget {
  const SettingsPage({super.key});

  @override
  ConsumerState<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends ConsumerState<SettingsPage> {
  bool notificationsOn = true;
  String selectedLanguage = 'English (UK)';

  File? _avatarImage;
  final ImagePicker _picker = ImagePicker();

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
  Color get dividerColor => isDarkMode ? AppColors.profileDividerDark : AppColors.profileDividerLight;
  Color get accentBlue => AppColors.profileAccent;

  Future<void> _pickAvatar() async {
    final XFile? image =
    await _picker.pickImage(source: ImageSource.gallery);

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
                padding: const EdgeInsets.symmetric(vertical: 32),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Stack(
                      children: [
                        GestureDetector(
                          onTap: _pickAvatar,
                          child: TweenAnimationBuilder<double>(
                            tween: Tween(begin: 0.8, end: 1.0),
                            duration: const Duration(milliseconds: 800),
                            curve: Curves.elasticOut,
                            builder: (context, value, child) {
                              return Transform.scale(
                                scale: value,
                                child: Container(
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    boxShadow: [
                                      BoxShadow(
                                        color: accentBlue.withOpacity(0.3 * value),
                                        blurRadius: 20 * value,
                                        spreadRadius: 2 * value,
                                      ),
                                    ],
                                  ),
                                  child: child,
                                ),
                              );
                            },
                            child: CircleAvatar(
                              radius: 72,
                              backgroundColor: Colors.transparent, // Changed to transparent
                              child: CircleAvatar(
                                radius: 68,
                                backgroundImage: _avatarImage != null
                                    ? FileImage(_avatarImage!)
                                    : const AssetImage('assets/images/avatar.png')
                                        as ImageProvider,
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                          bottom: 6,
                          right: 6,
                          child: GestureDetector(
                            onTap: _pickAvatar,
                            child: TweenAnimationBuilder<double>(
                              tween: Tween(begin: 0.0, end: 1.0),
                              duration: const Duration(milliseconds: 400),
                              curve: Curves.easeOutBack,
                              builder: (context, value, child) {
                                return Transform.scale(
                                  scale: value,
                                  child: child,
                                );
                              },
                              child: AnimatedContainer(
                                duration: const Duration(milliseconds: 200),
                                padding: const EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                  color: accentBlue,
                                  shape: BoxShape.circle,
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withOpacity(0.4),
                                      blurRadius: 6,
                                    ),
                                  ],
                                border: Border.all(color: Colors.white, width: 2),
                                ),
                                child: const Icon(
                                  Icons.edit,
                                  size: 16,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'USER',
                      style: TextStyle(
                          color: textColor,
                          fontWeight: FontWeight.w800,
                          fontSize: 20,
                          letterSpacing: 0.5),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'youremail@domain.com | +91 XXXXXXXX',
                      style: TextStyle(color: subTextColor, fontSize: 13, fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 24),

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
                        fontWeight: FontWeight.w600,
                        fontSize: 13,
                        letterSpacing: 1.2,
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
                    isDarkMode: isDarkMode,
                    trailing: CustomAnimatedToggle(
                      value: notificationsOn,
                      activeColor: accentBlue,
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
                        fontWeight: FontWeight.w600,
                        fontSize: 13,
                        letterSpacing: 1.2,
                      ),
                    ),
                  ),
                  AnimatedActionCard(
                    icon: Icons.palette_outlined,
                    title: 'Theme',
                    subtitle: isDarkMode ? 'Dark Mode' : 'Light Mode',
                    isDarkMode: isDarkMode,
                    trailing: DropdownButton<bool>(
                      value: isDarkMode,
                      underline: const SizedBox(),
                      dropdownColor: cardColor,
                      icon: Icon(Icons.arrow_drop_down_rounded, color: subTextColor),
                      items: [
                        DropdownMenuItem(
                          value: false, 
                          child: Text('Light', style: TextStyle(color: textColor, fontSize: 14))
                        ),
                        DropdownMenuItem(
                          value: true, 
                          child: Text('Dark', style: TextStyle(color: textColor, fontSize: 14))
                        ),
                      ],
                      onChanged: (v) {
                        if (v != null) {
                          ref.read(themeProvider.notifier).toggleTheme(v);
                        }
                      },
                    ),
                    onTap: () {},
                  ),
                  const SizedBox(height: 48),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: TextButton.icon(
                      style: TextButton.styleFrom(
                        foregroundColor: Colors.redAccent,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                        backgroundColor: isDarkMode ? Colors.redAccent.withOpacity(0.05) : Colors.red.shade50,
                      ),
                      onPressed: () {},
                      icon: const Icon(Icons.logout_rounded),
                      label: const Center(
                        child: Text(
                          'Log Out', 
                          style: TextStyle(
                            fontSize: 16, 
                            fontWeight: FontWeight.w600,
                            letterSpacing: 0.5,
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
