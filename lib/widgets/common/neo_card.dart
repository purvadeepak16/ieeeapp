import 'package:flutter/material.dart';
import 'package:ieee_app/core/theme/app_colors.dart';
import 'package:ieee_app/core/theme/spacing_constants.dart';

class NeoCard extends StatelessWidget {
  final Widget child;
  final Color? backgroundColor;
  final double? borderRadius;
  final EdgeInsetsGeometry? padding;
  final VoidCallback? onTap;
  final bool showShadow;
  final bool showBorder;

  const NeoCard({
    super.key,
    required this.child,
    this.backgroundColor,
    this.borderRadius,
    this.padding,
    this.onTap,
    this.showShadow = true,
    this.showBorder = true,
  });

  @override
  Widget build(BuildContext context) {
    final double radius = borderRadius ?? AppSpacing.radiusCustom;
    final ThemeData theme = Theme.of(context);
    final bool isDark = theme.brightness == Brightness.dark;

    return Stack(
      children: [
        // The Shadow Layer
        if (showShadow)
          Positioned(
            top: AppSpacing.neoShadowOffset,
            left: AppSpacing.neoShadowOffset,
            right: 0,
            bottom: 0,
            child: Container(
              decoration: BoxDecoration(
                color: isDark ? AppColors.neoShadowDark : AppColors.neoShadow,
                borderRadius: BorderRadius.circular(radius),
              ),
            ),
          ),

        // The Bordered Card Layer
        Container(
          margin: showShadow
              ? const EdgeInsets.only(
                  bottom: AppSpacing.neoShadowOffset,
                  right: AppSpacing.neoShadowOffset)
              : EdgeInsets.zero,
          decoration: BoxDecoration(
            color: backgroundColor ?? theme.colorScheme.surface,
            borderRadius: BorderRadius.circular(radius),
            border: showBorder
                ? Border.all(
                    color: isDark
                        ? theme.colorScheme.onSurface
                        : AppColors.neoDarkBorder,
                    width: AppSpacing.neoBorderWidth,
                  )
                : null,
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(radius),
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: onTap,
                borderRadius: BorderRadius.circular(radius),
                child: Padding(
                  padding: padding ?? const EdgeInsets.all(AppSpacing.md),
                  child: child,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
