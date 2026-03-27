import 'package:url_launcher/url_launcher.dart';
import 'dart:developer' as developer;

class CalendarService {
  /// Generate Google Calendar URL for an event with pre-filled event details
  /// Uses the official Google Calendar action=TEMPLATE endpoint
  static String generateGoogleCalendarUrl({
    required String title,
    required DateTime date,
    required String startTime, // Format: "HH:MM"
    required String endTime,   // Format: "HH:MM"
    required String venue,
    required String description,
  }) {
    try {
      // Parse start time
      final startParts = startTime.split(':');
      final startHour = int.parse(startParts[0]);
      final startMin = int.parse(startParts[1]);

      // Parse end time
      final endParts = endTime.split(':');
      final endHour = int.parse(endParts[0]);
      final endMin = int.parse(endParts[1]);

      // Create DateTime objects
      final startDateTime = DateTime(
        date.year,
        date.month,
        date.day,
        startHour,
        startMin,
      );

      final endDateTime = DateTime(
        date.year,
        date.month,
        date.day,
        endHour,
        endMin,
      );

      // Format dates as RFC 3339 with Z suffix (UTC timezone)
      // Google Calendar expects: 20260417T143000Z/20260417T163000Z
      final startStr = _formatRFC3339(startDateTime);
      final endStr = _formatRFC3339(endDateTime);
      final datesParam = '$startStr/$endStr';

      // Build event description with all details
      final fullDescription =
          'Venue: $venue\n\nDetails: $description';

      // Use Google Calendar's TEMPLATE action endpoint
      // This is the most reliable way to pre-fill event details
      final params = <String, String>{
        'action': 'TEMPLATE',
        'text': title,
        'dates': datesParam,
        'location': venue,
        'details': fullDescription,
      };

      // Build URL with proper encoding
      final queryString = params.entries
          .map((e) => '${e.key}=${Uri.encodeComponent(e.value)}')
          .join('&');

      final url = 'https://www.google.com/calendar/render?$queryString';

      // Log for debugging
      developer.log('Generated Calendar URL: $url');

      return url;
    } catch (e) {
      developer.log('Error generating calendar URL: $e');
      throw 'Error generating calendar URL: $e';
    }
  }

  /// Format DateTime as YYYYMMDDTHHMMSS (local time, no timezone)
  /// Example: 20260417T143000 (April 17, 2026 at 2:30 PM local time)
  static String _formatRFC3339(DateTime dt) {
    final month = dt.month.toString().padLeft(2, '0');
    final day = dt.day.toString().padLeft(2, '0');
    final hour = dt.hour.toString().padLeft(2, '0');
    final minute = dt.minute.toString().padLeft(2, '0');

    return '${dt.year}$month$day' 'T$hour$minute' '00';
  }

  /// Launch Google Calendar with pre-filled event details
  static Future<void> addToGoogle({
    required String title,
    required DateTime date,
    required String startTime,
    required String endTime,
    required String venue,
    required String description,
  }) async {
    final url = generateGoogleCalendarUrl(
      title: title,
      date: date,
      startTime: startTime,
      endTime: endTime,
      venue: venue,
      description: description,
    );

    try {
      if (await canLaunchUrl(Uri.parse(url))) {
        await launchUrl(
          Uri.parse(url),
          mode: LaunchMode.externalApplication,
        );
      } else {
        throw 'Could not launch Google Calendar';
      }
    } catch (e) {
      throw 'Error opening calendar: $e';
    }
  }
}
