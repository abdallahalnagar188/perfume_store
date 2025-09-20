import 'package:ecommerce_store/features/shop/controllers/product/cart_controller.dart';
import 'package:ecommerce_store/utils/constants/sizes.dart';
import 'package:ecommerce_store/utils/helpers/pricing_calculator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TBillingAmountSection extends StatelessWidget {
  const TBillingAmountSection({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = CartController.instance;
    final subTotal = controller.totalCartPrice.value;
    return Column(
      children: [
        /// SubTotal
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('subTotal'.tr,style: Theme.of(context).textTheme.bodyMedium,),
            Text('\$$subTotal',style: Theme.of(context).textTheme.bodyMedium,),
          ],
        ),
        const SizedBox(height: TSizes.spaceBtwItems/2,),

        /// Shipping Fee
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('shipping'.tr,style: Theme.of(context).textTheme.bodyMedium,),
            Text('\$${TPricingCalculator.calculateShippingCost(subTotal, 'US')}',style: Theme.of(context).textTheme.labelLarge,),
          ],
        ),
        const SizedBox(height: TSizes.spaceBtwItems/2,),

        /// Tax Fee
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('tax'.tr,style: Theme.of(context).textTheme.bodyMedium,),
            Text('\$${TPricingCalculator.calculateTax(subTotal, 'US')}',style: Theme.of(context).textTheme.labelLarge,),
          ],
        ),
        const SizedBox(height: TSizes.spaceBtwItems/2,),
        /// Order Total
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('orderTotal'.tr,style: Theme.of(context).textTheme.bodyMedium,),
            Text('\$${TPricingCalculator.calculateTotalPrice(subTotal, 'US')}',style: Theme.of(context).textTheme.titleMedium,),
          ],
        ),
      ],
    );
  }
}
