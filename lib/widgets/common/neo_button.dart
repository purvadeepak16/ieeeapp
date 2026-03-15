import 'package:flutter/material.dart';
import 'package:ieee_app/core/theme/app_colors.dart';
import 'package:ieee_app/core/theme/spacing_constants.dart';

class NeoButton extends StatelessWidget {
  final VoidCallback onPressed;
  final Widget child;
  final Color? backgroundColor;
  final Color? foregroundColor;
  final double? borderRadius;
  final EdgeInsetsGeometry? padding;
  final bool isExpanded;

  const NeoButton({
    super.key,
    required this.onPressed,
    required this.child,
    this.backgroundColor,
    this.foregroundColor,
    this.borderRadius,
    this.padding,
    this.isExpanded = false,
  });

  @override
  Widget build(BuildContext context) {
    final double radius = borderRadius ?? AppSpacing.radiusSm;
    final Color bg = backgroundColor ?? AppColors.premiumBlack;
    final Color fg = foregroundColor ?? Colors.white;

    Widget buttonContent = Stack(
      children: [
        // Hard Shadow
        Positioned(
          top: 3,
          left: 3,
          right: 0,
          bottom: 0,
          child: Container(
            decoration: BoxDecoration(
              color: AppColors.premiumBlack,
              borderRadius: BorderRadius.circular(radius),
            ),
          ),
        ),
        // Main Button Surface
        Container(
          margin: const EdgeInsets.only(bottom: 3, right: 3),
          decoration: BoxDecoration(
            color: bg,
            borderRadius: BorderRadius.circular(radius),
            border: Border.all(color: AppColors.premiumBlack, width: 2),
          ),
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: onPressed,
              borderRadius: BorderRadius.circular(radius),
              child: Padding(
                padding: padding ?? const EdgeInsets.symmetric(vertical: 12, horizontal: 24),
                child: Center(
                  widthFactor: isExpanded ? null : 1.0,
                  child: DefaultTextStyle(
                    style: TextStyle(
                      color: fg,
                      fontWeight: FontWeight.w900,
                      letterSpacing: 1.0,
                      fontSize: 14,
                    ),
                    child: child,
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );

    if (isExpanded) {
      return SizedBox(width: double.infinity, child: buttonContent);
    }
    return buttonContent;
  }
}
