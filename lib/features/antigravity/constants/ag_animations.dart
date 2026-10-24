import 'package:flutter/material.dart';

/// Anti-Gravity Animation System
/// Spring-based, natural motion curves and durations for floating UI elements
class AGAnimations {
  AGAnimations._();

  // ==================== Duration Constants ====================

  /// Very fast micro-interactions (shimmer, ripple)
  static const Duration durationFast = Duration(milliseconds: 200);

  /// Standard UI transitions
  static const Duration durationStandard = Duration(milliseconds: 350);

  /// Entrance animations
  static const Duration durationEntrance = Duration(milliseconds: 600);

  /// Exit animations (slightly faster than entrance)
  static const Duration durationExit = Duration(milliseconds: 400);

  /// Slow, dramatic effects
  static const Duration durationSlow = Duration(milliseconds: 800);

  /// Continuous animations (shimmer loop)
  static const Duration durationContinuous = Duration(milliseconds: 3000);

  // ==================== Spring Curve Parameters ====================

  /// Gentle spring (minimal bounce)
  static const Curve springGentle = Curves.easeOutCubic;

  /// Standard spring with slight bounce
  static Curve springStandard = Curves.easeOutBack;

  /// Bouncy spring for playful effect
  static const Curve springBouncy = Curves.elasticOut;

  /// Smooth deceleration
  static const Curve easeOutSmooth = Curves.easeOutQuart;

  /// Smooth acceleration
  static const Curve easeInSmooth = Curves.easeInQuart;

  /// Smooth both ways
  static const Curve easeInOutSmooth = Curves.easeInOutCubic;

  // ==================== Preset Animations ====================

  /// Floating entrance animation (scale + opacity)
  static AnimationController getEntranceController({
    required TickerProvider vsync,
    Duration? duration,
  }) {
    return AnimationController(
      vsync: vsync,
      duration: duration ?? durationEntrance,
    );
  }

  /// Scale animation for entrance
  static Animation<double> getScaleAnimation(AnimationController controller) {
    return Tween<double>(
      begin: 0.8,
      end: 1.0,
    ).animate(CurvedAnimation(parent: controller, curve: springStandard));
  }

  /// Opacity fade-in animation
  static Animation<double> getFadeInAnimation(AnimationController controller) {
    return Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: controller,
        curve: Interval(0.0, 0.7, curve: easeOutSmooth),
      ),
    );
  }

  /// Slide up animation
  static Animation<Offset> getSlideUpAnimation(AnimationController controller) {
    return Tween<Offset>(
      begin: Offset(0, 0.1),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: controller, curve: springStandard));
  }

  /// Hover scale animation (desktop)
  static Animation<double> getHoverAnimation(AnimationController controller) {
    return Tween<double>(
      begin: 1.0,
      end: 1.02,
    ).animate(CurvedAnimation(parent: controller, curve: easeOutSmooth));
  }

  // ==================== Combined Animations ====================

  /// Complete floating card entrance (scale + fade + slide)
  static Map<String, Animation> getFloatingCardEntrance(
    AnimationController controller,
  ) {
    return {
      'scale': getScaleAnimation(controller),
      'fade': getFadeInAnimation(controller),
      'slide': getSlideUpAnimation(controller),
    };
  }

  // ==================== Shimmer Animation ====================

  /// Shimmer gradient position animation
  static Animation<double> getShimmerAnimation(AnimationController controller) {
    return Tween<double>(
      begin: -2.0,
      end: 2.0,
    ).animate(CurvedAnimation(parent: controller, curve: Curves.linear));
  }

  // ==================== Ripple Animation ====================

  /// Ripple expansion animation
  static Animation<double> getRippleAnimation(AnimationController controller) {
    return Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(parent: controller, curve: Curves.easeOut));
  }

  /// Ripple opacity fade
  static Animation<double> getRippleOpacityAnimation(
    AnimationController controller,
  ) {
    return Tween<double>(
      begin: 0.5,
      end: 0.0,
    ).animate(CurvedAnimation(parent: controller, curve: Curves.easeOut));
  }

  // ==================== Blur Animation ====================

  /// Blur intensity transition (for scroll-based blur)
  static Animation<double> getBlurAnimation({
    required AnimationController controller,
    double minBlur = 0.0,
    double maxBlur = 15.0,
  }) {
    return Tween<double>(
      begin: minBlur,
      end: maxBlur,
    ).animate(CurvedAnimation(parent: controller, curve: easeInOutSmooth));
  }

  // ==================== Glow Pulse Animation ====================

  /// Pulsing glow for active states
  static Animation<double> getGlowPulseAnimation(
    AnimationController controller,
  ) {
    return Tween<double>(
      begin: 0.2,
      end: 0.6,
    ).animate(CurvedAnimation(parent: controller, curve: Curves.easeInOut));
  }

  // ==================== Helper Methods ====================

  /// Create repeating animation controller
  static AnimationController getRepeatingController({
    required TickerProvider vsync,
    Duration? duration,
    bool reverse = true,
  }) {
    final controller = AnimationController(
      vsync: vsync,
      duration: duration ?? durationContinuous,
    );

    if (reverse) {
      controller.repeat(reverse: true);
    } else {
      controller.repeat();
    }

    return controller;
  }

  /// Dispose multiple controllers
  static void disposeControllers(List<AnimationController> controllers) {
    for (final controller in controllers) {
      controller.dispose();
    }
  }
}
