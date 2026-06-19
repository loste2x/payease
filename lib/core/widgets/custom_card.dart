import 'package:flutter/material.dart';
import '../constants/app_colors.dart';
import '../constants/app_sizes.dart';

/// M3 Card variants: filled, elevated, outlined
enum CardVariant { filled, elevated, outlined }

class CustomCard extends StatelessWidget {
  final Widget child;
  final CardVariant variant;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final VoidCallback? onTap;
  final Color? color;
  final double? borderRadius;

  const CustomCard({
    super.key,
    required this.child,
    this.variant = CardVariant.filled,
    this.padding,
    this.margin,
    this.onTap,
    this.color,
    this.borderRadius,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final radius = borderRadius ?? AppSizes.radiusLg;

    Color bgColor;
    Color? borderColor;
    double elevation;

    switch (variant) {
      case CardVariant.filled:
        bgColor = color ?? AppColors.surfaceContainerLowest;
        elevation = 0;
        break;
      case CardVariant.elevated:
        bgColor = color ?? theme.colorScheme.surface;
        elevation = 1;
        break;
      case CardVariant.outlined:
        bgColor = color ?? theme.colorScheme.surface;
        borderColor = theme.colorScheme.outlineVariant;
        elevation = 0;
        break;
    }

    return Container(
      margin: margin,
      child: Material(
        color: bgColor,
        elevation: elevation,
        shadowColor: Colors.black12,
        surfaceTintColor: Colors.transparent,
        borderRadius: BorderRadius.circular(radius),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(radius),
          child: Container(
            padding: padding ?? const EdgeInsets.all(AppSizes.lg),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(radius),
              border: borderColor != null
                  ? Border.all(color: borderColor, width: 1)
                  : null,
            ),
            child: child,
          ),
        ),
      ),
    );
  }
}