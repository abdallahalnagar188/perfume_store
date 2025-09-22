import 'package:ecommerce_store/common/widgets/appbar/appbar.dart';
import 'package:ecommerce_store/features/shop/screens/orders/widgets/orders_list.dart';
import 'package:ecommerce_store/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OrderScreen extends StatelessWidget {
  const OrderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TAppbar(
        title: Text('myOrders'.tr,style: Theme.of(context).textTheme.headlineSmall,),
        showBackArrow: true,
      ),
      body:Padding(
        padding: EdgeInsets.all(TSizes.defaultSpace),
        /// Orders
        child: TOrdersList(),
      ),
    );
  }
}
