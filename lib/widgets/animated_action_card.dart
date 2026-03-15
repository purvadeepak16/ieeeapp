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
    this.accentColor = AppColors.profileAccent,
  });

  @override
  State<AnimatedActionCard> createState() => _AnimatedActionCardState();
}

class _AnimatedActionCardState extends State<AnimatedActionCard> 
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  bool _isHovered = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 150),
    );
    _scaleAnimation = Tween<double>(begin: 1.0, end: 0.98).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _onTapDown(TapDownDetails details) {
    _controller.forward();
  }

  void _onTapUp(TapUpDetails details) {
    _controller.reverse();
    widget.onTap();
  }

  void _onTapCancel() {
    _controller.reverse();
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
    final borderColor = widget.isDarkMode 
        ? AppColors.profileDividerDark 
        : AppColors.profileDividerLight;

    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: GestureDetector(
        onTapDown: _onTapDown,
        onTapUp: _onTapUp,
        onTapCancel: _onTapCancel,
        child: AnimatedBuilder(
          animation: _scaleAnimation,
          builder: (context, child) => Transform.scale(
            scale: _scaleAnimation.value,
            child: child,
          ),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            margin: const EdgeInsets.symmetric(horizontal: AppSpacing.md, vertical: 6),
            padding: const EdgeInsets.all(AppSpacing.md),
            decoration: BoxDecoration(
              color: cardColor,
              borderRadius: BorderRadius.circular(AppSpacing.radiusProfileCard),
              border: Border.all(
                color: _isHovered ? widget.accentColor.withOpacity(0.5) : borderColor,
                width: 1.5,
              ),
              boxShadow: _isHovered 
                ? [
                    BoxShadow(
                      color: widget.accentColor.withOpacity(0.15),
                      blurRadius: 12,
                      offset: const Offset(0, 4),
                    )
                  ]
                : [
                    BoxShadow(
                      color: Colors.black.withOpacity(widget.isDarkMode ? 0.2 : 0.05),
                      blurRadius: 8,
                      offset: const Offset(0, 2),
                    )
                  ],
            ),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: widget.accentColor.withOpacity(0.1),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(widget.icon, color: widget.accentColor, size: 24),
                ),
                const SizedBox(width: AppSpacing.md),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        widget.title,
                        style: TextStyle(
                          color: textColor,
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                        ),
                      ),
                      if (widget.subtitle != null) ...[
                        const SizedBox(height: 4),
                        Text(
                          widget.subtitle!,
                          style: TextStyle(
                            color: subTextColor,
                            fontSize: 13,
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
                if (widget.trailing != null) 
                  widget.trailing!
                else
                  Icon(Icons.chevron_right, color: subTextColor),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
