import 'package:carousel_slider/carousel_slider.dart';
import 'package:ecommerce_store/common/widgets/shimmer/shimmer.dart';
import 'package:ecommerce_store/features/shop/controllers/banner_controller.dart';
import 'package:ecommerce_store/utils/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../common/widgets/custom_shapes/containers/circular_container.dart';
import '../../../../../common/widgets/image/t_rounded_image.dart';
import '../../../../../utils/constants/sizes.dart';

class TPromoSlider extends StatelessWidget {
  const TPromoSlider({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(BannerController());
    return Obx(() {
      // Loader
      if(controller.isLoading.value) return const TShimmerEffect(width: double.infinity, height: 190);
      if(controller.allBanners.isEmpty){
        return Center(child: const Text('No data Found'));
      }else{
        return Column(
          children: [
            CarouselSlider(
              options: CarouselOptions(
                animateToClosest: true,
                autoPlay: true,
                viewportFraction: 1,
                onPageChanged: (index, _) =>
                    controller.updatePageIndicator(index),
              ),
              items: controller.allBanners
                  .map(
                    (banner) => TRoundedImage(
                  imageUrl: banner.imageUrl,
                  isNetworkImage: true,
                  onPressed: () => Get.toNamed(banner.targetScreen),
                ),
              )
                  .toList(),
            ),
            const SizedBox(height: TSizes.spaceBtwItems),
            Obx(
                  () => Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  for (int i = 0; i < controller.allBanners.length; i++)
                    TCircularContainer(
                      width: 20,
                      height: 4,
                      margin: EdgeInsets.only(right: 10),
                      backgroundColor: controller.carousalCurrentIndex.value == i
                          ? TColors.primary
                          : TColors.grey,
                    ),
                ],
              ),
            ),
          ],
        );
      }

    });
  }
}
