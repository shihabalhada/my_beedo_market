import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_beedo_market/controllers/categories_controller.dart';
import 'package:my_beedo_market/controllers/product_controller.dart';
import 'package:my_beedo_market/pages/product_page.dart';
import 'package:my_beedo_market/routes/route_helper.dart';

import 'helper/dependencies.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Get.find<ProductController>().getProducts();
    // Get.find<CategoryController>().fetchCategories();
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Beedo Market',
      home: ProductView(),
      initialRoute: RouteHelper.login,
      getPages: RouteHelper.routes,
    );
  }
}
