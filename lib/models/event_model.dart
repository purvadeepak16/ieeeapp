import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

enum EventType { workshop, meeting, conference, deadline, social, competition }

class IEEEEvent {
  final String id;
  final String title;
  final String description;
  final DateTime date;
  final TimeOfDay startTime;
  final TimeOfDay? endTime;
  final String venue;
  final EventType type;
  final String? imageUrl;
  final bool isFeatured;
  final String registrationLink; // ADDED: Google Form link
  final List<String> tags;

  IEEEEvent({
    String? id,
    required this.title,
    required this.description,
    required this.date,
    required this.startTime,
    this.endTime,
    required this.venue,
    required this.type,
    this.imageUrl,
    this.isFeatured = false,
    required this.registrationLink, // REQUIRED now
    this.tags = const [],
  }) : id = id ?? const Uuid().v4();

  String get formattedDate => '${date.day}/${date.month}/${date.year}';

  String get formattedTime {
    final start = _formatTimeOfDay(startTime);
    if (endTime != null) {
      return '$start - ${_formatTimeOfDay(endTime!)}';
    }
    return start;
  }

  String _formatTimeOfDay(TimeOfDay time) {
    final hour = time.hourOfPeriod;
    final minute = time.minute.toString().padLeft(2, '0');
    final period = time.period == DayPeriod.am ? 'AM' : 'PM';
    return '$hour:$minute $period';
  }

  bool get isUpcoming =>
      date.isAfter(DateTime.now().subtract(const Duration(days: 1)));

  String get typeLabel {
    switch (type) {
      case EventType.workshop:
        return 'Workshop';
      case EventType.meeting:
        return 'Meeting';
      case EventType.conference:
        return 'Conference';
      case EventType.deadline:
        return 'Deadline';
      case EventType.social:
        return 'Social';
      case EventType.competition:
        return 'Competition';
    }
  }

  Color get typeColor {
    switch (type) {
      case EventType.workshop:
        return const Color(0xFF0066CC); // IEEE Blue
      case EventType.meeting:
        return const Color(0xFF34A853); // Green
      case EventType.conference:
        return const Color(0xFFEA4335); // Red
      case EventType.deadline:
        return const Color(0xFFFBBC05); // Yellow
      case EventType.social:
        return const Color(0xFF8E44AD); // Purple
      case EventType.competition:
        return const Color(0xFFE67E22); // Orange
    }
  }
}
