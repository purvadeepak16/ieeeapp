import 'package:flutter/material.dart';
import 'package:ieee_app/models/micro_skill_model.dart';
import 'package:ieee_app/screens/home/micro_skill_detail_screen.dart';

class MicroSkillsWidget extends StatelessWidget {
  final MicroSkill todaysSkill = MicroSkill(
    id: '1',
    title: 'API First Design',
    teaser: 'Build scalable systems by designing the API before implementation. Widely used in microservices.',
    fullDescription: 'API First Design is an approach where the API specification is designed before any implementation begins. This ensures consistency, better developer experience, and easier integration between different services.',
    category: 'Software Architecture',
    useCases: [
      'Microservices Communication',
      'Mobile App Backends',
      'Third-party Integrations',
      'Cloud-native Applications'
    ],
    resources: [
      Resource(
        type: 'article',
        title: 'API First Design Principles',
        url: 'https://swagger.io/resources/articles/adopting-an-api-first-approach/',
        description: 'Learn the core principles of API First Design',
      ),
      Resource(
        type: 'video',
        title: 'REST API Design Course',
        url: 'https://www.youtube.com/watch?v=lsMQRaeKNDk',
        description: 'Complete guide to REST API design',
      ),
      Resource(
        type: 'github',
        title: 'OpenAPI Examples',
        url: 'https://github.com/OAI/OpenAPI-Specification/tree/main/examples',
        description: 'Real-world OpenAPI specifications',
      ),
    ],
    externalUrl: 'https://www.postman.com/api-first/',
    icon: '🔌',
    date: DateTime.now(),
    difficulty: 'intermediate',
  );

  MicroSkillsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    CircleAvatar(
                      backgroundColor: Theme.of(context).colorScheme.primary,
                      child: Text(
                        todaysSkill.icon,
                        style: const TextStyle(fontSize: 16),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Text(
                      'Daily Micro-Skill',
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                Chip(
                  label: const Text('New'),
                  backgroundColor: Colors.green.withAlpha(51),
                  labelStyle: const TextStyle(color: Colors.green),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Text(
              todaysSkill.title,
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              todaysSkill.teaser,
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                color: Theme.of(context).colorScheme.onSurface.withAlpha(178),
              ),
            ),
            const SizedBox(height: 16),
            
            // FIXED: Wrap instead of Row for better responsiveness
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: [
                    Chip(
                      label: Text(todaysSkill.category),
                      backgroundColor: Theme.of(context).colorScheme.primary.withAlpha(51),
                    ),
                    Chip(
                      label: Text(todaysSkill.difficulty),
                      backgroundColor: _getDifficultyColor(context, todaysSkill.difficulty),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton.icon(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => MicroSkillDetailScreen(
                            microSkill: todaysSkill,
                          ),
                        ),
                      );
                    },
                    icon: const Icon(Icons.rocket_launch),
                    label: const Text('Learn Now'),
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            
            const SizedBox(height: 8),
            const LinearProgressIndicator(
              value: 0.3,
              backgroundColor: Colors.grey,
              valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
            ),
            const SizedBox(height: 4),
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Day 3 of 30',
                  style: TextStyle(fontSize: 12, color: Colors.grey),
                ),
                Text(
                  '30% complete',
                  style: TextStyle(fontSize: 12, color: Colors.grey),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Color _getDifficultyColor(BuildContext context, String difficulty) {
    switch (difficulty.toLowerCase()) {
      case 'beginner':
        return Colors.green.withAlpha(51);
      case 'intermediate':
        return Colors.orange.withAlpha(51);
      case 'advanced':
        return Colors.red.withAlpha(51);
      default:
        return Colors.grey.withAlpha(51);
    }
  }
}