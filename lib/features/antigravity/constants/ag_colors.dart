import 'package:flutter/material.dart';

/// Anti-Gravity Color Palette
/// Optimized for glassmorphism effects with enhanced translucency and refraction
class AGColors {
  AGColors._();

  // ==================== Base Glass Colors ====================

  /// Primary glass tint - soft blue with high luminosity for refraction
  static const Color glassPrimary = Color(0xFF6B85FF);
  static const Color glassPrimaryLight = Color(0xFF94A8FF);
  static const Color glassPrimaryDark = Color(0xFF4D67E8);

  /// Secondary glass tint - warm accent
  static const Color glassSecondary = Color(0xFFFFF066);
  static const Color glassAccent = Color(0xFFC2D6FF);

  // ==================== Glass Background Tints ====================

  /// Light mode glass backgrounds (use with low opacity 0.05-0.15)
  static const Color glassWhite = Color(0xFFFFFFFF);
  static const Color glassLight = Color(0xFFF8F9FF);
  static const Color glassSoftBlue = Color(0xFFE8EDFF);

  /// Dark mode glass backgrounds (use with low opacity 0.1-0.25)
  static const Color glassBlack = Color(0xFF0A0E1A);
  static const Color glassDark = Color(0xFF1A1F2E);
  static const Color glassDarkBlue = Color(0xFF252B3D);

  // ==================== Gradient Definitions ====================

  /// Light mode glass gradient (top to bottom)
  static const LinearGradient lightGlassGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      Color(0x12FFFFFF), // 7% opacity white
      Color(0x08FFFFFF), // 3% opacity white
    ],
  );

  /// Dark mode glass gradient
  static const LinearGradient darkGlassGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      Color(0x28FFFFFF), // 16% opacity white
      Color(0x0AFFFFFF), // 4% opacity white
    ],
  );

  /// Border gradient for glass containers (creates refraction effect)
  static const LinearGradient glassBorderGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      Color(0x40FFFFFF), // 25% opacity
      Color(0x10FFFFFF), // 6% opacity
    ],
  );

  /// Shimmer gradient for glass effects
  static LinearGradient getShimmerGradient({double opacity = 0.3}) {
    return LinearGradient(
      begin: Alignment(-1.0, -0.3),
      end: Alignment(1.0, 0.3),
      colors: [
        Color(0x00FFFFFF),
        Color(0xFFFFFFFF).withOpacity(opacity),
        Color(0x00FFFFFF),
      ],
      stops: const [0.0, 0.5, 1.0],
    );
  }

  // ==================== Depth & Shadow Colors ====================

  /// Shadow colors for floating elements (anti-gravity elevation)
  static Color getFloatingShadow(bool isDark, {double opacity = 0.15}) {
    return isDark
        ? Color(0xFF000000).withOpacity(opacity * 1.5)
        : Color(0xFF4D67E8).withOpacity(opacity);
  }

  /// Glow color for active/focused states
  static const Color glowPrimary = Color(0xFF6B85FF);
  static const Color glowSecondary = Color(0xFFFFF066);

  // ==================== Overlay Colors ====================

  /// Modal backdrop with blur
  static const Color modalBackdrop = Color(0x40000000); // 25% black
  static const Color modalBackdropDark = Color(0x60000000); // 38% black

  // ==================== Interaction States ====================

  /// Ripple effect color for glass buttons
  static const Color glassRipple = Color(0x20FFFFFF);
  static const Color glassRippleDark = Color(0x308BA4FF);

  /// Hover state overlay (desktop)
  static const Color hoverOverlay = Color(0x0AFFFFFF);
  static const Color hoverOverlayDark = Color(0x15FFFFFF);

  // ==================== Semantic Glass Colors ====================

  /// Success glass tint
  static const Color glassSuccess = Color(0xFF4ADE80);

  /// Error glass tint
  static const Color glassError = Color(0xFFEF4444);

  /// Warning glass tint
  static const Color glassWarning = Color(0xFFFBBF24);

  /// Info glass tint
  static const Color glassInfo = Color(0xFF60A5FA);

  // ==================== Helper Methods ====================

  /// Get adaptive glass background color based on theme brightness
  static Color getGlassBackground(
    Brightness brightness, {
    double opacity = 0.12,
  }) {
    return brightness == Brightness.light
        ? glassWhite.withOpacity(opacity)
        : glassDark.withOpacity(opacity * 1.8);
  }

  /// Get adaptive border color for glass containers
  static Color getGlassBorder(Brightness brightness, {double opacity = 0.2}) {
    return brightness == Brightness.light
        ? Color(0xFFFFFFFF).withOpacity(opacity)
        : Color(0xFFFFFFFF).withOpacity(opacity * 0.6);
  }

  /// Get gradient based on theme
  static LinearGradient getAdaptiveGradient(Brightness brightness) {
    return brightness == Brightness.light
        ? lightGlassGradient
        : darkGlassGradient;
  }
}
