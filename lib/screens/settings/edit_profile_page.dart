import 'package:flutter/material.dart';
import 'package:ieee_app/core/theme/app_colors.dart';
import 'package:ieee_app/core/theme/spacing_constants.dart';

class EditProfilePage extends StatefulWidget {
  final bool isDarkMode;

  const EditProfilePage({super.key, this.isDarkMode = true});

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  // Use theme colors
  Color get bgColor => widget.isDarkMode ? AppColors.darkBackground : AppColors.lightBackground;
  Color get cardColor => widget.isDarkMode ? AppColors.profileCardDark : AppColors.profileCardLight;
  Color get textColor => widget.isDarkMode ? AppColors.profileTextDark : AppColors.profileTextLight;
  Color get subTextColor => widget.isDarkMode ? AppColors.profileSubtextDark : AppColors.profileSubtextLight;
  
  bool _isButtonHovered = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(
        backgroundColor: widget.isDarkMode ? AppColors.profileCardDark : AppColors.profileCardLight,
        elevation: 0,
        iconTheme: IconThemeData(color: textColor),
        title: Text(
          'Edit Profile',
          style: TextStyle(fontWeight: FontWeight.w600, color: textColor),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(AppSpacing.lg, AppSpacing.lg, AppSpacing.lg, AppSpacing.xl),
          child: TweenAnimationBuilder<double>(
            tween: Tween(begin: 0.0, end: 1.0),
            duration: const Duration(milliseconds: 600),
            curve: Curves.easeOutCubic,
            builder: (context, value, child) {
              return Opacity(
                opacity: value,
                child: Transform.translate(
                  offset: Offset(0, 20 * (1 - value)),
                  child: child,
                ),
              );
            },
            child: Column(
              children: [
                _buildAnimatedField('Full name', Icons.person_outline_rounded, 0),
                _buildAnimatedField('Email', Icons.email_outlined, 1),
                _buildAnimatedField('Phone number', Icons.phone_outlined, 2),
                _buildAnimatedField('Password', Icons.lock_outline_rounded, 3, obscure: true),
                const SizedBox(height: AppSpacing.xl),
                _buildAnimatedButton(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildAnimatedField(String label, IconData icon, int index, {bool obscure = false}) {
    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0.0, end: 1.0),
      duration: Duration(milliseconds: 500 + (index * 100)),
      curve: Curves.easeOutCubic,
      builder: (context, value, child) {
        return Opacity(
          opacity: value,
          child: Transform.translate(
            offset: Offset(20 * (1 - value), 0),
            child: child,
          ),
        );
      },
      child: Padding(
        padding: const EdgeInsets.only(bottom: AppSpacing.md),
        child: TextField(
          obscureText: obscure,
          style: TextStyle(color: textColor),
          decoration: InputDecoration(
            hintText: label,
            hintStyle: TextStyle(color: subTextColor),
            filled: true,
            fillColor: cardColor,
            prefixIcon: Icon(icon, color: subTextColor, size: 20),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
              borderSide: BorderSide.none,
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
              borderSide: const BorderSide(color: AppColors.profileAccent, width: 2),
            ),
            contentPadding: const EdgeInsets.symmetric(vertical: 18, horizontal: 16),
          ),
        ),
      ),
    );
  }

  Widget _buildAnimatedButton() {
    return MouseRegion(
      onEnter: (_) => setState(() => _isButtonHovered = true),
      onExit: (_) => setState(() => _isButtonHovered = false),
      child: TweenAnimationBuilder<double>(
        tween: Tween(begin: 0.0, end: 1.0),
        duration: const Duration(milliseconds: 900),
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
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          width: double.infinity,
          height: 56,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
            boxShadow: _isButtonHovered ? [
              BoxShadow(
                color: AppColors.profileAccent.withOpacity(0.4),
                blurRadius: 12,
                offset: const Offset(0, 4),
              )
            ] : [],
          ),
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.profileAccent,
              foregroundColor: Colors.white,
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
              ),
            ),
            onPressed: () => Navigator.pop(context),
            child: const Text(
              'Update Profile',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                letterSpacing: 0.5,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
