import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:table_calendar/table_calendar.dart';

import 'package:ieee_app/models/event_model.dart';
import 'package:ieee_app/screens/events/providers/events_provider.dart';

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
    final events = ref.watch(eventsProvider);

    final firstDay = DateTime(DateTime.now().year - 1, 1, 1);
    final lastDay = DateTime(DateTime.now().year + 1, 12, 31);

    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
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
                return Container(
                  width: 6,
                  height: 6,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                );
              }
              return null;
            },
          ),

          // =========================
          // 🎨 STYLES
          // =========================
          calendarStyle: CalendarStyle(
            todayDecoration: BoxDecoration(
              color:
                  Theme.of(context).colorScheme.primary.withValues(alpha: 0.15),
              shape: BoxShape.circle,
              border: Border.all(
                color: Theme.of(context).colorScheme.primary,
                width: 1.5,
              ),
            ),
            todayTextStyle: TextStyle(
              color: Theme.of(context).colorScheme.primary,
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
            selectedDecoration: BoxDecoration(
              color: Theme.of(context).colorScheme.primary,
              shape: BoxShape.circle,
            ),
            selectedTextStyle: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
            defaultTextStyle: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: Colors.grey[800],
            ),
            weekendTextStyle: TextStyle(
              color: Colors.red[700],
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
            outsideDaysVisible: false,
            cellPadding: const EdgeInsets.all(6),
          ),

          headerStyle: HeaderStyle(
            formatButtonVisible: false,
            titleCentered: true,
            titleTextStyle: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Theme.of(context).colorScheme.primary,
            ),
            leftChevronIcon: Icon(
              Icons.chevron_left,
              color: Theme.of(context).colorScheme.primary,
              size: 28,
            ),
            rightChevronIcon: Icon(
              Icons.chevron_right,
              color: Theme.of(context).colorScheme.primary,
              size: 28,
            ),
            headerPadding: const EdgeInsets.only(bottom: 16),
          ),

          daysOfWeekStyle: DaysOfWeekStyle(
            weekdayStyle: TextStyle(
              color: Colors.grey[700],
              fontWeight: FontWeight.bold,
              fontSize: 14,
            ),
            weekendStyle: TextStyle(
              color: Colors.red[700],
              fontWeight: FontWeight.bold,
              fontSize: 14,
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
