import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_store/data/repo/brands/brand_repo.dart';
import 'package:ecommerce_store/data/repo/products/products_repo.dart';
import 'package:ecommerce_store/features/shop/models/product_model.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../../utils/exceptions/firebase_exceptions.dart';
import '../../../utils/exceptions/platform_exceptions.dart';
import '../../../utils/popups/loaders.dart';
import '../models/brand_model.dart';

class BrandController extends GetxController{
  static BrandController get instance => Get.find();

  final isLoading = true.obs;
  final RxList<BrandModel> featuredBrands = <BrandModel>[].obs;
  final RxList<BrandModel> allBrands = <BrandModel>[].obs;
  final brandRepo = Get.put(BrandRepo());

  @override
  void onInit() {
    getFeaturedBrands();
    super.onInit();
  }

  Future<void> getFeaturedBrands() async {
    try {

      isLoading.value = true;

      final brands = await brandRepo.getAllBrands();
      allBrands.assignAll(brands);

      featuredBrands.assignAll(allBrands.where((brand) => brand.isFeatured ?? false).take(6));

    } catch (e) {
    //  TLoaders.errorSnackBar(title: 'Oh Snap!', message: e.toString());

    }finally{
      isLoading.value =false;
    }
  }

  /// Get brands for category
  Future<List<BrandModel>> getBrandsForCategory( String categoryId) async {
    try {

      final  brands = await BrandRepo.instance.getBrandsForCategory(categoryId);
      return brands;

    } catch (e) {
      print(e);
    //  TLoaders.errorSnackBar(title: 'Oh Snap!', message: e.toString());
      return[];
    }
  }

  Future<List<ProductModel>> getBrandProducts({ required String brandId, int limit = -1}) async {
    try {

     final  products = await ProductRepo.instance.getProductsForBrand(brandId: brandId,limit: limit);
     return products;

    } catch (e) {
      TLoaders.errorSnackBar(title: 'Oh Snap!', message: e.toString());
      return[];
    }
  }

}