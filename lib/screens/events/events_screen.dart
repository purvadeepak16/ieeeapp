import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ieee_app/models/event_model.dart';
import 'package:ieee_app/widgets/event_card.dart';
import 'package:ieee_app/widgets/calendar_widget.dart';

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

    return Scaffold(
      appBar: AppBar(
        title: const Text('Events'),
      ),
      body: CustomScrollView(
        slivers: [
          // Featured Events
          if (featuredEvents.isNotEmpty)
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Featured',
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                    const SizedBox(height: 8),
                    SizedBox(
                      height: 160,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: featuredEvents.length,
                        itemBuilder: (context, index) {
                          return SizedBox(
                            width: 260,
                            child: EventCard(
                              event: featuredEvents[index],
                              compact: true,
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
              child: Card(
                child: Padding(
                  padding: const EdgeInsets.all(4),
                  child: Row(
                    children: [
                      Expanded(
                        child: ChoiceChip.elevated(
                          label: const Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.calendar_today, size: 16),
                              SizedBox(width: 4),
                              Text('Calendar'),
                            ],
                          ),
                          selected: _selectedView == 0,
                          onSelected: (selected) =>
                              setState(() => _selectedView = 0),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: ChoiceChip.elevated(
                          label: const Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.list, size: 16),
                              SizedBox(width: 4),
                              Text('List'),
                            ],
                          ),
                          selected: _selectedView == 1,
                          onSelected: (selected) =>
                              setState(() => _selectedView = 1),
                        ),
                      ),
                    ],
                  ),
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
                      'Events on ${selectedDate.day}/${selectedDate.month}/${selectedDate.year}',
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.bold,
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
                      vertical: 8,
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
                child: Text(
                  'Upcoming Events',
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
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
                      vertical: 8,
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
      ),
    );
  }
}
