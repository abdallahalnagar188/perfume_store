import 'package:ecommerce_store/common/widgets/layouts/grid_layout.dart';
import 'package:ecommerce_store/common/widgets/products/products_cards/product_card_vertical.dart';
import 'package:ecommerce_store/common/widgets/texts/section_heading.dart';
import 'package:ecommerce_store/features/shop/models/category_model.dart';
import 'package:flutter/material.dart';

import '../../../../../common/widgets/brands/brand_show_case.dart';
import '../../../../../utils/constants/image_strings.dart';
import '../../../../../utils/constants/sizes.dart';
import '../../../models/product_model.dart';

class TCategoryTab extends StatelessWidget {
  const TCategoryTab({super.key, required this.categoryModel});

  final CategoryModel categoryModel;

  @override
  Widget build(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      children:[ Padding(
        padding: EdgeInsets.all(TSizes.defaultSpace),
        child: Column(
          children: [
            /// Brands
            TBrandShowcase(images: [TImages.productImage3, TImages.productImage1, TImages.productImage4,],),
            TBrandShowcase(images: [TImages.productImage40, TImages.productImage41, TImages.productImage42,],),
            SizedBox(height: TSizes.spaceBtwItems,),

            /// Products You may like
            TSectionHeading(title: 'You might like',showActionButton: true,onPressed: (){},),
            SizedBox(height: TSizes.spaceBtwItems,),
            TGridLayout(itemCount: 4, itemBuilder: (_,index) => TProductCardVertical(productModel: ProductModel.empty(),))
          ],
        ),
      ),]
    );
  }
}
