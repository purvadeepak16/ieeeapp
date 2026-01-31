import 'package:flutter/material.dart';

class MagazineScreen extends StatelessWidget {
  const MagazineScreen({super.key});

  static const accentBlue = Color(0xFF1F6BFF);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return SafeArea(
      child: Scaffold(
        backgroundColor: theme.scaffoldBackgroundColor,
        body: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),

              Text(
                'IEEE Publications',
                style: theme.textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 20),

              Row(
                children: const [
                  Expanded(
                    child: _CategoryButton(
                      icon: Icons.menu_book,
                      label: 'Magazines',
                      isActive: true,
                    ),
                  ),
                  SizedBox(width: 12),
                  Expanded(
                    child: _CategoryButton(
                      icon: Icons.description,
                      label: 'Papers',
                      isActive: false,
                    ),
                  ),
                  SizedBox(width: 12),
                  Expanded(
                    child: _CategoryButton(
                      icon: Icons.star,
                      label: 'Starred',
                      isActive: false,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 28),

              Text(
                'Student Reviews',
                style: theme.textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 12),

              SizedBox(
                height: 180,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  separatorBuilder: (_, __) => const SizedBox(width: 16),
                  itemCount: 3,
                  itemBuilder: (context, index) {
                    return _ReviewCard(
                      name: 'Reviewer ${index + 1}',
                      review: index == 0
                          ? 'Great paper, very insightful'
                          : index == 1
                          ? 'Thorough analysis, must-read'
                          : 'Well structured and helpful',
                      rating: 5 - index,
                    );
                  },
                ),
              ),

              const SizedBox(height: 28),

              Text(
                'Downloadable Papers',
                style: theme.textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 12),

              const _PaperTile(
                title: 'Paper 1',
                subtitle: 'Tech Conference 2020',
              ),
              const _PaperTile(
                title: 'Paper 2',
                subtitle: 'Journal of Engineering',
              ),
              const _PaperTile(
                title: 'Paper 3',
                subtitle: 'IEEE Research',
              ),

              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }
}

/* ---------------- CATEGORY BUTTON ---------------- */

class _CategoryButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool isActive;

  const _CategoryButton({
    required this.icon,
    required this.label,
    required this.isActive,
  });

  static const accentBlue = Color(0xFF1F6BFF);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return AnimatedContainer(
      duration: const Duration(milliseconds: 250),
      padding: const EdgeInsets.symmetric(vertical: 14),
      decoration: BoxDecoration(
        color: isActive
            ? accentBlue.withOpacity(0.12)
            : theme.cardColor,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
          color: isActive ? accentBlue : theme.dividerColor,
          width: 1.2,
        ),
      ),
      child: Column(
        children: [
          Icon(
            icon,
            size: 22,
            color: isActive
                ? accentBlue
                : theme.colorScheme.onBackground.withOpacity(0.6),
          ),
          const SizedBox(height: 8),
          Text(
            label,
            style: theme.textTheme.labelMedium?.copyWith(
              fontWeight: FontWeight.w600,
              color: isActive
                  ? accentBlue
                  : theme.colorScheme.onBackground,
            ),
          ),
        ],
      ),
    );
  }
}

/* ---------------- REVIEW CARD ---------------- */

class _ReviewCard extends StatelessWidget {
  final String name;
  final String review;
  final int rating;

  const _ReviewCard({
    required this.name,
    required this.review,
    required this.rating,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Container(
      width: 260,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: isDark
            ? const LinearGradient(
          colors: [
            Color(0xFF1A1F26),
            Color(0xFF14181E),
          ],
        )
            : null,
        color: isDark ? null : theme.cardColor,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: theme.dividerColor),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const CircleAvatar(
                radius: 16,
                backgroundColor: Color(0xFF2A2F36),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  name,
                  style: theme.textTheme.bodyLarge?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              Row(
                children: List.generate(
                  5,
                      (i) => Icon(
                    Icons.star,
                    size: 14,
                    color: i < rating
                        ? Colors.amber
                        : theme.dividerColor,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),
          Text(
            review,
            style: theme.textTheme.bodyMedium?.copyWith(
              color: theme.textTheme.bodySmall?.color,
            ),
          ),
        ],
      ),
    );
  }
}

/* ---------------- PAPER TILE ---------------- */

class _PaperTile extends StatelessWidget {
  final String title;
  final String subtitle;

  const _PaperTile({
    required this.title,
    required this.subtitle,
  });

  static const accentBlue = Color(0xFF1F6BFF);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: theme.cardColor,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: theme.dividerColor),
      ),
      child: Row(
        children: [
          Icon(Icons.picture_as_pdf, color: accentBlue),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: theme.textTheme.bodyLarge?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  subtitle,
                  style: theme.textTheme.bodySmall,
                ),
              ],
            ),
          ),
          Icon(Icons.download_rounded,
              color: theme.textTheme.bodySmall?.color),
        ],
      ),
    );
  }
}
