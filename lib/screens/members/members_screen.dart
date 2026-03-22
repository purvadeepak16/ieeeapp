import 'package:flutter/material.dart';
import 'package:ieee_app/data/council_members_data.dart';
import 'package:ieee_app/models/council_member_model.dart';
import 'package:ieee_app/widgets/council_member_card.dart';
import 'package:ieee_app/screens/members/member_detail_screen.dart';

class MembersScreen extends StatelessWidget {
  const MembersScreen({super.key});

  void _openMember(BuildContext context, CouncilMember member) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => MemberDetailScreen(member: member),
      ),
    );
  }

  Widget _sectionTitle(BuildContext context, String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: Center(
        child: Text(
          title,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: Theme.of(context).colorScheme.primary,
            letterSpacing: 1,
          ),
        ),
      ),
    );
  }

  Widget _memberList(BuildContext context, List<CouncilMember> members) {
    return Column(
      children: [
        for (final m in members) ...[
          const Divider(height: 1, indent: 16, endIndent: 16),
          CouncilMemberCard(
            member: m,
            onTap: () => _openMember(context, m),
          ),
        ],
      ],
    );
  }

  Widget _expandableSection(
    BuildContext context, {
    required String title,
    required List<CouncilMember> members,
  }) {
    return Theme(
      data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
      child: ExpansionTile(
        shape: const Border(),
        collapsedShape: const Border(),
        title: Center(
          child: Text(
            title,
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: Theme.of(context).colorScheme.primary,
              letterSpacing: 1,
            ),
          ),
        ),
        iconColor: Theme.of(context).colorScheme.primary,
        collapsedIconColor: Theme.of(context).colorScheme.primary,
        children: [
          _memberList(context, members),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    const branch = CouncilMembersData.branchCounsellors;
    const senior = CouncilMembersData.seniorCouncil;
    const junior = CouncilMembersData.juniorCouncil;
    const se = CouncilMembersData.seCouncil;

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: ListView(
                children: [
                  _sectionTitle(context, 'Branch Counsellors'),
                  _memberList(context, branch),
                  const Divider(height: 1, indent: 16, endIndent: 16),
                  _sectionTitle(context, 'Senior Council'),
                  _memberList(context, senior),
                  const Divider(height: 1, indent: 16, endIndent: 16),
                  _expandableSection(context,
                      title: 'Junior Council', members: junior),
                  const Divider(height: 1, indent: 16, endIndent: 16),
                  _expandableSection(context, title: 'SE Council', members: se),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
