import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class QuickNavigation extends StatelessWidget {
  final List<NavItem> navItems = [
    NavItem(
      title: 'Events',
      icon: Icons.event,
      route: '/events',
      color: Colors.blue,
    ),
    NavItem(
      title: 'Members',
      icon: Icons.people,
      route: '/members',
      color: Colors.green,
    ),
    NavItem(
      title: 'Magazine',
      icon: Icons.menu_book,
      route: '/magazine',
      color: Colors.orange,
    ),
    NavItem(
      title: 'Calendar',
      icon: Icons.calendar_today,
      route: '/events', // Goes to events screen which has calendar
      color: Colors.purple,
    ),
    NavItem(
      title: 'Profile',
      icon: Icons.person,
      route: '/profile',
      color: Colors.teal,
    ),
    NavItem(
      title: 'About',
      icon: Icons.info,
      route: '/about',
      color: Colors.brown,
    ),
  ];

  QuickNavigation({super.key});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
        childAspectRatio: 1.0,
      ),
      itemCount: navItems.length,
      padding: const EdgeInsets.all(16),
      itemBuilder: (context, index) {
        final item = navItems[index];
        return GestureDetector(
          onTap: () {
            context.go(item.route);
          },
          child: Column(
            children: [
              Container(
                width: 70,
                height: 70,
                decoration: BoxDecoration(
                  color: item.color.withAlpha(51),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: item.color.withAlpha(102)),
                ),
                child: Icon(
                  item.icon,
                  color: item.color,
                  size: 32,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                item.title,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.w500,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        );
      },
    );
  }
}

class NavItem {
  final String title;
  final IconData icon;
  final String route;
  final Color color;

  NavItem({
    required this.title,
    required this.icon,
    required this.route,
    required this.color,
  });
}