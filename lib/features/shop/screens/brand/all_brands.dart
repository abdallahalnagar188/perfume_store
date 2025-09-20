import 'package:ecommerce_store/common/widgets/brands/brand_card.dart';
import 'package:ecommerce_store/common/widgets/layouts/grid_layout.dart';
import 'package:ecommerce_store/common/widgets/products/sortable_products/sortable_products.dart';
import 'package:ecommerce_store/common/widgets/texts/section_heading.dart';
import 'package:ecommerce_store/features/shop/controllers/brand_controller.dart';
import 'package:ecommerce_store/features/shop/models/brand_model.dart';
import 'package:ecommerce_store/features/shop/screens/brand/brand_products.dart';
import 'package:ecommerce_store/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../../../common/widgets/appbar/appbar.dart';
import '../../../../common/widgets/shimmer/brands_shimmer.dart';

class AllBrandsScreen extends StatelessWidget {
  const AllBrandsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final brandController = BrandController.instance;
    return Scaffold(
      appBar: TAppbar(
        title: Text('brands'.tr, style: Theme.of(context).textTheme.headlineSmall),
        showBackArrow: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(TSizes.defaultSpace),
          child: Column(
            children: [
              /// Heading
              TSectionHeading(title: 'brands'.tr, showActionButton: false),
              const SizedBox(height: TSizes.spaceBtwItems),

              /// Brands
              Obx(() {
                if (brandController.isLoading.value) {
                  return const TBrandsShimmer(itemCount: 6);
                }
                if (brandController.allBrands.isEmpty) {
                  return Center(
                    child: Text(
                      'No data found'.tr,
                      style: Theme.of(
                        context,
                      ).textTheme.bodyMedium!.apply(color: Colors.white),
                    ),
                  );
                }

                return TGridLayout(
                  mainAxisExtent: 80,
                  itemCount: brandController.allBrands.length,
                  itemBuilder: (_, index) {
                    final brand = brandController.allBrands[index];
                    return TBrandCard(
                      showBorder: true,
                      brand: brand,
                      onTap: () => Get.to(() => BrandProducts(brand: brand)),
                    );
                  },
                );
              }),
            ],
          ),
        ),
      ),
    );
  }
}
