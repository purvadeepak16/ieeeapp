import 'package:flutter/material.dart';
class MicroSkill {
  final String id;
  final String title;
  final String teaser;
  final String fullDescription;
  final String category;
  final List<String> useCases;
  final List<Resource> resources;
  final String externalUrl;
  final String icon;
  final DateTime date;
  final String difficulty; // beginner, intermediate, advanced

  MicroSkill({
    required this.id,
    required this.title,
    required this.teaser,
    required this.fullDescription,
    required this.category,
    required this.useCases,
    required this.resources,
    required this.externalUrl,
    required this.icon,
    required this.date,
    this.difficulty = 'beginner',
  });

  factory MicroSkill.fromJson(Map<String, dynamic> json) {
    return MicroSkill(
      id: json['id'] ?? '',
      title: json['title'] ?? '',
      teaser: json['teaser'] ?? '',
      fullDescription: json['fullDescription'] ?? '',
      category: json['category'] ?? 'Technology',
      useCases: List<String>.from(json['useCases'] ?? []),
      resources: (json['resources'] as List?)
          ?.map((e) => Resource.fromJson(e))
          .toList() ?? [],
      externalUrl: json['externalUrl'] ?? '',
      icon: json['icon'] ?? '⚡',
      date: DateTime.parse(json['date'] ?? DateTime.now().toString()),
      difficulty: json['difficulty'] ?? 'beginner',
    );
  }
}

class Resource {
  final String type; // 'video', 'article', 'pdf', 'tool', 'github'
  final String title;
  final String url;
  final String description;

  Resource({
    required this.type,
    required this.title,
    required this.url,
    required this.description,
  });

  factory Resource.fromJson(Map<String, dynamic> json) {
    return Resource(
      type: json['type'] ?? 'article',
      title: json['title'] ?? '',
      url: json['url'] ?? '',
      description: json['description'] ?? '',
    );
  }

  IconData get icon {
    switch (type) {
      case 'video':
        return Icons.videocam;
      case 'article':
        return Icons.article;
      case 'pdf':
        return Icons.picture_as_pdf;
      case 'github':
        return Icons.code;
      case 'tool':
        return Icons.build;
      default:
        return Icons.link;
    }
  }
}