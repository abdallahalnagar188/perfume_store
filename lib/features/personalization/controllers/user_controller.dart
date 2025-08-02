import 'package:ecommerce_store/data/repo/auth/auth_repo.dart';
import 'package:ecommerce_store/data/repo/user/user_repo.dart';
import 'package:ecommerce_store/features/auth/screens/login/login.dart';
import 'package:ecommerce_store/features/personalization/models/user_model.dart';
import 'package:ecommerce_store/features/personalization/screens/profile/widgets/re_auth_user_login_form.dart';
import 'package:ecommerce_store/utils/constants/image_strings.dart';
import 'package:ecommerce_store/utils/constants/sizes.dart';
import 'package:ecommerce_store/utils/popups/full_screen_loader.dart';
import 'package:ecommerce_store/utils/popups/loaders.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../../utils/helpers/network_manager.dart';

class UserController extends GetxController {
  static UserCredential get instance => Get.find();

  final profileLoading = false.obs;
  Rx<UserModel> user = UserModel.empty.obs;
  final userRepo = Get.put(UserRepo());

  final hidePassword = false.obs;
  final imageUploading = false.obs;
  final verifyEmail = TextEditingController();
  final verifyPassword = TextEditingController();
  GlobalKey<FormState> reAuthFormKey = GlobalKey<FormState>();

  @override
  void onInit() {
    super.onInit();
    fetchUserRecord();
  }

  Future<void> fetchUserRecord() async {
    try {
      profileLoading.value = true;
      final user = await userRepo.fetchUserDetails();
      this.user(user);
      profileLoading.value = false;
    } catch (e) {
      user(UserModel.empty);
    } finally {
      profileLoading.value = false;
    }
  }

  /// save user record from any Registraion provider
  Future<void> saveUserRecord(UserCredential? userCredential) async {
    try {
      // refresh the user record
      await fetchUserRecord();
      if (user.value.id.isEmpty) {
        if (userCredential != null) {
          final nameParts = UserModel.namePars(
            userCredential.user?.displayName ?? "",
          );
          final userName = UserModel.generateUsername(
            userCredential.user?.displayName ?? "",
          );

          final user = UserModel(
            id: userCredential.user!.uid,
            firstName: nameParts[0],
            lastName: nameParts.length > 1
                ? nameParts.sublist(1).join(" ")
                : "",
            username: userName,
            email: userCredential.user!.email ?? "",
            phoneNumber: userCredential.user!.phoneNumber ?? "",
            profilePicture: userCredential.user!.photoURL ?? "",
          );

          // save user data
          await userRepo.saveUserRecord(user);
        }
      }
    } catch (e) {
      TLoaders.warningSnackBar(
        title: 'Data Not save',
        message:
            'Something went wrong while saving your info . You can re-save your data again',
      );
    }
  }

  /// delete account warning
  void deleteAccountWarningPopup() async {
    Get.defaultDialog(
      contentPadding: EdgeInsets.all(TSizes.md),
      title: 'Delete Account',
      middleText: 'Are your sure your want to delete your account permanently?',
      confirm: ElevatedButton(
        onPressed: () => deleteUserAccount,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.red,
          side: const BorderSide(color: Colors.red),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: TSizes.lg),
          child: Text('Delete'),
        ),
      ),
      cancel: OutlinedButton(
        onPressed: () => Navigator.of(Get.overlayContext!).pop(),
        child: Text('Cancel'),
      ),
    );
  }

  /// Delete User Account
  void deleteUserAccount() async {
    try {
      TFullScreenLoader.openLoadingDialog(
        'Processing...',
        TImages.docerAnimation,
      );

      /// First ReAuth User
      final auth = AuthenticationRepo.instance;
      final provider = auth.authUser!.providerData
          .map((e) => e.providerId)
          .first;
      TFullScreenLoader.stopLoading();
      Get.to(() => ReAuthUserLoginForm());
      // if (provider.isNotEmpty) {
      //   if (provider == "google.come") {
      //     await auth.signInWithGoogle();
      //     await auth.deleteAccount();
      //     TFullScreenLoader.stopLoading();
      //     Get.offAll(() => LoginScreen());
      //   } else if (provider == "password") {
      //
      //   }
      // }
    } catch (e) {
      TFullScreenLoader.stopLoading();
      TLoaders.errorSnackBar(title: "Oh Snap", message: e.toString());
    }
  }

  /// re Auth before deleting
  Future<void> reAuthEmailAndPasswordUser() async {
    try {
      TFullScreenLoader.openLoadingDialog(
        'Processing...',
        TImages.docerAnimation,
      );
      // check Internet connection
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        TFullScreenLoader.stopLoading();
        return;
      }
      // Form Validate
      if (!reAuthFormKey.currentState!.validate()) {
        TFullScreenLoader.stopLoading();
        return;
      }

      await AuthenticationRepo.instance.reAuthWithEmailAndPassword(
        verifyEmail.text.trim(),
        verifyPassword.text.trim(),
      );
      await AuthenticationRepo.instance.deleteAccount();
      TFullScreenLoader.stopLoading();
      Get.offAll(() => LoginScreen());
    } catch (e) {
      TFullScreenLoader.stopLoading();
      TLoaders.errorSnackBar(title: "Oh Snap", message: e.toString());
    }
  }

  /// Upload profile image
  uploadUserProfileImage() async {
    try {
      final image = await ImagePicker().pickImage(
        source: ImageSource.gallery,
        imageQuality: 70,
        maxHeight: 512,
        maxWidth: 512,
      );
      if (image != null) {
        imageUploading.value = true;
        // Upload Image
        final imageUrl = await userRepo.uploadImage(
          'User/Images/Profile/',
          image,
        );

        //Upload User Image record
        Map<String, dynamic> json = {'ProfilePicture': imageUrl};
        await userRepo.updateSingField(json);

        user.value.profilePicture = imageUrl;

        user.refresh();
        TLoaders.successSnackBar(
          title: 'Congratulations',
          message: 'Your profile image has been updated',
        );
      }
    } catch (e) {
      TLoaders.errorSnackBar(title: "Oh Snap", message: e.toString());
    } finally {
      imageUploading.value = false;
    }
  }
}
