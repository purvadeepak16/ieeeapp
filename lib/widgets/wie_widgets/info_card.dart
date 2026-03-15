import 'package:flutter/material.dart';
import 'package:ieee_app/widgets/common/neo_card.dart';

class InfoCard extends StatelessWidget {
  final String title;
  final String body;
  final Color? backgroundColor;
  final TextStyle? titleStyle;
  final TextStyle? bodyStyle;

  const InfoCard({
    super.key,
    required this.title,
    required this.body,
    this.backgroundColor,
    this.titleStyle,
    this.bodyStyle,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return NeoCard(
      backgroundColor: backgroundColor ?? theme.cardTheme.color,
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: titleStyle ?? theme.textTheme.titleLarge),
          const SizedBox(height: 8),
          Text(
            body,
            textAlign: TextAlign.justify,
            style: bodyStyle ?? theme.textTheme.bodyLarge,
          ),
        ],
      ),
    );
  }
}
