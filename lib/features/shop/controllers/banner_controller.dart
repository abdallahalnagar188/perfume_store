import 'package:ecommerce_store/data/repo/banner/banner_repo.dart';
import 'package:ecommerce_store/features/shop/models/banner_model.dart';
import 'package:get/get.dart';

import '../../../data/repo/brands/brand_repo.dart';
import '../../../utils/popups/loaders.dart';

class BannerController extends GetxController{
  static BannerController get instance => Get.find();

  // Variables
  final carousalCurrentIndex = 0.obs;
  final isLoading = false.obs;
  final _bannerRepo = Get.put(BannerRepo());
  RxList<BannerModel> allBanners = <BannerModel>[].obs;


  @override
  void onInit() {
    fetchBanners();
    super.onInit();
  }
  // Update Page Dots
  void updatePageIndicator(index){
    carousalCurrentIndex.value = index;
  }

  //Fetch Banner
  Future<void> fetchBanners() async {
    try {
      // show loading
      isLoading.value = true;

      // fetch category from data source
      final banners = await _bannerRepo.getAllBanners();

      // update the category list
      allBanners.assignAll(banners);


    } catch (e) {
      TLoaders.errorSnackBar(title: 'Oh Snap!', message: e.toString());
    } finally {
      // remove loading
      isLoading.value = false;
    }
  }

}