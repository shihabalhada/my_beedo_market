import 'package:my_beedo_market/pages/login_page.dart';
import 'package:my_beedo_market/pages/payment_page.dart';
import 'package:my_beedo_market/pages/product_by_category.dart';
import 'package:my_beedo_market/pages/product_details_page.dart';
import 'package:my_beedo_market/pages/product_page.dart';
import 'package:my_beedo_market/pages/signup_page.dart';
import 'package:get/get.dart';

import '../pages/address_page.dart';


class RouteHelper {
  static const String home = "/";
  static const String signUp = "/sign-up";
  static const String login = "/login";
  static const String product="/product";
  static const String payment="/payment";
  static const String productByCategoryId="/productByCategoryId";
  static const String address="/address";

  static String getHome() => "$home";

  static String getSignUp() => "$signUp";

  static String getLogin() => "$login";

  static String getPayment() => "$payment";

  static String getProduct(int productId) => "$product?productId=$productId";

  static String getProductByCategoryId(int categoryId) => "$productByCategoryId?categoryId=$categoryId";

  static String getAddress() => "$address";

  static List<GetPage> routes = [
    GetPage(
        name: home,
        page: () {
          return ProductView();
        }),
    GetPage(
        name: signUp,
        page: (){
          return SignupPage();
        }
    ),
    GetPage(
        name: login,
        page: (){
          return LoginPage();
        }
    ),
    GetPage(
        name: payment,
        page: (){
          return PaymentPage();
        }
    ),
    GetPage(
        name: address,
        page: (){
          return AddressPage();
        }
    ),
    GetPage(
      name: product,
      page: () {
        var productId = Get.parameters['productId'];
        return ProductDetailView(productId: int.parse(productId!));
      },
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: productByCategoryId,
      page: () {
        var categoryId = Get.parameters['categoryId'];
        return ProductByCategoryPage(id: int.parse(categoryId!));
      },
      transition: Transition.fadeIn,
    ),

  ];
}
