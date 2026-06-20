import 'package:ecommerce_store/data/repo/products/products_repo.dart';
import 'package:ecommerce_store/features/shop/models/product_model.dart';
import 'package:ecommerce_store/utils/popups/loaders.dart';
import 'package:ecommerce_store/features/shop/controllers/category_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TSearchController extends GetxController {
  static TSearchController get instance => Get.find();

  final isLoading = false.obs;
  final searchTextController = TextEditingController();
  
  RxList<ProductModel> allProducts = <ProductModel>[].obs;
  RxList<ProductModel> searchResults = <ProductModel>[].obs;
  
  final _productRepo = Get.put(ProductRepo());

  final searchQuery = ''.obs;

  @override
  void onInit() {
    fetchAllProducts();
    debounce(searchQuery, (query) => _performSearch(query.toString()), time: const Duration(milliseconds: 500));
    super.onInit();
  }

  Future<void> fetchAllProducts() async {
    try {
      isLoading.value = true;
      final products = await _productRepo.getAllProducts();
      allProducts.assignAll(products);
    } catch (e) {
      TLoaders.errorSnackBar(title: 'Oh Snap!', message: e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  void _performSearch(String query) {
    if (query.isEmpty) {
      searchResults.clear();
      return;
    }
    
    final lowerQuery = query.toLowerCase();
    final categories = CategoryController.instance.allCategories;

    final results = allProducts.where((product) {
      final matchesTitle = product.title.toLowerCase().contains(lowerQuery);
      final matchesBrand = product.brand?.name.toLowerCase().contains(lowerQuery) ?? false;
      
      final matchesCategory = categories.any((category) => 
        category.id == product.categoryId && category.name.toLowerCase().contains(lowerQuery)
      );

      return matchesTitle || matchesBrand || matchesCategory;
    }).toList();
    
    searchResults.assignAll(results);
  }

  @override
  void onClose() {
    searchTextController.dispose();
    super.onClose();
  }
}
