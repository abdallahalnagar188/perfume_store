import 'package:ecommerce_store/features/shop/controllers/product/order_controller.dart';
import 'package:ecommerce_store/utils/constants/sizes.dart';
import 'package:ecommerce_store/utils/helpers/cloud_helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../navigation_menu.dart';
import '../../../../../utils/constants/image_strings.dart';
import '../../../../../utils/loaders/animation_loader.dart';
import 'order_list_item.dart';

class TOrdersList extends StatelessWidget {
  const TOrdersList({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(OrderController());
    
    return FutureBuilder(
      future: controller.fetchUserOrders(),
      builder: (context, snapshot) {


        // Nothing found widget
        final emptyWidget = TAnimationLoaderWidget(
          text: 'Whoops! No orders yet',
          animation: TImages.emptyCartAnimation,
          showAction: true,
          actionText: 'Let\'s fill it',
          onActionPressed: () => Get.off(() => const NavigationMenu()),
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
            return OrderListItem(order: order);
         }

        );
      }
    );
  }
}
