import 'package:flutter/material.dart';
import 'package:ieee_app/widgets/wie_widgets/member_card.dart';
import 'package:ieee_app/models/wie_member_model.dart';

class MembersGrid extends StatelessWidget {
  final List<WieMemberModel> members;
  const MembersGrid({super.key, required this.members});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (_, c) {
        final w = c.maxWidth;
        final cross = w >= 900 ? 3 : w >= 650 ? 2 : 1;
        
        // Dynamic aspect ratio calculation based on screen size
        final double childAspectRatio = w >= 900 ? 0.9 : (w >= 650 ? 0.85 : 1.15);

        return GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: members.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: cross,
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
            childAspectRatio: childAspectRatio,
          ),
          itemBuilder: (_, i) => MemberCard(member: members[i]),
        );
      },
    );
  }
}
