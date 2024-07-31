import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_beedo_market/controllers/categories_by_id_controller.dart';
import 'package:my_beedo_market/controllers/categories_controller.dart';
import 'package:my_beedo_market/controllers/product_controller.dart';

import '../models/product_model.dart';
import '../routes/route_helper.dart';

class ProductByCategoryPage extends StatelessWidget {
  final int id;
  // final CategoriesByIdController categoriesByIdController = Get.find<CategoriesByIdController>();
  final ProductController productController = Get.find<ProductController>();
  ProductByCategoryPage({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    // categoriesByIdController.getCategoryById(id);
    productController.getProductByCategoryId(id);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Products by Category'),
      ),
      body: Column(
        children: [
          GetBuilder<CategoryController>(
            builder: (categoryController) {
              if (categoryController.isLoading) {
                return Center(child: CircularProgressIndicator());
              }else{
                return ListView.builder(
                  shrinkWrap: true,
                  itemCount: categoryController.categoriesById.length,
                  itemBuilder: (context, index) {
                    var category = categoryController.categoriesById[index];
                    return ExpansionTile(
                      title: Text(category.name+" "+category.id.toString()),
                      children: category.subCategories.map((subCategory) {
                        return ListTile(
                          title: GestureDetector(
                            onTap: () {
                              // Get.lazyPut(()=>CategoriesByIdController(categoriesByIdRepo: Get.find()));
                              // Get.toNamed(RouteHelper.getProductByCategoryId(category.id));
                            },
                            child: Text(subCategory.name+" "+subCategory.id.toString()),
                          ),
                        );
                      }).toList(),
                    );
                  },
                );
              }
            },
          ),
          SizedBox(height: 10,),
          Obx(() {
            if (productController.isLoading.value) {
              return Center(child: CircularProgressIndicator());
            } else if (productController.products.isEmpty) {
              return Center(child: Text('No products available'));
            } else {
              return ListView.builder(
                shrinkWrap: true,
                itemCount: productController.productbycategory.length,
                itemBuilder: (context, index) {
                  Product product = productController.productbycategory[index];
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
    );
  }
}
