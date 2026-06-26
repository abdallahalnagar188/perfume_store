import 'package:ecommerce_store/common/widgets/appbar/appbar.dart';
import 'package:ecommerce_store/features/personalization/controllers/address_controller.dart';
import 'package:ecommerce_store/utils/constants/sizes.dart';
import 'package:ecommerce_store/utils/constants/colors.dart';
import 'package:ecommerce_store/utils/validators/validation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class EditAddressScreen extends StatelessWidget {
  const EditAddressScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = AddressController.instance;
    return Scaffold(
      appBar: TAppbar(
        showBackArrow: true,
        title: Text(
          'Edit Address',
          style: Theme.of(context).textTheme.headlineMedium,
        ),
      ),

      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(TSizes.defaultSpace),
          child: Form(
            key: controller.addressFormKey,
            child: Column(
              children: [
                // Google Maps Preview
                Obx(() => Container(
                  height: 250,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(TSizes.cardRadiusLg),
                    border: Border.all(color: TColors.borderPrimary),
                    boxShadow: [
                      BoxShadow(
                        color: TColors.darkGrey.withOpacity(0.1),
                        blurRadius: 10,
                        spreadRadius: 2,
                      )
                    ],
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(TSizes.cardRadiusLg),
                    child: Stack(
                      children: [
                        GoogleMap(
                          initialCameraPosition: CameraPosition(
                            target: controller.selectedLocation.value ?? const LatLng(37.422, -122.084),
                            zoom: 15,
                          ),
                          onMapCreated: (GoogleMapController mapController) {
                            controller.mapController = mapController;
                          },
                          onCameraMove: (CameraPosition position) {
                            controller.selectedLocation.value = position.target;
                          },
                          myLocationEnabled: true,
                          myLocationButtonEnabled: false,
                          zoomControlsEnabled: false,
                        ),
                        // Center Pin
                        const Center(
                          child: Padding(
                            padding: EdgeInsets.only(bottom: 35.0),
                            child: Icon(Icons.location_pin, color: TColors.error, size: 40),
                          ),
                        ),
                        // Pick Current Location Button
                        Positioned(
                          bottom: TSizes.sm,
                          right: TSizes.sm,
                          child: FloatingActionButton(
                            mini: true,
                            backgroundColor: TColors.white,
                            onPressed: () => controller.pickCurrentLocation(),
                            child: const Icon(Icons.my_location, color: TColors.primary),
                          ),
                        ),
                      ],
                    ),
                  ),
                )),
                const SizedBox(height: TSizes.spaceBtwSections),

                // Form Fields with Premium UI
                TextFormField(
                  controller: controller.name,
                  validator: (value) =>
                      TValidator.validateEmptyText('Name', value),
                  decoration: InputDecoration(
                    prefixIcon: const Icon(Iconsax.user),
                    labelText: 'username'.tr,
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(TSizes.inputFieldRadius)),
                  ),
                ),
                const SizedBox(height: TSizes.spaceBtwInputFields),
                TextFormField(
                  controller: controller.phoneNumber,
                  validator: TValidator.validatePhoneNumber,
                  decoration: InputDecoration(
                    prefixIcon: const Icon(Iconsax.mobile),
                    labelText: 'phoneNo'.tr,
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(TSizes.inputFieldRadius)),
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
                          prefixIcon: const Icon(Iconsax.building_31),
                          labelText: 'street'.tr,
                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(TSizes.inputFieldRadius)),
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
                          prefixIcon: const Icon(Iconsax.code),
                          labelText: 'postCode'.tr,
                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(TSizes.inputFieldRadius)),
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
                          prefixIcon: const Icon(Iconsax.building),
                          labelText: 'city'.tr,
                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(TSizes.inputFieldRadius)),
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
                          prefixIcon: const Icon(Iconsax.activity),
                          labelText: 'state'.tr,
                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(TSizes.inputFieldRadius)),
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
                    prefixIcon: const Icon(Iconsax.global),
                    labelText: 'country'.tr,
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(TSizes.inputFieldRadius)),
                  ),
                ),
                const SizedBox(height: TSizes.spaceBtwSections),
                SizedBox(
                  width: double.infinity,
                  height: 55,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: TColors.primary,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(TSizes.buttonRadius),
                      ),
                      elevation: TSizes.buttonElevation,
                    ),
                    onPressed: () => controller.submitEditedAddress(),
                    child: Text(
                      'save'.tr,
                      style: Theme.of(context).textTheme.titleLarge!.copyWith(color: TColors.white, fontWeight: FontWeight.bold),
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
