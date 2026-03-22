import 'package:flutter/material.dart';
import 'package:ieee_app/core/theme/app_colors.dart';
import 'package:ieee_app/core/theme/spacing_constants.dart';

class AnimatedActionCard extends StatefulWidget {
  final IconData icon;
  final String title;
  final String? subtitle;
  final Widget? trailing;
  final VoidCallback onTap;
  final bool isDarkMode;
  final Color accentColor;

  const AnimatedActionCard({
    super.key,
    required this.icon,
    required this.title,
    this.subtitle,
    this.trailing,
    required this.onTap,
    required this.isDarkMode,
    this.accentColor = AppColors.primaryBlue,
  });

  @override
  State<AnimatedActionCard> createState() => _AnimatedActionCardState();
}

class _AnimatedActionCardState extends State<AnimatedActionCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _pressAnimation;
  bool _isHovered = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 120),
    );
    _pressAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final cardColor = widget.isDarkMode
        ? AppColors.profileCardDark
        : AppColors.profileCardLight;
    final textColor = widget.isDarkMode
        ? AppColors.profileTextDark
        : AppColors.profileTextLight;
    final subTextColor = widget.isDarkMode
        ? AppColors.profileSubtextDark
        : AppColors.profileSubtextLight;

    // Neo-brutalism border: dark in both modes, just a bit lighter in dark mode
    final borderColor = widget.isDarkMode
        ? const Color(0xFF4A5260)
        : AppColors.neoDarkBorder;

    // Neo shadow color: hard solid color, no blur
    final neoShadowColor = widget.isDarkMode
        ? AppColors.neoShadowDark
        : AppColors.neoShadow;

    // Shadow offset: 0 when pressed, larger when hovered
    final double baseOffset = AppSpacing.neoShadowOffset;

    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: GestureDetector(
        onTapDown: (_) => _controller.forward(),
        onTapUp: (_) {
          _controller.reverse();
          widget.onTap();
        },
        onTapCancel: () => _controller.reverse(),
        child: AnimatedBuilder(
          animation: _pressAnimation,
          builder: (context, child) {
            // When pressed: card translates down-right into its shadow
            final pressOffset = _pressAnimation.value * baseOffset;
            // When hovered (and not pressed): extra lift via larger shadow
            final hoverLift = _isHovered && _controller.value == 0.0 ? 2.0 : 0.0;
            final shadowOffset = baseOffset + hoverLift - pressOffset;

            return Padding(
              padding: EdgeInsets.only(
                right: baseOffset + hoverLift,
                bottom: baseOffset + hoverLift,
              ),
              child: Stack(
                children: [
                  // ── Neo shadow layer (behind, offset, no blur) ──
                  Positioned(
                    top: shadowOffset,
                    left: shadowOffset,
                    right: -(shadowOffset),
                    bottom: -(shadowOffset),
                    child: Container(
                      margin: EdgeInsets.symmetric(
                        horizontal: AppSpacing.md,
                        vertical: AppSpacing.profileActionCardVerticalMargin,
                      ),
                      decoration: BoxDecoration(
                        color: neoShadowColor,
                        borderRadius: BorderRadius.circular(AppSpacing.radiusProfileCard),
                        border: Border.all(color: borderColor, width: AppSpacing.neoBorderWidth),
                      ),
                    ),
                  ),

                  // ── Card layer (foreground) ──
                  Transform.translate(
                    offset: Offset(pressOffset, pressOffset),
                    child: Container(
                      margin: EdgeInsets.symmetric(
                        horizontal: AppSpacing.md,
                        vertical: AppSpacing.profileActionCardVerticalMargin,
                      ),
                      decoration: BoxDecoration(
                        color: cardColor,
                        borderRadius: BorderRadius.circular(AppSpacing.radiusProfileCard),
                        border: Border.all(color: borderColor, width: AppSpacing.neoBorderWidth),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(AppSpacing.radiusProfileCard - 2),
                        child: Padding(
                          padding: const EdgeInsets.all(AppSpacing.md),
                          child: Row(
                            children: [
                              // Icon badge
                              AnimatedContainer(
                                duration: const Duration(milliseconds: 200),
                                padding: const EdgeInsets.all(AppSpacing.md * 0.75),
                                decoration: BoxDecoration(
                                  color: widget.accentColor.withValues(
                                    alpha: _isHovered ? 0.18 : 0.10,
                                  ),
                                  borderRadius: BorderRadius.circular(14),
                                  border: Border.all(
                                    color: widget.accentColor.withValues(alpha: 0.25),
                                    width: 1.5,
                                  ),
                                ),
                                child: Icon(widget.icon, color: widget.accentColor, size: 22),
                              ),
                              const SizedBox(width: AppSpacing.md),
                              // Text
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      widget.title,
                                      style: TextStyle(
                                        color: textColor,
                                        fontWeight: FontWeight.w800,
                                        fontSize: 15,
                                        letterSpacing: -0.3,
                                      ),
                                    ),
                                    if (widget.subtitle != null) ...[
                                      const SizedBox(height: 3),
                                      Text(
                                        widget.subtitle!,
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                          color: subTextColor,
                                          fontSize: 12.5,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ],
                                  ],
                                ),
                              ),
                              // Trailing
                              if (widget.trailing != null)
                                widget.trailing!
                              else
                                Container(
                                  padding: const EdgeInsets.all(6),
                                  decoration: BoxDecoration(
                                    color: borderColor.withValues(alpha: 0.1),
                                    borderRadius: BorderRadius.circular(8),
                                    border: Border.all(
                                      color: borderColor.withValues(alpha: 0.3),
                                      width: 1,
                                    ),
                                  ),
                                  child: Icon(
                                    Icons.arrow_forward_ios_rounded,
                                    color: subTextColor,
                                    size: 12,
                                  ),
                                ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
