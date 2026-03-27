import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:table_calendar/table_calendar.dart';

import 'package:ieee_app/models/event_model.dart';
import 'package:ieee_app/screens/events/providers/events_provider.dart';

import 'package:ieee_app/widgets/common/neo_card.dart';
import 'package:ieee_app/core/theme/app_colors.dart';

class CalendarWidget extends ConsumerStatefulWidget {
  final Function(DateTime) onDateSelected;

  const CalendarWidget({
    super.key,
    required this.onDateSelected,
  });

  @override
  ConsumerState<CalendarWidget> createState() => _CalendarWidgetState();
}

class _CalendarWidgetState extends ConsumerState<CalendarWidget> {
  late DateTime _focusedDay;
  late DateTime _selectedDay;

  final CalendarFormat _calendarFormat = CalendarFormat.month;

  @override
  void initState() {
    super.initState();
    final now = DateTime.now();
    _focusedDay = DateTime(now.year, now.month, now.day);
    _selectedDay = _focusedDay;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final events = ref.watch(eventsProvider);

    final firstDay = DateTime(DateTime.now().year - 1, 1, 1);
    final lastDay = DateTime(DateTime.now().year + 1, 12, 31);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: NeoCard(
        backgroundColor: theme.colorScheme.surface,
        padding: const EdgeInsets.all(12),
        child: TableCalendar<IEEEEvent>(
          locale: 'en_US',
          firstDay: firstDay,
          lastDay: lastDay,
          focusedDay: _focusedDay,
          calendarFormat: _calendarFormat,

          selectedDayPredicate: (day) => isSameDay(_selectedDay, day),

          eventLoader: (day) {
            final dayOnly = DateTime(day.year, day.month, day.day);
            return events.where((event) {
              final eventDay = DateTime(
                event.date.year,
                event.date.month,
                event.date.day,
              );
              return eventDay == dayOnly;
            }).toList();
          },

          onDaySelected: (selectedDay, focusedDay) {
            final normalized =
                DateTime(selectedDay.year, selectedDay.month, selectedDay.day);

            setState(() {
              _selectedDay = normalized;
              _focusedDay = focusedDay;
            });

            ref.read(selectedDateProvider.notifier).state = normalized;
            widget.onDateSelected(normalized);
          },

          onPageChanged: (focusedDay) {
            _focusedDay = focusedDay;
          },

          onFormatChanged: null,
          availableCalendarFormats: const {
            CalendarFormat.month: 'Month',
          },

          sixWeekMonthsEnforced: true,

          // =========================
          // 🔥 CUSTOM DATE RENDERING
          // =========================
          calendarBuilders: CalendarBuilders(
            markerBuilder: (context, day, events) {
              if (events.isNotEmpty) {
                // Use varying opacity based on event count for "intensity"
                final double opacity =
                    (events.length * 0.2 + 0.3).clamp(0.3, 1.0);
                return Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    margin: const EdgeInsets.only(bottom: 6),
                    width: 5,
                    height: 5,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: AppColors.premiumBlue.withOpacity(opacity),
                      border:
                          Border.all(color: AppColors.premiumBlack, width: 0.5),
                    ),
                  ),
                );
              }
              return null;
            },
            outsideBuilder: (context, day, focusedDay) {
              return Center(
                child: Text(
                  '${day.day}',
                  style: TextStyle(
                    color: theme.colorScheme.onSurface.withValues(alpha: 0.25),
                    fontWeight: FontWeight.w400,
                    fontSize: 14,
                  ),
                ),
              );
            },
          ),

          // =========================
          // 🎨 STYLES
          // =========================
          calendarStyle: CalendarStyle(
            todayDecoration: BoxDecoration(
              color: AppColors.blueTint,
              shape: BoxShape.circle,
              border: Border.all(
                color: AppColors.premiumBlue,
                width: 3,
              ),
            ),
            todayTextStyle: const TextStyle(
              color: AppColors.premiumBlue,
              fontWeight: FontWeight.w900,
              fontSize: 16,
            ),
            selectedDecoration: BoxDecoration(
              color: AppColors.premiumBlue,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: AppColors.premiumBlue.withValues(alpha: 0.4),
                  blurRadius: 8,
                  spreadRadius: 2,
                ),
              ],
            ),
            selectedTextStyle: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w900,
              fontSize: 16,
            ),
            defaultTextStyle: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w700,
              color: theme.colorScheme.onSurface,
            ),
            rangeHighlightColor: theme.colorScheme.primary.withValues(alpha: 0.3),
            rangeEndTextStyle: const TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w700,
              color: Colors.white,
            ),
            rangeStartTextStyle: const TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w700,
              color: Colors.white,
            ),
            withinRangeTextStyle: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w700,
              color: theme.colorScheme.onSurface,
            ),
            weekendTextStyle: TextStyle(
              color: theme.colorScheme.error,
              fontSize: 15,
              fontWeight: FontWeight.w700,
            ),
            outsideDaysVisible: true,
            cellPadding: const EdgeInsets.all(2),
            tableBorder: TableBorder.all(
              color: theme.colorScheme.outlineVariant,
              width: 1.5,
            ),
          ),

          headerStyle: HeaderStyle(
            formatButtonVisible: false,
            titleCentered: true,
            titleTextStyle: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w900,
              color: theme.colorScheme.onSurface,
              letterSpacing: -0.5,
            ),
            leftChevronIcon: Icon(Icons.chevron_left_rounded,
                color: theme.colorScheme.onSurface, size: 28),
            rightChevronIcon: Icon(Icons.chevron_right_rounded,
                color: theme.colorScheme.onSurface, size: 28),
            headerMargin: const EdgeInsets.only(bottom: 12),
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(color: theme.dividerColor, width: 1),
              ),
            ),
          ),

          daysOfWeekStyle: DaysOfWeekStyle(
            weekdayStyle: TextStyle(
              color: theme.colorScheme.onSurface,
              fontWeight: FontWeight.w900,
              fontSize: 13,
            ),
            weekendStyle: TextStyle(
              color: theme.colorScheme.error,
              fontWeight: FontWeight.w900,
              fontSize: 13,
            ),
          ),

          rowHeight: 52,
          daysOfWeekHeight: 40,
          startingDayOfWeek: StartingDayOfWeek.sunday,
        ),
      ),
    );
  }
}
