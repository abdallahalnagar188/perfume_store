import 'package:ecommerce_store/utils/constants/enums.dart';
import 'package:ecommerce_store/utils/constants/sizes.dart';
import 'package:ecommerce_store/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import '../../../utils/constants/colors.dart';
import '../../../features/antigravity/antigravity.dart';

class TAppbar extends StatelessWidget implements PreferredSizeWidget {
  const TAppbar({
    super.key,
    this.title,
    this.showBackArrow = false,
    this.leadingIcon,
    this.actions,
    this.leadingOnPressed,
    this.enableGlassEffect = false, // Default false to not break existing UI
    this.scrollOffset = 0.0,
  });

  final Widget? title;
  final bool showBackArrow;
  final IconData? leadingIcon;
  final List<Widget>? actions;
  final VoidCallback? leadingOnPressed;
  final bool enableGlassEffect;
  final double scrollOffset;

  @override
  Widget build(BuildContext context) {
    // Use AGGlassAppBar if glass effect is enabled
    if (enableGlassEffect) {
      return AGGlassAppBar(
        title: title,
        showBackButton: showBackArrow,
        onBackPressed: leadingOnPressed,
        leading: leadingIcon != null
            ? IconButton(onPressed: leadingOnPressed, icon: Icon(leadingIcon))
            : null,
        actions: actions,
        scrollOffset: scrollOffset,
      );
    }

    // Original implementation
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: TSizes.md),
      child: AppBar(
        automaticallyImplyLeading: false,
        leading: showBackArrow
            ? IconButton(
                onPressed: () => Get.back(),
                icon: Icon(
                  Iconsax.arrow_right,
                  color: THelperFunctions.isDarkMode(context)
                      ? TColors.white
                      : TColors.black,
                ),
              )
            : leadingIcon != null
            ? IconButton(
                onPressed: () => leadingOnPressed,
                icon: Icon(leadingIcon),
              )
            : null,
        title: title,
        actions: actions,
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
