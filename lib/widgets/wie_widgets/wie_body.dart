import 'package:flutter/material.dart';
import 'package:ieee_app/widgets/wie_widgets/global_wie_info.dart';
import 'package:ieee_app/widgets/wie_widgets/hero_strip.dart';
import 'package:ieee_app/widgets/wie_widgets/team_section.dart';

class WieBody extends StatelessWidget {
  const WieBody({super.key});

  @override
  Widget build(BuildContext context) {
    return const SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          HeroStrip(),
          Padding(
              padding: EdgeInsets.all(16),
              child: GlobalWieInfo()),
          SizedBox(height: 16),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: TeamSection(),
          ),
          SizedBox(height: 24),
        ],
      ),
    );
  }
}
