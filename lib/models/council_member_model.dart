import 'package:flutter/material.dart';

class CouncilMember {
  final String name;
  final String role;
  final Color color;
  final String email;
  final String quote;
  final String? imagePath;

  const CouncilMember({
    required this.name,
    required this.role,
    required this.color,
    required this.email,
    required this.quote,
    this.imagePath,
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
      quote: quote ?? this.quote,
      imagePath: imagePath,
    );
  }
}
