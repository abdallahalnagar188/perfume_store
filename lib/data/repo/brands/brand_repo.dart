import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_store/utils/exceptions/TFirebaseStorageService.dart';
import 'package:ecommerce_store/utils/exceptions/firebase_exceptions.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../../features/shop/models/banner_model.dart';
import '../../../features/shop/models/brand_model.dart';
import '../../../utils/exceptions/platform_exceptions.dart';

class BrandRepo extends GetxController {
  static BrandRepo get instance => Get.find();

  // Variables
  final _db = FirebaseFirestore.instance;



  // get all brands
  Future<List<BrandModel>> getAllBrands() async {
    try {
      final snapshot = await _db.collection('Brands').get();
      final list = snapshot.docs.map((document) => BrandModel.fromSnapshot(document)).toList();
      return list;

    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong , Please try again';
    }
  }



  Future<void> uploadDummyData(List<BrandModel> brands) async {
    try {
      final storage =
          Get.find<TFirebaseStorageService>(); // use existing instance
      for (var brand in brands) {
        final file = await storage.getImageDataFromAssets(brand.image);
        final url = await storage.uploadImageData('Brands', file, brand.name);
        final updatedBrand = brand.copyWith(image: url);
        await _db
            .collection('Brands')
            .doc(updatedBrand.id)
            .set(updatedBrand.toJson());
      }
    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e, stackTrace) {
      print('uploadDummyData error: $e');
      print(stackTrace);
      throw 'Something went wrong , Please try again';
    }
  }
}
