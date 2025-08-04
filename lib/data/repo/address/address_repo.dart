import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_store/data/repo/auth/auth_repo.dart';
import 'package:ecommerce_store/features/personalization/models/address_model.dart';
import 'package:get/get.dart';
import 'package:http/http.dart';

class AddressRepo extends GetxController {
  static AddressRepo get instance => Get.find();

  final _db = FirebaseFirestore.instance;

  Future<List<AddressModel>> fetchUserAddress() async {
    try {
      final userId = AuthenticationRepo.instance.authUser!.uid;

      if (userId.isEmpty) {
        throw 'Unable to find user information, Try again in few minutes.';
      }

      final result = await _db
          .collection('Users')
          .doc(userId)
          .collection('Addresses')
          .get();
      return result.docs
          .map(
            (documentSnapshot) =>
                AddressModel.fromDocumentSnapshot(documentSnapshot),
          )
          .toList();
    } catch (e) {
      print('fetchUserAddress error: $e');
      throw 'Something went wrong while fetching address information. Try again';
    }
  }

  Future<void> updateSelectedFiled(String addressId, bool selected) async {
    try {
      final userId = AuthenticationRepo.instance.authUser!.uid;
      await _db
          .collection('Users')
          .doc(userId)
          .collection('Addresses')
          .doc(addressId)
          .update({'SelectedAddress': selected});
    } catch (e) {
      throw 'Unable to update your address selection, try again';
    }
  }

  Future<String> addAddress(AddressModel address) async {
    try {
      final userId = AuthenticationRepo.instance.authUser!.uid;
      final currentAddress = await _db.collection('Users').doc(userId).collection('Addresses').add(address.toJson());
      return currentAddress.id;

    } catch (e) {
      throw 'Something went wrong while saving address information, try again';
    }

  }
}
