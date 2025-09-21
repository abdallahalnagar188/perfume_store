import 'package:ecommerce_store/common/widgets/success_screen/success_screen.dart';
import 'package:ecommerce_store/data/repo/auth/auth_repo.dart';
import 'package:ecommerce_store/features/personalization/controllers/address_controller.dart';
import 'package:ecommerce_store/features/shop/controllers/product/cart_controller.dart';
import 'package:ecommerce_store/features/shop/controllers/product/checkout_controller.dart';
import 'package:ecommerce_store/features/shop/controllers/product/variation_controller.dart';
import 'package:ecommerce_store/features/shop/models/cart_item_model.dart';
import 'package:ecommerce_store/features/shop/models/order_model.dart';
import 'package:ecommerce_store/features/shop/models/payment_method_model.dart';
import 'package:ecommerce_store/navigation_menu.dart';
import 'package:ecommerce_store/utils/local_storage/storage_utility.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../common/widgets/texts/section_heading.dart';
import '../../../../data/repo/orders/order_repo.dart';
import '../../../../utils/constants/enums.dart';
import '../../../../utils/constants/image_strings.dart';
import '../../../../utils/constants/sizes.dart';
import '../../../../utils/popups/full_screen_loader.dart';
import '../../../../utils/popups/loaders.dart';
import '../../models/product_model.dart';
import '../../screens/checkout/widgets/payment_tile.dart';

class OrderController extends GetxController {
  static OrderController get instance => Get.find();

  // Variables
  final cartController = CartController.instance;
  final addressController = AddressController.instance;
  final checkoutController = CheckoutController.instance;
  final orderRepo = Get.put(OrderRepo());

  /// fetch user order history
  Future<List<OrderModel>> fetchUserOrders() async {
    try {
      final orders = await orderRepo.fetchUserOrders();
      return orders;
    } catch (e) {
      TLoaders.warningSnackBar(title: 'Oh Snap!', message: e.toString());
      return [];
    }
  }

  /// Add methods for order processing
  void processOrder(double totalAmount) async {
    try {
      // Start Loader
      TFullScreenLoader.openLoadingDialog(
        'processingYourOrder'.tr,
        TImages.pencilAnimation,
      );

      // Get user authentication Id
      final userId = AuthenticationRepo.instance.authUser!.uid;
      if (userId.isEmpty) return;

      // Add Details
      final order = OrderModel(
        // Generate a unique ID for the order
        id: UniqueKey().toString(),
        userId: userId,
        status: OrderStatus.processing,
        totalAmount: totalAmount,
        orderDate: DateTime.now(),
        paymentMethod: checkoutController.selectedPaymentMethod.value.name,
        address: addressController.selectedAddress.value,
        // Set Date as needed
        deliveryDate: DateTime.now(),
        items: cartController.cartItems.toList(),
      );

      // Save the order to Firestore
      await orderRepo.saveOrder(order, userId);
      await orderRepo.saveOrderToFirestore(order);

      cartController.clearCart();

      // Show Success screen

      Get.off(
        () => SuccessScreen(
          title: 'thisOrderIsProcessing'.tr,
          subTitle: 'yourItemWillBeShippedSoon'.tr,
          image: TImages.successfulPaymentIcon,
          onPressed: () => Get.offAll(() => const NavigationMenu()),
        ),
      );

      // You might want to update cart or navigate somewhere here...
    } catch (e) {
      // Handle errors (optional)
      TLoaders.errorSnackBar(title: 'Oh Snap!',message: e.toString());
    }
  }
}
