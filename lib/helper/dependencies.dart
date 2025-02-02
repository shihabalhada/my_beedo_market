import 'package:my_beedo_market/controllers/address_controller.dart';
import 'package:my_beedo_market/controllers/categories_by_id_controller.dart';
import 'package:my_beedo_market/controllers/payment_controller.dart';
import 'package:my_beedo_market/controllers/product_controller.dart';
import 'package:my_beedo_market/controllers/profile_controller.dart';
import 'package:my_beedo_market/data/repository/address_repo.dart';
import 'package:my_beedo_market/data/repository/categories_by_id_repo.dart';
import 'package:my_beedo_market/data/repository/payment_repo.dart';
import 'package:my_beedo_market/data/repository/product_repo.dart';
import 'package:get/get.dart';
import 'package:my_beedo_market/data/api/api_client.dart';
import 'package:my_beedo_market/data/repository/profile_repo.dart';
import 'package:my_beedo_market/utils/app_constants.dart';

import '../controllers/categories_controller.dart';
import '../controllers/login_controller.dart';
import '../controllers/signup_controller.dart';
import '../data/repository/categories_repo.dart';
import '../data/repository/login_repo.dart';
import '../data/repository/signup_repo.dart';

Future<void> init()async{
  //api client
  Get.lazyPut(()=>ApiClient(appBaseUrl: AppConstants.BASE_URL));

  //repo
  Get.lazyPut(() =>CategoryRepo(apiClient: Get.find()));
  Get.lazyPut(() =>LoginRepo(apiClient: Get.find()));
  Get.lazyPut(() =>SignupRepo(apiClient: Get.find()));
  Get.lazyPut(() =>ProductRepo(apiClient: Get.find()));
  Get.lazyPut(() =>PaymentRepo(apiClient: Get.find()));
  Get.lazyPut(() =>CategoriesByIdRepo(apiClient: Get.find()));
  Get.lazyPut(() =>AddressRepo(apiClient: Get.find()));
  Get.lazyPut(() =>ProfileRepo(apiClient: Get.find()));


  //controllers
  Get.lazyPut(() => CategoryController(categoryRepo: Get.find()));
  Get.lazyPut(() => LoginController(loginRepo: Get.find()));
  Get.lazyPut(() => SignupController(signupRepo: Get.find()));
  Get.lazyPut(() => ProductController(productRepo: Get.find()));
  Get.lazyPut(() => PaymentController(paymentRepo: Get.find()));
  Get.lazyPut(() => CategoriesByIdController(categoriesByIdRepo: Get.find()));
  Get.lazyPut(() => AddressController(addressRepo: Get.find()));
  Get.lazyPut(() => ProfileController(profileRepo: Get.find()));

}