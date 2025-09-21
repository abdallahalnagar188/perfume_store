import 'package:ecommerce_store/common/widgets/appbar/appbar.dart';
import 'package:ecommerce_store/common/widgets/image/t_rounded_image.dart';
import 'package:ecommerce_store/common/widgets/products/products_cards/product_card_horizontal.dart';
import 'package:ecommerce_store/common/widgets/shimmer/horizontal_product_shimmer.dart';
import 'package:ecommerce_store/common/widgets/texts/section_heading.dart';
import 'package:ecommerce_store/features/shop/controllers/category_controller.dart';
import 'package:ecommerce_store/features/shop/screens/all_products/all_products_screen.dart';
import 'package:ecommerce_store/utils/constants/image_strings.dart';
import 'package:ecommerce_store/utils/constants/sizes.dart';
import 'package:ecommerce_store/utils/helpers/cloud_helper_functions.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../models/category_model.dart';

class SubCategoriesScreen extends StatelessWidget {
  const SubCategoriesScreen({super.key, required this.category});

  final CategoryModel category;

  @override
  Widget build(BuildContext context) {
    final controller = CategoryController.instance;
    return Scaffold(
      appBar: TAppbar(
        title: Text(
          category.name,
          style: Theme.of(context).textTheme.headlineSmall,
        ),
        showBackArrow: true,
      ),

      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(TSizes.defaultSpace),
          child: Column(
            children: [
              // /// Banner
              // TRoundedImage(
              //   imageUrl: TImages.banner3,
              //   width: double.infinity,
              //   height: null,
              //   applyImageRadius: true,
              // ),
              // const SizedBox(height: TSizes.spaceBtwSections),

              /// sub category
              FutureBuilder(
                future: controller.getSubCategories(category.id),
                builder: (context, asyncSnapshot) {
                  /// handel loader and no record and error message
                  const loader = THorizontalProductShimmer();
                  final widget = TCloudHelperFunctions.checkMultiRecordState(
                    snapshot: asyncSnapshot,
                    loader: loader,
                  );
                  if (widget != null) return widget;

                  final subCategories = asyncSnapshot.data!;

                  return ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: subCategories.length,
                    itemBuilder: (_, index) {
                      final subCategory = subCategories[index];
                      return FutureBuilder(
                        future: controller.getCategoryProducts(categoryId: subCategory.id,),
                        builder: (context, asyncSnapshot) {

                          const loader = THorizontalProductShimmer();
                          final widget = TCloudHelperFunctions.checkMultiRecordState(
                            snapshot: asyncSnapshot,
                            loader: loader,
                          );
                          if (widget != null) return widget;

                          final products = asyncSnapshot.data!;
                          debugPrint("Products for ${subCategory.name} (${subCategory.id}): ${products.length}");


                          return Column(
                            children: [
                              /// Heading
                              TSectionHeading(
                                title: subCategory.name,
                                onPressed: () => Get.to(
                                  () => AllProductsScreen(
                                    title: subCategory.name,
                                    futureMethod: controller.getCategoryProducts(
                                      categoryId: subCategory.id,
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(height: TSizes.spaceBtwItems / 2),

                              SizedBox(
                                height: 120,
                                child: ListView.separated(
                                  scrollDirection: Axis.horizontal,
                                  itemCount: products.length,
                                  separatorBuilder: (_, __) =>
                                      const SizedBox(width: TSizes.spaceBtwItems),
                                  itemBuilder: (_, index) =>
                                      TProductCardHorizontal(product: products[index],),
                                ),
                              ),

                              const SizedBox(height: TSizes.spaceBtwSections,)
                            ],
                          );
                        }
                      );
                    },
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
