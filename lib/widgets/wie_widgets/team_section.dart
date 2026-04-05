import 'package:flutter/material.dart';
import 'package:ieee_app/models/wie_member_model.dart';
import 'package:ieee_app/widgets/wie_widgets/members_grid.dart';
import 'package:ieee_app/widgets/wie_widgets/section_header.dart';

class TeamSection extends StatelessWidget {
  const TeamSection({super.key});

  @override
  Widget build(BuildContext context) {
    final membersSenior = [
      const WieMemberModel(
        name: 'Anshi Tiwari',
        role: 'Sr. Women in Engineering',
        email: '2022.anshi.tiware@ves.ac.in',
        linkedin: 'https://www.linkedin.com/in/anshi-tiwari-b4a6642a7/',
        github: 'https://github.com/anshi1108',
        image: 'assets/images/BE_council/Anshi.jpeg',
      ),
      const WieMemberModel(
        name: 'Vedika Parab',
        role: 'Jr. Women in Engineering',
        image: 'assets/images/TE_council/VedikaParab.jpg', // Fallback to avatar if Vedika.png is absent
        github: 'https://github.com/VedikaParab',
        linkedin: 'http://linkedin.com/in/vedika-parab',
        email: '2023.vedika.parab@ves.ac.in',
      ),
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SectionHeader(title: 'Meet Our Team'),
        const SizedBox(height: 8),
        MembersGrid(members: membersSenior),
      ],
    );
  }
}
