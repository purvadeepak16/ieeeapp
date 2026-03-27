import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart';

class DevtoService {
  static const String baseUrl = 'https://dev.to/api';
  static const String _tag = 'DevtoService';

  /// Fetch tech articles from Dev.to API
  /// Returns a list of articles sorted by recent
  static Future<List<DevtoArticle>> fetchTechArticles({
    String tag = 'technology',
    int limit = 10,
  }) async {
    try {
      final Uri url = Uri.parse(
        '$baseUrl/articles?tag_names=$tag&per_page=$limit&sort_by=latest',
      );

      debugPrint('[$_tag] Fetching articles from: $url');

      final response = await http.get(url).timeout(
        const Duration(seconds: 10),
        onTimeout: () => throw Exception('Request timeout'),
      );

      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);
        final articles = data
            .map((json) => DevtoArticle.fromJson(json as Map<String, dynamic>))
            .toList();

        debugPrint('[$_tag] Successfully fetched ${articles.length} articles');
        return articles;
      } else {
        throw Exception(
          'Failed to fetch articles: ${response.statusCode}',
        );
      }
    } catch (e) {
      debugPrint('[$_tag] Error: $e');
      rethrow;
    }
  }

  /// Fetch a single random article for daily skill
  static Future<DevtoArticle> fetchDailyTechArticle({
    String tag = 'technology',
  }) async {
    final articles = await fetchTechArticles(tag: tag, limit: 20);
    if (articles.isEmpty) {
      throw Exception('No articles available');
    }

    // Use date-based seeding for consistent daily article
    final now = DateTime.now();
    final daySeed = now.year * 10000 + now.month * 100 + now.day;
    final index = daySeed % articles.length;

    debugPrint('[$_tag] Selected article index: $index for day: $daySeed');
    return articles[index];
  }
}

class DevtoArticle {
  final int id;
  final String title;
  final String description;
  final String url;
  final String? coverImage;
  final List<String> tags;
  final String author;
  final DateTime publishedAt;
  final int readingTimeMinutes;

  DevtoArticle({
    required this.id,
    required this.title,
    required this.description,
    required this.url,
    this.coverImage,
    required this.tags,
    required this.author,
    required this.publishedAt,
    required this.readingTimeMinutes,
  });

  factory DevtoArticle.fromJson(Map<String, dynamic> json) {
    return DevtoArticle(
      id: json['id'] as int? ?? 0,
      title: json['title'] as String? ?? 'Untitled',
      description: json['description'] as String? ?? 'No description',
      url: json['url'] as String? ?? '',
      coverImage: json['cover_image'] as String?,
      tags: List<String>.from(json['tag_list'] as List? ?? []),
      author: json['user']?['name'] as String? ?? 'Unknown',
      publishedAt: DateTime.tryParse(json['published_at'] as String? ?? '') ??
          DateTime.now(),
      readingTimeMinutes: json['reading_time_minutes'] as int? ?? 5,
    );
  }

  @override
  String toString() => 'DevtoArticle(id: $id, title: $title)';
}
