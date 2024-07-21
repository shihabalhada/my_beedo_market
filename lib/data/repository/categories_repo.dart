import 'package:get/get.dart';
import 'package:my_beedo_market/data/api/api_client.dart';
import 'package:my_beedo_market/models/category_model.dart';
import 'package:my_beedo_market/utils/app_constants.dart';

class CategoryRepo extends GetxService {
  final ApiClient apiClient;

  CategoryRepo({required this.apiClient});

  Future<Response> getCategories() async {
    return await apiClient.getData(AppConstants.CATEGORIES_URI);
  }

  Future<Response> addCategory(Category category) async {
    return await apiClient.postData(AppConstants.ADD_CATEGORY_URI, category.toJson());
  }

  Future<Response> updateCategory(Category category) async {
    return await apiClient.postData('${AppConstants.UPDATE_CATEGORY_URI}/${category.id}', category.toJson());
  }

  // Future<Response> deleteCategory(int categoryId) async {
  //   return await apiClient.postData('${AppConstants.DELETE_CATEGORY_URI}/$categoryId');
  // }
}
