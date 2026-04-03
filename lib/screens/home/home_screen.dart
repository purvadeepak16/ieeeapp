import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:ieee_app/core/auth/auth_provider.dart';
import 'package:ieee_app/core/constants/app_constants.dart';
import 'package:ieee_app/core/theme/app_colors.dart';
import 'package:ieee_app/models/event_model.dart';
import 'package:ieee_app/widgets/common/neo_card.dart';
import 'package:ieee_app/widgets/event_card.dart';
import 'package:ieee_app/widgets/micro_skills_widget.dart';
import 'package:ieee_app/screens/events/providers/events_provider.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      color: theme.scaffoldBackgroundColor,
      child: RefreshIndicator(
        onRefresh: () async {
          await Future.delayed(const Duration(seconds: 1));
          return;
        },
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Greeting Section
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 32, 20, 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Welcome back, ${_getUserName()}',
                      style:
                          Theme.of(context).textTheme.headlineMedium?.copyWith(
                                fontWeight: FontWeight.w900,
                                color: theme.colorScheme.onSurface,
                                letterSpacing: -1.2,
                              ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Your technical journey continues here.',
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                            color: theme.colorScheme.onSurface
                                .withValues(alpha: 0.7),
                            fontWeight: FontWeight.w500,
                          ),
                    ),
                  ],
                ),
              ),

              // Section: Council Intro
              _buildIntroSection(context),
              const SizedBox(height: 48),

              // Section 1 - Today's Highlight
              _buildMicroSkillCard(context),
              const SizedBox(height: 48),

              // Section 2 - Featured Event
              _buildFeaturedEvent(context),
              const SizedBox(height: 48),

              // Section 3 - Announcements
              _buildAnnouncementsSection(context),
              const SizedBox(height: 48),

              // Section 4 - Quick Access
              _buildQuickAccessSection(context),
              const SizedBox(height: 64),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMicroSkillCard(BuildContext context) {
    return const MicroSkillsWidget();
  }

  Widget _buildFeaturedEvent(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Upcoming Events',
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
          ),
          const SizedBox(height: 16),
          Consumer(
            builder: (context, ref, child) {
              final allEvents = ref.watch(eventsProvider);
              
              // Filter for upcoming events (date >= today)
              final now = DateTime.now();
              final upcomingEvents = allEvents
                  .where((event) => event.date.isAfter(DateTime(now.year, now.month, now.day)))
                  .toList()
                ..sort((a, b) => a.date.compareTo(b.date));

              if (upcomingEvents.isEmpty) {
                return Center(
                  child: Padding(
                    padding: const EdgeInsets.all(32),
                    child: Text(
                      'No upcoming events',
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                            color: Theme.of(context)
                                .colorScheme
                                .onSurface
                                .withValues(alpha: 0.6),
                          ),
                    ),
                  ),
                );
              }

              return SizedBox(
                height: 240,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: upcomingEvents.length,
                  itemBuilder: (context, index) {
                    final event = upcomingEvents[index];
                    return Padding(
                      padding: EdgeInsets.only(
                        right: index == upcomingEvents.length - 1 ? 0 : 16,
                      ),
                      child: _buildEventCard(context, event),
                    );
                  },
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildEventCard(BuildContext context, IEEEEvent event) {
    return GestureDetector(
      onTap: () {
        showModalBottomSheet(
          context: context,
          isScrollControlled: true,
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(top: Radius.circular(24))),
          builder: (context) => EventDetailsSheet(event: event),
        );
      },
      child: NeoCard(
        backgroundColor: Theme.of(context).colorScheme.surface,
        padding: EdgeInsets.zero,
        child: SizedBox(
          width: 280,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Event Date Badge
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: _getEventColor(event.type),
                  border: const Border(
                    bottom: BorderSide(color: Colors.black, width: 2),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      event.title,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.w900,
                            color: Colors.white,
                          ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      _formatDate(event.date),
                      style: Theme.of(context).textTheme.labelSmall?.copyWith(
                            fontWeight: FontWeight.w700,
                            color: Colors.white.withValues(alpha: 0.9),
                          ),
                    ),
                  ],
                ),
              ),
              // Event Details
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          const Icon(Icons.location_on_rounded,
                              size: 16, color: AppColors.premiumBlue),
                          const SizedBox(width: 6),
                          Expanded(
                            child: Text(
                              event.venue,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: Theme.of(context)
                                  .textTheme
                                  .labelSmall
                                  ?.copyWith(
                                    fontWeight: FontWeight.w600,
                                    color: Theme.of(context)
                                        .colorScheme
                                        .onSurface
                                        .withValues(alpha: 0.7),
                                  ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      Expanded(
                        child: Text(
                          event.description,
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                color: Theme.of(context)
                                    .colorScheme
                                    .onSurface
                                    .withValues(alpha: 0.7),
                              ),
                        ),
                      ),
                      const SizedBox(height: 12),
                      Wrap(
                        spacing: 6,
                        children: event.tags
                            .take(2)
                            .map(
                              (tag) => Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 8, vertical: 4),
                                decoration: BoxDecoration(
                                  color: _getEventColor(event.type)
                                      .withValues(alpha: 0.2),
                                  borderRadius: BorderRadius.circular(4),
                                ),
                                child: Text(
                                  tag.toLowerCase(),
                                  style: Theme.of(context)
                                      .textTheme
                                      .labelSmall
                                      ?.copyWith(
                                        fontWeight: FontWeight.w600,
                                        color: _getEventColor(event.type),
                                      ),
                                ),
                              ),
                            )
                            .toList(),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  String _formatDate(DateTime date) {
    final monthNames = [
      'JAN',
      'FEB',
      'MAR',
      'APR',
      'MAY',
      'JUN',
      'JUL',
      'AUG',
      'SEP',
      'OCT',
      'NOV',
      'DEC'
    ];
    return '${date.day.toString().padLeft(2, '0')} ${monthNames[date.month - 1]}';
  }

  Color _getEventColor(EventType type) {
    switch (type) {
      case EventType.workshop:
        return const Color(0xFF3B82F6);
      case EventType.competition:
        return const Color(0xFFEF4444);
      case EventType.conference:
        return const Color(0xFF8B5CF6);
      case EventType.social:
        return const Color(0xFF10B981);
      default:
        return const Color(0xFF6B7280);
    }
  }

  Widget _buildAnnouncementsSection(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Announcements',
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.w900,
                      color: Theme.of(context).colorScheme.onSurface,
                      letterSpacing: -0.5,
                    ),
              ),
              TextButton(
                onPressed: () {},
                child: const Text('VIEW ALL',
                    style: TextStyle(
                        color: AppColors.premiumBlue,
                        fontWeight: FontWeight.w900,
                        fontSize: 12,
                        letterSpacing: 1.0)),
              ),
            ],
          ),
          const SizedBox(height: 8),
          _buildAnnouncementItem(
            context,
            'Membership Renewals Started',
            'Feb 15, 2026',
          ),
          const Divider(height: 1, color: AppColors.border),
          _buildAnnouncementItem(
            context,
            'Call for Paper: IEEE AISC 2026',
            'Feb 12, 2026',
          ),
        ],
      ),
    );
  }

  Widget _buildAnnouncementItem(
      BuildContext context, String title, String date) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Text(
              title,
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    fontWeight: FontWeight.w900,
                    color: Theme.of(context).colorScheme.onSurface,
                  ),
            ),
          ),
          Text(
            date.toUpperCase(),
            style: Theme.of(context).textTheme.labelSmall?.copyWith(
                  color: Theme.of(context)
                      .colorScheme
                      .onSurface
                      .withValues(alpha: 0.6),
                  fontWeight: FontWeight.w900,
                  letterSpacing: 0.5,
                ),
          ),
        ],
      ),
    );
  }

  Widget _buildQuickAccessSection(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Quick Access',
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              Expanded(
                  child: _buildQuickAccessBtn(
                      context,
                      Icons.people_outline_rounded,
                      'Members',
                      Colors.blue,
                      AppConstants.membersPath)),
              const SizedBox(width: 12),
              Expanded(
                  child: _buildQuickAccessBtn(context, Icons.event_note_rounded,
                      'Calendar', Colors.orange, AppConstants.eventsPath)),
              const SizedBox(width: 12),
              Expanded(
                  child: _buildQuickAccessBtn(context, Icons.menu_book_rounded,
                      'Magazine', Colors.teal, AppConstants.magazinePath)),
              const SizedBox(width: 12),
              Expanded(
                  child: _buildQuickAccessBtn(
                      context,
                      Icons.contact_support_outlined,
                      'Support',
                      Colors.purple,
                      AppConstants.aboutPath)),
            ],
          ),
        ],
      ),
    );
  }

  String _getUserName() {
    final user = ref.read(authRepositoryProvider).currentUser;
    final displayName = user?.displayName?.trim();
    if (displayName != null && displayName.isNotEmpty) {
      return displayName;
    }
    return 'Member';
  }

  Widget _buildQuickAccessBtn(BuildContext context, IconData icon, String label,
      Color color, String route) {
    return NeoCard(
      onTap: () => context.go(route),
      backgroundColor: Theme.of(context).colorScheme.surface,
      padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 16),
      borderRadius: 12,
      showBorder: true,
      showShadow: true,
      child: Column(
        children: [
          Icon(icon, color: AppColors.premiumBlue, size: 24),
          const SizedBox(height: 12),
          Text(
            label.toUpperCase(),
            style: Theme.of(context).textTheme.labelSmall?.copyWith(
                  fontWeight: FontWeight.w900,
                  color: Theme.of(context).colorScheme.onSurface,
                  fontSize: 9,
                  letterSpacing: 0.5,
                ),
          ),
        ],
      ),
    );
  }

  Widget _buildIntroSection(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: NeoCard(
        backgroundColor: Theme.of(context).colorScheme.surface,
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'IEEE-VESIT',
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.w900,
                    color: AppColors.premiumBlue,
                    letterSpacing: -0.5,
                  ),
            ),
            const SizedBox(height: 16),
            Text(
              'At IEEE-VESIT we aim at fostering both technical excellence and vibrant student engagement. From cutting-edge workshops and seminars to fun, enriching events, we ensure a perfect balance between academics and co-curriculars.\n\nBacked by international IEEE membership, students gain global exposure — from writing research papers to getting published. Whether it’s placements, higher studies, or hands-on learning, IEEE-VESIT is your one-stop society for it all.',
              textAlign: TextAlign.justify,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    height: 1.6,
                    color: Theme.of(context)
                        .colorScheme
                        .onSurface
                        .withValues(alpha: 0.8),
                    fontWeight: FontWeight.w500,
                  ),
            ),
          ],
        ),
      ),
    );
  }
}
