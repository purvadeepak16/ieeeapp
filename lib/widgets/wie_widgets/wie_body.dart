import 'package:flutter/material.dart';
import 'package:ieee_app/widgets/wie_widgets/global_wie_info.dart';
import 'package:ieee_app/widgets/wie_widgets/hero_strip.dart';
import 'package:ieee_app/widgets/wie_widgets/inspiring_carousel.dart';
import 'package:ieee_app/widgets/wie_widgets/team_section.dart';

class WieBody extends StatelessWidget {
  const WieBody({super.key});

  @override
  Widget build(BuildContext context) {
    final pad = MediaQuery.of(context).size.width < 400 ? 12.0 : 16.0;
    final theme = Theme.of(context);

    return SingleChildScrollView(
      child: Container(
        color: theme.colorScheme.surface,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const HeroStrip(),
            Padding(padding: EdgeInsets.all(pad), child: const GlobalWieInfo()),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: pad),
              child: const InspiringCarousel(),
            ),
            const SizedBox(height: 16),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: pad),
              child: const TeamSection(),
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}
