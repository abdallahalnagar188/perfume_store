import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

/// Platform Adapter Utilities
/// Provides platform-aware configurations and device capability detection
class AGPlatformAdapter {
  AGPlatformAdapter._();

  // ==================== Platform Detection ====================

  /// Check if running on mobile (iOS or Android)
  static bool get isMobile => !kIsWeb && (Platform.isIOS || Platform.isAndroid);

  /// Check if running on desktop (Windows, macOS, Linux)
  static bool get isDesktop =>
      !kIsWeb && (Platform.isWindows || Platform.isMacOS || Platform.isLinux);

  /// Check if running on web
  static bool get isWeb => kIsWeb;

  /// Check if iOS specifically
  static bool get isIOS => !kIsWeb && Platform.isIOS;

  /// Check if Android specifically
  static bool get isAndroid => !kIsWeb && Platform.isAndroid;

  /// Check if macOS
  static bool get isMacOS => !kIsWeb && Platform.isMacOS;

  /// Check if Windows
  static bool get isWindows => !kIsWeb && Platform.isWindows;

  // ==================== Device Capability Detection ====================

  /// Estimate device performance tier
  /// Returns: 'high', 'medium', 'low'
  static String getDevicePerformanceTier() {
    // This is a simplified heuristic
    // In production, you might check actual device specs via platform channels

    if (isDesktop || isWeb) {
      return 'high'; // Assume desktops can handle heavy blur
    }

    // For mobile, we'd ideally check device model/chipset
    // For now, return medium as safe default
    return 'medium';
  }

  /// Get recommended blur intensity based on device capability
  static double getOptimalBlurSigma({
    required double requestedBlur,
    bool forceFullQuality = false,
  }) {
    if (forceFullQuality) return requestedBlur;

    final tier = getDevicePerformanceTier();

    switch (tier) {
      case 'high':
        return requestedBlur;
      case 'medium':
        return requestedBlur * 0.8; // 80% of requested blur
      case 'low':
        return requestedBlur * 0.5; // 50% of requested blur
      default:
        return requestedBlur;
    }
  }

  /// Check if device should use reduced motion
  static bool shouldReduceMotion(BuildContext context) {
    return MediaQuery.of(context).disableAnimations;
  }

  // ==================== Platform-Specific Spacing ====================

  /// Get platform-appropriate padding for containers
  static EdgeInsets getAdaptivePadding({
    double? horizontal,
    double? vertical,
    double? all,
  }) {
    final basePadding = all ?? 16.0;
    final hPadding = horizontal ?? basePadding;
    final vPadding = vertical ?? basePadding;

    if (isIOS) {
      // iOS typically needs slightly more padding
      return EdgeInsets.symmetric(
        horizontal: hPadding * 1.1,
        vertical: vPadding,
      );
    } else if (isAndroid) {
      // Android Material guidelines
      return EdgeInsets.symmetric(horizontal: hPadding, vertical: vPadding);
    } else if (isDesktop) {
      // Desktop can have more generous spacing
      return EdgeInsets.symmetric(
        horizontal: hPadding * 1.2,
        vertical: vPadding * 1.1,
      );
    }

    return EdgeInsets.symmetric(horizontal: hPadding, vertical: vPadding);
  }

  /// Get minimum touch target size per platform
  static double get minTouchTarget {
    if (isIOS) {
      return 44.0; // Apple HIG
    } else if (isAndroid) {
      return 48.0; // Material Design
    } else {
      return 40.0; // Desktop can be slightly smaller
    }
  }

  // ==================== Platform-Specific Icons ====================

  /// Get platform-appropriate back icon
  static IconData get backIcon {
    if (isIOS) {
      return Icons.arrow_back_ios_new; // Chevron style for iOS
    } else {
      return Icons.arrow_back; // Standard arrow for Android/Others
    }
  }

  /// Get platform-appropriate close icon
  static IconData get closeIcon {
    if (isIOS) {
      return Icons.close;
    } else {
      return Icons.close;
    }
  }

  // ==================== Platform-Specific Animations ====================

  /// Get platform-appropriate page transition duration
  static Duration get pageTransitionDuration {
    if (isIOS) {
      return const Duration(milliseconds: 350); // iOS native feel
    } else if (isAndroid) {
      return const Duration(milliseconds: 300); // Material motion
    } else {
      return const Duration(milliseconds: 250); // Snappier on desktop
    }
  }

  /// Get platform-appropriate curve for navigation
  static Curve get pageTransitionCurve {
    if (isIOS) {
      return Curves.easeInOut; // iOS smooth
    } else {
      return Curves.fastOutSlowIn; // Material standard
    }
  }

  // ==================== Gesture Configuration ====================

  /// Check if hover interactions should be enabled
  static bool get supportsHover => isDesktop || isWeb;

  /// Check if haptic feedback should be used
  static bool get supportsHaptics => isMobile;

  /// Get scroll physics for platform
  static ScrollPhysics getScrollPhysics() {
    if (isIOS) {
      return const BouncingScrollPhysics();
    } else if (isAndroid) {
      return const ClampingScrollPhysics();
    } else {
      return const BouncingScrollPhysics(); // Bouncing feels better on desktop
    }
  }

  // ==================== Responsive Breakpoints ====================

  /// Check if screen is mobile size
  static bool isMobileSize(BuildContext context) {
    return MediaQuery.of(context).size.width < 600;
  }

  /// Check if screen is tablet size
  static bool isTabletSize(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return width >= 600 && width < 1024;
  }

  /// Check if screen is desktop size
  static bool isDesktopSize(BuildContext context) {
    return MediaQuery.of(context).size.width >= 1024;
  }

  /// Get responsive column count for grid
  static int getGridColumnCount(
    BuildContext context, {
    int mobileColumns = 2,
    int tabletColumns = 3,
    int desktopColumns = 4,
  }) {
    if (isMobileSize(context)) return mobileColumns;
    if (isTabletSize(context)) return tabletColumns;
    return desktopColumns;
  }

  // ==================== Accessibility ====================

  /// Get text scale capped for better layout
  static double getTextScale(BuildContext context, {double maxScale = 2.0}) {
    final scale = MediaQuery.of(context).textScaleFactor;
    return scale.clamp(1.0, maxScale);
  }

  /// Check if large text accessibility is enabled
  static bool isLargeTextEnabled(BuildContext context) {
    return MediaQuery.of(context).textScaleFactor > 1.3;
  }
}
