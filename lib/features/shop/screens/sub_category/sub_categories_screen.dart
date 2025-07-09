import 'package:ecommerce_store/common/widgets/appbar/appbar.dart';
import 'package:ecommerce_store/common/widgets/image/t_rounded_image.dart';
import 'package:ecommerce_store/common/widgets/products/products_cards/product_card_horizontal.dart';
import 'package:ecommerce_store/common/widgets/texts/section_heading.dart';
import 'package:ecommerce_store/utils/constants/image_strings.dart';
import 'package:ecommerce_store/utils/constants/sizes.dart';
import 'package:flutter/material.dart';

class SubCategoriesScreen extends StatelessWidget {
  const SubCategoriesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TAppbar(
        title: Text('Sports',style: Theme.of(context).textTheme.headlineSmall,),
        showBackArrow: true,
      ),

      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(TSizes.defaultSpace),
          child: Column(
            children: [
              /// Banner
             TRoundedImage(imageUrl: TImages.banner3,width: double.infinity,height: null,applyImageRadius: true,),
              const SizedBox(height: TSizes.spaceBtwSections,),

              /// sub category
              Column(
                children: [
                  /// Heading
                  TSectionHeading(title: 'Sports shirts', onPressed: (){},),
                  const SizedBox(height: TSizes.spaceBtwItems /2,),

                  SizedBox(
                    height: 120,
                    child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                        itemCount: 4,
                        separatorBuilder: (_,__) => const SizedBox(width: TSizes.spaceBtwItems,),
                        itemBuilder: (_,index) =>  TProductCardHorizontal()),
                  )

                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
