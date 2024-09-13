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
          scrollDirection: Axis.horizontal,
          itemCount: categoryController.categories.length,
          itemBuilder: (context, index) {
            var category = categoryController.categories[index];
            return Container(
              height: 50,
              margin:
              const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
              padding: const EdgeInsets.symmetric(horizontal: 25),
              decoration: BoxDecoration(
                color: const Color(0xFFF4F6FA),
                borderRadius: BorderRadius.circular(10),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 4,
                    spreadRadius: 2,
                  ),
                ],
              ),
              child: Center(
                child: Text(
                  category.name,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: Colors.black54,
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }
}
