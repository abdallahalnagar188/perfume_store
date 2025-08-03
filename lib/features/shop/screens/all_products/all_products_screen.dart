import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_store/common/widgets/shimmer/vertical_product_shimmer.dart';
import 'package:ecommerce_store/features/shop/controllers/product/all_product_controller.dart';
import 'package:ecommerce_store/features/shop/models/product_model.dart';
import 'package:ecommerce_store/utils/constants/sizes.dart';
import 'package:ecommerce_store/utils/helpers/cloud_helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import '../../../../common/widgets/appbar/appbar.dart';
import '../../../../common/widgets/products/sortable_products/sortable_products.dart';

class AllProductsScreen extends StatelessWidget {
  const AllProductsScreen({
    super.key,
    required this.title,
    this.query,
    this.futureMethod,
  });

  final String title;
  final Query? query;
  final Future<List<ProductModel>>? futureMethod;

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(AllProductController());
    return Scaffold(
      appBar: TAppbar(
        title: Text(title, style: Theme.of(context).textTheme.headlineSmall),
        showBackArrow: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(TSizes.defaultSpace),
          child: FutureBuilder(
            future: futureMethod ?? controller.fetchProductByQuery(query),
            builder: (context, asyncSnapshot) {
              const loader = TVerticalProductShimmer(itemCount: 6,);

              final widget = TCloudHelperFunctions.checkMultiRecordState(
                snapshot: asyncSnapshot,
                loader: loader,
              );
              if (widget != null) return widget;
              final products = asyncSnapshot.data!;
              return TSortableProducts(products: products);
            },
          ),
        ),
      ),
    );
  }
}
