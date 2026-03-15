import 'dart:async';

import 'package:flutter/material.dart';
import 'package:ieee_app/widgets/wie_widgets/inspire_slide.dart';
import 'package:ieee_app/widgets/wie_widgets/section_header.dart';

class InspiringCarousel extends StatefulWidget {
  const InspiringCarousel({super.key});

  @override
  State<InspiringCarousel> createState() => _InspiringCarouselState();
}

class _InspiringCarouselState extends State<InspiringCarousel> {
  final _pageCtrl = PageController(viewportFraction: 0.92);
  int _index = 0;
  Timer? _timer;

  final _slides = const [
    InspireSlide(
      title: 'Breaking Barriers',
      subtitle: 'Alumni talk on leading AI teams',
      asset: 'assets/images/wie_banner_1.jpg',
    ),
    InspireSlide(
      title: 'Hands-on Workshop',
      subtitle: 'Intro to Embedded Systems',
      asset: 'assets/images/wie_banner_2.jpg',
    ),
    InspireSlide(
      title: 'Leadership Circle',
      subtitle: 'Mentorship & networking evening',
      asset: 'assets/images/Leadership Circle Networking Event.png',
    ),
  ];

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(const Duration(seconds: 4), (_) {
      if (!mounted) return;
      final next = (_index + 1) % _slides.length;
      _pageCtrl.animateToPage(
        next,
        duration: const Duration(milliseconds: 450),
        curve: Curves.easeOut,
      );
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    _pageCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      children: [
        const SectionHeader(title: 'Inspiring at WIE'),
        const SizedBox(height: 8),
        SizedBox(
          height: 180,
          child: PageView.builder(
            controller: _pageCtrl,
            itemCount: _slides.length,
            onPageChanged: (i) => setState(() => _index = i),
            itemBuilder: (_, i) => Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4.0), // Added spacing
              child: _slides[i],
            ),
          ),
        ),
        const SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(_slides.length, (i) {
            final active = _index == i;
            return AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              margin: const EdgeInsets.symmetric(horizontal: 4),
              width: active ? 12 : 8,
              height: 8,
              decoration: BoxDecoration(
                color: active
                    ? theme.colorScheme.primary
                    : theme.colorScheme.onSurface.withOpacity(0.4),
                borderRadius: BorderRadius.circular(8),
              ),
            );
          }),
        ),
      ],
    );
  }
}
