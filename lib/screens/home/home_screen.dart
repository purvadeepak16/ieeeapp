import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:ieee_app/core/constants/app_constants.dart';
import 'package:ieee_app/core/theme/app_colors.dart';
import 'package:ieee_app/models/event_model.dart';
import 'package:ieee_app/models/micro_skill_model.dart';
import 'package:ieee_app/widgets/common/neo_card.dart';
import 'package:ieee_app/widgets/event_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
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
                      'Welcome back, Member',
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
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: NeoCard(
        backgroundColor: AppColors.premiumNavy,
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    color: AppColors.premiumBlue,
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Text(
                    'SPOTLIGHT',
                    style: Theme.of(context).textTheme.labelSmall?.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.w900,
                          letterSpacing: 1.5,
                        ),
                  ),
                ),
                Text(
                  'LVL 04',
                  style: Theme.of(context).textTheme.labelSmall?.copyWith(
                        color: Colors.white54,
                        fontWeight: FontWeight.bold,
                      ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Text(
              'Modern UI Patterns with Flutter',
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.w900,
                    color: Colors.white,
                    letterSpacing: -0.5,
                  ),
            ),
            const SizedBox(height: 12),
            Text(
              'Master the architecture of premium responsive interfaces.',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Colors.white.withValues(alpha: 0.7),
                    height: 1.5,
                  ),
            ),
            const SizedBox(height: 28),
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(4),
                        child: const LinearProgressIndicator(
                          value: 0.65,
                          minHeight: 10,
                          backgroundColor: Colors.white10,
                          valueColor: AlwaysStoppedAnimation<Color>(
                              AppColors.premiumBlue),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 20),
                ElevatedButton(
                  onPressed: () {
                    final todaysSkill = MicroSkill(
                      id: '1',
                      title: 'Modern UI Patterns with Flutter',
                      teaser:
                          'Master the architecture of premium responsive interfaces.',
                      fullDescription:
                          'API First Design is an approach where the API specification is designed before any implementation begins.',
                      category: 'Engineering',
                      useCases: ['Architecture', 'Design Systems'],
                      resources: [],
                      icon: '⚡',
                      date: DateTime.now(),
                      difficulty: 'advanced',
                      externalUrl: 'https://ieee.org',
                    );
                    context.push('/micro-skill/${todaysSkill.id}',
                        extra: todaysSkill);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: AppColors.premiumNavy,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(4)),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 12),
                  ),
                  child: const Text('CONTINUE',
                      style: TextStyle(
                          fontWeight: FontWeight.w900, letterSpacing: 0.5)),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFeaturedEvent(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Featured Event',
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
          ),
          const SizedBox(height: 16),
          NeoCard(
            padding: EdgeInsets.zero,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Stack(
                  children: [
                    Container(
                      height: 200,
                      width: double.infinity,
                      decoration: const BoxDecoration(
                        image: DecorationImage(
                          image: NetworkImage(
                              'https://images.unsplash.com/photo-1517077304055-6e89abbf09b0?ixlib=rb-1.2.1&auto=format&fit=crop&w=800&q=80'),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Positioned(
                      top: 16,
                      right: 16,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 8),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(4),
                          border: Border.all(
                              color: AppColors.premiumBlack, width: 2),
                          boxShadow: const [
                            BoxShadow(
                              color: AppColors.premiumBlack,
                              offset: Offset(3, 3),
                            ),
                          ],
                        ),
                        child: Column(
                          children: [
                            Text(
                              '24',
                              style: Theme.of(context)
                                  .textTheme
                                  .headlineSmall
                                  ?.copyWith(
                                    color: AppColors.premiumBlue,
                                    fontWeight: FontWeight.w900,
                                  ),
                            ),
                            Text(
                              'FEB',
                              style: Theme.of(context)
                                  .textTheme
                                  .labelSmall
                                  ?.copyWith(
                                    fontWeight: FontWeight.w900,
                                    letterSpacing: 1.0,
                                  ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'IEEE Tech Nexus 2026',
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                              fontWeight: FontWeight.w900,
                              color: Theme.of(context).colorScheme.onSurface,
                              letterSpacing: -0.5,
                            ),
                      ),
                      const SizedBox(height: 12),
                      Row(
                        children: [
                          const Icon(Icons.location_on_rounded,
                              size: 18, color: AppColors.premiumBlue),
                          const SizedBox(width: 8),
                          Text(
                            'VESIT Campus • 09:00 AM',
                            style:
                                Theme.of(context).textTheme.bodySmall?.copyWith(
                                      fontWeight: FontWeight.bold,
                                      color: Theme.of(context)
                                          .colorScheme
                                          .onSurface
                                          .withValues(alpha: 0.7),
                                    ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 24),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () {
                            final featuredEvent = IEEEEvent(
                              title: 'IEEE Tech Nexus 2026',
                              description:
                                  'Join us for the flagship technical symposium of IEEE VESIT.',
                              date: DateTime(2026, 2, 24),
                              startTime: const TimeOfDay(hour: 9, minute: 0),
                              venue: 'VESIT Campus',
                              type: EventType.conference,
                              registrationLink: 'https://ieee.org',
                              tags: ['Tech', 'Navy', 'Premium'],
                              isFeatured: true,
                            );
                            showModalBottomSheet(
                              context: context,
                              isScrollControlled: true,
                              shape: const RoundedRectangleBorder(
                                  borderRadius: BorderRadius.vertical(
                                      top: Radius.circular(24))),
                              builder: (context) =>
                                  EventDetailsSheet(event: featuredEvent),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.premiumBlack,
                            foregroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(4)),
                            padding: const EdgeInsets.symmetric(vertical: 16),
                          ),
                          child: const Text('VIEW DETAILS',
                              style: TextStyle(
                                  fontWeight: FontWeight.w900,
                                  letterSpacing: 1.0)),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
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
