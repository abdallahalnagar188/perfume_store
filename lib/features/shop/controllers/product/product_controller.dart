import 'package:ecommerce_store/data/repo/banner/banner_repo.dart';
import 'package:ecommerce_store/features/shop/models/banner_model.dart';
import 'package:ecommerce_store/features/shop/models/product_model.dart';
import 'package:get/get.dart';

import '../../../../data/repo/products/products_repo.dart';
import '../../../../utils/popups/loaders.dart';

class ProductController extends GetxController{
  static ProductController get instance => Get.find();

  // Variables
  final isLoading = false.obs;
  RxList<ProductModel> featuredProducts = <ProductModel>[].obs;
  final _productRepo = Get.put(ProductRepo());

  @override
  void onInit() {
    fetchFeatureProducts();
    super.onInit();
  }

  //Fetch Banner
  Future<void> fetchFeatureProducts() async {
    try {
      // show loading
      isLoading.value = true;

      // fetch category from data source
      final products = await _productRepo.getFeaturedProducts();

      // update the category list
      featuredProducts.assignAll(products);


    } catch (e) {
      TLoaders.errorSnackBar(title: 'Oh Snap!', message: e.toString());
    } finally {
      // remove loading
      isLoading.value = false;
    }
  }

  Future<List<ProductModel>> fetchAllFeatureProducts() async {
    try {
      // fetch category from data source
      final products = await _productRepo.getAllFeaturedProducts();
      return products;

    } catch (e) {
      TLoaders.errorSnackBar(title: 'Oh Snap!', message: e.toString());
      return [];
    }
  }
  String getProductPrice(ProductModel product){

    return (product.salePrice> 0 ? product.salePrice : product.price).toString();
  }

  String? calculateSalePrecentage(double originalPrice , double? salePrice){
    if(salePrice == null || salePrice <= 0.0){
      return null;
    } if(originalPrice<= 0)return null;
    double percentage = ((originalPrice -salePrice) / originalPrice )*100;
    return percentage.toStringAsFixed(0);

  }

  String getProductStockStatus (int stock){
    return stock >0 ? 'In Stock' : 'Out of Stock';
  }

}