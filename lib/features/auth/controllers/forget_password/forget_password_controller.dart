import 'package:ecommerce_store/data/repo/auth/auth_repo.dart';
import 'package:ecommerce_store/features/auth/screens/password_configration/reset_password.dart';
import 'package:ecommerce_store/utils/popups/full_screen_loader.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../../../utils/constants/image_strings.dart';
import '../../../../utils/helpers/network_manager.dart';
import '../../../../utils/popups/loaders.dart';

class ForgetPasswordController extends GetxController {
  static ForgetPasswordController get instance => Get.find();

  final email = TextEditingController();
  GlobalKey<FormState> forgetPasswordFormKey = GlobalKey<FormState>();

  /// Send reset password email
  sendResetPasswordEmail() async {
    try {
      TFullScreenLoader.openLoadingDialog(
        'Processing your request...',
        TImages.docerAnimation,
      );

      // check Internet connection
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        TFullScreenLoader.stopLoading();
        return;
      }
      // Form Validate
      if (!forgetPasswordFormKey.currentState!.validate()) {
        TFullScreenLoader.stopLoading();
        return;
      }

      await AuthenticationRepo.instance.sendPasswordResetEmail(email.text.trim(),);

      // Remove Loading
      TFullScreenLoader.stopLoading();

      TLoaders.successSnackBar(title: 'Email Sent', message: 'Email Link Sent to reset your password'.tr);

      // Record
      Get.to(() => ResetPasswordScreen(email: email.text.trim()));
    } catch (e) {
      TFullScreenLoader.stopLoading();
      TLoaders.errorSnackBar(title: "Oh Snap", message: e.toString());
    }
  }

  resendPasswordResetEmail(String email) async {
    try {
      TFullScreenLoader.openLoadingDialog(
        'Processing your request...',
        TImages.docerAnimation,
      );

      // check Internet connection
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        TFullScreenLoader.stopLoading();
        return;
      }

      await AuthenticationRepo.instance.sendPasswordResetEmail(email);

      // Remove Loading
      TFullScreenLoader.stopLoading();

      TLoaders.successSnackBar(title: 'Email Sent', message: 'Email Link Sent to reset your password'.tr);

    } catch (e) {
      TFullScreenLoader.stopLoading();
      TLoaders.errorSnackBar(title: "Oh Snap", message: e.toString());
    }
  }
}
