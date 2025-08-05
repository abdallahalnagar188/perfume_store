import 'package:ecommerce_store/data/repo/address/address_repo.dart';
import 'package:ecommerce_store/features/personalization/models/address_model.dart';
import 'package:ecommerce_store/features/personalization/screens/address/add_new_address.dart';
import 'package:ecommerce_store/utils/constants/image_strings.dart';
import 'package:ecommerce_store/utils/popups/full_screen_loader.dart';
import 'package:ecommerce_store/utils/popups/loaders.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart';

import '../../../common/widgets/texts/section_heading.dart';
import '../../../utils/constants/sizes.dart';
import '../../../utils/helpers/cloud_helper_functions.dart';
import '../../../utils/helpers/network_manager.dart';
import '../screens/address/widgets/single_address.dart';

class AddressController extends GetxController {
  static AddressController get instance => Get.find();

  final name = TextEditingController();
  final phoneNumber = TextEditingController();
  final street = TextEditingController();
  final postalCode = TextEditingController();
  final city = TextEditingController();
  final state = TextEditingController();
  final country = TextEditingController();
  GlobalKey<FormState> addressFormKey = GlobalKey<FormState>();

  RxBool refreshDate = true.obs;
  final Rx<AddressModel> selectedAddress = AddressModel.empty().obs;
  final addressRepo = Get.put(AddressRepo());

  /// Fetch all user address
  Future<List<AddressModel>> getAllUserAddress() async {
    try {
      final addresses = await addressRepo.fetchUserAddress();
      selectedAddress.value = addresses.firstWhere(
        (element) => element.selectedAddress,
        orElse: () => AddressModel.empty(),
      );
      return addresses;
    } catch (e) {
      TLoaders.errorSnackBar(title: 'Address not found', message: e.toString());
      return [];
    }
  }

  Future selectAddress(AddressModel newSelectedAddress) async {
    try {
      // clear the selected field
      if (selectedAddress.value.id.isNotEmpty) {
        await addressRepo.updateSelectedFiled(selectedAddress.value.id, false);
      }
      // assign selected address
      newSelectedAddress.selectedAddress = true;
      selectedAddress.value = newSelectedAddress;
      // set the selected field to true for the newly selected address
      await addressRepo.updateSelectedFiled(selectedAddress.value.id, true);
    } catch (e) {
      TLoaders.errorSnackBar(title: 'Error in selected', message: e.toString());
    }
  }

  /// add new address
  Future addNewAddress() async {
    try {
      TFullScreenLoader.openLoadingDialog(
        'Storing Address...',
        TImages.docerAnimation,
      );

      // check Internet connection
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        TFullScreenLoader.stopLoading();
        return;
      }

      if (!addressFormKey.currentState!.validate()) {
        TFullScreenLoader.stopLoading();
        return;
      }
      final address = AddressModel(
        id: '',
        name: name.text.trim(),
        phoneNumber: phoneNumber.text.trim(),
        street: street.text.trim(),
        city: city.text.trim(),
        state: state.text.trim(),
        postalCode: postalCode.text.trim(),
        country: country.text.trim(),
        selectedAddress: true,
      );

      final id = await addressRepo.addAddress(address);

      address.id = id;
      await selectAddress(address);

      TFullScreenLoader.stopLoading();

      TLoaders.successSnackBar(
        title: 'Congratulations',
        message: 'Your address has been saved successfully.',
      );

      refreshDate.toggle();

      resetFormFields();

      Navigator.of(Get.context!).pop();
    } catch (e) {
      TFullScreenLoader.stopLoading();
      TLoaders.errorSnackBar(title: 'Error in selected', message: e.toString());
    }
  }

  /// Show Addresses ModalBottomSheet at Checkout
  Future<dynamic> selectNewAddressPopup(BuildContext context) {
    return showModalBottomSheet(
      context: context,
      builder: (_) => Container(
        padding: const EdgeInsets.all(TSizes.lg),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const TSectionHeading(
              title: 'Select Address',
              showActionButton: false,
            ),
            FutureBuilder(
              future: getAllUserAddress(),
              builder: (_, snapshot) {
                /// Helper Function: Handle Loader, No Record, OR ERROR Message
                final response = TCloudHelperFunctions.checkMultiRecordState(
                  snapshot: snapshot,
                );
                if (response != null) return response;

                return ListView.builder(
                  shrinkWrap: true,
                  itemCount: snapshot.data!.length,
                  itemBuilder: (_, index) => TSingleAddress(
                    address: snapshot.data![index],
                    onTap: () async {
                      await selectAddress(snapshot.data![index]);
                      Get.back();
                    },
                  ),
                );
              },
            ),
            const SizedBox(height: TSizes.defaultSpace * 2),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () => Get.to(() => AddNewAddressScreen()),
                child: Text('Add new address', style: Theme.of(context).textTheme.bodyMedium,),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void resetFormFields() {
    name.clear();
    phoneNumber.clear();
    street.clear();
    postalCode.clear();
    city.clear();
    state.clear();
    country.clear();
    addressFormKey.currentState!.reset();
  }
}
