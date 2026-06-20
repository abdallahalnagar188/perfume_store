import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_store/data/repo/auth/auth_repo.dart';
import 'package:ecommerce_store/utils/exceptions/firebase_exceptions.dart';
import 'package:ecommerce_store/utils/exceptions/format_exceptions.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:ecommerce_store/utils/constants/supabase_config.dart';

import '../../../features/personalization/models/user_model.dart';
import '../../../utils/exceptions/platform_exceptions.dart';
import '../../../utils/logging/logger.dart';

class UserRepo extends GetxController {
  static UserRepo get instance => Get.find();

  final FirebaseFirestore _dp = FirebaseFirestore.instance;

  /// Fun to save user data to firestore
  Future<void> saveUserRecord (UserModel user) async{
    try{
      await TLoggerHelper.wrapFirestoreCall(
        'Save User Record',
        _dp.collection('Users').doc(user.id).set(user.toJson()),
      );
    } on FirebaseException catch(e){
      throw TFirebaseException(e.code).message;
    }on FormatException catch(_){
      throw const TFormatException();
    }on PlatformException catch (e){
      throw TPlatformException(e.code).message;
    }catch(e){
      throw 'Something went wrong , Please try again';
    }
  }

  /// fun to fetch user data based on user ID
  Future<UserModel> fetchUserDetails () async{
    try{
      final documentSnapshot = await TLoggerHelper.wrapFirestoreCall(
        'Fetch User Details',
        _dp.collection('Users').doc(AuthenticationRepo.instance.authUser?.uid).get(),
      );

      if(documentSnapshot.exists){
        return UserModel.fromSnapshot(documentSnapshot);
      }else{
        return UserModel.empty;
      }
    } on FirebaseException catch(e){
      throw TFirebaseException(e.code).message;
    }on FormatException catch(_){
      throw const TFormatException();
    }on PlatformException catch (e){
      throw TPlatformException(e.code).message;
    }catch(e){
      throw 'Something went wrong , Please try again';
    }
  }

  /// fun to update user data in firestore
  Future<void> updateUserDetails (UserModel updatedUser) async{
    try{
      await TLoggerHelper.wrapFirestoreCall(
        'Update User Details',
        _dp.collection('Users').doc(updatedUser.id).update(updatedUser.toJson()),
      );

    } on FirebaseException catch(e){
      throw TFirebaseException(e.code).message;
    }on FormatException catch(_){
      throw const TFormatException();
    }on PlatformException catch (e){
      throw TPlatformException(e.code).message;
    }catch(e){
      throw 'Something went wrong , Please try again';
    }
  }

  /// fun to update any field in specific User Collection
  Future<void> updateSingField (Map<String , dynamic> json) async{
    try{
      await TLoggerHelper.wrapFirestoreCall(
        'Update User Single Field',
        _dp.collection('Users').doc(AuthenticationRepo.instance.authUser?.uid).update(json),
      );

    } on FirebaseException catch(e){
      throw TFirebaseException(e.code).message;
    }on FormatException catch(_){
      throw const TFormatException();
    }on PlatformException catch (e){
      throw TPlatformException(e.code).message;
    }catch(e){
      throw 'Something went wrong , Please try again';
    }
  }

  /// fun to remove user data from firestore
  Future<void> removeUserRecord (String userId) async{
    try{
      await TLoggerHelper.wrapFirestoreCall(
        'Remove User Record',
        _dp.collection('Users').doc(userId).delete(),
      );

    } on FirebaseException catch(e){
      throw TFirebaseException(e.code).message;
    }on FormatException catch(_){
      throw const TFormatException();
    }on PlatformException catch (e){
      throw TPlatformException(e.code).message;
    }catch(e){
      throw 'Something went wrong , Please try again';
    }
  }

  /// Upload any Image
  Future<String> uploadImage (String path, XFile image) async{
    try{

      final ref = FirebaseStorage.instance.ref(path).child(image.name);
      await ref.putFile(File(image.path));
      final url = await ref.getDownloadURL();
      return url;
    } on FirebaseException catch(e){
      throw TFirebaseException(e.code).message;
    }on FormatException catch(_){
      throw const TFormatException();
    }on PlatformException catch (e){
      throw TPlatformException(e.code).message;
    }catch(e){
      throw 'Something went wrong , Please try again';
    }
  }

  /// Upload Profile Image to Supabase
  Future<String> uploadImageToSupabase(String path, XFile image) async {
    try {
      final file = File(image.path);
      // Ensure unique and safe filename (strip non-ascii characters)
      final ext = image.name.split('.').last;
      final fileName = '${DateTime.now().millisecondsSinceEpoch}.$ext';
      final fullPath = '$path/$fileName';

      // Upload to Supabase bucket
      await Supabase.instance.client.storage
          .from(SupabaseConfig.storageBucket)
          .upload(fullPath, file);

      // Get public URL
      final publicUrl = Supabase.instance.client.storage
          .from(SupabaseConfig.storageBucket)
          .getPublicUrl(fullPath);

      return publicUrl;
    } catch (e) {
      print('🔥 SUPABASE UPLOAD ERROR (UserRepo): $e');
      throw 'Something went wrong while uploading to Supabase: $e';
    }
  }
}