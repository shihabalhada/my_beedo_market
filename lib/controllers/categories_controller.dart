import 'package:get/get.dart';
import 'package:my_beedo_market/data/repository/categories_repo.dart';
import 'package:my_beedo_market/models/category_model.dart';

class CategoryController extends GetxController {
  final CategoryRepo categoryRepo;
  bool isLoading = false;
  List<Category> categories = [];

  CategoryController({required this.categoryRepo});

  Future<void> fetchCategories() async {
    try {
      isLoading = true;
      update();

      Response response = await categoryRepo.getCategories();

      if (response.statusCode == 200) {
        var categoryList = response.body as List;
        categories = categoryList.map((c) => Category.fromJson(c)).toList();
      } else {
        Get.snackbar('Error', response.statusText ?? 'Failed to fetch categories');
      }
    } catch (e) {
      Get.snackbar('Error', 'Failed to fetch categories.......');
    } finally {
      isLoading = false;
      update();
    }
  }

  Future<void> addCategory(Category category) async {
    try {
      isLoading = true;
      update();

      Response response = await categoryRepo.addCategory(category);

      if (response.statusCode == 200 || response.statusCode == 201) {
        fetchCategories();
        Get.snackbar('Success', 'Category added successfully');
      } else {
        Get.snackbar('Error', response.statusText ?? 'Failed to add category');
      }
    } catch (e) {
      Get.snackbar('Error', 'Failed to add category');
    } finally {
      isLoading = false;
      update();
    }
  }

  Future<void> updateCategory(Category category) async {
    try {
      isLoading = true;
      update();

      Response response = await categoryRepo.updateCategory(category);

      if (response.statusCode == 200) {
        fetchCategories();
        Get.snackbar('Success', 'Category updated successfully');
      } else {
        Get.snackbar('Error', response.statusText ?? 'Failed to update category');
      }
    } catch (e) {
      Get.snackbar('Error', 'Failed to update category');
    } finally {
      isLoading = false;
      update();
    }
  }

  // Future<void> deleteCategory(int categoryId) async {
  //   try {
  //     isLoading = true;
  //     update();
  //
  //     Response response = await categoryRepo.deleteCategory(categoryId);
  //
  //     if (response.statusCode == 200) {
  //       fetchCategories();
  //       Get.snackbar('Success', 'Category deleted successfully');
  //     } else {
  //       Get.snackbar('Error', response.statusText ?? 'Failed to delete category');
  //     }
  //   } catch (e) {
  //     Get.snackbar('Error', 'Failed to delete category');
  //   } finally {
  //     isLoading = false;
  //     update();
  //   }
  // }
}
