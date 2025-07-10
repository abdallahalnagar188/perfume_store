import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_store/utils/exceptions/firebase_exceptions.dart';
import 'package:ecommerce_store/utils/exceptions/format_exceptions.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../../features/personalization/models/user_model.dart';
import '../../../utils/exceptions/platform_exceptions.dart';

class UserRepo extends GetxController {
  static UserRepo get instance => Get.find();

  final FirebaseFirestore _dp = FirebaseFirestore.instance;

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
}