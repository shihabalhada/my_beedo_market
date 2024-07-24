import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_beedo_market/controllers/categories_by_id_controller.dart';
import 'package:my_beedo_market/controllers/categories_controller.dart';

class ProductByCategoryPage extends StatelessWidget {
  final int id;
  // final CategoriesByIdController categoriesByIdController = Get.find<CategoriesByIdController>();
  // final CategoryController categoryController = Get.find<CategoryController>();
  ProductByCategoryPage({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    // categoriesByIdController.getCategoryById(id);
    Get.find<CategoryController>().fetchCategories();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Products by Category'),
      ),
      body: GetBuilder<CategoryController>(
        builder: (categoryController) {
          if (categoryController.isLoading) {
            return Center(child: CircularProgressIndicator());
          }

          return ListView.builder(
            shrinkWrap: true,
            itemCount: categoryController.categories.length,
            itemBuilder: (context, index) {
              var category = categoryController.categories[index];
              if(category.id==id){
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
              }

            },
          );
        },
      ),
    );
  }
}
