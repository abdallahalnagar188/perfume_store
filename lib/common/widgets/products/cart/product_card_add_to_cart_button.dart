import 'package:ecommerce_store/features/shop/controllers/product/cart_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../features/shop/models/product_model.dart';
import '../../../../utils/constants/colors.dart';
import '../../../../utils/constants/sizes.dart';

class ProductCardAddToCartButton extends StatelessWidget {
  const ProductCardAddToCartButton({super.key, required this.product});

  final ProductModel product;

  @override
  Widget build(BuildContext context) {
    final controller = CartController.instance;
    return InkWell(
      onTap: () {
        final cartItem = controller.convertToCartItem(product, 1);
        controller.addOneToCart(cartItem);
      },
      child: Obx(() {
        final productQuantityInCart = controller.getProductQuantityInCart(
          product.id,
        );
        return Container(
          decoration: BoxDecoration(
            color: productQuantityInCart > 0 ? TColors.primary : TColors.dark,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(TSizes.cardRadiusMd),
              bottomRight: Radius.circular(TSizes.productImageRadius),
            ),
          ),
          child: SizedBox(
            height: TSizes.iconLg * 1.2,
            width: TSizes.iconLg * 1.2,
            child: Center(
              child: productQuantityInCart > 0
                  ? (Text(
                      productQuantityInCart.toString(),
                      style: Theme.of(
                        context,
                      ).textTheme.bodyLarge!.apply(color: TColors.white),
                    ))
                  : Icon(Iconsax.add, color: TColors.white),
            ),
          ),
        );
      }),
    );
  }
}
