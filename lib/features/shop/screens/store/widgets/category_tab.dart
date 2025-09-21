import 'package:ecommerce_store/common/widgets/layouts/grid_layout.dart';
import 'package:ecommerce_store/common/widgets/products/products_cards/product_card_vertical.dart';
import 'package:ecommerce_store/common/widgets/shimmer/vertical_product_shimmer.dart';
import 'package:ecommerce_store/common/widgets/texts/section_heading.dart';
import 'package:ecommerce_store/features/shop/controllers/category_controller.dart';
import 'package:ecommerce_store/features/shop/models/category_model.dart';
import 'package:ecommerce_store/features/shop/screens/all_products/all_products_screen.dart';
import 'package:ecommerce_store/features/shop/screens/store/widgets/category_brands.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import '../../../../../utils/constants/sizes.dart';
import '../../../../../utils/helpers/cloud_helper_functions.dart';

class TCategoryTab extends StatelessWidget {
  const TCategoryTab({super.key, required this.categoryModel});

  final CategoryModel categoryModel;

  @override
  Widget build(BuildContext context) {
    final controller = CategoryController.instance;
    return ListView(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      children: [
        Padding(
          padding: EdgeInsets.all(TSizes.defaultSpace),
          child: Column(
            children: [
              /// Brands
              CategoryBrands(category: categoryModel),
              SizedBox(height: TSizes.spaceBtwItems),

              /// Products You may like
              FutureBuilder(
                future: controller.getCategoryProducts(
                  categoryId: categoryModel.id,
                ),
                builder: (context, snapshot) {
                  final widget = TCloudHelperFunctions.checkMultiRecordState(
                    snapshot: snapshot,
                    loader: TVerticalProductShimmer(),
                  );

                  if (widget != null) return widget;

                  final products = snapshot.data!;
                  return Column(
                    children: [
                      TSectionHeading(
                        title: 'you might like'.tr,
                        buttonTitle: 'viewAll'.tr,
                        showActionButton: true,
                        onPressed: () => Get.to(
                          AllProductsScreen(
                            title: categoryModel.name,
                            futureMethod: controller.getCategoryProducts(
                              categoryId: categoryModel.id,

                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: TSizes.spaceBtwItems),
                      TGridLayout(
                        itemCount: products.length,
                        itemBuilder: (_, index) =>
                            TProductCardVertical(productModel: products[index]),
                      ),
                    ],
                  );
                },
              ),
            ],
          ),
        ),
      ],
    );
  }
}
