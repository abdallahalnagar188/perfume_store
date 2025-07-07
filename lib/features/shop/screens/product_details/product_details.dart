import 'package:ecommerce_store/common/widgets/appbar/appbar.dart';
import 'package:ecommerce_store/common/widgets/custom_shapes/curved_edge/curved_edge_widget.dart';
import 'package:ecommerce_store/common/widgets/icons/t_circular_icon.dart';
import 'package:ecommerce_store/common/widgets/image/t_rounded_image.dart';
import 'package:ecommerce_store/features/shop/screens/product_details/widgets/product_details_image_slider.dart';
import 'package:ecommerce_store/features/shop/screens/product_details/widgets/product_meta_data.dart';
import 'package:ecommerce_store/features/shop/screens/product_details/widgets/rating_share_widget.dart';
import 'package:ecommerce_store/utils/constants/colors.dart';
import 'package:ecommerce_store/utils/constants/image_strings.dart';
import 'package:ecommerce_store/utils/constants/sizes.dart';
import 'package:ecommerce_store/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class ProductDetailsScreen extends StatelessWidget {
  const ProductDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            /// 1- Product Image Slider
            TProductImageSlider(),

            /// 2-  Product Details
            Padding(
              padding: EdgeInsets.only(
                right: TSizes.defaultSpace,
                left: TSizes.defaultSpace,
                bottom: TSizes.defaultSpace,
              ),
              child: Column(
                children: [
                  /// Rating and shareButton
                  TRatingAndShareButton(),

                  /// Price ,Title,Stoke , Brand
                  TProductMetaData(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
