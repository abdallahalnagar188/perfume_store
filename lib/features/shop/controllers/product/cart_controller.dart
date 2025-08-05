import 'package:ecommerce_store/features/shop/controllers/product/variation_controller.dart';
import 'package:ecommerce_store/features/shop/models/cart_item_model.dart';
import 'package:ecommerce_store/utils/local_storage/storage_utility.dart';
import 'package:get/get.dart';

import '../../../../utils/popups/loaders.dart';
import '../../models/product_model.dart';

class CartController extends GetxController {
  static CartController get instance => Get.find();

  // Variables
  RxInt noOfCartItem = 0.obs;
  RxDouble totalCartPrice = 0.0.obs;
  RxInt productQuantityInCart = 0.obs;
  RxList<CartItemModel> cartItems = <CartItemModel>[].obs;
  final variationController = VariationController.instance;


  CartController(){
    loadCartItems();
  }
  // Add items in the cart
  void addToCart(ProductModel product) {
    // Quantity Check
    if (productQuantityInCart.value < 1) {
      TLoaders.customToast(message: 'Select Quantity');
      return;
    }

    // Variation Selected?
    if (variationController.selectedVariation.value.id.isEmpty) {
      TLoaders.customToast(message: 'Select Variation');
      return;
    }

    // Out of Stock Status

    if (variationController.selectedVariation.value.stock < 1) {
      TLoaders.warningSnackBar(
        message: 'Selected variation is out of stock.',
        title: 'Oh Snap!',
      );
      return;
    } else {
      if (product.stock < 1) {
        TLoaders.warningSnackBar(
          message: 'Selected Product is out of stock.',
          title: 'Oh Snap!',
        );
        return;
      }
    }

    final selectedCartItem = convertToCartItem(
      product,
      productQuantityInCart.value,
    );

    int index = cartItems.indexWhere(
      (cartItem) =>
          cartItem.productId == selectedCartItem.productId &&
          cartItem.variationId == selectedCartItem.variationId,
    );

    if (index >= 0) {
      cartItems[index].quantity = selectedCartItem.quantity;
    } else {
      cartItems.add(selectedCartItem);
    }

    updateCart();

    TLoaders.customToast(message: 'Your Product has been add to the cart');
  }

  void addOneToCart(CartItemModel item) {
    int index = cartItems.indexWhere((cartItem) =>
    cartItem.productId == item.productId && cartItem.variationId == item.variationId);

    if (index >= 0) {
      cartItems[index].quantity += 1;
    } else {
      cartItems.add(item);
    }

    updateCart();
  }

  void removeOneFromCart(CartItemModel item) {
    int index = cartItems.indexWhere((cartItem) =>
    cartItem.productId == item.productId && cartItem.variationId == item.variationId);

    if (index >= 0) {
      if (cartItems[index].quantity > 1) {
        cartItems[index].quantity -= 1;
      } else {
        // Show dialog before completely removing
        cartItems[index].quantity == 1
            ? removeFromCartDialog(index)
            : cartItems.removeAt(index);
      }
    }

    updateCart();
  }

  void removeFromCartDialog(int index) {
    Get.defaultDialog(
      title: 'Remove Product',
      middleText: 'Are you sure you want to remove this product?',
      onConfirm: () {
        // Remove the item from the cart
        cartItems.removeAt(index);
        updateCart();
        TLoaders.customToast(message: 'Product removed from the Cart.');
        Get.back();
      },
      onCancel: () => Get.back(),
    );
  }


  CartItemModel convertToCartItem(ProductModel product, int quantity) {
    variationController.resetSelectedAttributes();

    final variation = variationController.selectedVariation.value;
    final isVariation = variation.id.isNotEmpty;

    final price = isVariation
        ? variation.salePrice > 0.0
              ? variation.salePrice
              : variation.price
        : product.salePrice > 0.0
        ? product.salePrice
        : product.price;

    return CartItemModel(
      productId: product.id,
      quantity: quantity,
      title: product.title,
      price: price,
      variationId: variation.id,
      brandName: product.brand != null ? product.brand!.name : '',
      image: isVariation ? variation.image : product.thumbnail,
      selectedVariation: isVariation ? variation.attributeValues : null,
    );
  }

  void updateCart() {
    updateCartTotals();
    saveCartItem();
    cartItems.refresh();
  }

  void updateCartTotals() {
    double calculateTotalPrice = 0.0;
    int calculateNoOfItems = 0;

    for (var item in cartItems) {
      calculateTotalPrice += (item.price) * item.quantity.toDouble();
      calculateNoOfItems += item.quantity;
    }
    totalCartPrice.value = calculateTotalPrice;
    noOfCartItem.value = calculateNoOfItems;
  }

  void saveCartItem() {
    final cartItemString = cartItems.map((item) => item.toJson()).toList();
    TLocalStorage.instance().writeData('cartItems', cartItemString);
  }

  void loadCartItems() {
    final carrItemsString = TLocalStorage.instance().readData<List<dynamic>>(
      'cartItems',
    );
    if (carrItemsString != null) {
      cartItems.assignAll(
        carrItemsString.map(
          (item) => CartItemModel.fromJson(item as Map<String, dynamic>),
        ),
      );
      updateCartTotals();
    }
  }

  int getProductQuantityInCart(String productId) {
    final foundItem = cartItems
        .where((item) => item.productId == productId)
        .fold(0, (previousValue, element) => previousValue + element.quantity);
    return foundItem;
  }

  int getVariationQuantityInCart(String productId, String variationId) {
    final foundItem = cartItems.firstWhere(
      (item) => item.productId == productId && item.variationId == variationId,
      orElse: () => CartItemModel.empty(),
    );
    return foundItem.quantity;
  }

  void clearCart(){
    productQuantityInCart.value = 0;
    cartItems.clear();
    updateCart();
  }

  void updateAlreadyAddedProductCount(ProductModel product){
    productQuantityInCart.value = getProductQuantityInCart(product.id);
    final variationId = variationController.selectedVariation.value.id;
    productQuantityInCart.value = getVariationQuantityInCart(product.id, variationId);
  }
}
