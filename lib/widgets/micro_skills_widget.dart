import 'package:flutter/material.dart';
import 'package:ieee_app/models/micro_skill_model.dart';
import 'package:ieee_app/screens/home/micro_skill_detail_screen.dart';
import 'package:ieee_app/widgets/common/neo_card.dart';

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
    resources: const [
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
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: NeoCard(
        backgroundColor: Colors.white,
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.black, width: 1.5),
                      ),
                      child: CircleAvatar(
                        backgroundColor: Theme.of(context).colorScheme.primary,
                        radius: 16,
                        child: Text(
                          todaysSkill.icon,
                          style: const TextStyle(fontSize: 14),
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Text(
                      'DAILY MICRO-SKILL',
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w900,
                        letterSpacing: 1.0,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: Colors.green.withAlpha(51),
                    borderRadius: BorderRadius.circular(4),
                    border: Border.all(color: Colors.green, width: 1.5),
                  ),
                  child: const Text(
                    'NEW',
                    style: TextStyle(
                      color: Colors.green,
                      fontWeight: FontWeight.w900,
                      fontSize: 10,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Text(
              todaysSkill.title,
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.w900,
                color: Colors.black,
                letterSpacing: -0.5,
              ),
            ),
            const SizedBox(height: 12),
            Text(
              todaysSkill.teaser,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: Colors.black87,
                height: 1.5,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 24),
            
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.primary.withAlpha(51),
                        borderRadius: BorderRadius.circular(4),
                        border: Border.all(color: Theme.of(context).colorScheme.primary, width: 1),
                      ),
                      child: Text(
                        todaysSkill.category.toUpperCase(),
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.primary,
                          fontWeight: FontWeight.w900,
                          fontSize: 10,
                        ),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                      decoration: BoxDecoration(
                        color: _getDifficultyColor(todaysSkill.difficulty),
                        borderRadius: BorderRadius.circular(4),
                        border: Border.all(color: _getDifficultyTextColor(todaysSkill.difficulty), width: 1),
                      ),
                      child: Text(
                        todaysSkill.difficulty.toUpperCase(),
                        style: TextStyle(
                          color: _getDifficultyTextColor(todaysSkill.difficulty),
                          fontWeight: FontWeight.w900,
                          fontSize: 10,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
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
                    icon: const Icon(Icons.rocket_launch_rounded),
                    label: const Text('LEARN NOW'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.black,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(4),
                      ),
                      elevation: 0,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                    ),
                  ),
                ),
              ],
            ),
            
            const SizedBox(height: 16),
            Container(
              height: 8,
              decoration: BoxDecoration(
                color: Colors.black12,
                borderRadius: BorderRadius.circular(4),
                border: Border.all(color: Colors.black, width: 1),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(4),
                child: const LinearProgressIndicator(
                  value: 0.3,
                  backgroundColor: Colors.transparent,
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
                ),
              ),
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'DAY 3 OF 30',
                  style: TextStyle(fontSize: 10, color: Colors.black54, fontWeight: FontWeight.w900),
                ),
                const Text(
                  '30% COMPLETE',
                  style: TextStyle(fontSize: 10, color: Colors.black54, fontWeight: FontWeight.w900),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Color _getDifficultyTextColor(String difficulty) {
    switch (difficulty.toLowerCase()) {
      case 'beginner': return Colors.green;
      case 'intermediate': return Colors.orange;
      case 'advanced': return Colors.red;
      default: return Colors.grey;
    }
  }

  Color _getDifficultyColor(String difficulty) {
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