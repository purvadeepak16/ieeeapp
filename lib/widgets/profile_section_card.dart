import 'package:flutter/material.dart';
import 'package:ieee_app/widgets/common/neo_card.dart';

class ProfileSectionCard extends StatelessWidget {
  final List<Widget> children;

  const ProfileSectionCard({
    super.key,
    required this.children,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: NeoCard(
        backgroundColor: Colors.white,
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: Column(children: children),
      ),
    );
  }
}
