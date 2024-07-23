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

}
