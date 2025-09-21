import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_store/features/shop/models/category_model.dart';
import 'package:ecommerce_store/features/shop/models/product_category_model.dart';
import 'package:ecommerce_store/features/shop/models/product_model.dart';
import 'package:ecommerce_store/utils/exceptions/TFirebaseStorageService.dart';
import 'package:ecommerce_store/utils/exceptions/firebase_exceptions.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../../features/shop/models/banner_model.dart';
import '../../../utils/exceptions/firebase_auth_exceptions.dart';
import '../../../utils/exceptions/platform_exceptions.dart';

class ProductRepo extends GetxController {
  static ProductRepo get instance => Get.find();

  // Variables
  final _db = FirebaseFirestore.instance;

  // get all categories
  Future<List<ProductModel>> getFeaturedProducts() async {
    try {
      final snapshot = await _db.collection('Products').where('IsFeatured', isEqualTo: true).limit(8).get();
      return snapshot.docs.map((e) => ProductModel.fromSnapshot(e)).toList();

    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong , Please try again$e';
    }
  }

  Future<List<ProductModel>> getAllFeaturedProducts() async {
    try {
      final snapshot = await _db.collection('Products').where('IsFeatured', isEqualTo: true).get();
      return snapshot.docs.map((e) => ProductModel.fromSnapshot(e)).toList();

    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong , Please try again$e';
    }
  }

  Future<List<ProductModel>> fetchProductsByQuery(Query query) async {
    try {

      final querySnapshot = await query.get();
      final List<ProductModel> list =  querySnapshot.docs.map((doc) => ProductModel.fromQuerySnapshot(doc)).toList();
      return list;


    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong , Please try again$e';
    }
  }


  // Get Favorite Products from FireStore
  Future<List<ProductModel>> getFavoriteProducts(List<String> productIds) async {
    try {

      final snapshot = await _db.collection('Products').where(FieldPath.documentId,whereIn: productIds).get();
      return snapshot.docs.map((querySnapshot) => ProductModel.fromSnapshot(querySnapshot)).toList();

    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong , Please try again$e';
    }
  }

  Future<List<ProductModel>> getProductsForBrand({required String brandId, int limit = -1}) async {
    try {

      final querySnapshot = limit == -1 ? await _db.collection('Products').where('Brand.Id',isEqualTo: brandId).get():
          await _db.collection('Products').where('Brand.Id',isEqualTo: brandId).limit(limit).get();

      final products = querySnapshot.docs.map((doc) => ProductModel.fromSnapshot(doc)).toList();
      return products;

    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong , Please try again$e';
    }
  }

  Future<List<ProductModel>> getProductsForCategory({
    required String categoryId,
    int limit = -1,
  }) async {
    try {
      // Get product IDs from ProductCategory
      QuerySnapshot querySnapshot = limit == -1
          ? await _db
          .collection('ProductCategory')
          .where('categoryId', isEqualTo: categoryId)
          .get()
          : await _db
          .collection('ProductCategory')
          .where('categoryId', isEqualTo: categoryId)
          .limit(limit)
          .get();

      List<String> categoryIds = querySnapshot.docs
          .map((doc) => doc['productId']?.toString() ?? '')
          .where((id) => id.isNotEmpty)
          .toList();

      // ✅ Avoid empty whereIn
      if (categoryIds.isEmpty) return [];

      // ✅ Firestore whereIn supports max 10
      if (categoryIds.length > 10) {
        final chunks = <List<String>>[];
        for (var i = 0; i < categoryIds.length; i += 10) {
          chunks.add(categoryIds.sublist(
              i, i + 10 > categoryIds.length ? categoryIds.length : i + 10));
        }

        List<ProductModel> products = [];
        for (var chunk in chunks) {
          final query = await _db
              .collection('Products')
              .where(FieldPath.documentId, whereIn: chunk)
              .get();
          products.addAll(
              query.docs.map((doc) => ProductModel.fromSnapshot(doc)).toList());
        }
        return products;
      }

      // ✅ Normal case
      final productsQuery = limit == -1
          ? await _db
          .collection('Products')
          .where(FieldPath.documentId, whereIn: categoryIds)
          .get()
          : await _db
          .collection('Products')
          .where(FieldPath.documentId, whereIn: categoryIds)
          .limit(limit)
          .get();

      return productsQuery.docs
          .map((doc) => ProductModel.fromSnapshot(doc))
          .toList();
    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong , Please try again $e';
    }
  }

  Future<void> uploadProductCategory(List<ProductCategoryModel> productCategories) async {
    try {
      WriteBatch batch = _db.batch();

      for(var productCategory in productCategories){
        DocumentReference docRef = _db.collection('ProductCategory').doc();
        batch.set(docRef, productCategory.toJson());
      }

      await batch.commit();
    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong, Please try again';
    }
  }
  //upload category to cloud firestore
  Future<void> uploadDummyData(List<ProductModel> products) async {
    try {
      final storage = Get.put(TFirebaseStorageService());

      for (var product in products) {
        final thumbnail = await storage.getImageDataFromAssets(
          product.thumbnail,
        );

        final url = await storage.uploadImageData(
          'Products/Images',
          thumbnail,
          product.thumbnail.toString(),
        );
        product.thumbnail = url;

        if (product.images != null && product.images!.isNotEmpty) {
          List<String> imagesUrl = [];
          for (var image in product.images!) {
            final asstImage = await storage.getImageDataFromAssets(image);
            final url = await storage.uploadImageData(
              'Products/Images',
              asstImage,
              image,
            );

            imagesUrl.add(url);
          }
          product.images!.clear();
          product.images!.addAll(imagesUrl);
        }

        for (var variation in product.productVariations!) {
          final asstImage = await storage.getImageDataFromAssets(
            variation.image,
          );
          final url = await storage.uploadImageData(
            'Products/Images',
            asstImage,
            variation.image,
          );
          variation.image = url;
        }

        await _db.collection('Products').doc(product.id).set(product.toJson());
      }
    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong , Please try again';
    }
  }
}
