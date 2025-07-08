import 'package:ecommerce_store/common/widgets/appbar/appbar.dart';
import 'package:ecommerce_store/features/shop/screens/product_reviews/widgets/progress_indicator_and_rating.dart';
import 'package:ecommerce_store/features/shop/screens/product_reviews/widgets/rating_progress_indicator.dart';
import 'package:ecommerce_store/features/shop/screens/product_reviews/widgets/user_reviews_card.dart';
import 'package:ecommerce_store/utils/constants/colors.dart';
import 'package:ecommerce_store/utils/constants/sizes.dart';
import 'package:ecommerce_store/utils/device/device_utility.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../common/widgets/products/rating/rating_indicator.dart';

class ProductReviewsScreen extends StatelessWidget {
  const ProductReviewsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      /// Appbar
      appBar: TAppbar(title: Text('Reviews and Ratings'), showBackArrow: true),

      /// Body
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(TSizes.defaultSpace),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const  Text(
                'Raring and reviews are verified and are from people who use the same type of device that you use.',
              ),
              const SizedBox(height: TSizes.spaceBtwItems),

              /// Overall Product Rating
              const  TOverallProductRating(),
              const  TRatingBarIndicator(rating: 3.5,),
              Text('12,612',style: Theme.of(context).textTheme.bodySmall,),
              const  SizedBox(height: TSizes.spaceBtwSections),

              UserReviewsCard(),
              UserReviewsCard(),
              UserReviewsCard(),
              UserReviewsCard(),
            ],
          ),
        ),
      ),
    );
  }
}


