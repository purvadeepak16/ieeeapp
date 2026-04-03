import 'package:flutter/material.dart';

class CouncilMember {
  final String name;
  final String role;
  final Color color;
  final String email;
  final String? imagePath;
  final String? linkedinUrl;
  final String? githubUrl;

  const CouncilMember({
    required this.name,
    required this.role,
    required this.color,
    required this.email,
    this.githubUrl,
    this.imagePath,
    this.linkedinUrl,
  });

  CouncilMember copyWith({
    String? email,
    String? quote,
  }) {
    return CouncilMember(
      name: name,
      role: role,
      color: color,
      email: email ?? this.email,
      githubUrl: githubUrl,
      imagePath: imagePath,
      linkedinUrl: linkedinUrl,
    );
  }
}
