import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../constants/ag_animations.dart';
import '../constants/ag_colors.dart';
import '../constants/ag_effects.dart';
import '../utils/platform_adapter.dart';
import 'ag_glass_container.dart';

/// AGGlassButton - Interactive Glass Button with Ripple Distortion
/// A futuristic button with shimmer effects and glass morphism
class AGGlassButton extends StatefulWidget {
  const AGGlassButton({
    super.key,
    required this.onPressed,
    required this.child,
    this.width,
    this.height,
    this.padding,
    this.blurIntensity,
    this.borderRadius,
    this.gradient,
    this.backgroundColor,
    this.enableShimmer = true,
    this.isLoading = false,
    this.loadingColor,
  });

  final VoidCallback? onPressed;
  final Widget child;
  final double? width;
  final double? height;
  final EdgeInsetsGeometry? padding;
  final double? blurIntensity;
  final double? borderRadius;
  final Gradient? gradient;
  final Color? backgroundColor;
  final bool enableShimmer;
  final bool isLoading;
  final Color? loadingColor;

  @override
  State<AGGlassButton> createState() => _AGGlassButtonState();
}

class _AGGlassButtonState extends State<AGGlassButton>
    with TickerProviderStateMixin {
  late AnimationController _shimmerController;
  late AnimationController _pressController;
  late Animation<double> _shimmerAnimation;

  bool _isPressed = false;
  bool _isHovering = false;

  @override
  void initState() {
    super.initState();

    // Shimmer animation
    _shimmerController = AnimationController(
      vsync: this,
      duration: AGAnimations.durationContinuous,
    );

    _shimmerAnimation = AGAnimations.getShimmerAnimation(_shimmerController);

    if (widget.enableShimmer && !widget.isLoading) {
      _shimmerController.repeat();
    }

    // Press animation
    _pressController = AnimationController(
      vsync: this,
      duration: AGAnimations.durationFast,
    );
  }

  @override
  void didUpdateWidget(AGGlassButton oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (widget.isLoading != oldWidget.isLoading) {
      if (widget.isLoading) {
        _shimmerController.stop();
      } else if (widget.enableShimmer) {
        _shimmerController.repeat();
      }
    }
  }

  @override
  void dispose() {
    _shimmerController.dispose();
    _pressController.dispose();
    super.dispose();
  }

  void _handleTapDown(TapDownDetails details) {
    if (widget.onPressed != null && !widget.isLoading) {
      if (AGPlatformAdapter.supportsHaptics) {
        HapticFeedback.lightImpact();
      }

      setState(() {
        _isPressed = true;
      });

      _pressController.forward();
    }
  }

  void _handleTapUp(TapUpDetails details) {
    setState(() {
      _isPressed = false;
    });

    _pressController.reverse();
  }

  void _handleTapCancel() {
    setState(() {
      _isPressed = false;
    });

    _pressController.reverse();
  }

  void _handleHoverEnter(PointerEnterEvent event) {
    if (AGPlatformAdapter.supportsHover && widget.onPressed != null) {
      setState(() {
        _isHovering = true;
      });
    }
  }

  void _handleHoverExit(PointerExitEvent event) {
    setState(() {
      _isHovering = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDisabled = widget.onPressed == null;

    final effectivePadding =
        widget.padding ??
        AGPlatformAdapter.getAdaptivePadding(horizontal: 24, vertical: 12);

    final effectiveRadius = widget.borderRadius ?? AGEffects.radiusMedium;

    // Determine button color/gradient
    Gradient? buttonGradient = widget.gradient;
    Color? buttonColor = widget.backgroundColor;

    if (buttonGradient == null && buttonColor == null) {
      // Default glass gradient
      buttonGradient = LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [
          AGColors.glassPrimary.withOpacity(0.3),
          AGColors.glassPrimary.withOpacity(0.15),
        ],
      );
    }

    Widget buttonChild = widget.child;

    // Show loading spinner if loading
    if (widget.isLoading) {
      buttonChild = SizedBox(
        width: 20,
        height: 20,
        child: CircularProgressIndicator(
          strokeWidth: 2,
          valueColor: AlwaysStoppedAnimation(
            widget.loadingColor ?? theme.colorScheme.onPrimary,
          ),
        ),
      );
    }

    // Build base glass button
    Widget button = AGGlassContainer(
      width: widget.width,
      height: widget.height,
      padding: effectivePadding,
      blurIntensity: widget.blurIntensity ?? AGEffects.blurLight,
      borderRadius: effectiveRadius,
      gradient: buttonGradient,
      backgroundColor: buttonColor,
      elevation: _isPressed ? 0.5 : (_isHovering ? 1.5 : 1.0),
      floatingShadow: !isDisabled,
      child: Center(child: buttonChild),
    );

    // Add shimmer overlay
    if (widget.enableShimmer && !widget.isLoading && !isDisabled) {
      button = Stack(
        children: [
          button,
          Positioned.fill(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(effectiveRadius),
              child: AnimatedBuilder(
                animation: _shimmerAnimation,
                builder: (context, child) {
                  return Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment(_shimmerAnimation.value - 1, -0.3),
                        end: Alignment(_shimmerAnimation.value, 0.3),
                        colors: [
                          Colors.transparent,
                          Colors.white.withOpacity(0.1),
                          Colors.transparent,
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      );
    }

    // Add hover color overlay
    if (_isHovering && !isDisabled) {
      button = Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(effectiveRadius),
          color: AGColors.hoverOverlay,
        ),
        child: button,
      );
    }

    // Wrap with gesture detector
    button = GestureDetector(
      onTap: widget.isLoading ? null : widget.onPressed,
      onTapDown: _handleTapDown,
      onTapUp: _handleTapUp,
      onTapCancel: _handleTapCancel,
      child: button,
    );

    // Add mouse region for desktop hover
    if (AGPlatformAdapter.supportsHover) {
      button = MouseRegion(
        onEnter: _handleHoverEnter,
        onExit: _handleHoverExit,
        cursor: isDisabled
            ? SystemMouseCursors.forbidden
            : SystemMouseCursors.click,
        child: button,
      );
    }

    // Add scale animation
    button = AnimatedScale(
      scale: _isPressed ? AGEffects.pressScale : 1.0,
      duration: AGAnimations.durationFast,
      curve: AGAnimations.easeOutSmooth,
      child: button,
    );

    // Add opacity for disabled state
    if (isDisabled) {
      button = Opacity(opacity: 0.5, child: button);
    }

    return button;
  }
}
