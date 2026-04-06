import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:ieee_app/screens/events/providers/events_provider.dart';

class MagazineScreen extends ConsumerWidget {
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
  Widget build(BuildContext context, WidgetRef ref) {
    final events = ref.watch(eventsProvider);
    // Filter workshops that have resourceLink
    final allWorkshops = events
        .where((event) => event.type.toString().contains('workshop'))
        .toList();
        
    final seenTitles = <String>{};
    final workshops = allWorkshops.where((w) => seenTitles.add(w.title)).toList();
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
                'RESOURCES',
                style: theme.textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.w900,
                  color: theme.colorScheme.onSurface,
                  letterSpacing: 0.5,
                ),
              ),
              const SizedBox(height: 16),
              if (workshops.isEmpty) ...[
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 32),
                  child: Center(
                    child: Text(
                      'No workshop resources available yet',
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color: theme.colorScheme.onSurface.withValues(alpha: 0.6),
                      ),
                    ),
                  ),
                ),
              ] else ...[
                ...workshops.map((workshop) => _ResourceTile(
                  title: workshop.title.toUpperCase(),
                  subtitle: workshop.description,
                  driveLink: workshop.resourceLink ?? '',
                )),
              ],
              const SizedBox(height: 48),
            ],
          ),
        ),
      ),
    );
  }
}

/* ---------------- RESOURCE TILE ---------------- */

class _ResourceTile extends StatefulWidget {
  final String title;
  final String subtitle;
  final String driveLink;

  const _ResourceTile({
    required this.title,
    required this.subtitle,
    required this.driveLink,
  });

  @override
  State<_ResourceTile> createState() => _ResourceTileState();
}

class _ResourceTileState extends State<_ResourceTile> {
  static const accentBlue = Color(0xFF1F6BFF);
  bool _isPressed = false;

  Future<void> _openResourceLink(BuildContext context) async {
    final Uri url = Uri.parse(widget.driveLink);
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
              content: Text('Could not open resource link'),
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
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: GestureDetector(
        onTap: () => _openResourceLink(context),
        onTapDown: (_) => setState(() => _isPressed = true),
        onTapUp: (_) => setState(() => _isPressed = false),
        onTapCancel: () => setState(() => _isPressed = false),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 120),
          curve: Curves.easeOut,
          decoration: BoxDecoration(
            color: _isPressed
                ? accentBlue.withValues(alpha: 0.08)
                : Theme.of(context).colorScheme.surface,
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
          child: Padding(
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
                  child: Icon(
                    Icons.folder_rounded,
                    color: _isPressed ? accentBlue : accentBlue.withValues(alpha: 0.75),
                    size: 24,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.title,
                        style: TextStyle(
                          fontWeight: FontWeight.w900,
                          fontSize: 15,
                          color: Theme.of(context).colorScheme.onSurface,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        widget.subtitle,
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
                Icon(
                  Icons.open_in_new_rounded,
                  color: _isPressed
                      ? accentBlue
                      : Theme.of(context)
                          .colorScheme
                          .onSurface
                          .withValues(alpha: 0.7),
                ),
              ],
            ),
          ),
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
