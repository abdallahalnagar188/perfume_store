import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_store/data/repo/auth/auth_repo.dart';
import 'package:ecommerce_store/utils/exceptions/firebase_exceptions.dart';
import 'package:ecommerce_store/utils/exceptions/format_exceptions.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../../features/personalization/models/user_model.dart';
import '../../../utils/exceptions/platform_exceptions.dart';

class UserRepo extends GetxController {
  static UserRepo get instance => Get.find();

  final FirebaseFirestore _dp = FirebaseFirestore.instance;

  /// Fun to save user data to firestore
  Future<void> saveUserRecord (UserModel user) async{
    try{
      await _dp.collection('Users').doc(user.id).set(user.toJson());
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
      final documentSnapshot = await _dp.collection('Users').doc(AuthenticationRepo.instance.authUser?.uid).get();

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
   await _dp.collection('Users').doc(updatedUser.id).update(updatedUser.toJson());

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
      await _dp.collection('Users').doc(AuthenticationRepo.instance.authUser?.uid).update(json);

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
      await _dp.collection('Users').doc(userId).delete();

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
}