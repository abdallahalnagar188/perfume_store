import 'package:cached_network_image/cached_network_image.dart';
import 'package:ecommerce_store/common/widgets/products/favorite_icon/TFavouriteIcon.dart';
import 'package:ecommerce_store/features/shop/controllers/product/images_controller.dart';
import 'package:ecommerce_store/features/shop/models/product_model.dart';
import 'package:ecommerce_store/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../../common/widgets/appbar/appbar.dart';
import '../../../../../common/widgets/custom_shapes/curved_edge/curved_edge_widget.dart';
import '../../../../../common/widgets/icons/t_circular_icon.dart';
import '../../../../../common/widgets/image/t_rounded_image.dart';
import '../../../../../utils/constants/colors.dart';
import '../../../../../utils/constants/sizes.dart';

class TProductImageSlider extends StatelessWidget {
  const TProductImageSlider({super.key, required this.product});

  final ProductModel product;

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    final controller = Get.put(ImagesController());
    final images = controller.getAllProductImages(product);
    return TCurvedEdgeWidget(
      child: Container(
        color: dark ? TColors.darkerGrey : TColors.light,
        child: Stack(
          children: [
            /// Main Large Image
            SizedBox(
              height: 400,
              child: Padding(
                padding: const EdgeInsets.all(TSizes.productImageRadius * 2),
                child: Center(
                  child: Obx(() {
                    final image = controller.selectedProductImage.value;
                    return GestureDetector(
                      onTap: () => controller.showEnlargedImage(image),
                      child: CachedNetworkImage(
                        imageUrl: image,
                        progressIndicatorBuilder: (_, __, downloadProgress) =>
                            CircularProgressIndicator(
                              value: downloadProgress.progress,
                              color: TColors.primary,
                            ),
                      ),
                    );
                  }),
                ),
              ),
            ),

            /// Image Slider
            Positioned(
              right: 0,
              bottom: 30,
              left: TSizes.defaultSpace,
              child: SizedBox(
                height: 80,
                child: ListView.separated(
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  physics: AlwaysScrollableScrollPhysics(),
                  separatorBuilder: (_, __) =>
                      const SizedBox(width: TSizes.spaceBtwItems),
                  itemCount: images.length,
                  itemBuilder: (_, index) => 
                     Obx(() {
                       final selectedImage = controller.selectedProductImage.value == images[index];
                       return  TRoundedImage(
                         width: 80,
                         isNetworkImage: true,
                         border: Border.all(color:selectedImage? TColors.primary:Colors.transparent),
                         padding: const EdgeInsets.all(TSizes.sm),
                         backgroundColor: dark ? TColors.dark : TColors.white,
                         onPressed: () => controller.selectedProductImage.value = images[index],
                         imageUrl: images[index],
                       );
                     }),
                ),
              ),
            ),

            /// Appbar Icons
            TAppbar(
              showBackArrow: true,
              actions: [TFavouriteIcon(productId: product.id,)],
            ),
          ],
        ),
      ),
    );
  }
}
