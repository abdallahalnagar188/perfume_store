import 'package:ecommerce_store/common/widgets/custom_shapes/containers/rounded_container.dart';
import 'package:ecommerce_store/common/widgets/texts/section_heading.dart';
import 'package:ecommerce_store/features/shop/controllers/product/checkout_controller.dart';
import 'package:ecommerce_store/utils/constants/colors.dart';
import 'package:ecommerce_store/utils/constants/image_strings.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../../../../utils/constants/sizes.dart';
import '../../../../../utils/helpers/helper_functions.dart';

class TBillingPaymentSection extends StatelessWidget {
  const TBillingPaymentSection({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(CheckoutController());
    final dark = THelperFunctions.isDarkMode(context);

    return Column(
      children: [
        TSectionHeading(title: 'pymentMethod'.tr, buttonTitle: 'change'.tr, onPressed: () => controller.selectPaymentMethod(context),),
        const SizedBox(height: TSizes.spaceBtwItems/2,),

        Obx(
          () =>  Row(
            children: [
              TRoundedContainer(
                width: 60,
                height: 35,
                backgroundColor: dark? TColors.light:TColors.white,
                padding: EdgeInsets.all(TSizes.sm),
                child:  Image(image: AssetImage(controller.selectedPaymentMethod.value.image),fit: BoxFit.contain,),
              ),
              const SizedBox(height: TSizes.spaceBtwItems/2,),
              Text(controller.selectedPaymentMethod.value.name,style: Theme.of(context).textTheme.bodyMedium,)

            ],
          ),
        )
      ],
    );
  }
}
