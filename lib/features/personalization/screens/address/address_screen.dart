import 'package:ecommerce_store/common/widgets/appbar/appbar.dart';
import 'package:ecommerce_store/features/personalization/controllers/address_controller.dart';
import 'package:ecommerce_store/features/personalization/screens/address/add_new_address.dart';
import 'package:ecommerce_store/features/personalization/screens/address/widgets/single_address.dart';
import 'package:ecommerce_store/utils/constants/colors.dart';
import 'package:ecommerce_store/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../utils/helpers/cloud_helper_functions.dart';

class UserAddressScreen extends StatelessWidget {
  const UserAddressScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(AddressController());
    return Scaffold(
      appBar: TAppbar(
        title: Text(
          'Addresses',
          style: Theme.of(context).textTheme.headlineMedium,
        ),
        showBackArrow: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(TSizes.defaultSpace),

          child: Obx(
            () => FutureBuilder(
              key: Key(controller.refreshDate.value.toString()),
              future: controller.getAllUserAddress(),
              builder: (context, snapshot) {
                final widget = TCloudHelperFunctions.checkMultiRecordState(
                  snapshot: snapshot,
                );
                if (widget != null) return widget;

                final addresses = snapshot.data!;
                return ListView.builder(
                  shrinkWrap: true,
                  itemCount: snapshot.data!.length,
                  itemBuilder: (_, index) {
                    return TSingleAddress(
                      address: addresses[index],
                      onTap: () => controller.selectAddress(addresses[index]),
                    );
                  },
                );
              },
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Get.to(() => const AddNewAddressScreen()),
        backgroundColor: TColors.primary,
        child: const Icon(Iconsax.add, color: TColors.white),
      ),
    );
  }
}
