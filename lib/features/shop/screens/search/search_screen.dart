import 'package:ecommerce_store/common/widgets/appbar/appbar.dart';
import 'package:ecommerce_store/common/widgets/layouts/grid_layout.dart';
import 'package:ecommerce_store/common/widgets/products/products_cards/product_card_vertical.dart';
import 'package:ecommerce_store/features/shop/controllers/search/search_controller.dart';
import 'package:ecommerce_store/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import '../../../../common/widgets/loaders/empty_data_widget.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(TSearchController());

    return Scaffold(
      appBar: TAppbar(
        showBackArrow: true,
        title: Text('search'.tr, style: Theme.of(context).textTheme.headlineMedium),
      ),
      body: Padding(
        padding: const EdgeInsets.all(TSizes.defaultSpace),
        child: Column(
          children: [
            // Search Bar
            TextField(
              controller: controller.searchTextController,
              onChanged: (query) => controller.searchQuery.value = query,
              autofocus: true,
              decoration: InputDecoration(
                prefixIcon: const Icon(Iconsax.search_normal),
                hintText: 'searchForProducts'.tr,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(TSizes.cardRadiusLg),
                ),
                suffixIcon: IconButton(
                  icon: const Icon(Iconsax.close_circle),
                  onPressed: () {
                    controller.searchTextController.clear();
                    controller.searchQuery.value = '';
                  },
                ),
              ),
            ),
            const SizedBox(height: TSizes.spaceBtwSections),
            
            // Search Results
            Expanded(
              child: Obx(() {
                final query = controller.searchQuery.value; // Read to trigger Obx
                
                if (controller.isLoading.value) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (query.isEmpty) {
                  return TEmptyDataWidget(
                    text: 'typeToSearch'.tr,
                  );
                }

                if (controller.searchResults.isEmpty) {
                  return TEmptyDataWidget(
                    text: 'noProductsFound'.tr,
                  );
                }

                return SingleChildScrollView(
                  child: TGridLayout(
                    itemCount: controller.searchResults.length,
                    itemBuilder: (_, index) => TProductCardVertical(
                      productModel: controller.searchResults[index],
                    ),
                  ),
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
}
