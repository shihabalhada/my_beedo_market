import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_beedo_market/controllers/categories_controller.dart';
import 'package:my_beedo_market/models/category_model.dart';

import '../data/api/api_client.dart';
import '../data/repository/categories_repo.dart';
import '../utils/app_constants.dart';

class CategoryPage extends StatelessWidget {
  final CategoryController categoryController = Get.find<CategoryController>();

  @override
  Widget build(BuildContext context) {
    // Fetch categories when the page is first loaded
    categoryController.fetchCategories();

    return GetBuilder<CategoryController>(
      builder: (categoryController) {
        if (categoryController.isLoading) {
          return Center(child: CircularProgressIndicator());
        }

        return ListView.builder(
          shrinkWrap: true,
          itemCount: categoryController.categories.length,
          itemBuilder: (context, index) {
            var category = categoryController.categories[index];
            return ExpansionTile(
              title: Text(category.name+" "+category.id.toString()),
              children: category.subCategories.map((subCategory) {
                return ListTile(
                  title: Text(subCategory.name+" "+subCategory.id.toString()),
                );
              }).toList(),
            );
          },
        );
      },
    );
  }
}
