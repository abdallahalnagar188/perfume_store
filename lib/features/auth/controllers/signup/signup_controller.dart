import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:ecommerce_store/data/repo/auth/auth_repo.dart';
import 'package:ecommerce_store/data/repo/user/user_repo.dart';
import 'package:ecommerce_store/features/auth/screens/signup/verfiy_email.dart';
import 'package:ecommerce_store/utils/popups/full_screen_loader.dart';
import 'package:ecommerce_store/utils/popups/loaders.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../../../utils/constants/image_strings.dart';
import '../../../../utils/helpers/network_manager.dart';
import '../../../personalization/models/user_model.dart';

class SignupController extends GetxController {
  static SignupController get instance => Get.find();

  /// Variables

  final hidePassword = true.obs;
  final privacyPolicy = true.obs;
  final email = TextEditingController();
  final firstName = TextEditingController();
  final lastName = TextEditingController();
  final username = TextEditingController();
  final password = TextEditingController();
  final phoneNumber = TextEditingController();
  GlobalKey<FormState> signupFormKey = GlobalKey<FormState>();

  /// SIGNUP
  void signup() async {
    bool isSignupSuccess = false; // flag to track success

    try {
      // Start Loading
      TFullScreenLoader.openLoadingDialog(
        'We are processing your information ...',
        TImages.docerAnimation,
      );

      // Check Network Connection
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) return;

      // Form Validation
      if (!signupFormKey.currentState!.validate()) return;

      // Privacy Policy Check
      if (!privacyPolicy.value) {
        TLoaders.warningSnackBar(
          title: 'Accept Privacy Policy',
          message: 'In order to create an account, you must accept the Privacy Policy and Terms of Use.',
        );
        return;
      }

      // Register user in Firebase Auth
      final userCredential = await AuthenticationRepo.instance
          .registerWithEmailAndPassword(
        email.text.trim(),
        password.text.trim(),
      );

      // Save user data in Firestore
      final newUser = UserModel(
        id: userCredential.user!.uid,
        firstName: firstName.text.trim(),
        lastName: lastName.text.trim(),
        username: username.text.trim(),
        email: email.text.trim(),
        phoneNumber: phoneNumber.text.trim(),
        profilePicture: '',
      );

      final userRepo = Get.put(UserRepo());
      await userRepo.saveUserRecord(newUser);

      // Show success message
      TLoaders.successSnackBar(
        title: 'Congratulations',
        message: 'Your account has been created! Please verify your email to continue.',
      );

      // Mark signup as successful
      isSignupSuccess = true;

    } catch (e) {
      // Show error message
      TLoaders.errorSnackBar(title: 'Oops!', message: e.toString());
    } finally {
      // Stop loading
      TFullScreenLoader.stopLoading();

      // Navigate if signup was successful
      if (isSignupSuccess) {
        Get.to(() => const VerifyEmailScreen());
      }
    }
  }

}
