import 'package:flutter/material.dart';
import 'package:ieee_app/data/council_members_data.dart';
import 'package:ieee_app/models/council_member_model.dart';
import 'package:ieee_app/widgets/council_member_card.dart';
import 'member_detail_screen.dart';

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


  Widget _sectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: Center(
        child: Text(
          title,
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: Color(0xFF1A237E),
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
            style: const TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: Color(0xFF1A237E),
              letterSpacing: 1,
            ),
          ),
        ),
        iconColor: const Color(0xFF1A237E),
        collapsedIconColor: const Color(0xFF1A237E),
        children: [
          _memberList(context, members),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final branch = CouncilMembersData.branchCounsellors;
    final senior = CouncilMembersData.seniorCouncil;
    final junior = CouncilMembersData.juniorCouncil;
    final se = CouncilMembersData.seCouncil;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            // Header
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        border: Border.all(color: const Color(0xFF1A237E), width: 2),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Image.asset(
                        'assets/images/logos/ieee_logo.png',
                        width: 24,
                        height: 24,
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),

                  const Text(
                    'IEEE Council',
                    style: TextStyle(
                      color: Color(0xFF1A237E),
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),

            Expanded(
              child: ListView(
                children: [
                  _sectionTitle('Branch Counsellors'),
                  _memberList(context, branch),

                  const Divider(height: 1, indent: 16, endIndent: 16),
                  _sectionTitle('Senior Council'),
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

            // Send Message Button
            Padding(
              padding:
              const EdgeInsets.symmetric(horizontal: 40.0, vertical: 20.0),
              child: SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF1A237E),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25),
                    ),
                  ),
                  child: const Text(
                    'Send Message',
                    style: TextStyle(fontSize: 16, color: Colors.white),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

