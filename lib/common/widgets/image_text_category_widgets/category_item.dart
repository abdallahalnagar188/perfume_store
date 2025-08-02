import 'package:ecommerce_store/common/widgets/icons/t_circular_icon.dart';
import 'package:ecommerce_store/common/widgets/image/t_circular_image.dart';
import 'package:flutter/material.dart';

import '../../../utils/constants/colors.dart';
import '../../../utils/constants/sizes.dart';
import '../../../utils/helpers/helper_functions.dart';

class TVerticalImageText extends StatelessWidget {
  const TVerticalImageText({
    super.key,
    required this.image,
    required this.title,
    this.textColor = TColors.white,
    this.backgroundColor,
    required this.onTap,
    this.isNetworkImage = true,
  });

  final String image, title;
  final Color textColor;
  final bool isNetworkImage;
  final Color? backgroundColor;
  final void Function() onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.only(right: TSizes.spaceBtwItems),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [

            /// image
            TCircularImage(image: image,
              fit: BoxFit.fitWidth,
              padding: TSizes.sm * 1.4,
              isNetworkImage: isNetworkImage,
              backgroundColor: backgroundColor,
              overlayColor: THelperFunctions.isDarkMode(context)
                  ? TColors.light
                  : TColors.dark,),

            /// Text
             SizedBox(height: 4),
            SizedBox(
              width: 55,
              child: Text(
                title,
                style: Theme
                    .of(
                  context,
                )
                    .textTheme
                    .labelMedium!
                    .apply(color: textColor),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
