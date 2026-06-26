import 'package:ecommerce_store/data/repo/address/address_repo.dart';
import 'package:ecommerce_store/features/personalization/models/address_model.dart';
import 'package:ecommerce_store/features/personalization/screens/address/add_new_address.dart';
import 'package:ecommerce_store/utils/constants/image_strings.dart';
import 'package:ecommerce_store/utils/helpers/cloud_helper_functions.dart';
import 'package:ecommerce_store/utils/popups/full_screen_loader.dart';
import 'package:ecommerce_store/utils/popups/loaders.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../common/widgets/texts/section_heading.dart';
import '../../../utils/constants/sizes.dart';
import '../../../utils/helpers/network_manager.dart';
import '../screens/address/widgets/single_address.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:ecommerce_store/features/personalization/screens/address/edit_address.dart';

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

  // Map variables
  Rx<LatLng?> selectedLocation = Rx<LatLng?>(null);
  GoogleMapController? mapController;
  
  // Edit mode variable
  String editingAddressId = '';

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

  /// Pick current location using Geolocator
  Future<void> pickCurrentLocation() async {
    try {
      bool serviceEnabled;
      LocationPermission permission;

      serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        TLoaders.warningSnackBar(title: 'Location Services Disabled', message: 'Please enable location services.');
        return;
      }

      permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          TLoaders.warningSnackBar(title: 'Permission Denied', message: 'Location permissions are denied.');
          return;
        }
      }

      if (permission == LocationPermission.deniedForever) {
        TLoaders.warningSnackBar(title: 'Permission Denied', message: 'Location permissions are permanently denied, we cannot request permissions.');
        return;
      }

      Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
      final latLng = LatLng(position.latitude, position.longitude);
      selectedLocation.value = latLng;
      
      if (mapController != null) {
        mapController!.animateCamera(CameraUpdate.newLatLngZoom(latLng, 15));
      }
    } catch (e) {
      TLoaders.errorSnackBar(title: 'Location Error', message: e.toString());
    }
  }

  /// Initialize Add New Address Flow
  void addNewAddressInit() {
    resetFormFields();
    Get.to(() => const AddNewAddressScreen());
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
        latitude: selectedLocation.value?.latitude,
        longitude: selectedLocation.value?.longitude,
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

  /// Initialize Edit Address Flow
  void editAddressInit(AddressModel address) {
    editingAddressId = address.id;
    name.text = address.name;
    phoneNumber.text = address.phoneNumber;
    street.text = address.street;
    postalCode.text = address.postalCode;
    city.text = address.city;
    state.text = address.state;
    country.text = address.country;
    if (address.latitude != null && address.longitude != null) {
      selectedLocation.value = LatLng(address.latitude!, address.longitude!);
    } else {
      selectedLocation.value = null;
    }
    Get.to(() => const EditAddressScreen());
  }

  /// Submit Edited Address
  Future submitEditedAddress() async {
    try {
      TFullScreenLoader.openLoadingDialog(
        'Updating Address...',
        TImages.docerAnimation,
      );

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
        id: editingAddressId,
        name: name.text.trim(),
        phoneNumber: phoneNumber.text.trim(),
        street: street.text.trim(),
        city: city.text.trim(),
        state: state.text.trim(),
        postalCode: postalCode.text.trim(),
        country: country.text.trim(),
        selectedAddress: selectedAddress.value.id == editingAddressId,
        latitude: selectedLocation.value?.latitude,
        longitude: selectedLocation.value?.longitude,
      );

      await addressRepo.updateAddress(address);

      if (selectedAddress.value.id == editingAddressId) {
        selectedAddress.value = address;
      }

      TFullScreenLoader.stopLoading();
      TLoaders.successSnackBar(
        title: 'Success',
        message: 'Your address has been updated successfully.',
      );
      refreshDate.toggle();
      resetFormFields();
      Navigator.of(Get.context!).pop();
    } catch (e) {
      TFullScreenLoader.stopLoading();
      TLoaders.errorSnackBar(title: 'Error updating address', message: e.toString());
    }
  }

  /// Delete Address Popup Confirmation
  void deleteAddressPopup(AddressModel address) {
    Get.defaultDialog(
      contentPadding: const EdgeInsets.all(TSizes.md),
      title: 'Delete Address',
      middleText: 'Are you sure you want to delete this address?',
      confirm: ElevatedButton(
        onPressed: () async {
          Navigator.of(Get.overlayContext!).pop();
          await deleteAddress(address);
        },
        style: ElevatedButton.styleFrom(backgroundColor: Colors.red, side: const BorderSide(color: Colors.red)),
        child: const Padding(padding: EdgeInsets.symmetric(horizontal: TSizes.lg), child: Text('Delete')),
      ),
      cancel: OutlinedButton(
        onPressed: () => Navigator.of(Get.overlayContext!).pop(),
        child: const Text('Cancel'),
      ),
    );
  }

  /// Delete Address Flow
  Future<void> deleteAddress(AddressModel address) async {
    try {
      TFullScreenLoader.openLoadingDialog('Deleting Address...', TImages.docerAnimation);
      await addressRepo.deleteAddress(address.id);
      
      // Handle fallback if deleted address was selected
      if (selectedAddress.value.id == address.id) {
        final addresses = await addressRepo.fetchUserAddress();
        if (addresses.isNotEmpty) {
          await selectAddress(addresses.first);
        } else {
          selectedAddress.value = AddressModel.empty();
        }
      }
      
      TFullScreenLoader.stopLoading();
      TLoaders.successSnackBar(title: 'Success', message: 'Address successfully deleted.');
      refreshDate.toggle();
    } catch (e) {
      TFullScreenLoader.stopLoading();
      TLoaders.errorSnackBar(title: 'Error deleting address', message: e.toString());
    }
  }

  /// Show Addresses ModalBottomSheet at Checkout
  Future<dynamic> selectNewAddressPopup(BuildContext context) {
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (_) => SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(TSizes.lg),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
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
                onPressed: () {
                  Get.back();
                  addNewAddressInit();
                },
                child: Text('Add new address', style: Theme.of(context).textTheme.bodyMedium,),
              ),
            ),
          ],
        ),
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
    selectedLocation.value = null;
    editingAddressId = '';
    addressFormKey.currentState?.reset();
  }
}
