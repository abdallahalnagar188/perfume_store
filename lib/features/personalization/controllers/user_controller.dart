import 'package:ecommerce_store/data/repo/user/user_repo.dart';
import 'package:ecommerce_store/features/personalization/models/user_model.dart';
import 'package:ecommerce_store/utils/popups/loaders.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class UserController extends GetxController {
  static UserCredential get instance => Get.find();

  final userRepo = Get.put(UserRepo());
  /// save user record from any Registraion provider
  Future<void> saveUserRecord(UserCredential? userCredential) async {
    try {
      if (userCredential != null) {
        final nameParts = UserModel.namePars(
            userCredential.user?.displayName ?? "");
        final userName = UserModel.generateUsername(
            userCredential.user?.displayName ?? "");

        final user = UserModel(id: userCredential.user!.uid,
            firstName: nameParts[0],
            lastName: nameParts.length > 1 ? nameParts.sublist(1).join(" ") : "",
            username: userName,
            email: userCredential.user!.email ??"",
            phoneNumber: userCredential.user!.phoneNumber ??"",
            profilePicture: userCredential.user!.photoURL ??"");

        // save user data
        await userRepo.saveUserRecord(user);
      }
    } catch (e) {
      TLoaders.warningSnackBar(
        title: 'Data Not save',
        message: 'Something went wrong while saving your info . You can re-save your data again',
      );
    }
  }
}
