import 'package:cached_network_image/cached_network_image.dart';
import 'package:ecommerce_store/common/widgets/shimmer/shimmer.dart';
import 'package:ecommerce_store/features/shop/screens/brand/brand_products.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../../features/shop/models/brand_model.dart';
import '../../../utils/constants/colors.dart';
import '../../../utils/constants/sizes.dart';
import '../../../utils/helpers/helper_functions.dart';
import '../custom_shapes/containers/rounded_container.dart';
import 'brand_card.dart';

class TBrandShowcase extends StatelessWidget {
  const TBrandShowcase({super.key, required this.images, required this.brand});

  final BrandModel brand;
  final List<String> images;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap:()=> Get.to(() => BrandProducts(brand: brand)),
      child: TRoundedContainer(
        showBorder: true,
        borderColor: TColors.darkGrey,
        backgroundColor: Colors.transparent,
        margin: EdgeInsets.only(bottom: TSizes.spaceBtwItems),
        padding: EdgeInsets.all(TSizes.md),
        child: Column(
          children: [
            /// Brand with product count
            TBrandCard(showBorder: false, brand: brand),

            /// Brand with 3 Product image
            Row(
              children: images
                  .map((image) => brandTopProductImageWidget(image, context))
                  .toList(),
            ),
          ],
        ),
      ),
    );
  }

  Widget brandTopProductImageWidget(String image, context) {
    return Expanded(
      child: TRoundedContainer(
        height: 100,
        backgroundColor: THelperFunctions.isDarkMode(context)
            ? TColors.darkerGrey
            : TColors.light,
        margin: EdgeInsets.only(right: TSizes.sm),
        padding: EdgeInsets.all(TSizes.md),
        child:  CachedNetworkImage(
          fit: BoxFit.contain,
            progressIndicatorBuilder: (context,url,downloadProgress) => const TShimmerEffect(width: 100, height: 100),
            errorWidget: (context,url,error) => const Icon(Icons.error),
            imageUrl:image
            ),
      ),
    );
  }
}
