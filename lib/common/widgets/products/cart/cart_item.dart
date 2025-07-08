
import 'package:ecommerce_store/common/widgets/image/t_rounded_image.dart';
import 'package:flutter/material.dart';

import '../../../../utils/constants/colors.dart';
import '../../../../utils/constants/image_strings.dart';
import '../../../../utils/constants/sizes.dart';
import '../../../../utils/helpers/helper_functions.dart';
import '../../texts/product_title_text.dart';
import '../../texts/t_brand_title_with_verified_icon.dart';

class TCartItem extends StatelessWidget {
  const TCartItem({
    super.key,
  });


  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);

    return Row(
      children: [
        /// Image
        TRoundedImage(
          imageUrl: TImages.productImage1,
          height: 60,
          width: 60,
          padding: EdgeInsets.all(TSizes.sm),
          backgroundColor: dark ? TColors.darkerGrey : TColors.light,
        ),
        const SizedBox(width: TSizes.spaceBtwItems),

        /// Title and price and size
        Expanded(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const   TBrandTitleWithVerifiedIcon(title: 'Nike'),
              Flexible(child: const  TProductTitleText(text: 'Black Sport shoes', maxLines: 1,)),

              /// Attributes
              Text.rich(TextSpan(
                  children: [
                    TextSpan(text: 'Color',style: Theme.of(context).textTheme.bodySmall),
                    TextSpan(text: 'Green',style: Theme.of(context).textTheme.bodySmall),
                    TextSpan(text: 'Size',style: Theme.of(context).textTheme.bodySmall),
                    TextSpan(text: 'UK 08',style: Theme.of(context).textTheme.bodySmall),
                  ]
              ))
            ],
          ),
        )
      ],
    );
  }
}