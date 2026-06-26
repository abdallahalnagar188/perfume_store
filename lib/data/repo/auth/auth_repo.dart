import 'package:ecommerce_store/data/repo/user/user_repo.dart';
import 'package:ecommerce_store/features/auth/screens/login/login.dart';
import 'package:ecommerce_store/features/auth/screens/onboarding/onboarding.dart';
import 'package:ecommerce_store/features/auth/screens/signup/verfiy_email.dart';
import 'package:ecommerce_store/navigation_menu.dart';
import 'package:ecommerce_store/utils/exceptions/firebase_auth_exceptions.dart';
import 'package:ecommerce_store/utils/exceptions/firebase_exceptions.dart';
import 'package:ecommerce_store/utils/exceptions/format_exceptions.dart';
import 'package:ecommerce_store/utils/exceptions/platform_exceptions.dart';
import 'package:ecommerce_store/utils/local_storage/storage_utility.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:ecommerce_store/utils/logging/logger.dart';

class AuthenticationRepo extends GetxController {
  static AuthenticationRepo get instance => Get.find();

  final deviceStorage = GetStorage();
  final _auth = FirebaseAuth.instance;

  /// Get Auth User data
  User? get authUser => _auth.currentUser;

  @override
  void onReady() {
    try {
      FlutterNativeSplash.remove();
    } catch (e) {
      print('FlutterNativeSplash.remove() failed (likely on Web): $e');
    }
    screenRedirect();
  }

  void screenRedirect() async {
    final user = _auth.currentUser;
    if (user != null) {
      if (user.emailVerified) {

        await TLocalStorage.init(user.uid);
        Get.offAll(() => NavigationMenu());
      } else {
        Get.offAll(() => VerifyEmailScreen(email: _auth.currentUser?.email));
      }
    } else {
      deviceStorage.writeIfNull('IsFirstTime', true);
      deviceStorage.read('IsFirstTime') != true
          ? Get.offAll(() => const LoginScreen())
          : Get.offAll(() => const OnboardingScreen());
    }
  }

  /* ---------------------------- Email and Password sign in -----------------*/

  /// [ Email Auth ] Login
  Future<UserCredential> loginWithEmailAndPassword(
    String email,
    String password,
  ) async {
    try {
      return await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on FirebaseAuthException catch (e) {
      throw TFirebaseAuthException(e.code).message;
    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw TFormatException();
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong , Please try again';
    }
  }

  ///[Email Auth] sing Up
  Future<UserCredential> registerWithEmailAndPassword(
    String email,
    String password,
  ) async {
    try {
      return await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on FirebaseAuthException catch (e) {
      throw TFirebaseAuthException(e.code).message;
    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw TFormatException();
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong , Please try again';
    }
  }

  /// [Email Verification] - Mail Verify
  Future<void> sendEmailVerification() async {
    try {
      await _auth.currentUser?.sendEmailVerification();
    } on TFirebaseAuthException catch (e) {
      throw TFirebaseAuthException(e.code).message;
    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw TFormatException();
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong , Please try again';
    }
  }

  /// Forget Password
  Future<void> sendPasswordResetEmail(String email) async {
    await _auth.sendPasswordResetEmail(email: email);
    try {} on TFirebaseAuthException catch (e) {
      throw TFirebaseAuthException(e.code).message;
    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw TFormatException();
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong , Please try again';
    }
  }

  /* -------------------------- Federated identity and social Sign in ---------------------*/

  /// Google Sign in
  Future<UserCredential?> signInWithGoogle() async {
    try {
      TLoggerHelper.logRequest(service: 'FirebaseAuth', operation: 'signInWithGoogle');

      // Trigger the Google Sign-In flow
      final GoogleSignInAccount? userAccount = await GoogleSignIn().signIn();

      if (userAccount == null) {
        throw 'sign_in_canceled';
      }

      final GoogleSignInAuthentication googleAuth =
          await userAccount.authentication;

      if (googleAuth.accessToken == null && googleAuth.idToken == null) {
        throw 'No Authentication tokens found.';
      }

      // Create the credential
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      final userCredential = await _auth.signInWithCredential(credential);
      TLoggerHelper.logResponse(service: 'FirebaseAuth', operation: 'signInWithGoogle', duration: const Duration(milliseconds: 0), data: userCredential.user?.uid);
      return userCredential;
    } on FirebaseAuthException catch (e) {
      await GoogleSignIn().signOut();
      TLoggerHelper.logError(service: 'FirebaseAuth', operation: 'signInWithGoogle', error: 'FirebaseAuthException: ${e.code} - ${e.message}');
      throw TFirebaseAuthException(e.code).message;
    } on PlatformException catch (e) {
      await GoogleSignIn().signOut();
      TLoggerHelper.logError(service: 'GoogleSignIn', operation: 'signInWithGoogle', error: 'PlatformException: ${e.code} - ${e.message}');
      throw TPlatformException(e.code).message;
    } catch (e) {
      await GoogleSignIn().signOut();
      TLoggerHelper.logError(service: 'GoogleSignIn', operation: 'signInWithGoogle', error: 'Unknown Error: $e');
      throw 'Something went wrong , Please try again';
    }
  }

  /// Facebook Sign in

  /// Logout
  Future<void> logout() async {
    try {
      await GoogleSignIn().signOut();
      await FirebaseAuth.instance.signOut();
      
      // Clear Cache (Local Storage)
      deviceStorage.remove('REMEMBER_ME_EMAIL');
      deviceStorage.remove('REMEMBER_ME_PASSWORD');

      Get.offAll(() => LoginScreen());
    } on TFirebaseAuthException catch (e) {
      throw TFirebaseAuthException(e.code).message;
    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw TFormatException();
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong , Please try again';
    }
  }

  /// Delete Account
  Future<void> deleteAccount() async {
    try {
      await UserRepo.instance.removeUserRecord(_auth.currentUser!.uid);
      await _auth.currentUser?.delete();
    } on TFirebaseAuthException catch (e) {
      throw TFirebaseAuthException(e.code).message;
    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw TFormatException();
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong , Please try again';
    }
  }

  /// re Auth User
  Future<void> reAuthWithEmailAndPassword(String email, String password) async {
    try {
    AuthCredential credential = EmailAuthProvider.credential(email: email, password: password);
    await _auth.currentUser!.reauthenticateWithCredential(credential);
    } on TFirebaseAuthException catch (e) {
      throw TFirebaseAuthException(e.code).message;
    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw TFormatException();
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong , Please try again';
    }
  }
}
