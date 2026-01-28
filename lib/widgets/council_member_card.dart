import 'package:flutter/material.dart';
import 'package:ieee_app/models/council_member_model.dart';

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
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
        child: Row(
          children: [
            CircleAvatar(
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
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              )
                  : null,
            ),



            const SizedBox(width: 20),

            Expanded(
              child: Text(
                member.name,
                style: const TextStyle(
                  color: Color(0xFF1A237E),
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),

            Text(
              member.role,
              style: const TextStyle(
                color: Color(0xFF1A237E),
                fontSize: 14,
                fontWeight: FontWeight.w400,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
