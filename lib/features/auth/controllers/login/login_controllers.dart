import 'package:ecommerce_store/data/repo/auth/auth_repo.dart';
import 'package:ecommerce_store/features/personalization/controllers/user_controller.dart';
import 'package:ecommerce_store/utils/helpers/network_manager.dart';
import 'package:ecommerce_store/utils/popups/full_screen_loader.dart';
import 'package:ecommerce_store/utils/popups/loaders.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../../../data/repo/user/user_repo.dart';
import '../../../../utils/constants/image_strings.dart';

class LoginControllers extends GetxController {
  /// variables
  ///
  final rememberMe = false.obs;
  final hidePassword = true.obs;
  final localStorage = GetStorage();
  final email = TextEditingController();
  final password = TextEditingController();

  GlobalKey<FormState> loginFormKey = GlobalKey<FormState>();
  final userControl = Get.put(UserController());

  @override
  void onInit() {
    email.text = localStorage.read('REMEMBER_ME_EMAIL') ?? '';
    password.text = localStorage.read('REMEMBER_ME_PASSWORD') ?? '';
    super.onInit();
  }

  /// Email and Password Sign in
  Future<void> emailAndPasswordSignIn() async {
    try {
      // Start Loading
      TFullScreenLoader.openLoadingDialog(
        'Logging you in...',
        TImages.docerAnimation,
      );

      // check Internet connection
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        TFullScreenLoader.stopLoading();
        return;
      }

      // Form Validate
      if (!loginFormKey.currentState!.validate()) {
        TFullScreenLoader.stopLoading();
        return;
      }

      // Save data if remember me is selected
      if (rememberMe.value) {
        localStorage.write('REMEMBER_ME_EMAIL', email.text.trim());
        localStorage.write('REMEMBER_ME_PASSWORD', password.text.trim());
      }

      // Login user using Email and Password Auth
      final user = await AuthenticationRepo.instance
          .loginWithEmailAndPassword(email.text.trim(), password.text.trim());

      // Remove Loading
      TFullScreenLoader.stopLoading();

      // Redirect
      AuthenticationRepo.instance.screenRedirect();
    } catch (e) {
      TFullScreenLoader.stopLoading();
      TLoaders.errorSnackBar(title: "Oh Snap", message: e.toString());
    }
  }

  /// Google Sign in
  Future<void> googleSignIn() async{
    try{
      // Start Loading
      TFullScreenLoader.openLoadingDialog(
        'Logging you in...',
        TImages.docerAnimation,
      );

      // check Internet connection
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        TFullScreenLoader.stopLoading();
        return;
      }

      // Google Auth
      final userCredentials = await AuthenticationRepo.instance.signInWithGoogle();

      // save user data
      await userControl.saveUserRecord( userCredentials);

      // stop loading
      TFullScreenLoader.stopLoading();

    }catch(e){
      TFullScreenLoader.stopLoading();
      TLoaders.errorSnackBar(title: 'Oh Snap', message: e.toString());
    }
  }
}
