import 'package:flutter/material.dart';
import 'package:ieee_app/widgets/common/neo_card.dart';
import 'package:url_launcher/url_launcher.dart';

class MagazineScreen extends StatelessWidget {
  const MagazineScreen({super.key});

  static const accentBlue = Color(0xFF1F6BFF);

  // Magazine data for three consecutive years
  static final List<MagazineData> magazines = [
    MagazineData(
      year: 2024,
      driveLink:
          'https://drive.google.com/file/d/14mnQqGuPa0hvi9m7xzME9yyhpJCunRci/view?usp=sharing',
    ),
    MagazineData(
      year: 2023,
      driveLink:
          'https://drive.google.com/file/d/14mnQqGuPa0hvi9m7xzME9yyhpJCunRci/view?usp=sharing',
    ),
    MagazineData(
      year: 2022,
      driveLink:
          'https://drive.google.com/file/d/14mnQqGuPa0hvi9m7xzME9yyhpJCunRci/view?usp=sharing',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return SafeArea(
      child: Scaffold(
        backgroundColor: theme.scaffoldBackgroundColor,
        body: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 32),
              Text(
                'IEEE PUBLICATIONS',
                style: theme.textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.w900,
                  color: theme.colorScheme.onSurface,
                  letterSpacing: 1.0,
                ),
              ),
              const SizedBox(height: 32),
              Text(
                'MAGAZINES',
                style: theme.textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.w900,
                  color: theme.colorScheme.onSurface,
                  letterSpacing: 0.5,
                ),
              ),
              const SizedBox(height: 16),
              SizedBox(
                child: GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    childAspectRatio: 0.95,
                    crossAxisSpacing: 12,
                    mainAxisSpacing: 12,
                  ),
                  itemCount: magazines.length,
                  itemBuilder: (context, index) {
                    return _MagazineCard(
                      magazineData: magazines[index],
                    );
                  },
                ),
              ),
              const SizedBox(height: 40),
              Text(
                'STUDENT REVIEWS',
                style: theme.textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.w900,
                  color: theme.colorScheme.onSurface,
                  letterSpacing: 0.5,
                ),
              ),
              const SizedBox(height: 16),
              SizedBox(
                height: 170,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  separatorBuilder: (_, __) => const SizedBox(width: 16),
                  itemCount: 3,
                  itemBuilder: (context, index) {
                    return _ReviewCard(
                      name: 'REVIEWER ${index + 1}',
                      review: index == 0
                          ? 'Great paper, very insightful and well-researched.'
                          : index == 1
                              ? 'Thorough analysis, must-read for tech enthusiasts.'
                              : 'Well structured and extremely helpful guide.',
                      rating: 5 - index,
                    );
                  },
                ),
              ),
              const SizedBox(height: 40),
              Text(
                'DOWNLOADABLE PAPERS',
                style: theme.textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.w900,
                  color: theme.colorScheme.onSurface,
                  letterSpacing: 0.5,
                ),
              ),
              const SizedBox(height: 16),
              const _PaperTile(
                title: 'PAPER 1',
                subtitle: 'TECH CONFERENCE 2020',
              ),
              const _PaperTile(
                title: 'PAPER 2',
                subtitle: 'JOURNAL OF ENGINEERING',
              ),
              const _PaperTile(
                title: 'PAPER 3',
                subtitle: 'IEEE RESEARCH',
              ),
              const SizedBox(height: 48),
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
    return SizedBox(
      height: 90, // Constrain height to prevent shadow layer from breaking
      child: NeoCard(
        backgroundColor: isActive
            ? accentBlue.withValues(alpha: 0.12)
            : Theme.of(context).colorScheme.surface,
        padding: EdgeInsets
            .zero, // Remove NeoCard padding since we center the content
        borderRadius: 12,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min, // Keep column tight
            children: [
              Icon(
                icon,
                size: 24, // Slightly larger icon
                color: isActive
                    ? accentBlue
                    : Theme.of(context)
                        .colorScheme
                        .onSurface
                        .withValues(alpha: 0.7),
              ),
              const SizedBox(height: 6),
              Text(
                label,
                style: TextStyle(
                  fontWeight: FontWeight.w900,
                  fontSize: 10,
                  letterSpacing: 0.5,
                  color: Theme.of(context).colorScheme.onSurface,
                ),
                maxLines: 1,
                overflow: TextOverflow
                    .ellipsis, // Ensure long labels don't break layout
              ),
            ],
          ),
        ),
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
    return Container(
      width: 260,
      margin: const EdgeInsets.only(
          bottom: 8, right: 8), // Small margin for the shadow offset in NeoCard
      child: NeoCard(
        backgroundColor: Theme.of(context).colorScheme.surface,
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                        color: Theme.of(context).colorScheme.onSurface,
                        width: 1.5),
                  ),
                  child: CircleAvatar(
                    radius: 14,
                    backgroundColor:
                        Theme.of(context).colorScheme.surfaceContainerHighest,
                    child: Icon(Icons.person,
                        size: 16,
                        color: Theme.of(context)
                            .colorScheme
                            .onSurface
                            .withValues(alpha: 0.7)),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    name,
                    style: TextStyle(
                      fontWeight: FontWeight.w900,
                      fontSize: 14,
                      color: Theme.of(context).colorScheme.onSurface,
                    ),
                  ),
                ),
                Row(
                  children: List.generate(
                    5,
                    (i) => Icon(
                      Icons.star_rounded,
                      size: 16,
                      color: i < rating ? Colors.amber : Colors.black12,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 14),
            Text(
              review,
              maxLines: 4,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                color: Theme.of(context)
                    .colorScheme
                    .onSurface
                    .withValues(alpha: 0.85),
                fontSize: 12,
                height: 1.5,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
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
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: NeoCard(
        backgroundColor: Theme.of(context).colorScheme.surface,
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: accentBlue.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: accentBlue, width: 1.5),
              ),
              child:
                  const Icon(Icons.picture_as_pdf_rounded, color: accentBlue),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontWeight: FontWeight.w900,
                      fontSize: 15,
                      color: Theme.of(context).colorScheme.onSurface,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    subtitle,
                    style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context)
                          .colorScheme
                          .onSurface
                          .withValues(alpha: 0.7),
                    ),
                  ),
                ],
              ),
            ),
            Icon(Icons.download_for_offline_rounded,
                color: Theme.of(context)
                    .colorScheme
                    .onSurface
                    .withValues(alpha: 0.7)),
          ],
        ),
      ),
    );
  }
}

