import 'package:flutter/material.dart';
import 'package:ieee_app/models/council_member_model.dart';
import 'package:ieee_app/widgets/common/neo_card.dart';

class CouncilMemberCard extends StatelessWidget {
  final CouncilMember member;
  final VoidCallback? onTap;

  const CouncilMemberCard({
    super.key,
    required this.member,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: NeoCard(
        backgroundColor: Colors.white,
        padding: const EdgeInsets.all(16),
        onTap: onTap,
        child: Row(
          children: [
            Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: Colors.black, width: 2),
              ),
              child: CircleAvatar(
                radius: 30,
                backgroundColor: member.color,
                backgroundImage: (member.imagePath != null && member.imagePath!.trim().isNotEmpty)
                    ? AssetImage(member.imagePath!)
                    : null,
                child: (member.imagePath == null || member.imagePath!.trim().isEmpty)
                    ? Text(
                        member.name.isNotEmpty ? member.name[0].toUpperCase() : '?',
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w900,
                          color: Colors.white,
                        ),
                      )
                    : null,
              ),
            ),
            const SizedBox(width: 20),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    member.name,
                    style: const TextStyle(
                      color: Color(0xFF1A1A1A),
                      fontSize: 18,
                      fontWeight: FontWeight.w900,
                      letterSpacing: -0.5,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                    decoration: BoxDecoration(
                      color: member.color.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(4),
                      border: Border.all(color: member.color, width: 1),
                    ),
                    child: Text(
                      member.role.toUpperCase(),
                      style: TextStyle(
                        color: member.color,
                        fontSize: 10,
                        fontWeight: FontWeight.w900,
                        letterSpacing: 0.5,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
