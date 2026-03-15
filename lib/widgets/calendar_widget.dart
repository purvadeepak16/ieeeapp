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
    final events = ref.watch(eventsProvider);

    final firstDay = DateTime(DateTime.now().year - 1, 1, 1);
    final lastDay = DateTime(DateTime.now().year + 1, 12, 31);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: NeoCard(
        backgroundColor: Colors.white,
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
                final double opacity = (events.length * 0.2 + 0.3).clamp(0.3, 1.0);
                return Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    margin: const EdgeInsets.only(bottom: 6),
                    width: 5,
                    height: 5,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: AppColors.premiumBlue.withOpacity(opacity),
                      border: Border.all(color: AppColors.premiumBlack, width: 0.5),
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
                    color: AppColors.premiumNavy.withOpacity(0.2),
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
            selectedDecoration: const BoxDecoration(
              color: AppColors.premiumBlack,
              shape: BoxShape.circle,
            ),
            selectedTextStyle: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w900,
              fontSize: 16,
            ),
            defaultTextStyle: const TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w700,
              color: AppColors.premiumNavy,
            ),
            weekendTextStyle: TextStyle(
              color: Colors.red[900],
              fontSize: 15,
              fontWeight: FontWeight.w700,
            ),
            outsideDaysVisible: true,
            cellPadding: const EdgeInsets.all(2),
            tableBorder: TableBorder.all(
              color: AppColors.premiumBlack.withOpacity(0.15),
              width: 1.5,
            ),
          ),

          headerStyle: HeaderStyle(
            formatButtonVisible: false,
            titleCentered: true,
            titleTextStyle: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w900,
              color: AppColors.premiumNavy,
              letterSpacing: -0.5,
            ),
            leftChevronIcon: const Icon(Icons.chevron_left_rounded, color: AppColors.premiumBlack, size: 28),
            rightChevronIcon: const Icon(Icons.chevron_right_rounded, color: AppColors.premiumBlack, size: 28),
            headerMargin: const EdgeInsets.only(bottom: 12),
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(color: AppColors.premiumBlack.withOpacity(0.1), width: 1),
              ),
            ),
          ),

          daysOfWeekStyle: DaysOfWeekStyle(
            weekdayStyle: TextStyle(
              color: AppColors.premiumNavy,
              fontWeight: FontWeight.w900,
              fontSize: 13,
            ),
            weekendStyle: TextStyle(
              color: Colors.red,
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
