import 'package:ecommerce_store/common/widgets/custom_shapes/containers/rounded_container.dart';
import 'package:ecommerce_store/common/widgets/texts/product_title_text.dart';
import 'package:ecommerce_store/common/widgets/texts/section_heading.dart';
import 'package:ecommerce_store/common/widgets/texts/t_product_price_text.dart';
import 'package:ecommerce_store/features/shop/controllers/product/variation_controller.dart';
import 'package:ecommerce_store/features/shop/models/product_model.dart';
import 'package:ecommerce_store/utils/constants/colors.dart';
import 'package:ecommerce_store/utils/constants/sizes.dart';
import 'package:ecommerce_store/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../../../../common/widgets/chips/chice_chip.dart';

class TProductAttributes extends StatelessWidget {
  const TProductAttributes({super.key, required this.product});

  final ProductModel product;

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(VariationController());
    final dark = THelperFunctions.isDarkMode(context);
    return Obx(
      () => Column(
        children: [
            if (controller.selectedVariation.value.id.isNotEmpty)
          TRoundedContainer(
            padding: EdgeInsets.all(TSizes.md),
            backgroundColor: dark ? TColors.darkerGrey : TColors.grey,
            child: Column(
              children: [
                /// Title and price and Stoke Status
                Row(
                  children: [
                    TSectionHeading(
                      title: 'Variation',
                      showActionButton: false,
                    ),
                    SizedBox(width: TSizes.spaceBtwItems),

                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            const TProductTitleText(
                              text: 'Price : ',
                              smallSize: true,
                            ),

                            /// Actual Price
                            Text(
                              '\$${controller.selectedVariation.value.salePrice}',
                              style: Theme.of(context).textTheme.titleSmall!
                                  .apply(
                                    decoration: TextDecoration.lineThrough,
                                  ),
                            ),
                            SizedBox(width: TSizes.spaceBtwItems),

                            /// Sale Price
                            TProductPriceText(price: product.price.toString()),
                          ],
                        ),

                        Row(
                          children: [
                            const TProductTitleText(
                              text: 'Stoke : ',
                              smallSize: true,
                            ),
                            Text(
                              controller.variationStockStats.value,
                              style: Theme.of(context).textTheme.titleMedium,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),

                /// Variation Description
                TProductTitleText(
                  text: controller.selectedVariation.value.description,
                  smallSize: true,
                  maxLines: 4,
                ),
              ],
            ),
          ),
          const SizedBox(height: TSizes.spaceBtwItems),

          /// Attributes
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: product.productAttributes!
                .map(
                  (attribute) => Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TSectionHeading(
                        title: attribute.name!,
                        showActionButton: false,
                      ),
                      const SizedBox(height: TSizes.spaceBtwItems / 2),
                      Obx(
                        () => Wrap(
                          spacing: 8,
                          children: attribute.values!.map((attributeValue) {
                            final isSelected =
                                controller.selectedAttributes[attribute.name] ==
                                attributeValue;
                            final available = controller
                                .getAttributesAvailabilityInVariation(
                                  product.productVariations!,
                                  attribute.name!,
                                )
                                .contains(attributeValue);
                            return TChoiceChip(
                              text: attributeValue,
                              selected: isSelected,
                              onSelected: available
                                  ? (selected) {
                                      if (selected && available) {
                                        controller.onAttributeSelected(
                                          product,
                                          attribute.name,
                                          attributeValue,
                                        );
                                      }
                                    }
                                  : null,
                            );
                          }).toList(),
                        ),
                      ),
                    ],
                  ),
                )
                .toList(),
          ),
        ],
      ),
    );
  }
}
