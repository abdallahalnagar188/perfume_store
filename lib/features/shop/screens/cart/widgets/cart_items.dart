import 'package:ecommerce_store/features/shop/controllers/product/cart_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../common/widgets/products/cart/add_remove_button.dart';
import '../../../../../common/widgets/products/cart/cart_item.dart';
import '../../../../../common/widgets/texts/t_product_price_text.dart';
import '../../../../../utils/constants/sizes.dart';

class TCartItems extends StatelessWidget {
  const TCartItems({super.key, this.showAddRemoveButtons = true});

  final bool showAddRemoveButtons;

  @override
  Widget build(BuildContext context) {
    final controller = CartController.instance;
    return Obx(
      () => ListView.separated(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        separatorBuilder: (_, __) =>
            const SizedBox(height: TSizes.spaceBtwItems),
        itemCount: controller.cartItems.length,
        itemBuilder: (_, index) => Obx(() {
          final item = controller.cartItems[index];
          return Column(
            children: [
              TCartItem(cartItem: item),
              if (showAddRemoveButtons)
                const SizedBox(height: TSizes.spaceBtwItems),
              if (showAddRemoveButtons)
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        const SizedBox(width: 70),

                        /// Add Remove buttons
                        TProductQuantityWithAddRemoveButton(
                          quantity: item.quantity,
                          add: () => controller.addOneToCart(item),
                          remove: () => controller.removeOneFromCart(item),
                        ),
                      ],
                    ),

                    TProductPriceText(price: (item.price  *  item.quantity).toStringAsFixed(1)),
                  ],
                ),
            ],
          );
        }),
      ),
    );
  }
}
