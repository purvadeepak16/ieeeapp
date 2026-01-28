import 'package:flutter/material.dart';
import 'package:ieee_app/models/council_member_model.dart';

class MemberDetailScreen extends StatelessWidget {
  final CouncilMember member;

  const MemberDetailScreen({
    super.key,
    required this.member,
  });

  bool get _hasImage =>
      member.imagePath != null && member.imagePath!.trim().isNotEmpty;

  bool get _hasEmail => member.email.trim().isNotEmpty;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Top logo
                Align(
                  alignment: Alignment.centerLeft,
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      border: Border.all(color: const Color(0xFF1A237E), width: 2),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Image.asset(
                      'assets/images/logos/ieee_logo.png',
                      width: 28,
                      height: 28,
                      fit: BoxFit.contain,
                      errorBuilder: (context, error, stackTrace) {
                        return const Icon(
                          Icons.change_history,
                          color: Color(0xFF1A237E),
                          size: 24,
                        );
                      },
                    ),
                  ),
                ),

                const SizedBox(height: 20),

                // Profile Card + Avatar
                Stack(
                  alignment: Alignment.topCenter,
                  clipBehavior: Clip.none,
                  children: [
                    // Main Info Card
                    Container(
                      margin: const EdgeInsets.only(top: 55),
                      width: double.infinity,
                      padding: const EdgeInsets.fromLTRB(20, 70, 20, 25),
                      decoration: BoxDecoration(
                        color: const Color(0xFF1A237E),
                        borderRadius: BorderRadius.circular(22),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.12),
                            blurRadius: 14,
                            offset: const Offset(0, 6),
                          ),
                        ],
                      ),
                      child: Column(
                        children: [
                          Text(
                            member.name,
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const SizedBox(height: 10),

                          // Role badge
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.12),
                              borderRadius: BorderRadius.circular(30),
                              border: Border.all(color: Colors.white.withOpacity(0.25)),
                            ),
                            child: Text(
                              member.role.isEmpty ? "Member" : member.role,
                              style: const TextStyle(
                                color: Colors.white70,
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    // Avatar
                    // Avatar
                    Positioned(
                      top: 0,
                      child: CircleAvatar(
                        radius: 55,
                        backgroundColor: member.color,
                        child: ClipOval(
                          child: _hasImage
                              ? Image.asset(
                            member.imagePath!,
                            width: 110,
                            height: 110,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) {
                              // if image path wrong
                              return Center(
                                child: Text(
                                  member.name.isNotEmpty
                                      ? member.name[0].toUpperCase()
                                      : '?',
                                  style: const TextStyle(
                                    fontSize: 34,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                              );
                            },
                          )
                              : Center(
                            child: Text(
                              member.name.isNotEmpty
                                  ? member.name[0].toUpperCase()
                                  : '?',
                              style: const TextStyle(
                                fontSize: 34,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),

                  ],
                ),

                const SizedBox(height: 30),

                // Quote Card
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(26),
                  decoration: BoxDecoration(
                    color: const Color(0xFF1A237E),
                    borderRadius: BorderRadius.circular(22),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.10),
                        blurRadius: 10,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Text(
                    member.quote.trim().isEmpty
                        ? '“Work hard, stay consistent, and keep learning every day.”'
                        : '“${member.quote}”',
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                      height: 1.4,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                ),

                const SizedBox(height: 40),

                // Contact Details
                const Text(
                  'CONTACT DETAILS',
                  style: TextStyle(
                    color: Color(0xFF1A237E),
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1,
                  ),
                ),
                const SizedBox(height: 16),

                // Email Button
                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: _hasEmail ? () {} : null,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF1A237E),
                      disabledBackgroundColor: const Color(0xFF1A237E).withOpacity(0.35),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: Text(
                      _hasEmail ? member.email : 'Email not available',
                      style: const TextStyle(color: Colors.white, fontSize: 16),
                    ),
                  ),
                ),

                const SizedBox(height: 50),

                // Back Button
                SizedBox(
                  width: 200,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: () => Navigator.pop(context),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF1A237E),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    child: const Text(
                      'Back',
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    ),
                  ),
                ),

                const SizedBox(height: 10),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
