import 'package:ecommerce_store/common/widgets/image/t_rounded_image.dart';
import 'package:ecommerce_store/features/shop/models/cart_item_model.dart';
import 'package:flutter/material.dart';

import '../../../../utils/constants/colors.dart';
import '../../../../utils/constants/image_strings.dart';
import '../../../../utils/constants/sizes.dart';
import '../../../../utils/helpers/helper_functions.dart';
import '../../texts/product_title_text.dart';
import '../../texts/t_brand_title_with_verified_icon.dart';

class TCartItem extends StatelessWidget {
  const TCartItem({super.key, required this.cartItem});

  final CartItemModel cartItem;

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);

    return Row(
      children: [
        /// Image
        TRoundedImage(
          imageUrl: cartItem.image ?? '',
          height: 60,
          width: 60,
          isNetworkImage: true,
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
              TBrandTitleWithVerifiedIcon(title: cartItem.brandName ?? ""),
              Flexible(
                child: TProductTitleText(text: cartItem.title, maxLines: 1),
              ),

              /// Attributes
              Text.rich(
                TextSpan(
                  children: (cartItem.selectedVariation ?? {}).entries
                      .expand<TextSpan>((e) => [
                    TextSpan(
                      text: '${e.key}: ',
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                    TextSpan(
                      text: '${e.value}  ',
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                  ])
                      .toList(),
                ),
              ),

            ],
          ),
        ),
      ],
    );
  }
}
