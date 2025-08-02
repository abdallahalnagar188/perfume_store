import 'package:ecommerce_store/common/widgets/shimmer/caterory_shimmer.dart';
import 'package:ecommerce_store/features/shop/controllers/category_controller.dart';
import 'package:ecommerce_store/features/shop/screens/sub_category/sub_categories_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../../../../common/widgets/image_text_category_widgets/category_item.dart';
import '../../../../../utils/constants/image_strings.dart';

class THomeCategory extends StatelessWidget {
  const THomeCategory({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(CategoryController());
    return Obx(() {
      if(controller.isLoading.value){
        return const TCategoryShimmer();
      }
      if(controller.featuredCategories.isEmpty){
        return const Center(child: Text('No Data Found',));
      }
      return SizedBox(
        height: 80,
        child: ListView.builder(
          shrinkWrap: true,
          itemCount: controller.featuredCategories.length,
          scrollDirection: Axis.horizontal,
          itemBuilder: (_, index) {

            final category = controller.featuredCategories[index];
            return TVerticalImageText(
              image: category.image,
              title: category.name,
              onTap: () => Get.to(() => const SubCategoriesScreen()),
            );
          },
        ),
      );
    });
  }
}
