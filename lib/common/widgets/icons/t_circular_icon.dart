import 'package:flutter/material.dart';
import 'package:ecommerce_store/utils/helpers/helper_functions.dart';
import '../../../features/antigravity/antigravity.dart';

class TCircularIcon extends StatelessWidget {
  const TCircularIcon({
    super.key,
    this.width,
    this.height,
    this.size = 56,
    required this.icon,
    this.color,
    this.backgroundColor,
    this.onPressed,
    this.enableGlassEffect = true,
  });

  final double? width, height, size;
  final IconData icon;
  final Color? color;
  final Color? backgroundColor;
  final VoidCallback? onPressed;
  final bool enableGlassEffect;

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);

    // Use AGGlassIcon if glass effect is enabled
    if (enableGlassEffect) {
      return AGGlassIcon(
        icon: icon,
        size: size ?? width ?? height ?? 56,
        iconColor: color,
        backgroundColor: backgroundColor,
        onTap: onPressed,
      );
    }

    // Fallback to original implementation
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(100),
        color:
            backgroundColor ??
            (dark
                ? Colors.white.withOpacity(0.9)
                : Colors.black.withOpacity(0.9)),
      ),
      child: IconButton(
        onPressed: onPressed,
        icon: Icon(icon, color: color, size: size),
      ),
    );
  }
}
