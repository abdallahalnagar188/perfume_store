import 'package:carousel_slider/carousel_slider.dart';
import 'package:ecommerce_store/common/widgets/custom_shapes/containers/circular_container.dart';
import 'package:ecommerce_store/common/widgets/shimmer/vertical_product_shimmer.dart';
import 'package:ecommerce_store/features/shop/controllers/home_controllers.dart';
import 'package:ecommerce_store/features/shop/controllers/product/product_controller.dart';
import 'package:ecommerce_store/features/shop/screens/all_products/all_products_screen.dart';
import 'package:ecommerce_store/features/shop/screens/home/widgets/home_appbar.dart';
import 'package:ecommerce_store/features/shop/screens/home/widgets/home_category.dart';
import 'package:ecommerce_store/features/shop/screens/home/widgets/promo_slider.dart';
import 'package:ecommerce_store/utils/constants/colors.dart';
import 'package:ecommerce_store/utils/constants/sizes.dart';
import 'package:ecommerce_store/utils/device/device_utility.dart';
import 'package:ecommerce_store/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
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
    final homeController = Get.put(ProductController());
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
                        SizedBox(height: TSizes.spaceBtwSections),
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
                  TPromoSlider(),
                  const SizedBox(height: TSizes.spaceBtwSections),
                  TSectionHeading(
                    title: 'Popular Products',
                    showActionButton: true,
                    textColor: THelperFunctions.isDarkMode(context)
                        ? TColors.white
                        : TColors.black,
                    onPressed: () => Get.to(() =>  AllProductsScreen()),
                  ),
                  SizedBox(height: TSizes.spaceBtwItems),

                  /// Popular Products
                  Obx(() {
                    if (homeController.isLoading.value) {
                      return const TVerticalProductShimmer();
                    }
                    if (homeController.featuredProducts.isEmpty) {
                      return const Center(child: Text('No data found'));
                    } else {
                      return TGridLayout(
                        itemCount: homeController.featuredProducts.length,
                        itemBuilder: (_, index) => TProductCardVertical(
                          productModel: homeController.featuredProducts[index],
                        ),
                      );
                    }
                  }),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
