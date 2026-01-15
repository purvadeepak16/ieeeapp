import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ieee_app/models/event_model.dart';

final eventsProvider = StateProvider<List<IEEEEvent>>((ref) => _demoEvents);

final _demoEvents = [
  IEEEEvent(
    title: 'Flutter Workshop',
    description:
        'Learn Flutter from scratch with hands-on projects. Perfect for beginners who want to dive into mobile development.',
    date: DateTime(2026, 1, 18),
    startTime: const TimeOfDay(hour: 14, minute: 30),
    endTime: const TimeOfDay(hour: 17, minute: 0),
    venue: 'Lab 301, VESIT',
    type: EventType.workshop,
    imageUrl: 'https://picsum.photos/400/300?random=1',
    isFeatured: true,
    registrationLink: 'https://forms.gle/example1', // Google Form link
    tags: ['flutter', 'mobile', 'beginners', 'development'],
  ),
  IEEEEvent(
    title: 'IEEE General Body Meeting',
    description:
        'Monthly meeting to discuss upcoming events, initiatives, and member activities.',
    date: DateTime(2026, 1, 20),
    startTime: const TimeOfDay(hour: 16, minute: 0),
    endTime: const TimeOfDay(hour: 18, minute: 0),
    venue: 'Auditorium, VESIT',
    type: EventType.meeting,
    registrationLink: 'https://forms.gle/example2',
    tags: ['meeting', 'general', 'discussion'],
  ),
  IEEEEvent(
    title: 'Project Submission Deadline',
    description:
        'Last date to submit IEEE project proposals for funding consideration.',
    date: DateTime(2026, 1, 25),
    startTime: const TimeOfDay(hour: 23, minute: 59),
    venue: 'Online',
    type: EventType.deadline,
    registrationLink: 'https://forms.gle/example3',
    tags: ['deadline', 'projects', 'submission'],
  ),
  IEEEEvent(
    title: 'Hackathon 2026',
    description:
        'Annual 24-hour coding competition with exciting prizes and networking opportunities.',
    date: DateTime(2026, 1, 28),
    startTime: const TimeOfDay(hour: 9, minute: 0),
    endTime: const TimeOfDay(hour: 9, minute: 0),
    venue: 'Computer Center, VESIT',
    type: EventType.competition,
    imageUrl: 'https://picsum.photos/400/300?random=2',
    isFeatured: true,
    registrationLink: 'https://forms.gle/example4',
    tags: ['hackathon', 'competition', 'coding', 'prizes'],
  ),
  IEEEEvent(
    title: 'AI & ML Conference',
    description:
        'Explore latest trends in Artificial Intelligence and Machine Learning with industry experts.',
    date: DateTime(2026, 1, 29),
    startTime: const TimeOfDay(hour: 10, minute: 0),
    endTime: const TimeOfDay(hour: 16, minute: 0),
    venue: 'Seminar Hall, VESIT',
    type: EventType.conference,
    imageUrl: 'https://picsum.photos/400/300?random=3',
    registrationLink: 'https://forms.gle/example5',
    tags: ['ai', 'ml', 'conference', 'technology'],
  ),
];

final selectedDateProvider = StateProvider<DateTime>((ref) => DateTime.now());
