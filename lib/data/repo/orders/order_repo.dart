import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_store/data/repo/auth/auth_repo.dart';
import 'package:get/get.dart';

import '../../../features/shop/models/order_model.dart';

class OrderRepo extends GetxController{
  static OrderRepo get instance => Get.find();

  // -------------------- Variables --------------------
  final _db = FirebaseFirestore.instance;


// -------------------- FUNCTIONS --------------------

  /// Get all orders related to current User
  Future<List<OrderModel>> fetchUserOrders() async {
    try {
      final userId = AuthenticationRepo.instance.authUser!.uid;
      if (userId.isEmpty) throw 'Unable to find user information. Try again in few minutes.';

      final result = await _db
          .collection('Users')
          .doc(userId)
          .collection('Orders')
          .get();

      return result.docs
          .map((documentSnapshot) => OrderModel.fromSnapshot(documentSnapshot))
          .toList();
    } catch (e) {
      throw 'Something went wrong while fetching Order Information. Try again later';
    }
  }

  /// Store new user order
  Future<void> saveOrder(OrderModel order, String userId) async {
    try {
      await _db
          .collection('Users')
          .doc(userId)
          .collection('Orders')
          .add(order.toJson());
    } catch (e) {
      throw 'Something went wrong while saving Order Information. Try again later';
    }
  }

  /// save a new order to the Orders Collection in Firestore

Future<void> saveOrderToFirestore(OrderModel order) async {
    try{
      await _db.collection('Orders').add(order.toJson());
    }catch(e){
      throw 'Something went wrong while saving Order Information. Try again later';
    }
}


}
