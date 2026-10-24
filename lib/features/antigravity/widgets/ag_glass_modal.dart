import 'dart:ui';
import 'package:flutter/material.dart';
import '../constants/ag_animations.dart';
import '../constants/ag_colors.dart';
import '../constants/ag_effects.dart';
import '../utils/platform_adapter.dart';

/// AGGlassModal - Floating Glass Dialog/Modal
/// Bottom sheet or center modal with heavy blur backdrop
class AGGlassModal {
  /// Show a glass modal dialog in the center of the screen
  static Future<T?> showCenterModal<T>({
    required BuildContext context,
    required Widget child,
    bool barrierDismissible = true,
    Color? barrierColor,
    double? blurIntensity,
    double? borderRadius,
    EdgeInsets? padding,
    double? maxWidth,
  }) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return showGeneralDialog<T>(
      context: context,
      barrierDismissible: barrierDismissible,
      barrierLabel: 'Glass Modal',
      barrierColor:
          barrierColor ??
          (isDark ? AGColors.modalBackdropDark : AGColors.modalBackdrop),
      transitionDuration: AGAnimations.durationEntrance,
      pageBuilder: (context, animation, secondaryAnimation) {
        return _GlassModalContent(
          animation: animation,
          blurIntensity: blurIntensity,
          borderRadius: borderRadius,
          padding: padding,
          maxWidth: maxWidth,
          child: child,
        );
      },
    );
  }

  /// Show a glass bottom sheet
  static Future<T?> showBottomSheet<T>({
    required BuildContext context,
    required Widget child,
    bool isDismissible = true,
    bool enableDrag = true,
    Color? backgroundColor,
    double? blurIntensity,
    double? borderRadius,
    EdgeInsets? padding,
  }) {
    final theme = Theme.of(context);

    return showModalBottomSheet<T>(
      context: context,
      isDismissible: isDismissible,
      enableDrag: enableDrag,
      backgroundColor: Colors.transparent,
      barrierColor: theme.brightness == Brightness.dark
          ? AGColors.modalBackdropDark
          : AGColors.modalBackdrop,
      isScrollControlled: true,
      builder: (context) {
        return _GlassBottomSheet(
          child: child,
          backgroundColor: backgroundColor,
          blurIntensity: blurIntensity,
          borderRadius: borderRadius,
          padding: padding,
        );
      },
    );
  }
}

/// Internal widget for center modal content
class _GlassModalContent extends StatelessWidget {
  const _GlassModalContent({
    required this.animation,
    required this.child,
    this.blurIntensity,
    this.borderRadius,
    this.padding,
    this.maxWidth,
  });

  final Animation<double> animation;
  final Widget child;
  final double? blurIntensity;
  final double? borderRadius;
  final EdgeInsets? padding;
  final double? maxWidth;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    final effectiveRadius = borderRadius ?? AGEffects.radiusLarge;
    final effectivePadding = padding ?? const EdgeInsets.all(24);
    final effectiveBlur = blurIntensity ?? AGEffects.blurHeavy;

    return Center(
      child: ScaleTransition(
        scale: CurvedAnimation(
          parent: animation,
          curve: AGAnimations.springStandard,
        ),
        child: FadeTransition(
          opacity: animation,
          child: Container(
            constraints: BoxConstraints(maxWidth: maxWidth ?? 400),
            margin: AGPlatformAdapter.getAdaptivePadding(all: 24),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(effectiveRadius),
              child: BackdropFilter(
                filter: ImageFilter.blur(
                  sigmaX: effectiveBlur,
                  sigmaY: effectiveBlur,
                ),
                child: Container(
                  padding: effectivePadding,
                  decoration: BoxDecoration(
                    gradient: AGColors.getAdaptiveGradient(theme.brightness),
                    borderRadius: BorderRadius.circular(effectiveRadius),
                    border: Border.all(
                      color: AGColors.getGlassBorder(
                        theme.brightness,
                        opacity: 0.3,
                      ),
                      width: 1.5,
                    ),
                    boxShadow: AGEffects.getFloatingShadow(
                      isDark: isDark,
                      elevation: 2.0,
                    ),
                  ),
                  child: Material(color: Colors.transparent, child: child),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

/// Internal widget for bottom sheet
class _GlassBottomSheet extends StatelessWidget {
  const _GlassBottomSheet({
    required this.child,
    this.backgroundColor,
    this.blurIntensity,
    this.borderRadius,
    this.padding,
  });

  final Widget child;
  final Color? backgroundColor;
  final double? blurIntensity;
  final double? borderRadius;
  final EdgeInsets? padding;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    final effectiveRadius = borderRadius ?? AGEffects.radiusXLarge;
    final effectivePadding =
        padding ??
        EdgeInsets.fromLTRB(
          20,
          24,
          20,
          MediaQuery.of(context).viewInsets.bottom + 20,
        );
    final effectiveBlur = blurIntensity ?? AGEffects.blurHeavy;

    return ClipRRect(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(effectiveRadius),
        topRight: Radius.circular(effectiveRadius),
      ),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: effectiveBlur, sigmaY: effectiveBlur),
        child: Container(
          padding: effectivePadding,
          decoration: BoxDecoration(
            gradient: backgroundColor == null
                ? AGColors.getAdaptiveGradient(theme.brightness)
                : null,
            color: backgroundColor?.withOpacity(0.15),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(effectiveRadius),
              topRight: Radius.circular(effectiveRadius),
            ),
            border: Border(
              top: BorderSide(
                color: AGColors.getGlassBorder(theme.brightness, opacity: 0.3),
                width: 1.5,
              ),
            ),
            boxShadow: AGEffects.getFloatingShadow(
              isDark: isDark,
              elevation: 2.0,
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Drag handle
              Container(
                width: 40,
                height: 4,
                margin: const EdgeInsets.only(bottom: 16),
                decoration: BoxDecoration(
                  color: theme.dividerColor.withOpacity(0.5),
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              child,
            ],
          ),
        ),
      ),
    );
  }
}
