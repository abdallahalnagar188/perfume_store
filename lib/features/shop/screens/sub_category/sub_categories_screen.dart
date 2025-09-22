import 'package:ecommerce_store/common/widgets/appbar/appbar.dart';
import 'package:ecommerce_store/common/widgets/layouts/grid_layout.dart';
import 'package:ecommerce_store/common/widgets/products/products_cards/product_card_vertical.dart';
import 'package:ecommerce_store/common/widgets/shimmer/vertical_product_shimmer.dart';
import 'package:ecommerce_store/common/widgets/texts/section_heading.dart';
import 'package:ecommerce_store/features/shop/controllers/category_controller.dart';
import 'package:ecommerce_store/features/shop/models/category_model.dart';
import 'package:ecommerce_store/features/shop/screens/all_products/all_products_screen.dart';
import 'package:ecommerce_store/utils/constants/sizes.dart';
import 'package:ecommerce_store/utils/helpers/cloud_helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

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
          padding: const EdgeInsets.all(TSizes.defaultSpace),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// Fetch subcategories first
              FutureBuilder(
                future: controller.getSubCategories(category.id),
                builder: (context, subCategorySnapshot) {
                  final subCategoryWidget =
                  TCloudHelperFunctions.checkMultiRecordState(
                    snapshot: subCategorySnapshot,
                    loader: const TVerticalProductShimmer(),
                  );
                  if (subCategoryWidget != null) return subCategoryWidget;

                  final subCategories = subCategorySnapshot.data!;

                  return ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: subCategories.length,
                    itemBuilder: (_, index) {
                      final subCategory = subCategories[index];

                      return FutureBuilder(
                        future: controller.getCategoryProducts(
                          categoryId: subCategory.id,
                        ),
                        builder: (context, productSnapshot) {
                          final productWidget =
                          TCloudHelperFunctions.checkMultiRecordState(
                            snapshot: productSnapshot,
                            loader: const TVerticalProductShimmer(),
                          );
                          if (productWidget != null) return productWidget;

                          final products = productSnapshot.data!;

                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              /// Subcategory heading with "View All"
                              TSectionHeading(
                                title: subCategory.name,
                                buttonTitle: 'viewAll'.tr,
                                showActionButton: true,
                                onPressed: () => Get.to(
                                      () => AllProductsScreen(
                                    title: subCategory.name,
                                    futureMethod: controller.getCategoryProducts(
                                      categoryId: subCategory.id,
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(height: TSizes.spaceBtwItems),

                              /// Grid of products
                              TGridLayout(
                                itemCount: products.length,
                                itemBuilder: (_, index) =>
                                    TProductCardVertical(
                                      productModel: products[index],
                                    ),
                              ),
                              const SizedBox(height: TSizes.spaceBtwSections),
                            ],
                          );
                        },
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
