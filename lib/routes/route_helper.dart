import 'package:my_beedo_market/pages/login_page.dart';
import 'package:my_beedo_market/pages/product_details_page.dart';
import 'package:my_beedo_market/pages/product_page.dart';
import 'package:my_beedo_market/pages/signup_page.dart';
import 'package:get/get.dart';


class RouteHelper {
  static const String home = "/";
  static const String signUp = "/sign-up";
  static const String login = "/login";
  static const String product="/product";
  //هذا مابش معي له صفحة
  static const String productByCategoryId="/productByCategoryId";

  static String getHome() => "$home";

  static String getSignUp() => "$signUp";

  static String getLogin() => "$login";

  static String getProduct(int productId) => "$product?productId=$productId";

  static String getProductByCategoryId(int categoryId) => "$productByCategoryId?categoryId=$categoryId";

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
      name: product,
      page: () {
        var productId = Get.parameters['productId'];
        return ProductDetailView(productId: int.parse(productId!));
      },
      transition: Transition.fadeIn,
    ),

  ];
}
