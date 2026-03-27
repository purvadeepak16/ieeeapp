import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ieee_app/models/event_model.dart';

final eventsProvider = StateProvider<List<IEEEEvent>>((ref) => _demoEvents);

final _demoEvents = [
  IEEEEvent(
    title: 'Symposium',
    description:
        'A chapter closed with impact, memories, and a legacy that moves forward.',
    date: DateTime(2026, 04, 09),
    startTime: const TimeOfDay(hour: 14, minute: 30),
    endTime: const TimeOfDay(hour: 16, minute: 30),
    venue: 'B51, VESIT',
    type: EventType.social,
    tags: ['symposium', 'networking', 'community'],
  ),
  IEEEEvent(
    title: 'Machine Minds 2.0',
    description:
        'Data turned into decisions, participants built models that actually learn.',
    date: DateTime(2026, 03, 23),
    startTime: const TimeOfDay(hour: 14, minute: 30),
    endTime: const TimeOfDay(hour: 16, minute: 30),
    venue: 'B51, VESIT',
    type: EventType.workshop,
    tags: ['machinelearning', 'ai', 'datascience'],
    resourceLink: 'https://drive.google.com/drive/folders/1BUHnhWVkSJQUtSgS5q_488RdhXLiLKhx?usp=sharing',
  ),
  IEEEEvent(
    title: 'Machine Minds 2.0',
    description:
        'Data turned into decisions, participants built models that actually learn.',
    date: DateTime(2026, 03, 24),
    startTime: const TimeOfDay(hour: 14, minute: 30),
    endTime: const TimeOfDay(hour: 16, minute: 30),
    venue: 'B51, VESIT',
    type: EventType.workshop,
    tags: ['machinelearning', 'ai', 'datascience'],
    resourceLink: 'https://drive.google.com/drive/folders/1BUHnhWVkSJQUtSgS5q_488RdhXLiLKhx?usp=sharing',
  ),
  IEEEEvent(
    title: 'Capture The Flag Competition',
    description:
        'Pressure was real, challenges were tougher and only the sharpest cracked them.',
    date: DateTime(2026, 02, 13),
    startTime: const TimeOfDay(hour: 12, minute: 30),
    endTime: const TimeOfDay(hour: 16, minute: 30),
    venue: 'B51, B52, VESIT',
    type: EventType.competition,
    tags: ['cybersecurity', 'ctf', 'competition'],
  ),
  IEEEEvent(
    title: 'Capture The Flag Workshop',
    description:
        'Fast thinking, smart moves, and real cybersecurity challenges solved.',
    date: DateTime(2026, 02, 11),
    startTime: const TimeOfDay(hour: 19, minute: 00),
    endTime: const TimeOfDay(hour: 21, minute: 00),
    venue: 'Online',
    type: EventType.workshop,
    tags: ['cybersecurity', 'ctf', 'workshop'],
    resourceLink: 'https://drive.google.com/drive/folders/1BUHnhWVkSJQUtSgS5q_488RdhXLiLKhx?usp=sharing',
  ),
  IEEEEvent(
    title: 'Capture The Flag Workshop',
    description:
        'Fast thinking, smart moves, and real cybersecurity challenges solved.',
    date: DateTime(2026, 02, 12),
    startTime: const TimeOfDay(hour: 19, minute: 00),
    endTime: const TimeOfDay(hour: 21, minute: 00),
    venue: 'Online',
    type: EventType.workshop,
    tags: ['cybersecurity', 'ctf', 'workshop'],
    resourceLink: 'https://drive.google.com/drive/folders/1BUHnhWVkSJQUtSgS5q_488RdhXLiLKhx?usp=sharing',
  ),
  IEEEEvent(
    title: 'Arcane Hackathon',
    description:
        'Ideas turned into working solutions, built, tested, and delivered within hours.',
    date: DateTime(2026, 01, 04),
    startTime: const TimeOfDay(hour: 00, minute: 00),
    endTime: const TimeOfDay(hour: 10, minute: 00),
    venue: 'Online',
    type: EventType.competition,
    tags: ['hackathon', 'innovation', 'coding'],
  ),
  IEEEEvent(
    title: 'Arcane Hackathon',
    description:
        'Ideas turned into working solutions, built, tested, and delivered within hours.',
    date: DateTime(2026, 01, 03),
    startTime: const TimeOfDay(hour: 09, minute: 00),
    endTime: const TimeOfDay(hour: 23, minute: 59),
    venue: 'Online',
    type: EventType.competition,
    tags: ['hackathon', 'innovation', 'coding'],
  ),
  IEEEEvent(
    title: 'ApiCalypse',
    description:
        'Different systems connected seamlessly, real-world integrations in action.',
    date: DateTime(2025, 12, 09),
    startTime: const TimeOfDay(hour: 16, minute: 30),
    endTime: const TimeOfDay(hour: 18, minute: 30),
    venue: 'Online',
    type: EventType.workshop,
    tags: ['api', 'backend', 'integration'],
    resourceLink: 'https://drive.google.com/drive/folders/1BUHnhWVkSJQUtSgS5q_488RdhXLiLKhx?usp=sharing',
  ),
  IEEEEvent(
    title: 'ApiCalypse',
    description:
        'Different systems connected seamlessly, real-world integrations in action.',
    date: DateTime(2025, 12, 10),
    startTime: const TimeOfDay(hour: 16, minute: 30),
    endTime: const TimeOfDay(hour: 18, minute: 30),
    venue: 'Online',
    type: EventType.workshop,
    tags: ['api', 'backend', 'integration'],
    resourceLink: 'https://drive.google.com/drive/folders/1BUHnhWVkSJQUtSgS5q_488RdhXLiLKhx?usp=sharing',
  ),
  IEEEEvent(
    title: 'TPP Workshop',
    description:
        'Strong ideas, sharp thinking, and confident delivery on one stage.',
    date: DateTime(2025, 08, 23),
    startTime: const TimeOfDay(hour: 16, minute: 0),
    endTime: const TimeOfDay(hour: 18, minute: 0),
    venue: 'B21, VESIT',
    type: EventType.workshop,
    tags: ['presentation', 'research', 'technical'],
    resourceLink: 'https://drive.google.com/drive/folders/1BUHnhWVkSJQUtSgS5q_488RdhXLiLKhx?usp=sharing',
  ),
  IEEEEvent(
    title: 'TPP Workshop',
    description:
        'Strong ideas, sharp thinking, and confident delivery on one stage.',
    date: DateTime(2025, 08, 22),
    startTime: const TimeOfDay(hour: 14, minute: 30),
    endTime: const TimeOfDay(hour: 16, minute: 30),
    venue: 'B41, VESIT',
    type: EventType.workshop,
    tags: ['presentation', 'research', 'technical'],
    resourceLink: 'https://drive.google.com/drive/folders/1BUHnhWVkSJQUtSgS5q_488RdhXLiLKhx?usp=sharing',
  ),
  IEEEEvent(
    title: 'UI/UX Workshop',
    description:
        'Simple ideas turned into smooth, user-first digital experiences.',
    date: DateTime(2025, 07, 31),
    startTime: const TimeOfDay(hour: 14, minute: 30),
    endTime: const TimeOfDay(hour: 16, minute: 30),
    venue: 'B21, VESIT',
    type: EventType.workshop,
    tags: ['design', 'uiux', 'creativity'],
    resourceLink: 'https://drive.google.com/drive/folders/1BUHnhWVkSJQUtSgS5q_488RdhXLiLKhx?usp=sharing',
  ),
  IEEEEvent(
    title: 'UI/UX Workshop',
    description:
        'Simple ideas turned into smooth, user-first digital experiences.',
    date: DateTime(2025, 08, 01),
    startTime: const TimeOfDay(hour: 14, minute: 30),
    endTime: const TimeOfDay(hour: 16, minute: 30),
    venue: 'B21, VESIT',
    type: EventType.workshop,
    tags: ['design', 'uiux', 'creativity'],
    resourceLink: 'https://drive.google.com/drive/folders/1BUHnhWVkSJQUtSgS5q_488RdhXLiLKhx?usp=sharing',
  ),
  IEEEEvent(
    title: 'Build.PCB',
    description:
        'Ideas moved off the screen and onto real boards, fully built and working.',
    date: DateTime(2025, 07, 17),
    startTime: const TimeOfDay(hour: 14, minute: 30),
    endTime: const TimeOfDay(hour: 16, minute: 30),
    venue: 'Online',
    type: EventType.competition,
    isFeatured: true,
    tags: ['pcb', 'electronics', 'hardware'],
  ),
  IEEEEvent(
    title: 'Build.PCB',
    description:
        'Ideas moved off the screen and onto real boards, fully built and working.',
    date: DateTime(2025, 07, 18),
    startTime: const TimeOfDay(hour: 14, minute: 30),
    endTime: const TimeOfDay(hour: 16, minute: 30),
    venue: 'Online',
    type: EventType.competition,
    isFeatured: true,
    tags: ['pcb', 'electronics', 'hardware'],
  ),
  IEEEEvent(
    title: 'Mongo.INIT()',
    description:
        "mongo.init() wasn't just a start, it was where databases came to life.",
    date: DateTime(2025, 07, 04),
    startTime: const TimeOfDay(hour: 14, minute: 30),
    endTime: const TimeOfDay(hour: 16, minute: 30),
    venue: 'Online',
    type: EventType.workshop,
    tags: ['mongodb', 'database', 'nosql'],
    resourceLink: 'https://drive.google.com/drive/folders/1BUHnhWVkSJQUtSgS5q_488RdhXLiLKhx?usp=sharing',
  ),
  IEEEEvent(
    title: 'Mongo.INIT()',
    description:
        "mongo.init() wasn't just a start, it was where databases came to life.",
    date: DateTime(2025, 07, 05),
    startTime: const TimeOfDay(hour: 14, minute: 30),
    endTime: const TimeOfDay(hour: 16, minute: 30),
    venue: 'Online',
    type: EventType.workshop,
    tags: ['mongodb', 'database', 'nosql'],
    resourceLink: 'https://drive.google.com/drive/folders/1BUHnhWVkSJQUtSgS5q_488RdhXLiLKhx?usp=sharing',
  ),
];

final selectedDateProvider = StateProvider<DateTime>((ref) => DateTime.now());
