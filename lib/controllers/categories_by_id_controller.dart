import 'package:get/get.dart';
import 'package:my_beedo_market/models/category_model.dart';
import '../data/repository/categories_by_id_repo.dart';

class CategoriesByIdController extends GetxController {
  final CategoriesByIdRepo categoriesByIdRepo;
  bool isLoading = false;
  List<Category> categoriesById = [];


  CategoriesByIdController({required this.categoriesByIdRepo});


  Future<void> getCategoryById(int id) async{
    try {
      isLoading = true;
      update();

      Response response = await categoriesByIdRepo.getCategoriesById(id);

      if (response.statusCode == 200) {
        if(response.body !=null){
          var categoryByIdList = response.body as List;
          categoriesById = categoryByIdList.map((c) => Category.fromJson(c)).toList();
        }
      } else {
        Get.snackbar('Error', response.statusText ?? 'Failed to fetch categories');
      }
    } catch (e) {
      Get.snackbar('Error', 'Failed to fetch categories.......'+e.toString());
    } finally {
      isLoading = false;
      update();
    }
  }


}
