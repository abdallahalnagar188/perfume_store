import 'package:carousel_slider/carousel_slider.dart';
import 'package:ecommerce_store/common/widgets/custom_shapes/containers/circular_container.dart';
import 'package:ecommerce_store/features/shop/screens/home/widgets/home_appbar.dart';
import 'package:ecommerce_store/features/shop/screens/home/widgets/home_category.dart';
import 'package:ecommerce_store/features/shop/screens/home/widgets/promo_slider.dart';
import 'package:ecommerce_store/utils/constants/colors.dart';
import 'package:ecommerce_store/utils/constants/sizes.dart';
import 'package:ecommerce_store/utils/device/device_utility.dart';
import 'package:ecommerce_store/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import '../../../../common/widgets/custom_shapes/containers/primary_header_container.dart';
import '../../../../common/widgets/custom_shapes/containers/search_container.dart';
import '../../../../common/widgets/image_text_category_widgets/category_item.dart';
import '../../../../common/widgets/layouts/grid_layout.dart';
import '../../../../common/widgets/products/products_cards/product_card_vertical.dart';
import '../../../../common/widgets/texts/section_heading.dart';
import '../../../../utils/constants/image_strings.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            ///Header
             const TPrimaryHeaderContainer(
              child: Column(
                children: [
                  /// Appbar
                  THomeAppbar(),
                  SizedBox(height: TSizes.spaceBtwSections),

                  ///Searchbar
                  TSearchContainer(text: 'Search in Store'),
                  SizedBox(height: TSizes.spaceBtwSections),

                  /// Heading
                  Padding(
                    padding: EdgeInsets.only(left: TSizes.defaultSpace),
                    child: Column(
                      children: [
                        TSectionHeading(
                          title: 'Popular Categories',
                          showActionButton: false,
                          textColor: TColors.white,
                        ),
                        SizedBox(height: TSizes.spaceBtwItems),

                        /// Category
                        THomeCategory(),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            /// Body
            Padding(
              padding: const EdgeInsets.all(TSizes.defaultSpace),
              child: Column(
                children: [
                  /// Slider
                  TPromoSlider(
                    banners: [
                      TImages.promoBanner1,
                      TImages.promoBanner2,
                      TImages.promoBanner3,
                    ],
                  ),
                  const SizedBox(height: TSizes.spaceBtwSections),
                  TSectionHeading(
                    title: 'Popular Categories',
                    showActionButton: true,
                    textColor: THelperFunctions.isDarkMode(context)?TColors.white:TColors.black,
                    onPressed: (){},
                  ),
                  SizedBox(height: TSizes.spaceBtwItems),

                  /// Popular Products
                  TGridLayout(itemCount: 2, itemBuilder: (_ , index ) => const TProductCardVertical(),),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