/* ================== MAGAZINE CARD ================== */

class _MagazineCard extends StatefulWidget {
  final MagazineData magazineData;

  const _MagazineCard({
    required this.magazineData,
  });

  @override
  State<_MagazineCard> createState() => _MagazineCardState();
}

class _MagazineCardState extends State<_MagazineCard> {
  static const accentBlue = Color(0xFF1F6BFF);
  bool _isPressed = false;

  Future<void> _openDriveLink(BuildContext context) async {
    final Uri url = Uri.parse(widget.magazineData.driveLink);
    try {
      if (await canLaunchUrl(url)) {
        await launchUrl(
          url,
          mode: LaunchMode.externalApplication,
        );
      } else {
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Could not open magazine link'),
              duration: Duration(seconds: 2),
            ),
          );
        }
      }
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error: $e'),
            duration: const Duration(seconds: 2),
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final surface = Theme.of(context).colorScheme.surface;

    return GestureDetector(
      onTap: () => _openDriveLink(context),
      onTapDown: (_) => setState(() => _isPressed = true),
      onTapUp: (_) => setState(() => _isPressed = false),
      onTapCancel: () => setState(() => _isPressed = false),
      child: AnimatedScale(
        scale: _isPressed ? 0.94 : 1.0,
        duration: const Duration(milliseconds: 120),
        curve: Curves.easeOut,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 120),
          curve: Curves.easeOut,
          decoration: BoxDecoration(
            color: _isPressed
                ? accentBlue.withValues(alpha: 0.10)
                : surface,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: _isPressed
                  ? accentBlue.withValues(alpha: 0.5)
                  : Theme.of(context)
                      .colorScheme
                      .onSurface
                      .withValues(alpha: 0.15),
              width: 1.5,
            ),
            boxShadow: _isPressed
                ? []
                : [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.08),
                      blurRadius: 6,
                      offset: const Offset(0, 3),
                    ),
                  ],
          ),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.menu_book_rounded,
                  size: 32,
                  color: _isPressed
                      ? accentBlue
                      : accentBlue.withValues(alpha: 0.75),
                ),
                const SizedBox(height: 12),
                Text(
                  '${widget.magazineData.year}',
                  style: TextStyle(
                    fontWeight: FontWeight.w900,
                    fontSize: 18,
                    color: Theme.of(context).colorScheme.onSurface,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'MAGAZINE',
                  style: TextStyle(
                    fontWeight: FontWeight.w900,
                    fontSize: 10,
                    letterSpacing: 0.5,
                    color: Theme.of(context)
                        .colorScheme
                        .onSurface
                        .withValues(alpha: 0.55),
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

/* ================== MAGAZINE DATA MODEL ================== */

class MagazineData {
  final int year;
  final String driveLink;

  MagazineData({
    required this.year,
    required this.driveLink,
  });
}
