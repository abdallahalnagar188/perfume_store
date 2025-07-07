
import 'package:ecommerce_store/common/widgets/appbar/appbar.dart';
import 'package:ecommerce_store/common/widgets/image/t_circular_image.dart';
import 'package:ecommerce_store/common/widgets/texts/section_heading.dart';
import 'package:ecommerce_store/features/personalization/screens/profile/widgets/profile_menu.dart';
import 'package:ecommerce_store/utils/constants/colors.dart';
import 'package:ecommerce_store/utils/constants/image_strings.dart';
import 'package:ecommerce_store/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TAppbar(
        showBackArrow: true,
        title: Text('Profile'),
      ),
      body: SingleChildScrollView(
        child: Padding(padding: EdgeInsets.all(TSizes.defaultSpace),child:Column(
          children: [
            /// Profile Image
            SizedBox(
              width: double.infinity,
              child: Column(
                children: [
                  const TCircularImage(image: TImages.user,width: 80,height: 80,),
                  TextButton(onPressed: (){}, child: Text('Change Profile Image'))
                ],
              ),
            ),

            /// Details
            const SizedBox(height: TSizes.spaceBtwItems/2,),
            Divider(),
            const SizedBox(height: TSizes.spaceBtwItems,),

            /// Heading Profile info
            TSectionHeading(title: 'Profile Information',showActionButton: false,),
            const SizedBox(height: TSizes.spaceBtwItems,),

            TProfileMenu(onPressed: () {  }, title: 'Name', value: 'Abdallah Alnagar',),
            TProfileMenu(onPressed: () {  }, title: 'Username', value: 'Abdallah_Alnagar',),

            const SizedBox(height: TSizes.spaceBtwItems),
            Divider(),
            const SizedBox(height: TSizes.spaceBtwItems,),

            /// Heading Personal info
            TSectionHeading(title: 'Personal Information',showActionButton: false,),
            const SizedBox(height: TSizes.spaceBtwItems,),
            TProfileMenu(onPressed: () {  }, title: 'User Id', value: '18820',icon: Iconsax.copy,),
            TProfileMenu(onPressed: () {  }, title: 'E-mail', value: 'abdallahalnagar04@gmail.com',),
            TProfileMenu(onPressed: () {  }, title: 'Phone Number', value: '+201022437824',),
            TProfileMenu(onPressed: () {  }, title: 'Gender', value: 'Mail',),
            TProfileMenu(onPressed: () {  }, title: 'Date of Birth', value: '18 Ogs, 2002',),
            const SizedBox(height: TSizes.spaceBtwItems,),

            Divider(),
            const SizedBox(height: TSizes.spaceBtwItems,),

            Center(
              child: TextButton(onPressed: (){}, child: Text('Close Account',style: TextStyle(color: Colors.red),)),
            )

          ]
        ),),
      ),
    );
  }
}

