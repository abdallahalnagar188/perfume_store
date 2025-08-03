
import 'package:ecommerce_store/features/auth/screens/login/login.dart';
import 'package:ecommerce_store/features/auth/screens/onboarding/onboarding.dart';
import 'package:ecommerce_store/features/shop/screens/home/home_screen.dart';
import 'package:ecommerce_store/routes/routes.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../features/auth/screens/password_configration/forget_password.dart';
import '../features/auth/screens/password_configration/reset_password.dart';
import '../features/auth/screens/signup/signup.dart';
import '../features/auth/screens/signup/verfiy_email.dart';
import '../features/personalization/screens/address/address_screen.dart';
import '../features/personalization/screens/settings/settings_screen.dart';
import '../features/shop/models/product_model.dart';
import '../features/shop/screens/all_products/all_products_screen.dart';
import '../features/shop/screens/cart/cart_screen.dart';
import '../features/shop/screens/checkout/checkout_screen.dart';
import '../features/shop/screens/orders/order_screen.dart';
import '../features/shop/screens/product_details/product_details.dart';
import '../features/shop/screens/store/store_screen.dart';
import '../features/shop/screens/sub_category/sub_categories_screen.dart';
import '../features/shop/screens/wishlist/wishlist_screen.dart';

class AppRoutes {
  static final pages = [
    // Main
    GetPage(name: TRoutes.home, page: () => const HomeScreen()),
    GetPage(name: TRoutes.store, page: () => const StoreScreen()),
    GetPage(name: TRoutes.favorite, page: () => const FavoriteScreen()),
    GetPage(name: TRoutes.settings, page: () => const SettingsScreen()),

    // Products
    GetPage(name: TRoutes.subCategories, page: () => const SubCategoriesScreen()),
    // GetPage(name: TRoutes.search, page: () => const SearchScreen()),
    // GetPage(name: TRoutes.productReview, page: () => const ProductReviewScreen()),
    GetPage(name: TRoutes.productDetails, page: () =>  ProductDetailsScreen(product:  ProductModel.empty(),)),
    GetPage(name: TRoutes.allProducts, page: () => const AllProductsScreen(title: '',)),
   // GetPage(name: TRoutes.brand, page: () => const BrandScreen()),

    // Cart & order
    GetPage(name: TRoutes.cart, page: () => const CartScreen()),
    GetPage(name: TRoutes.checkout, page: () => const CheckoutScreen()),
    GetPage(name: TRoutes.order, page: () => const OrderScreen()),

    // User
   // GetPage(name: TRoutes.userProfile, page: () => const UserProfileScreen()),
    GetPage(name: TRoutes.userAddress, page: () => const UserAddressScreen()),

    // Auth
    GetPage(name: TRoutes.signup, page: () => const SignupScreen()),
   // GetPage(name: TRoutes.signupSuccess, page: () => const SignupSuccessScreen()),
    GetPage(name: TRoutes.verifyEmail, page: () => const VerifyEmailScreen()),
    GetPage(name: TRoutes.signIn, page: () => const LoginScreen()),
   // GetPage(name: TRoutes.resetPassword, page: () => const ResetPasswordScreen()),
    GetPage(name: TRoutes.forgetPassword, page: () => const ForgetPasswordScreen()),

    // Onboarding
    GetPage(name: TRoutes.onBoarding, page: () => const OnboardingScreen()),
  ];
}

