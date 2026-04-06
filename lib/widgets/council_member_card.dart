import 'package:flutter/material.dart';
import 'package:ieee_app/models/council_member_model.dart';
import 'package:ieee_app/widgets/common/neo_card.dart';
import 'package:ionicons/ionicons.dart';
import 'package:url_launcher/url_launcher.dart';

class CouncilMemberCard extends StatelessWidget {
  final CouncilMember member;
  final VoidCallback? onTap;

  const CouncilMemberCard({
    super.key,
    required this.member,
    this.onTap,
  });

  Future<void> _launch(BuildContext context, String url) async {
    if (url.trim().isEmpty) return;
    final uri = Uri.parse(url);
    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Could not launch $url')),
        );
      }
    }
  }

  Widget _socialIcon({
    required IconData icon,
    required Color color,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(right: 12),
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: color.withValues(alpha: 0.1),
          shape: BoxShape.circle,
        ),
        child: Icon(
          icon,
          size: 16,
          color: color,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: NeoCard(
        backgroundColor: Theme.of(context).colorScheme.surface,
        padding: const EdgeInsets.all(16),
        onTap: onTap,
        child: Row(
          children: [
            Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                    color: Theme.of(context).colorScheme.onSurface, width: 2),
              ),
              child: CircleAvatar(
                radius: 30,
                backgroundColor: member.color,
                backgroundImage: (member.imagePath != null &&
                        member.imagePath!.trim().isNotEmpty)
                    ? AssetImage(member.imagePath!)
                    : null,
                child: (member.imagePath == null ||
                        member.imagePath!.trim().isEmpty)
                    ? Text(
                        member.name.isNotEmpty
                            ? member.name[0].toUpperCase()
                            : '?',
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
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.onSurface,
                      fontSize: 18,
                      fontWeight: FontWeight.w900,
                      letterSpacing: -0.5,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
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
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      _socialIcon(
                        icon: Icons.mail,
                        color: Colors.redAccent,
                        onTap: () => _launch(context, 'mailto:${member.email}'),
                      ),
                      if (member.linkedinUrl != null &&
                          member.linkedinUrl!.trim().isNotEmpty)
                        _socialIcon(
                          icon: Ionicons.logo_linkedin,
                          color: const Color(0xFF0077B5),
                          onTap: () => _launch(context, member.linkedinUrl!),
                        ),
                      if (member.githubUrl != null &&
                          member.githubUrl!.trim().isNotEmpty)
                        _socialIcon(
                          icon: Ionicons.logo_github,
                          color: Theme.of(context).colorScheme.onSurface,
                          onTap: () => _launch(context, member.githubUrl!),
                        ),
                    ],
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
