import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ieee_app/widgets/event_card.dart';
import 'package:ieee_app/widgets/calendar_widget.dart';
import 'package:ieee_app/widgets/common/neo_card.dart';
import 'package:ieee_app/core/theme/app_colors.dart';

// Import providers from the providers file
import 'package:ieee_app/screens/events/providers/events_provider.dart';

class EventsScreen extends ConsumerStatefulWidget {
  const EventsScreen({super.key});

  @override
  ConsumerState<EventsScreen> createState() => _EventsScreenState();
}

class _EventsScreenState extends ConsumerState<EventsScreen> {
  int _selectedView = 0;

  @override
  Widget build(BuildContext context) {
    final events = ref.watch(eventsProvider);
    final selectedDate = ref.watch(selectedDateProvider);

    final selectedEvents = events
        .where((event) =>
            event.date.year == selectedDate.year &&
            event.date.month == selectedDate.month &&
            event.date.day == selectedDate.day)
        .toList();

    final upcomingEvents = events.where((e) => e.isUpcoming).toList();
    final featuredEvents = events.where((e) => e.isFeatured).toList();

    return CustomScrollView(
      physics: const AlwaysScrollableScrollPhysics(),
      slivers: [
        // Featured Events
        if (featuredEvents.isNotEmpty)
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 24, 20, 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'FEATURED EVENTS',
                    style: Theme.of(context).textTheme.labelSmall?.copyWith(
                          color: AppColors.premiumBlue,
                          fontWeight: FontWeight.w900,
                        ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Hand-picked for you',
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                          fontWeight: FontWeight.w900,
                          letterSpacing: -0.8,
                        ),
                  ),
                  const SizedBox(height: 16),
                  SizedBox(
                    height: 220, // Increased for better shadow visibility and breathing room
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: featuredEvents.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.only(right: 16),
                          child: SizedBox(
                            width: 260,
                            child: EventCard(
                              event: featuredEvents[index],
                              compact: true,
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),

        // View Toggle
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: NeoCard(
              padding: const EdgeInsets.all(4),
              borderRadius: 12,
              child: Row(
                children: [
                  Expanded(
                    child: ChoiceChip(
                      label: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.calendar_today,
                            size: 16,
                            color: _selectedView == 0 ? Colors.white : AppColors.premiumBlack,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            'Calendar',
                            style: TextStyle(
                              color: _selectedView == 0 ? Colors.white : AppColors.premiumBlack,
                              fontWeight: FontWeight.w900,
                            ),
                          ),
                        ],
                      ),
                      selected: _selectedView == 0,
                      selectedColor: AppColors.premiumBlack,
                      backgroundColor: Colors.transparent,
                      onSelected: (selected) =>
                          setState(() => _selectedView = 0),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: ChoiceChip(
                      label: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.list,
                            size: 16,
                            color: _selectedView == 1 ? Colors.white : AppColors.premiumBlack,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            'List',
                            style: TextStyle(
                              color: _selectedView == 1 ? Colors.white : AppColors.premiumBlack,
                              fontWeight: FontWeight.w900,
                            ),
                          ),
                        ],
                      ),
                      selected: _selectedView == 1,
                      selectedColor: AppColors.premiumBlack,
                      backgroundColor: Colors.transparent,
                      onSelected: (selected) =>
                          setState(() => _selectedView = 1),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),

        // Calendar View
        if (_selectedView == 0) ...[
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: CalendarWidget(
                onDateSelected: (date) {
                  ref.read(selectedDateProvider.notifier).state = date;
                },
              ),
            ),
          ),

          // Events for Selected Date
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Events on ${selectedDate.day}/${selectedDate.month}/${selectedDate.year}'.toUpperCase(),
                    style: Theme.of(context).textTheme.labelSmall?.copyWith(
                          fontWeight: FontWeight.w900,
                          color: AppColors.premiumBlue,
                        ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Daily Schedule',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.w900,
                        ),
                  ),
                  if (selectedEvents.isEmpty)
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 16),
                      child: Center(
                        child: Text(
                          'No events scheduled',
                          style: TextStyle(color: Colors.grey),
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ),

          // Events List for selected date
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                final event = selectedEvents[index];
                return Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 16,
                  ),
                  child: EventCard(event: event, compact: false),
                );
              },
              childCount: selectedEvents.length,
            ),
          ),
        ],

        // List View
        if (_selectedView == 1) ...[
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'UPCOMING',
                    style: Theme.of(context).textTheme.labelSmall?.copyWith(
                          color: AppColors.premiumBlue,
                          fontWeight: FontWeight.w900,
                        ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Full Schedule',
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                          fontWeight: FontWeight.w900,
                        ),
                  ),
                ],
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                final event = upcomingEvents[index];
                return Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 16,
                  ),
                  child: EventCard(event: event, compact: false),
                );
              },
              childCount: upcomingEvents.length,
            ),
          ),
        ],

        const SliverToBoxAdapter(
          child: SizedBox(height: 32),
        ),
      ],
    );
  }
}
