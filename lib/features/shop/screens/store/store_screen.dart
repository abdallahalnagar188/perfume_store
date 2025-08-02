import 'package:ecommerce_store/common/widgets/appbar/appbar.dart';
import 'package:ecommerce_store/common/widgets/custom_shapes/containers/rounded_container.dart';
import 'package:ecommerce_store/common/widgets/custom_shapes/containers/search_container.dart';
import 'package:ecommerce_store/common/widgets/layouts/grid_layout.dart';
import 'package:ecommerce_store/common/widgets/products/cart/cart_menu_icon.dart';
import 'package:ecommerce_store/common/widgets/texts/section_heading.dart';
import 'package:ecommerce_store/features/shop/controllers/category_controller.dart';
import 'package:ecommerce_store/features/shop/screens/brand/all_brands.dart';
import 'package:ecommerce_store/features/shop/screens/store/widgets/category_tab.dart';
import 'package:ecommerce_store/utils/constants/colors.dart';
import 'package:ecommerce_store/utils/constants/sizes.dart';
import 'package:ecommerce_store/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../common/widgets/appbar/tabbar.dart';
import '../../../../common/widgets/brands/brand_card.dart';


class StoreScreen extends StatelessWidget {
  const StoreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(CategoryController());
    return DefaultTabController(
      length: controller.featuredCategories.length,
      child: Scaffold(
        appBar: TAppbar(
          title: Text(
            'Store',
            style: Theme.of(context).textTheme.headlineMedium,
          ),
          actions: [TCartCounterIcon(onPressed: () {})],
        ),
        body: NestedScrollView(
          headerSliverBuilder: (_, innerBoxIsScrolled) {
            return [
              SliverAppBar(
                pinned: true,
                floating: true,
                automaticallyImplyLeading: false,
                // <-- Removes back icon
                backgroundColor: THelperFunctions.isDarkMode(context)
                    ? TColors.black
                    : TColors.white,
                expandedHeight: 440,
                flexibleSpace: Padding(
                  padding: EdgeInsets.all(TSizes.defaultSpace),
                  child: ListView(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    children: [
                      SizedBox(height: TSizes.spaceBtwItems),

                      /// Search bar
                      TSearchContainer(
                        text: 'Search in Store',
                        showBorder: true,
                        showBackground: false,
                        padding: EdgeInsets.zero,
                      ),
                      SizedBox(height: TSizes.spaceBtwSections),

                      /// Featured Brands
                      TSectionHeading(
                        title: 'Featured Brands',
                        showActionButton: true,
                        onPressed: ()  => Get.to(() => const AllBrandsScreen()),
                      ),
                      SizedBox(height: TSizes.spaceBtwItems / 1.5),

                      /// Brands
                      TGridLayout(
                        mainAxisExtent: 80,
                        itemCount: 4,
                        itemBuilder: (_, index) {
                          return const TBrandCard(showBorder: true);
                        },
                      ),
                    ],
                  ),
                ),
                bottom: TTabBar(
                  tabs: controller.featuredCategories.map((category) => Tab(child: Text(category.name),)).toList(),
                ),
              ),
            ];
          },
          body: TabBarView(
              children: controller.featuredCategories.map((category) => TCategoryTab(categoryModel: category)).toList()
          ),
        ),
      ),
    );
  }
}


