import 'package:my_beedo_market/controllers/address_controller.dart';
import 'package:my_beedo_market/controllers/categories_controller.dart';
import 'package:my_beedo_market/pages/category_page.dart';
import 'package:my_beedo_market/routes/route_helper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_beedo_market/controllers/product_controller.dart';
import 'package:my_beedo_market/models/product_model.dart';
import 'package:my_beedo_market/pages/product_details_page.dart';

import '../controllers/payment_controller.dart';

class ProductView extends StatelessWidget {
  final ProductController productController = Get.find<ProductController>();


  @override
  Widget build(BuildContext context) {
    // productController.getProducts();
    return Scaffold(
      appBar: AppBar(
        title: Text('Products'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            GestureDetector(
              onTap: (){
                Get.find<PaymentController>().fetchPaymentTypes();
                Get.toNamed(RouteHelper.getPayment());
              },
              child: Text("Payment"),
            ),
            SizedBox(height: 10,),
            GestureDetector(
              onTap: (){

                Get.toNamed(RouteHelper.getAddress());
              },
              child: Text("Address"),
            ),
            SizedBox(height: 20,),
            CategoryPage(),
            SizedBox(height: 20,),
            Obx(() {
              if (productController.isLoading.value) {
                return Center(child: CircularProgressIndicator());
              } else if (productController.products.isEmpty) {
                return Center(child: Text('No products available'));
              } else {
                return ListView.builder(
                  shrinkWrap: true,
                  itemCount: productController.products.length,
                  itemBuilder: (context, index) {
                    Product product = productController.products[index];
                    return ListTile(
                      title: Text(product.productName+''+product.productId.toString()),
                      subtitle: Text(product.productDescription),
                      onTap: () {
                        productController.getProductById(product.productId);
                        Get.toNamed(RouteHelper.getProduct(product.productId));
                      },
                    );
                  },
                );
              }
            }),
          ],
        ),
      ),
    );
  }
}