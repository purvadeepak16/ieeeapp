import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:ieee_app/core/theme/app_colors.dart';
import 'package:ieee_app/core/theme/spacing_constants.dart';
import 'package:ieee_app/core/extensions/context_extensions.dart';
import 'package:ieee_app/core/constants/app_constants.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          _buildDrawerHeader(context),
          Expanded(
            child: ListView(
              padding: EdgeInsets.zero,
              children: [
                _buildDrawerItem(
                  context,
                  icon: Icons.home_outlined,
                  label: 'Home',
                  onTap: () => context.go(AppConstants.homePath),
                ),
                _buildDrawerItem(
                  context,
                  icon: Icons.settings_outlined,
                  label: 'Settings',
                  onTap: () {
                    // Navigate to settings
                    Navigator.pop(context); // Close drawer
                  },
                ),
                 const Divider(color: AppColors.border),
                _buildDrawerItem(
                  context,
                  icon: Icons.logout,
                  label: 'Logout',
                  textColor: AppColors.error,
                  iconColor: AppColors.error,
                  onTap: () {
                     // Handle Logout
                     context.go(AppConstants.loginPath);
                  },
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(AppSpacing.md),
            child: Text(
              'Version ${AppConstants.appVersion}',
              style: context.textTheme.labelSmall,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDrawerHeader(BuildContext context) {
    return const UserAccountsDrawerHeader(
      decoration: BoxDecoration(
        color: AppColors.primaryBlue,
      ),
      currentAccountPicture: CircleAvatar(
        backgroundColor: AppColors.white,
        child: Text(
          'A',
          style: TextStyle(fontSize: 24, color: AppColors.primaryBlue),
        ),
      ),
      accountName: Text(
        'Admin User',
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
      accountEmail: Text('admin@ieee.org'),
    );
  }

  Widget _buildDrawerItem(
    BuildContext context, {
    required IconData icon,
    required String label,
    required VoidCallback onTap,
    Color? textColor,
    Color? iconColor,
  }) {
    return ListTile(
      leading: Icon(icon, color: iconColor ?? AppColors.textMedium),
      title: Text(
        label,
        style: context.textTheme.bodyMedium?.copyWith(
          color: textColor,
          fontWeight: FontWeight.w500,
        ),
      ),
      onTap: onTap,
    );
  }
}
