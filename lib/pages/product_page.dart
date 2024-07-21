import 'package:my_beedo_market/routes/route_helper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_beedo_market/controllers/product_controller.dart';
import 'package:my_beedo_market/models/product_model.dart';
import 'package:my_beedo_market/pages/product_details_page.dart';

class ProductView extends StatelessWidget {
  final ProductController productController = Get.find<ProductController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Products'),
      ),
      body: Obx(() {
        if (productController.isLoading.value) {
          return Center(child: CircularProgressIndicator());
        } else if (productController.products.isEmpty) {
          return Center(child: Text('No products available'));
        } else {
          return ListView.builder(
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
    );
  }
}