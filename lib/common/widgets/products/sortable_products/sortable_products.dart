
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../features/shop/models/product_model.dart';
import '../../../../utils/constants/sizes.dart';
import '../../layouts/grid_layout.dart';
import '../products_cards/product_card_vertical.dart';

class TSortableProducts extends StatelessWidget {
  const TSortableProducts({
    super.key,
  });


  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        /// Dropdown
        DropdownButtonFormField(
          decoration: const InputDecoration(prefixIcon:Icon( Iconsax.sort)),
          items: ['Name', 'Higher Price', 'Low Price', 'Sale', 'Newest', 'Popular',]
              .map((option) => DropdownMenuItem(value: option, child: Text(option)))
              .toList(),
          onChanged: (value) {},
        ),
        const SizedBox(height: TSizes.spaceBtwSections,),

        TGridLayout(itemCount: 4, itemBuilder: (_,index) =>  TProductCardVertical(productModel:  ProductModel.empty(),))
      ],
    );
  }
}