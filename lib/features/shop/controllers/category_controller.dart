import 'package:ecommerce_store/data/repo/category/category_repo.dart';
import 'package:ecommerce_store/features/shop/models/category_model.dart';
import 'package:ecommerce_store/utils/popups/loaders.dart';
import 'package:get/get.dart';

class CategoryController extends GetxController {
  static CategoryController get instance => Get.find();

  final isLoading = false.obs;
  final _categoryRepo = Get.put(CategoryRepo());
  RxList<CategoryModel> allCategories = <CategoryModel>[].obs;
  RxList<CategoryModel> featuredCategories = <CategoryModel>[].obs;

  @override
  void onInit() {
    fetchCategories();
    super.onInit();
  }

  /// ---- Load Category Data
  Future<void> fetchCategories() async {
    try {
      // show loading
      isLoading.value = true;

      // fetch category from data source
      final categories = await _categoryRepo.getAllCategories();

      // update the category list
      allCategories.assignAll(categories);

      // filter featured categories

      featuredCategories.assignAll(
        allCategories
            .where(
              (category) => category.isFeatured && category.parentId.isEmpty,
            )
            .take(8)
            .toList(),
      );
    } catch (e) {
      TLoaders.errorSnackBar(title: 'Oh Snap!', message: e.toString());
    } finally {
      // remove loading
      isLoading.value = false;
    }
  }

  /// ---- Load Selected Category Data

  /// ---- Get Category or sub-category Products
}
