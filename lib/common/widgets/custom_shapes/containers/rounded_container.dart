import 'package:ecommerce_store/utils/constants/colors.dart';
import 'package:ecommerce_store/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import '../../../../features/antigravity/widgets/ag_glass_container.dart';

class TRoundedContainer extends StatelessWidget {
  const TRoundedContainer({
    super.key,
    this.width,
    this.height,
    this.radius = TSizes.cardRadiusLg,
    this.child,
    this.showBorder = false,
    this.borderColor = TColors.borderPrimary,
    this.backgroundColor = TColors.white,
    this.margin,
    this.padding,
    this.enableGlassEffect = true, // New parameter for glass effect
  });

  final double? width, height;
  final double radius;
  final Widget? child;
  final bool showBorder;
  final Color borderColor;
  final Color backgroundColor;
  final EdgeInsetsGeometry? margin;
  final EdgeInsetsGeometry? padding;
  final bool enableGlassEffect; // Enable/disable glass effect

  @override
  Widget build(BuildContext context) {
    // If glass effect is enabled, use AGGlassContainer
    if (enableGlassEffect) {
      return AGGlassContainer(
        width: width,
        height: height,
        borderRadius: radius,
        margin: margin,
        padding: padding,
        borderColor: showBorder ? borderColor : null,
        borderWidth: showBorder ? 1.0 : 0.0,
        backgroundColor: backgroundColor.withOpacity(0.15),
        enableGlassEffect: true,
        child: child ?? const SizedBox.shrink(),
      );
    }

    // Fallback to original implementation if glass effect is disabled
    return Container(
      width: width,
      height: height,
      padding: padding,
      margin: margin,
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(radius),
        border: showBorder ? Border.all(color: borderColor) : null,
      ),
      child: child,
    );
  }
}
