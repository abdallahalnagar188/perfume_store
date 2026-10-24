import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../constants/ag_animations.dart';
import '../constants/ag_effects.dart';
import '../utils/platform_adapter.dart';
import 'ag_glass_container.dart';

/// AGGlassCard - Floating Glass Card with Hover & Parallax Effects
/// An interactive card component that feels suspended in air
class AGGlassCard extends StatefulWidget {
  const AGGlassCard({
    super.key,
    required this.child,
    this.onTap,
    this.onLongPress,
    this.blurIntensity,
    this.borderRadius,
    this.padding,
    this.margin,
    this.width,
    this.height,
    this.enableHoverEffect = true,
    this.enableEntranceAnimation = true,
    this.enableParallax = false,
    this.elevation = 1.0,
  });

  final Widget child;
  final VoidCallback? onTap;
  final VoidCallback? onLongPress;
  final double? blurIntensity;
  final double? borderRadius;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final double? width;
  final double? height;
  final bool enableHoverEffect;
  final bool enableEntranceAnimation;
  final bool enableParallax;
  final double elevation;

  @override
  State<AGGlassCard> createState() => _AGGlassCardState();
}

class _AGGlassCardState extends State<AGGlassCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _entranceController;
  late Animation<double> _scaleAnimation;
  late Animation<double> _fadeAnimation;

  bool _isHovering = false;
  bool _isPressed = false;

  @override
  void initState() {
    super.initState();

    // Setup entrance animation
    _entranceController = AnimationController(
      vsync: this,
      duration: AGAnimations.durationEntrance,
    );

    _scaleAnimation = AGAnimations.getScaleAnimation(_entranceController);
    _fadeAnimation = AGAnimations.getFadeInAnimation(_entranceController);

    // Start entrance animation if enabled
    if (widget.enableEntranceAnimation) {
      _entranceController.forward();
    } else {
      _entranceController.value = 1.0;
    }
  }

  @override
  void dispose() {
    _entranceController.dispose();
    super.dispose();
  }

  void _handleTapDown(TapDownDetails details) {
    if (AGPlatformAdapter.supportsHaptics) {
      HapticFeedback.lightImpact();
    }

    setState(() {
      _isPressed = true;
    });
  }

  void _handleTapUp(TapUpDetails details) {
    setState(() {
      _isPressed = false;
    });
  }

  void _handleTapCancel() {
    setState(() {
      _isPressed = false;
    });
  }

  void _handleHoverEnter(PointerEnterEvent event) {
    if (AGPlatformAdapter.supportsHover && widget.enableHoverEffect) {
      setState(() {
        _isHovering = true;
      });
    }
  }

  void _handleHoverExit(PointerExitEvent event) {
    if (AGPlatformAdapter.supportsHover) {
      setState(() {
        _isHovering = false;
      });
    }
  }

  double get _currentScale {
    if (_isPressed) {
      return AGEffects.pressScale;
    } else if (_isHovering) {
      return AGEffects.hoverScale;
    }
    return 1.0;
  }

  double get _currentElevation {
    if (_isPressed) {
      return widget.elevation * 0.7;
    } else if (_isHovering) {
      return widget.elevation * 1.3;
    }
    return widget.elevation;
  }

  @override
  Widget build(BuildContext context) {
    final shouldReduceMotion = AGPlatformAdapter.shouldReduceMotion(context);

    Widget card = AGGlassContainer(
      blurIntensity: widget.blurIntensity,
      borderRadius: widget.borderRadius,
      padding: widget.padding,
      margin: widget.margin,
      width: widget.width,
      height: widget.height,
      elevation: _currentElevation,
      floatingShadow: true,
      child: widget.child,
    );

    // Wrap with GestureDetector if interactive
    if (widget.onTap != null || widget.onLongPress != null) {
      card = GestureDetector(
        onTap: widget.onTap,
        onLongPress: widget.onLongPress,
        onTapDown: _handleTapDown,
        onTapUp: _handleTapUp,
        onTapCancel: _handleTapCancel,
        child: card,
      );
    }

    // Add hover detection for desktop
    if (AGPlatformAdapter.supportsHover && widget.enableHoverEffect) {
      card = MouseRegion(
        onEnter: _handleHoverEnter,
        onExit: _handleHoverExit,
        cursor: widget.onTap != null
            ? SystemMouseCursors.click
            : SystemMouseCursors.basic,
        child: card,
      );
    }

    // Add scale transition for hover/press
    if (!shouldReduceMotion) {
      card = AnimatedScale(
        scale: _currentScale,
        duration: AGAnimations.durationFast,
        curve: AGAnimations.easeOutSmooth,
        child: card,
      );
    }

    // Wrap with entrance animation
    if (widget.enableEntranceAnimation && !shouldReduceMotion) {
      card = FadeTransition(
        opacity: _fadeAnimation,
        child: ScaleTransition(scale: _scaleAnimation, child: card),
      );
    }

    return card;
  }
}
