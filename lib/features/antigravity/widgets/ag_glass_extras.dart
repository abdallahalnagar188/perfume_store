import 'package:flutter/material.dart';
import '../constants/ag_effects.dart';
import 'ag_glass_container.dart';

/// AGGlassIcon - Circular Icon with Glass Background
/// Small glass container around icons for floating effect
class AGGlassIcon extends StatelessWidget {
  const AGGlassIcon({
    super.key,
    required this.icon,
    this.size = 40.0,
    this.iconSize,
    this.iconColor,
    this.backgroundColor,
    this.blurIntensity,
    this.onTap,
    this.padding,
  });

  final IconData icon;
  final double size;
  final double? iconSize;
  final Color? iconColor;
  final Color? backgroundColor;
  final double? blurIntensity;
  final VoidCallback? onTap;
  final EdgeInsets? padding;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final effectiveIconSize = iconSize ?? size * 0.5;
    final effectivePadding =
        padding ?? EdgeInsets.all((size - effectiveIconSize) / 2);

    Widget iconWidget = AGGlassContainer(
      width: size,
      height: size,
      blurIntensity: blurIntensity ?? AGEffects.blurLight,
      borderRadius: size / 2, // Circular
      padding: effectivePadding,
      backgroundColor: backgroundColor,
      elevation: 0.8,
      child: Icon(
        icon,
        size: effectiveIconSize,
        color: iconColor ?? theme.iconTheme.color,
      ),
    );

    if (onTap != null) {
      iconWidget = InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(size / 2),
        child: iconWidget,
      );
    }

    return iconWidget;
  }
}

/// AGGlassChip - Small Glass Chip Component
/// For categories, tags, filters, etc.
class AGGlassChip extends StatelessWidget {
  const AGGlassChip({
    super.key,
    required this.label,
    this.icon,
    this.onTap,
    this.onDeleted,
    this.isSelected = false,
    this.backgroundColor,
    this.selectedColor,
    this.blurIntensity,
    this.borderRadius,
    this.padding,
  });

  final String label;
  final IconData? icon;
  final VoidCallback? onTap;
  final VoidCallback? onDeleted;
  final bool isSelected;
  final Color? backgroundColor;
  final Color? selectedColor;
  final double? blurIntensity;
  final double? borderRadius;
  final EdgeInsets? padding;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final effectiveRadius = borderRadius ?? AGEffects.radiusLarge;
    final effectivePadding =
        padding ?? EdgeInsets.symmetric(horizontal: 16, vertical: 8);

    // Determine colors based on selection
    Color? effectiveBackground = backgroundColor;
    if (isSelected) {
      effectiveBackground =
          selectedColor ?? theme.primaryColor.withOpacity(0.3);
    }

    final double effectiveOpacity = isSelected ? 0.25 : 0.12;

    Widget chip = AGGlassContainer(
      blurIntensity: blurIntensity ?? AGEffects.blurLight,
      borderRadius: effectiveRadius,
      padding: effectivePadding,
      backgroundColor: effectiveBackground,
      opacity: effectiveOpacity,
      elevation: isSelected ? 1.2 : 0.7,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (icon != null) ...[Icon(icon, size: 18), const SizedBox(width: 6)],
          Text(
            label,
            style: theme.textTheme.bodyMedium?.copyWith(
              fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
            ),
          ),
          if (onDeleted != null) ...[
            const SizedBox(width: 6),
            InkWell(
              onTap: onDeleted,
              borderRadius: BorderRadius.circular(12),
              child: const Icon(Icons.close, size: 16),
            ),
          ],
        ],
      ),
    );

    if (onTap != null) {
      chip = InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(effectiveRadius),
        child: chip,
      );
    }

    return chip;
  }
}
