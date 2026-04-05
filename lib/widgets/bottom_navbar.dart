import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:ieee_app/core/constants/app_constants.dart';
import 'package:ieee_app/core/theme/app_colors.dart';

class BottomNavBar extends StatelessWidget {
  final String location;

  const BottomNavBar({
    super.key,
    required this.location,
  });

  @override
  Widget build(BuildContext context) {
    final int currentIndex = _getIndexFromLocation(location);
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Container(
      decoration: BoxDecoration(
        color: isDark ? AppColors.surfaceDark.withValues(alpha: 0.9) : Colors.white.withValues(alpha: 0.9),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: isDark ? 0.3 : 0.05),
            blurRadius: 24,
            offset: const Offset(0, -8),
          ),
        ],
      ),
      child: ClipRect(
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
          child: SafeArea(
            child: Container(
              height: 75,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _buildNavItem(
                    context,
                    icon: Icons.home_outlined,
                    activeIcon: Icons.home_rounded,
                    label: 'Home',
                    index: 0,
                    currentIndex: currentIndex,
                    onTap: () => context.go(AppConstants.homePath),
                  ),
                  _buildNavItem(
                    context,
                    icon: Icons.calendar_today_outlined,
                    activeIcon: Icons.calendar_today_rounded,
                    label: 'Events',
                    index: 1,
                    currentIndex: currentIndex,
                    onTap: () => context.go(AppConstants.eventsPath),
                  ),
                  _buildNavItem(
                    context,
                    icon: Icons.groups_outlined,
                    activeIcon: Icons.groups_rounded,
                    label: 'Members',
                    index: 2,
                    currentIndex: currentIndex,
                    onTap: () => context.go(AppConstants.membersPath),
                  ),
                  _buildNavItem(
                    context,
                    icon: Icons.menu_book_outlined,
                    activeIcon: Icons.menu_book_rounded,
                    label: 'Magazine',
                    index: 3,
                    currentIndex: currentIndex,
                    onTap: () => context.go(AppConstants.magazinePath),
                  ),
                  _buildNavItem(
                    context,
                    icon: Icons.person_outline_rounded,
                    activeIcon: Icons.person_rounded,
                    label: 'Profile',
                    index: 4,
                    currentIndex: currentIndex,
                    onTap: () => context.go(AppConstants.profilePath),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildNavItem(
    BuildContext context, {
    required IconData icon,
    required IconData activeIcon,
    required String label,
    required int index,
    required int currentIndex,
    required VoidCallback onTap,
  }) {
    final isSelected = index == currentIndex;
    final color = isSelected ? AppColors.primaryBlue : Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.5);
    
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        behavior: HitTestBehavior.opaque,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Stack(
              clipBehavior: Clip.none,
              alignment: Alignment.center,
              children: [
                AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeOutCubic,
                  padding: EdgeInsets.symmetric(
                    horizontal: isSelected ? 20 : 12, 
                    vertical: 8
                  ),
                  decoration: BoxDecoration(
                    color: isSelected ? AppColors.primaryBlue.withValues(alpha: 0.1) : Colors.transparent,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Icon(
                    isSelected ? activeIcon : icon,
                    color: color,
                    size: 26,
                  ),
                ),
                if (isSelected)
                  Positioned(
                    bottom: -8,
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.easeOutBack,
                      width: 5,
                      height: 5,
                      decoration: const BoxDecoration(
                        color: AppColors.primaryBlue,
                        shape: BoxShape.circle,
                      ),
                    ),
                  )
              ],
            ),
            const SizedBox(height: 6),
            AnimatedDefaultTextStyle(
              duration: const Duration(milliseconds: 200),
              style: Theme.of(context).textTheme.labelSmall!.copyWith(
                    color: color,
                    fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
                    fontSize: isSelected ? 11 : 10,
                  ),
              child: Text(label),
            ),
          ],
        ),
      ),
    );
  }

  int _getIndexFromLocation(String location) {
    if (location.startsWith(AppConstants.homePath)) return 0;
    if (location.startsWith(AppConstants.eventsPath)) return 1;
    if (location.startsWith(AppConstants.membersPath)) return 2;
    if (location.startsWith(AppConstants.magazinePath)) return 3;
    if (location.startsWith(AppConstants.profilePath)) return 4;
    // Return -1 for routes that are not part of the bottom navigation
    // (e.g. /wie) so that no bottom item is shown as selected.
    return -1;
  }
}

