import 'package:ecommerce_store/common/widgets/appbar/appbar.dart';
import 'package:ecommerce_store/common/widgets/custom_shapes/curved_edge/curved_edge_widget.dart';
import 'package:ecommerce_store/common/widgets/icons/t_circular_icon.dart';
import 'package:ecommerce_store/common/widgets/image/t_rounded_image.dart';
import 'package:ecommerce_store/common/widgets/texts/section_heading.dart';
import 'package:ecommerce_store/features/shop/screens/product_details/widgets/bottom_add_to_cart_widget.dart';
import 'package:ecommerce_store/features/shop/screens/product_details/widgets/product_attributes.dart';
import 'package:ecommerce_store/features/shop/screens/product_details/widgets/product_details_image_slider.dart';
import 'package:ecommerce_store/features/shop/screens/product_details/widgets/product_meta_data.dart';
import 'package:ecommerce_store/features/shop/screens/product_details/widgets/rating_share_widget.dart';
import 'package:ecommerce_store/features/shop/screens/product_reviews/product_reviews.dart';
import 'package:ecommerce_store/utils/constants/colors.dart';
import 'package:ecommerce_store/utils/constants/image_strings.dart';
import 'package:ecommerce_store/utils/constants/sizes.dart';
import 'package:ecommerce_store/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:iconsax/iconsax.dart';
import 'package:readmore/readmore.dart';

import '../../models/product_model.dart';

class ProductDetailsScreen extends StatelessWidget {
  const ProductDetailsScreen({super.key, required this.product});
  final ProductModel product;

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    return Scaffold(
      bottomNavigationBar: TBottomAddToCartWidget(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            /// 1- Product Image Slider
            TProductImageSlider(product: product,),

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
                  TProductMetaData(product: product,),
                  const SizedBox(height: TSizes.spaceBtwItems / 2),

                  /// Attributes
                  TProductAttributes(product: product,),
                  const SizedBox(height: TSizes.spaceBtwSections),

                  /// Checkout Button
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {},
                      child: Text('Checkout'),
                    ),
                  ),
                  const SizedBox(height: TSizes.spaceBtwSections),

                  /// Description
                  const TSectionHeading(
                    title: 'Description',
                    showActionButton: false,
                  ),
                  const SizedBox(height: TSizes.spaceBtwItems),
                  ReadMoreText(
                  product.description !,
                    trimLines: 2,
                    trimMode: TrimMode.Line,
                    trimCollapsedText: 'Show more',
                    trimExpandedText: 'Less',
                    moreStyle: const TextStyle(fontSize: 14, fontWeight: FontWeight.w800),
                    lessStyle: const TextStyle(fontSize: 14, fontWeight: FontWeight.w800),
                  ),

                  /// Reviews
                  const Divider(),
                  const SizedBox(height: TSizes.spaceBtwItems),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TSectionHeading(title: 'Reviews (199)', showActionButton: false,),
                      IconButton(onPressed: () => Get.to(() => const ProductReviewsScreen()), icon: Icon(Iconsax.arrow_right_3))
                    ],
                  ),
                  const SizedBox(height: TSizes.spaceBtwSections),

                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
