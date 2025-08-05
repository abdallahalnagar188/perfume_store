import 'package:ecommerce_store/common/widgets/appbar/appbar.dart';
import 'package:ecommerce_store/features/shop/controllers/product/cart_controller.dart';
import 'package:ecommerce_store/features/shop/screens/cart/widgets/cart_items.dart';
import 'package:ecommerce_store/features/shop/screens/checkout/checkout_screen.dart';
import 'package:ecommerce_store/utils/constants/sizes.dart';
import 'package:ecommerce_store/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../../../navigation_menu.dart';
import '../../../../utils/constants/image_strings.dart';
import '../../../../utils/loaders/animation_loader.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    final controller = CartController.instance;
    return Scaffold(
      appBar: TAppbar(
        title: Text('Cart', style: Theme.of(context).textTheme.headlineSmall),
        showBackArrow: true,
      ),

      body: SingleChildScrollView(
        child: Obx(() {
          // Nothing found widget
          final emptyWidget = TAnimationLoaderWidget(
            text: 'Whoops! Wishlist is empty...',
            animation: TImages.emptyCartAnimation,
            showAction: true,
            actionText: 'Let\'s add some',
            onActionPressed: () => Get.off(() => NavigationMenu()),
          );

          return controller.cartItems.isEmpty
              ? Column(
            mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  emptyWidget,
                ],
              )
              : SingleChildScrollView(
                child: Padding(
                    padding: EdgeInsets.all(TSizes.defaultSpace),
                    child: TCartItems(),
                  ),
              );
        }),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(TSizes.defaultSpace),
        child:controller.totalCartPrice > 0 ? ElevatedButton(
          onPressed: () => Get.to(() => const CheckoutScreen()),
          child: Obx(() =>  Text('Checkout \$${controller.totalCartPrice.value}')),
        ): null,
      ),
    );
  }
}
