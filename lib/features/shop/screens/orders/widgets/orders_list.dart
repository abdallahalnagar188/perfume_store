import 'package:ecommerce_store/common/widgets/custom_shapes/containers/rounded_container.dart';
import 'package:ecommerce_store/features/shop/controllers/product/order_controller.dart';
import 'package:ecommerce_store/utils/constants/colors.dart';
import 'package:ecommerce_store/utils/constants/sizes.dart';
import 'package:ecommerce_store/utils/helpers/cloud_helper_functions.dart';
import 'package:ecommerce_store/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../../navigation_menu.dart';
import '../../../../../utils/constants/image_strings.dart';
import '../../../../../utils/loaders/animation_loader.dart';

class TOrdersList extends StatelessWidget {
  const TOrdersList({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(OrderController());
    final dark = THelperFunctions.isDarkMode(context);
    
    return FutureBuilder(
      future: controller.fetchUserOrders(),
      builder: (context, snapshot) {


        // Nothing found widget
        final emptyWidget = TAnimationLoaderWidget(
          text: 'Whoops! No orders yet',
          animation: TImages.emptyCartAnimation,
          showAction: true,
          actionText: 'Let\'s fill it',
          onActionPressed: () => Get.off(() => NavigationMenu()),
        );

        final response  = TCloudHelperFunctions.checkMultiRecordState(snapshot: snapshot,nothingFound: emptyWidget);
        if(response != null)  return response;

        final orders = snapshot.data!;

        return ListView.separated(
          shrinkWrap: true,
          itemCount: orders.length,
          separatorBuilder: (_,index) => const SizedBox(height: TSizes.spaceBtwItems,),
         itemBuilder: (_,index) {
            final order = orders[index];
            return TRoundedContainer(
              padding: EdgeInsets.all(TSizes.md),
              showBorder: true,
              backgroundColor: dark ? TColors.dark : TColors.light,
              child: Column(
                mainAxisSize: MainAxisSize.min,

                children: [
                  Row(
                    children: [
                      /// Icon
                      Icon(Iconsax.ship),
                      SizedBox(width: TSizes.spaceBtwItems / 2),

                      /// Status and Date
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              order.orderStatusText,
                              style: Theme.of(context).textTheme.bodyLarge!.apply(
                                color: TColors.primary,
                                fontWeightDelta: 1,
                              ),
                            ),
                            Text(
                                order.formattedOrderDate,
                                style: Theme.of(context).textTheme.headlineSmall
                            ),
                          ],
                        ),
                      ),

                      /// Icon
                      IconButton(onPressed: (){}, icon: Icon(Iconsax.arrow_right_34,size: TSizes.iconSm,),)
                    ],
                  ),
                  const SizedBox(height: TSizes.spaceBtwItems,),

                  Row(
                    children: [
                      Expanded(
                        child: Row(
                          children: [
                            /// Icon
                            Icon(Iconsax.tag),
                            SizedBox(width: TSizes.spaceBtwItems / 2),

                            /// Status and Date
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text('Orders', style: Theme.of(context).textTheme.labelMedium),
                                  Text(order.id, style: Theme.of(context).textTheme.titleMedium),
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
                            Icon(Iconsax.calendar),
                            SizedBox(width: TSizes.spaceBtwItems / 2),

                            /// Status and Date
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text('Shipping Date', style: Theme.of(context).textTheme.labelMedium),
                                  Text(order.formattedDeliveryDate, style: Theme.of(context).textTheme.titleMedium),
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

        );
      }
    );
  }
}
