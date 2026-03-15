import 'package:flutter/material.dart';
import 'package:ieee_app/core/theme/app_colors.dart';
import 'package:ieee_app/models/wie_member_model.dart';
import 'package:ieee_app/widgets/common/neo_card.dart';
import 'package:ionicons/ionicons.dart';
import 'package:url_launcher/url_launcher.dart';

class MemberCard extends StatefulWidget {
  final WieMemberModel member;
  const MemberCard({super.key, required this.member});

  @override
  State<MemberCard> createState() => _MemberCardState();
}

class _MemberCardState extends State<MemberCard> {
  bool _pressed = false;

  Future<void> _launch(String url) async {
    final uri = Uri.parse(url);
    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Could not launch $url')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedScale(
      duration: const Duration(milliseconds: 120),
      scale: _pressed ? 0.98 : 1,
      child: NeoCard(
        backgroundColor: AppColors.white,
        borderRadius: 20,
        padding: EdgeInsets.zero,
        child: InkWell(
          borderRadius: BorderRadius.circular(20),
          onHighlightChanged: (v) => setState(() => _pressed = v),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                ClipOval(
                  child: Image.asset(
                    widget.member.image,
                    width: 120,
                    height: 120,
                    fit: BoxFit.cover,
                    errorBuilder: (_, __, ___) => Container(
                      width: 120,
                      height: 120,
                      color: Colors.black12,
                      alignment: Alignment.center,
                      child: const Icon(Icons.person, size: 56),
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  widget.member.name,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: AppColors.textDark,
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  widget.member.role,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: AppColors.textDark,
                    fontSize: 13,
                  ),
                ),
                const SizedBox(height: 12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(
                      icon: const Icon(Ionicons.logo_github, color: AppColors.textDark),
                      onPressed: () => _launch(widget.member.github),
                    ),
                    IconButton(
                      icon: const Icon(Ionicons.logo_linkedin,
                          color: AppColors.textDark),
                      onPressed: () => _launch(widget.member.linkedin),
                    ),
                    IconButton(
                      icon: const Icon(Icons.email, color: AppColors.textDark),
                      onPressed: () => _launch('mailto:${widget.member.email}'),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
