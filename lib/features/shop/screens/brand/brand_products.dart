import 'package:ecommerce_store/common/widgets/brands/brand_card.dart';
import 'package:ecommerce_store/common/widgets/products/sortable_products/sortable_products.dart';
import 'package:ecommerce_store/features/shop/models/product_model.dart';
import 'package:ecommerce_store/utils/constants/sizes.dart';
import 'package:flutter/material.dart';

import '../../../../common/widgets/appbar/appbar.dart';

class BrandProducts extends StatelessWidget {
  const BrandProducts({super.key});


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TAppbar(
        title: Text('Nike', style: Theme.of(context).textTheme.headlineSmall),
        showBackArrow: true,
      ),
      body: SingleChildScrollView(
        child: Padding(padding: EdgeInsets.all(TSizes.defaultSpace),child: Column(
          children: [
            /// Brand Details
            TBrandCard(showBorder: true,),
            const SizedBox(height: TSizes.spaceBtwSections,),

            TSortableProducts(products: [],),
          ],
        ),),
      ),
    );
  }
}
