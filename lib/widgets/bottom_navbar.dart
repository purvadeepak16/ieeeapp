import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:ieee_app/core/constants/app_constants.dart';

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
            color: Colors.black.withOpacity(0.08),
            blurRadius: 20,
            offset: const Offset(0, -5),
          ),
        ],
      ),
      child: SafeArea(
        child: Container(
          height: 65,
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildNavItem(
                context,
                icon: Icons.badge_outlined, 
                activeIcon: Icons.badge,
                label: 'About',
                index: 0,
                currentIndex: currentIndex,
                onTap: () => context.go(AppConstants.aboutPath),
              ),
              _buildNavItem(
                context,
                icon: Icons.calendar_today_outlined,
                activeIcon: Icons.calendar_today,
                label: 'Events',
                index: 1,
                currentIndex: currentIndex,
                onTap: () => context.go(AppConstants.eventsPath),
              ),
              _buildCenterItem(
                context,
                isSelected: currentIndex == 2,
                onTap: () => context.go(AppConstants.membersPath),
              ),
              _buildNavItem(
                context,
                icon: Icons.menu_book_outlined,
                activeIcon: Icons.menu_book,
                label: 'Magazine',
                index: 3,
                currentIndex: currentIndex,
                onTap: () => context.go(AppConstants.magazinePath),
              ),
              _buildNavItem(
                context,
                icon: Icons.person_outline,
                activeIcon: Icons.person,
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
    // Dark dark blue for selected, dark grey for unselected
    final color = isSelected ? const Color(0xFF001540) : const Color(0xFF555555);
    final iconData = isSelected ? activeIcon : icon;

    return InkWell(
      onTap: onTap,
      splashColor: Colors.transparent, 
      highlightColor: Colors.transparent,
      child: Container(
        width: 60, 
        padding: const EdgeInsets.symmetric(vertical: 4.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              iconData, 
              color: color, 
              size: 26
            ),
            const SizedBox(height: 4),
            Text(
              label,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: 11,
                color: color,
                fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCenterItem(
    BuildContext context, {
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        // margin: const EdgeInsets.only(bottom: 25), // Removed floating margin
        height: 50, // Slightly smaller to match alignment better
        width: 50,
        decoration: BoxDecoration(
          color: const Color(0xFFA8C7FA), 
          borderRadius: BorderRadius.circular(14), 
          boxShadow: [
            BoxShadow(
              color: const Color(0xFF000000).withOpacity(0.1),
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: const Icon(
          Icons.groups_rounded,
          color: Color(0xFF001540), 
          size: 28, // Adjusted size to be closer to others (26)
        ),
      ),
    );
  }

  int _getIndexFromLocation(String location) {
    if (location.startsWith(AppConstants.aboutPath)) return 0;
    if (location.startsWith(AppConstants.eventsPath)) return 1;
    if (location.startsWith(AppConstants.membersPath)) return 2; // Members is now center
    if (location.startsWith(AppConstants.magazinePath)) return 3;
    if (location.startsWith(AppConstants.profilePath)) return 4;
 
    return 2;
  }
}
