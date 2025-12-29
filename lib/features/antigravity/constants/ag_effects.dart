import 'dart:ui';
import 'package:flutter/material.dart';

/// Anti-Gravity Glass Effect Constants
/// Defines blur levels, opacity ranges, shadows, and depth systems
class AGEffects {
  AGEffects._();

  // ==================== Blur Intensity Levels ====================

  /// Light blur for subtle glass effect (good for text containers)
  static const double blurLight = 8.0;

  /// Medium blur for standard glass cards
  static const double blurMedium = 15.0;

  /// Heavy blur for modals and overlays
  static const double blurHeavy = 25.0;

  /// Ultra blur for backdrop/background effects
  static const double blurUltra = 40.0;

  // ==================== Opacity Ranges ====================

  /// Minimum opacity for glass layers (very translucent)
  static const double opacityMin = 0.05;

  /// Light opacity for glass containers
  static const double opacityLight = 0.08;

  /// Standard opacity for glass cards
  static const double opacityStandard = 0.12;

  /// Medium opacity for more visible glass
  static const double opacityMedium = 0.18;

  /// High opacity for modal backgrounds
  static const double opacityHigh = 0.25;

  // ==================== Border Configurations ====================

  /// Standard glass border width
  static const double borderWidth = 1.0;

  /// Thin decorative border
  static const double borderWidthThin = 0.5;

  /// Thick border for emphasis
  static const double borderWidthThick = 1.5;

  /// Border radius for glass containers
  static const double radiusSmall = 12.0;
  static const double radiusMedium = 16.0;
  static const double radiusLarge = 24.0;
  static const double radiusXLarge = 32.0;

  // ==================== Shadow Elevation System ====================

  /// Floating shadows for anti-gravity effect
  static List<BoxShadow> getFloatingShadow({
    required bool isDark,
    double elevation = 1.0, // 0.5 to 3.0
  }) {
    final baseColor = isDark ? Colors.black : Color(0xFF4D67E8);
    final opacity = isDark ? 0.4 : 0.15;

    return [
      // Primary shadow
      BoxShadow(
        color: baseColor.withOpacity(opacity * elevation),
        blurRadius: 16.0 * elevation,
        offset: Offset(0, 4.0 * elevation),
        spreadRadius: -2.0,
      ),
      // Secondary soft shadow for depth
      BoxShadow(
        color: baseColor.withOpacity(opacity * 0.6 * elevation),
        blurRadius: 24.0 * elevation,
        offset: Offset(0, 8.0 * elevation),
        spreadRadius: -4.0,
      ),
    ];
  }

  /// Subtle inner glow for glass containers
  static List<BoxShadow> getInnerGlow({
    required bool isDark,
    Color? glowColor,
  }) {
    final color = glowColor ?? (isDark ? Colors.white : Color(0xFF6B85FF));

    return [
      BoxShadow(
        color: color.withOpacity(0.05),
        blurRadius: 10.0,
        offset: Offset(0, 0),
        spreadRadius: -5.0,
      ),
    ];
  }

  /// Glow effect for active/focused states
  static List<BoxShadow> getFocusGlow({
    Color glowColor = const Color(0xFF6B85FF),
    double intensity = 0.4,
  }) {
    return [
      BoxShadow(
        color: glowColor.withOpacity(intensity),
        blurRadius: 20.0,
        offset: Offset(0, 0),
        spreadRadius: 0,
      ),
      BoxShadow(
        color: glowColor.withOpacity(intensity * 0.5),
        blurRadius: 40.0,
        offset: Offset(0, 0),
        spreadRadius: -4.0,
      ),
    ];
  }

  // ==================== Parallax Intensity ====================

  /// Multiplier for parallax scroll effect
  static const double parallaxIntensityLight = 0.02;
  static const double parallaxIntensityMedium = 0.05;
  static const double parallaxIntensityHeavy = 0.08;

  // ==================== Hover & Scale Effects ====================

  /// Scale multiplier for hover effect on desktop
  static const double hoverScale = 1.02;
  static const double hoverScaleLarge = 1.05;

  /// Scale for pressed state
  static const double pressScale = 0.98;

  // ==================== Decoration Helpers ====================

  /// Get complete glass decoration
  static BoxDecoration getGlassDecoration({
    required bool isDark,
    double borderRadius = radiusMedium,
    Gradient? gradient,
    double borderOpacity = 0.2,
    double elevation = 1.0,
    Color? backgroundColor,
  }) {
    return BoxDecoration(
      gradient: gradient,
      color: backgroundColor,
      borderRadius: BorderRadius.circular(borderRadius),
      border: Border.all(
        color: isDark
            ? Colors.white.withOpacity(borderOpacity * 0.6)
            : Colors.white.withOpacity(borderOpacity),
        width: borderWidth,
      ),
      boxShadow: getFloatingShadow(isDark: isDark, elevation: elevation),
    );
  }

  /// Glass container with backdrop filter
  static Widget createGlassContainer({
    required Widget child,
    required bool isDark,
    double blurSigma = blurMedium,
    double borderRadius = radiusMedium,
    EdgeInsets? padding,
    Gradient? gradient,
    double opacity = opacityStandard,
  }) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(borderRadius),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: blurSigma, sigmaY: blurSigma),
        child: Container(
          padding: padding,
          decoration: getGlassDecoration(
            isDark: isDark,
            borderRadius: borderRadius,
            gradient: gradient,
          ),
          child: child,
        ),
      ),
    );
  }
}
