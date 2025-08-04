import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:ecommerce_store/data/repo/products/products_repo.dart';
import 'package:ecommerce_store/features/shop/models/product_model.dart';
import 'package:ecommerce_store/utils/constants/sizes.dart';
import 'package:ecommerce_store/utils/local_storage/storage_utility.dart';
import 'package:ecommerce_store/utils/popups/loaders.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FavouriteController extends GetxController {
  static FavouriteController get instance => Get.find();

  // variables
  final favorites = <String,bool>{}.obs;

  @override
  void onInit() {
    super.onInit();
    initFavorites();
  }

  // function to init favorite by reading from storage
  Future<void> initFavorites() async {

    final json = TLocalStorage.instance().readData('favorites');
    if(json != null){
      final storedFavorites = jsonDecode(json) as Map<String,dynamic>;
      favorites.assignAll(storedFavorites.map((key,value) => MapEntry(key, value as bool)));

    }
  }

  bool isFavorite(String productId){
    return favorites[productId] ?? false;
  }

  void toggleFavoriteProduct (String productId){
    if(!favorites.containsKey(productId)){
      favorites[productId] = true;
      saveFavoritesToStorage();
      TLoaders.customToast(message: 'Product has been added to wishlist');
    }else{
      TLocalStorage.instance().removeData(productId);
      favorites.remove(productId);
      saveFavoritesToStorage();
      favorites.refresh();
      TLoaders.customToast(message: 'Product has been removed from the wishlist');

    }
  }

  void saveFavoritesToStorage(){
    final encodedFavorites = json.encode(favorites);
    TLocalStorage.instance().saveData('favorites', encodedFavorites);
  }

  Future<List<ProductModel>> favoriteProducts()async{
    return await ProductRepo.instance.getFavoriteProducts(favorites.keys.toList());
  }
}
