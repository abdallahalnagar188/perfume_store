import 'package:ecommerce_store/common/widgets/custom_shapes/containers/rounded_container.dart';
import 'package:ecommerce_store/common/widgets/success_screen/success_screen.dart';
import 'package:ecommerce_store/features/shop/screens/cart/widgets/cart_items.dart';
import 'package:ecommerce_store/features/shop/screens/checkout/widgets/billing_address_section.dart';
import 'package:ecommerce_store/features/shop/screens/checkout/widgets/billing_amount_section.dart';
import 'package:ecommerce_store/features/shop/screens/checkout/widgets/billing_payment_section.dart';
import 'package:ecommerce_store/navigation_menu.dart';
import 'package:ecommerce_store/utils/constants/colors.dart';
import 'package:ecommerce_store/utils/constants/image_strings.dart';
import 'package:ecommerce_store/utils/constants/sizes.dart';
import 'package:ecommerce_store/utils/helpers/helper_functions.dart';
import 'package:ecommerce_store/utils/popups/loaders.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../../../common/widgets/appbar/appbar.dart';
import '../../../../common/widgets/products/cart/coupone_widget.dart';
import '../../../../utils/helpers/pricing_calculator.dart';
import '../../controllers/product/cart_controller.dart';
import '../../controllers/product/order_controller.dart';

class CheckoutScreen extends StatelessWidget {
  const CheckoutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = CartController.instance;
    final subTotal = controller.totalCartPrice.value;
    final orderController = Get.put(OrderController());
    final totalAmount = TPricingCalculator.calculateTotalPrice(subTotal, 'US');

    final dark = THelperFunctions.isDarkMode(context);
    return Scaffold(
      appBar: TAppbar(
        title: Text(
          'orderReview'.tr,
          style: Theme.of(context).textTheme.headlineSmall,
        ),
        showBackArrow: true,
      ),

      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(TSizes.defaultSpace),
          child: Column(
            children: [
              /// Items in Cart
              const TCartItems(showAddRemoveButtons: false),
              const SizedBox(height: TSizes.spaceBtwSections),

              /// Coupon TextField
            //  TCouponCode(),
              const SizedBox(height: TSizes.spaceBtwSections),

              ///Billing Section
              TRoundedContainer(
                showBorder: true,
                backgroundColor: dark ? TColors.black : TColors.white,
                padding: EdgeInsets.all(TSizes.md),
                child: Column(
                  children: [
                    /// Pricing
                    TBillingAmountSection(),
                    const SizedBox(height: TSizes.spaceBtwItems),

                    /// Divider
                    Divider(),
                    const SizedBox(height: TSizes.spaceBtwItems),

                    /// Payment Methods
                    TBillingPaymentSection(),
                    const SizedBox(height: TSizes.spaceBtwItems),

                    /// Address
                    TBillingAddressSection(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(TSizes.defaultSpace),
        child: ElevatedButton(
          onPressed: subTotal > 0
              ? () => orderController.processOrder(totalAmount)
              : () => TLoaders.warningSnackBar(title: 'Empty Cart', message: 'Add items in the cart in order to process',),
          child: Text('${'checkout'.tr} \$$totalAmount', style: Theme.of(context).textTheme.bodyMedium!.copyWith(color: Colors.white))),
        ),

    );
  }
}
