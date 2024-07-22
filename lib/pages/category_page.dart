import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_beedo_market/controllers/categories_controller.dart';
import 'package:my_beedo_market/routes/route_helper.dart';

import '../controllers/categories_by_id_controller.dart';


class CategoryPage extends StatelessWidget {
  final CategoryController categoryController = Get.find<CategoryController>();

  CategoryPage({super.key});

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
                  title: GestureDetector(
                    onTap: () {
                      Get.lazyPut(()=>CategoriesByIdController(categoriesByIdRepo: Get.find()));
                      Get.toNamed(RouteHelper.getProductByCategoryId(category.id));
                    },
                      child: Text(subCategory.name+" "+subCategory.id.toString()),
                  ),
                );
              }).toList(),
            );
          },
        );
      },
    );
  }
}
