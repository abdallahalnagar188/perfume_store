import 'dart:ui';
import 'package:flutter/material.dart';
import '../constants/ag_colors.dart';
import '../constants/ag_effects.dart';
import '../utils/platform_adapter.dart';

/// AGGlassContainer - Base Glass Container with Blur & Translucency
/// The foundation component for all glass morphism effects in the anti-gravity UI
class AGGlassContainer extends StatelessWidget {
  const AGGlassContainer({
    super.key,
    required this.child,
    this.blurIntensity,
    this.opacity,
    this.borderRadius,
    this.padding,
    this.margin,
    this.width,
    this.height,
    this.floatingShadow = true,
    this.gradient,
    this.backgroundColor,
    this.borderColor,
    this.borderWidth,
    this.elevation = 1.0,
    this.enableGlassEffect = true,
  });

  /// The widget below this widget in the tree
  final Widget child;

  /// Blur intensity (sigma value for BackdropFilter)
  /// If null, uses AGEffects.blurMedium optimized for device
  final double? blurIntensity;

  /// Background opacity (0.0 - 1.0)
  /// If null, uses AGEffects.opacityStandard
  final double? opacity;

  /// Border radius for rounded corners
  /// If null, uses AGEffects.radiusMedium
  final double? borderRadius;

  /// Internal padding
  final EdgeInsetsGeometry? padding;

  /// External margin
  final EdgeInsetsGeometry? margin;

  /// Container width
  final double? width;

  /// Container height
  final double? height;

  /// Enable floating shadow for depth
  final bool floatingShadow;

  /// Custom gradient (overrides default glass gradient)
  final Gradient? gradient;

  /// Background color (if you want solid color instead of glass)
  final Color? backgroundColor;

  /// Custom border color
  final Color? borderColor;

  /// Custom border width
  final double? borderWidth;

  /// Shadow elevation multiplier (0.5 - 3.0)
  final double elevation;

  /// Enable or disable glass effect (for backward compatibility)
  final bool enableGlassEffect;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    // Get optimized blur value based on device capability
    final requestedBlur = blurIntensity ?? AGEffects.blurMedium;
    final optimizedBlur = AGPlatformAdapter.getOptimalBlurSigma(
      requestedBlur: requestedBlur,
    );

    final effectiveRadius = borderRadius ?? AGEffects.radiusMedium;
    final effectiveOpacity = opacity ?? AGEffects.opacityStandard;
    final effectiveBorderWidth = borderWidth ?? AGEffects.borderWidth;

    // Determine gradient
    final effectiveGradient =
        gradient ?? AGColors.getAdaptiveGradient(theme.brightness);

    // Determine border color
    final effectiveBorderColor =
        borderColor ?? AGColors.getGlassBorder(theme.brightness, opacity: 0.2);

    // Build shadow list
    final shadows = floatingShadow
        ? AGEffects.getFloatingShadow(isDark: isDark, elevation: elevation)
        : <BoxShadow>[];

    // If glass effect is disabled, use simple container
    if (!enableGlassEffect) {
      return Container(
        width: width,
        height: height,
        margin: margin,
        padding: padding,
        decoration: BoxDecoration(
          color: backgroundColor ?? theme.cardColor,
          borderRadius: BorderRadius.circular(effectiveRadius),
          border: Border.all(
            color: effectiveBorderColor,
            width: effectiveBorderWidth,
          ),
          boxShadow: shadows,
        ),
        child: child,
      );
    }

    // Glass effect enabled
    return Container(
      width: width,
      height: height,
      margin: margin,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(effectiveRadius),
        child: BackdropFilter(
          filter: ImageFilter.blur(
            sigmaX: optimizedBlur,
            sigmaY: optimizedBlur,
          ),
          child: Container(
            padding: padding,
            decoration: BoxDecoration(
              gradient: backgroundColor == null ? effectiveGradient : null,
              color: backgroundColor?.withOpacity(effectiveOpacity),
              borderRadius: BorderRadius.circular(effectiveRadius),
              border: Border.all(
                color: effectiveBorderColor,
                width: effectiveBorderWidth,
              ),
              boxShadow: shadows,
            ),
            child: child,
          ),
        ),
      ),
    );
  }
}
