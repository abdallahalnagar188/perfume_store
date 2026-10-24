import 'dart:ui';
import 'package:flutter/material.dart';
import '../constants/ag_colors.dart';
import '../constants/ag_effects.dart';
import '../utils/platform_adapter.dart';

/// AGGlassAppBar - Transparent Floating App Bar with Blur
/// Blur intensifies on scroll, creating depth perception
class AGGlassAppBar extends StatelessWidget implements PreferredSizeWidget {
  const AGGlassAppBar({
    super.key,
    this.title,
    this.leading,
    this.actions,
    this.showBackButton = false,
    this.onBackPressed,
    this.backgroundColor,
    this.blurIntensity,
    this.scrollOffset = 0.0,
    this.centerTitle = true,
  });

  final Widget? title;
  final Widget? leading;
  final List<Widget>? actions;
  final bool showBackButton;
  final VoidCallback? onBackPressed;
  final Color? backgroundColor;
  final double? blurIntensity;

  /// Current scroll offset (0.0 - 1.0) to control blur intensity
  /// 0.0 = no blur, 1.0 = full blur
  final double scrollOffset;

  final bool centerTitle;

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    // Calculate blur based on scroll offset
    final baseBlur = blurIntensity ?? AGEffects.blurMedium;
    final currentBlur = baseBlur * scrollOffset.clamp(0.0, 1.0);

    // Calculate opacity based on scroll
    final baseOpacity = isDark ? 0.15 : 0.1;
    final currentOpacity = baseOpacity + (0.1 * scrollOffset.clamp(0.0, 1.0));

    // Build leading widget
    Widget? effectiveLeading = leading;
    if (showBackButton && leading == null) {
      effectiveLeading = IconButton(
        icon: Icon(AGPlatformAdapter.backIcon),
        onPressed: onBackPressed ?? () => Navigator.of(context).pop(),
        tooltip: 'Back',
      );
    }

    // App bar content
    final appBar = AppBar(
      automaticallyImplyLeading: false,
      leading: effectiveLeading,
      title: title,
      centerTitle: centerTitle,
      actions: actions,
      backgroundColor: Colors.transparent,
      elevation: 0,
      scrolledUnderElevation: 0,
      surfaceTintColor: Colors.transparent,
    );

    // Wrap with glass effect
    return ClipRect(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: currentBlur, sigmaY: currentBlur),
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                (backgroundColor ??
                        AGColors.getGlassBackground(theme.brightness))
                    .withOpacity(currentOpacity),
                (backgroundColor ??
                        AGColors.getGlassBackground(theme.brightness))
                    .withOpacity(currentOpacity * 0.7),
              ],
            ),
            border: Border(
              bottom: BorderSide(
                color: AGColors.getGlassBorder(theme.brightness, opacity: 0.1),
                width: scrollOffset > 0.1 ? 0.5 : 0,
              ),
            ),
            boxShadow: scrollOffset > 0.3
                ? AGEffects.getFloatingShadow(isDark: isDark, elevation: 0.5)
                : null,
          ),
          child: appBar,
        ),
      ),
    );
  }
}

/// AGScrollAwareGlassAppBar - Glass AppBar that responds to scroll position
/// Automatically increases blur as user scrolls
class AGScrollAwareGlassAppBar extends StatefulWidget {
  const AGScrollAwareGlassAppBar({
    super.key,
    this.title,
    this.leading,
    this.actions,
    this.showBackButton = false,
    this.onBackPressed,
    this.backgroundColor,
    this.blurIntensity,
    this.centerTitle = true,
    required this.scrollController,
    this.maxScrollExtent = 100.0,
  });

  final Widget? title;
  final Widget? leading;
  final List<Widget>? actions;
  final bool showBackButton;
  final VoidCallback? onBackPressed;
  final Color? backgroundColor;
  final double? blurIntensity;
  final bool centerTitle;
  final ScrollController scrollController;

  /// Maximum scroll distance to reach full blur effect
  final double maxScrollExtent;

  @override
  State<AGScrollAwareGlassAppBar> createState() =>
      _AGScrollAwareGlassAppBarState();
}

class _AGScrollAwareGlassAppBarState extends State<AGScrollAwareGlassAppBar> {
  double _scrollOffset = 0.0;

  @override
  void initState() {
    super.initState();
    widget.scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    widget.scrollController.removeListener(_onScroll);
    super.dispose();
  }

  void _onScroll() {
    final offset = widget.scrollController.offset;
    final normalizedOffset = (offset / widget.maxScrollExtent).clamp(0.0, 1.0);

    if ((_scrollOffset - normalizedOffset).abs() > 0.01) {
      setState(() {
        _scrollOffset = normalizedOffset;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return AGGlassAppBar(
      title: widget.title,
      leading: widget.leading,
      actions: widget.actions,
      showBackButton: widget.showBackButton,
      onBackPressed: widget.onBackPressed,
      backgroundColor: widget.backgroundColor,
      blurIntensity: widget.blurIntensity,
      centerTitle: widget.centerTitle,
      scrollOffset: _scrollOffset,
    );
  }
}
