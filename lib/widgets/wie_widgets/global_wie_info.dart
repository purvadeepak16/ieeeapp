import 'package:flutter/material.dart';
import 'package:ieee_app/widgets/wie_widgets/info_card.dart';

class GlobalWieInfo extends StatelessWidget {
  const GlobalWieInfo({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return InfoCard(
      title: 'About IEEE WIE',
      body: 'IEEE Women in Engineering (WIE) is one of the largest '
          'international professional organizations dedicated to promoting women engineers and scientists and inspiring girls around the world to follow their academic interests in a career in engineering.\n\n'
          'At IEEE-VESIT, our WIE affinity group works to foster a supportive '
          'environment for women in STEM through technical workshops, leadership training, and networking opportunities with industry professionals.',
      backgroundColor: theme.colorScheme.surfaceContainerHighest,
      titleStyle: theme.textTheme.headlineSmall,
      bodyStyle: theme.textTheme.bodyLarge,
    );
  }
}
