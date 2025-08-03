import 'package:ecommerce_store/common/widgets/brands/brand_card.dart';
import 'package:ecommerce_store/common/widgets/products/sortable_products/sortable_products.dart';
import 'package:ecommerce_store/common/widgets/shimmer/vertical_product_shimmer.dart';
import 'package:ecommerce_store/features/shop/controllers/brand_controller.dart';
import 'package:ecommerce_store/features/shop/models/product_model.dart';
import 'package:ecommerce_store/utils/constants/sizes.dart';
import 'package:ecommerce_store/utils/helpers/cloud_helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../../../common/widgets/appbar/appbar.dart';
import '../../models/brand_model.dart';

class BrandProducts extends StatelessWidget {
  const BrandProducts({super.key, required this.brand});

  final BrandModel brand;
  @override
  Widget build(BuildContext context) {
    final controller  = Get.put(BrandController());
    return Scaffold(
      appBar: TAppbar(
        title: Text(brand.name, style: Theme.of(context).textTheme.headlineSmall),
        showBackArrow: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(TSizes.defaultSpace),
          child: Column(
            children: [
              /// Brand Details
              TBrandCard(showBorder: true, brand: brand),
              const SizedBox(height: TSizes.spaceBtwSections),

              FutureBuilder(
                future: controller.getBrandProducts(brand.id),
                builder: (context, asyncSnapshot) {
                  const loader = TVerticalProductShimmer();
                  final widget  = TCloudHelperFunctions.checkMultiRecordState(snapshot: asyncSnapshot,loader: loader);
                  if(widget != null) return widget;

                  final brandProducts = asyncSnapshot.data!;
                  return TSortableProducts(products:brandProducts);
                }
              ),
            ],
          ),
        ),
      ),
    );
  }
}
