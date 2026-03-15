import 'package:flutter/material.dart';

class SectionHeader extends StatelessWidget {
  final String title;
  final Color? color;
  const SectionHeader({super.key, required this.title, this.color});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Text(
      title,
      style: theme.textTheme.titleLarge?.copyWith(
        color: color ?? theme.colorScheme.onBackground,
        fontWeight: FontWeight.w700,
      ),
    );
  }
}
