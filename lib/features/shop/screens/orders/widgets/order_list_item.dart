import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../../common/widgets/custom_shapes/containers/rounded_container.dart';
import '../../../../../utils/constants/colors.dart';
import '../../../../../utils/constants/enums.dart';
import '../../../../../utils/constants/sizes.dart';
import '../../../../../utils/helpers/helper_functions.dart';
import '../../../models/order_model.dart';

class OrderListItem extends StatelessWidget {
  const OrderListItem({super.key, required this.order});

  final OrderModel order;

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);

    return TRoundedContainer(
      padding: const EdgeInsets.all(TSizes.md),
      showBorder: true,
      backgroundColor: dark ? TColors.dark : TColors.light,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              /// Icon
              Icon(order.status.icon),
              const SizedBox(width: TSizes.spaceBtwItems / 2),

              /// Status and Date
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      order.orderStatusText,
                      style: Theme.of(context).textTheme.bodyLarge!.apply(
                            color: order.status.activeColor,
                            fontWeightDelta: 1,
                          ),
                    ),
                    Text(
                      order.formattedOrderDate,
                      style: Theme.of(context).textTheme.headlineSmall,
                    ),
                  ],
                ),
              ),


            ],
          ),
          const SizedBox(height: TSizes.spaceBtwItems),

          Row(
            children: [
              Expanded(
                child: Row(
                  children: [
                    /// Icon
                    const Icon(Iconsax.tag),
                    const SizedBox(width: TSizes.spaceBtwItems / 2),

                    /// Order ID
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text('Order',
                              style: Theme.of(context).textTheme.labelMedium),
                          Text(order.id,
                              style: Theme.of(context).textTheme.titleMedium),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Row(
                  children: [
                    /// Icon
                    const Icon(Iconsax.calendar),
                    const SizedBox(width: TSizes.spaceBtwItems / 2),

                    /// Shipping Date
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text('Shipping Date',
                              style: Theme.of(context).textTheme.labelMedium),
                          Text(order.formattedDeliveryDate,
                              style: Theme.of(context).textTheme.titleMedium),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
