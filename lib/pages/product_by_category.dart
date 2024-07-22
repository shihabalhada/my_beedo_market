import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_beedo_market/controllers/categories_by_id_controller.dart';
import 'package:my_beedo_market/controllers/categories_controller.dart';

class ProductByCategoryPage extends StatelessWidget {
  final int id;
  final CategoriesByIdController categoriesByIdController = Get.find<CategoriesByIdController>();
  ProductByCategoryPage({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    categoriesByIdController.getCategoryById(id);

    return Scaffold(
      appBar: AppBar(
        title: Text('Products by Category $id'),
      ),
      body: GetBuilder<CategoryController>(
        builder: (categoryController) {
          if (categoryController.isLoading) {
            return Center(child: CircularProgressIndicator());
          }

          return ListView.builder(
            itemCount: categoryController.categoriesById.length,
            itemBuilder: (context, index) {
              var category = categoryController.categoriesById[index];
              return ListTile(
                title: Text(category.name),
                subtitle: Text('Category ID: ${category.id}'),
              );
            },
          );
        },
      ),
    );
  }
}
