import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ieee_app/core/services/devto_service.dart';

/// Provider for fetching daily tech article from Dev.to
/// Caches the result so it doesn't refetch on every rebuild
/// Uses date-based seeding for consistent daily article
final dailyTechArticleProvider = FutureProvider<DevtoArticle>((ref) {
  return DevtoService.fetchDailyTechArticle(tag: 'technology');
});

/// Provider for fetching multiple tech articles
final techArticlesProvider = FutureProvider.family<List<DevtoArticle>, String>(
  (ref, tag) {
    return DevtoService.fetchTechArticles(tag: tag, limit: 10);
  },
);
