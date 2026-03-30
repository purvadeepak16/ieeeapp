import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ieee_app/core/services/devto_service.dart';
import 'package:ieee_app/models/micro_skill_model.dart';
import 'package:ieee_app/screens/home/providers/daily_skill_provider.dart';
import 'package:ieee_app/widgets/common/neo_card.dart';
import 'package:url_launcher/url_launcher.dart';

class MicroSkillsWidget extends ConsumerWidget {
  const MicroSkillsWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final dailyArticleAsync = ref.watch(dailyTechArticleProvider);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: dailyArticleAsync.when(
        loading: () => _buildLoadingState(context),
        error: (error, stackTrace) => _buildErrorState(context, error),
        data: (article) {
          final microSkill = _convertArticleToMicroSkill(article);
          return _buildSkillCard(context, microSkill, article.url);
        },
      ),
    );
  }

  /// Convert Dev.to article to MicroSkill format for display
  MicroSkill _convertArticleToMicroSkill(DevtoArticle article) {
    return MicroSkill(
      id: article.id.toString(),
      title: article.title,
      teaser: article.description,
      fullDescription: article.description,
      category: article.tags.isNotEmpty ? article.tags[0] : 'Technology',
      useCases: article.tags.length > 1
          ? article.tags.sublist(1).cast<String>()
          : ['Learn More'],
      resources: [
        Resource(
          type: 'article',
          title: 'Read on Dev.to',
          url: article.url,
          description: 'By ${article.author} • ${article.readingTimeMinutes} min read',
        ),
      ],
      externalUrl: article.url,
      icon: '📚',
      date: article.publishedAt,
      difficulty: _estimateDifficulty(article.readingTimeMinutes),
    );
  }

  /// Estimate difficulty based on reading time
  String _estimateDifficulty(int readingMinutes) {
    if (readingMinutes < 5) return 'beginner';
    if (readingMinutes < 15) return 'intermediate';
    return 'advanced';
  }

  /// Build the skill card
  Widget _buildSkillCard(
    BuildContext context,
    MicroSkill skill,
    String articleUrl,
  ) {
    final colorScheme = Theme.of(context).colorScheme;

    return NeoCard(
      backgroundColor: colorScheme.surface,
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
                      border: Border.all(color: colorScheme.onSurface, width: 1.5),
                    ),
                    child: CircleAvatar(
                      backgroundColor: colorScheme.primary,
                      radius: 16,
                      child: Text(
                        skill.icon,
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
                          color: colorScheme.onSurface,
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
            skill.title,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.w900,
                  color: colorScheme.onSurface,
                  letterSpacing: -0.5,
                ),
          ),
          const SizedBox(height: 12),
          Text(
            skill.teaser,
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: colorScheme.onSurface.withAlpha(220),
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
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                    decoration: BoxDecoration(
                      color:
                          colorScheme.primary.withAlpha(51),
                      borderRadius: BorderRadius.circular(4),
                      border: Border.all(
                          color: colorScheme.primary,
                          width: 1),
                    ),
                    child: Text(
                      skill.category.toUpperCase(),
                      style: TextStyle(
                        color: colorScheme.primary,
                        fontWeight: FontWeight.w900,
                        fontSize: 10,
                      ),
                    ),
                  ),
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                    decoration: BoxDecoration(
                      color: _getDifficultyColor(skill.difficulty),
                      borderRadius: BorderRadius.circular(4),
                      border: Border.all(
                          color: _getDifficultyTextColor(skill.difficulty),
                          width: 1),
                    ),
                    child: Text(
                      skill.difficulty.toUpperCase(),
                      style: TextStyle(
                        color: _getDifficultyTextColor(skill.difficulty),
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
                  onPressed: () => _openArticle(articleUrl),
                  icon: const Icon(Icons.rocket_launch_rounded),
                  label: const Text('READ FULL ARTICLE'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: colorScheme.onSurface,
                    foregroundColor: colorScheme.surface,
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
              color: colorScheme.onSurface.withAlpha(30),
              borderRadius: BorderRadius.circular(4),
              border: Border.all(color: colorScheme.onSurface, width: 1),
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
              Text(
                'UPDATED DAILY',
                style: TextStyle(
                    fontSize: 10,
                    color: colorScheme.onSurface.withAlpha(140),
                    fontWeight: FontWeight.w900),
              ),
              Text(
                'FROM DEV.TO',
                style: TextStyle(
                    fontSize: 10,
                    color: colorScheme.onSurface.withAlpha(140),
                    fontWeight: FontWeight.w900),
              ),
            ],
          ),
        ],
      ),
    );
  }

  /// Build loading state
  Widget _buildLoadingState(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return NeoCard(
      backgroundColor: colorScheme.surface,
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
                      border: Border.all(color: colorScheme.onSurface, width: 1.5),
                    ),
                    child: CircleAvatar(
                      backgroundColor: colorScheme.primary,
                      radius: 16,
                      child: const Text('📚', style: TextStyle(fontSize: 14)),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Text(
                    'DAILY MICRO-SKILL',
                    style: TextStyle(
                      fontWeight: FontWeight.w900,
                      letterSpacing: 1.0,
                      color: colorScheme.onSurface,
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 20),
          const CircularProgressIndicator(),
          const SizedBox(height: 12),
          Text(
            'Loading today\'s skill...',
            style: TextStyle(color: colorScheme.onSurface.withAlpha(140)),
          ),
        ],
      ),
    );
  }

  /// Build error state
  Widget _buildErrorState(BuildContext context, Object error) {
    final colorScheme = Theme.of(context).colorScheme;

    return NeoCard(
      backgroundColor: colorScheme.surface,
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
                      border: Border.all(color: Colors.red, width: 1.5),
                    ),
                    child: const CircleAvatar(
                      backgroundColor: Colors.red,
                      radius: 16,
                      child: Text('⚠️', style: TextStyle(fontSize: 14)),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Text(
                    'DAILY MICRO-SKILL',
                    style: TextStyle(
                      fontWeight: FontWeight.w900,
                      letterSpacing: 1.0,
                      color: colorScheme.onSurface,
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 20),
          Text(
            'Unable to load today\'s skill',
            style: TextStyle(
              fontWeight: FontWeight.w900,
              color: colorScheme.onSurface,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Please check your internet connection',
            style: TextStyle(color: colorScheme.onSurface.withAlpha(140), fontSize: 12),
          ),
        ],
      ),
    );
  }

  /// Open article URL
  Future<void> _openArticle(String url) async {
    final Uri uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }

  Color _getDifficultyTextColor(String difficulty) {
    switch (difficulty.toLowerCase()) {
      case 'beginner':
        return Colors.green;
      case 'intermediate':
        return Colors.orange;
      case 'advanced':
        return Colors.red;
      default:
        return Colors.grey;
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
