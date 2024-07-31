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
  Future<Response> getCategoriesById(int id) async {

    return await apiClient.getData("${AppConstants.CATEGORIES_BY_ID_URI}$id/");
  }
}
