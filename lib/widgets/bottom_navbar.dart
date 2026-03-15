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

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 20,
            offset: const Offset(0, -4),
          ),
        ],
      ),
      child: SafeArea(
        child: Container(
          height: 70,
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
    final color = isSelected ? AppColors.primaryBlue : AppColors.textDark.withValues(alpha: AppColors.textMutedOpacity);
    
    return Expanded(
      child: InkWell(
        onTap: onTap,
        splashColor: AppColors.primaryBlue.withValues(alpha: 0.05),
        highlightColor: Colors.transparent,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: isSelected ? AppColors.primaryBlue.withValues(alpha: 0.08) : Colors.transparent,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(
                isSelected ? activeIcon : icon,
                color: color,
                size: 24,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              label,
              style: Theme.of(context).textTheme.labelSmall?.copyWith(
                    color: color,
                    fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
                    fontSize: 10,
                  ),
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
    return 0;
  }
}

