import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:my_beedo_market/controllers/categories_controller.dart';
import 'package:my_beedo_market/controllers/product_controller.dart';
import 'package:my_beedo_market/pages/product_page.dart';
import 'package:my_beedo_market/routes/route_helper.dart';

import 'controllers/cart_controller.dart';
import 'helper/dependencies.dart';
import 'models/cart_model.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await init();
  await GetStorage.init();
  CartStorageService cartStorageService = CartStorageService();

  // Example Cart Data
  // Map<int, CartModule> cart = {
  //   1: CartModule(id: 1, name: "Item 1",desc: "desc",img: "sdcsdc", price: 10, quantity: 2),
  //   2: CartModule(id: 2, name: "Item 2",desc: "desc",img: "sdcsdc", price: 20, quantity: 1),
  // };

  // Save the cart to storage
  // cartStorageService.saveCart(cart);

  // Load the cart from storage
  // Map<int, CartModule> loadedCart = cartStorageService.loadCart();
  // print(loadedCart);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Get.find<ProductController>().getProducts();
    Get.find<CategoryController>().fetchCategories();
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Beedo Market',
      home: ProductView(),
      initialRoute: RouteHelper.login,
      getPages: RouteHelper.routes,
    );
  }
}
