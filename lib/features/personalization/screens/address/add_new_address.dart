import 'package:ecommerce_store/common/widgets/appbar/appbar.dart';
import 'package:ecommerce_store/features/personalization/controllers/address_controller.dart';
import 'package:ecommerce_store/utils/constants/sizes.dart';
import 'package:ecommerce_store/utils/validators/validation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class AddNewAddressScreen extends StatelessWidget {
  const AddNewAddressScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = AddressController.instance;
    return Scaffold(
      appBar: TAppbar(
        showBackArrow: true,
        title: Text(
          'addNewAddress'.tr,
          style: Theme.of(context).textTheme.headlineMedium,
        ),
      ),

      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(TSizes.defaultSpace),
          child: Form(
            key: controller.addressFormKey,
            child: Column(
              children: [
                TextFormField(
                  controller: controller.name,
                  validator: (value) =>
                      TValidator.validateEmptyText('Name', value),
                  decoration: InputDecoration(
                    prefixIcon: Icon(Iconsax.user),
                    labelText: 'username'.tr,
                  ),
                ),
                const SizedBox(height: TSizes.spaceBtwInputFields),
                TextFormField(
                  controller: controller.phoneNumber,
                  validator: TValidator.validatePhoneNumber,
                  decoration: InputDecoration(
                    prefixIcon: Icon(Iconsax.mobile),
                    labelText: 'phoneNo'.tr,
                  ),
                ),
                const SizedBox(height: TSizes.spaceBtwInputFields),

                Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        controller: controller.street,
                        validator: (value) =>
                            TValidator.validateEmptyText('Street', value),
                        decoration: InputDecoration(
                          prefixIcon: Icon(Iconsax.building_31),
                          labelText: 'street'.tr,
                        ),
                      ),
                    ),
                    const SizedBox(width: TSizes.spaceBtwInputFields),
                    Expanded(
                      child: TextFormField(
                        controller: controller.postalCode,
                        validator: (value) =>
                            TValidator.validateEmptyText('Postal Code', value),
                        decoration: InputDecoration(
                          prefixIcon: Icon(Iconsax.code),
                          labelText: 'postCode'.tr,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: TSizes.spaceBtwInputFields),

                Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        controller: controller.city,
                        validator: (value) =>
                            TValidator.validateEmptyText('City', value),
                        decoration: InputDecoration(
                          prefixIcon: Icon(Iconsax.building),
                          labelText: 'city'.tr,
                        ),
                      ),
                    ),
                    const SizedBox(width: TSizes.spaceBtwInputFields),
                    Expanded(
                      child: TextFormField(
                        controller: controller.state,
                        validator: (value) =>
                            TValidator.validateEmptyText('State', value),
                        decoration: InputDecoration(
                          prefixIcon: Icon(Iconsax.activity),
                          labelText: 'state'.tr,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: TSizes.spaceBtwInputFields),
                TextFormField(
                  controller: controller.country,
                  validator: (value) =>
                      TValidator.validateEmptyText('Country', value),
                  decoration: InputDecoration(
                    prefixIcon: Icon(Iconsax.global),
                    labelText: 'country'.tr,
                  ),
                ),
                const SizedBox(height: TSizes.defaultSpace),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () => controller.addNewAddress(),
                    child: Text(
                      'save'.tr,
                      style: Theme.of(
                        context,
                      ).textTheme.titleLarge!.copyWith(color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
