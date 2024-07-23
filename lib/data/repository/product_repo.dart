import 'package:get/get.dart';
import 'package:my_beedo_market/data/api/api_client.dart';
import 'package:my_beedo_market/utils/app_constants.dart';
import 'package:my_beedo_market/models/product_model.dart';

class ProductRepo extends GetxService {
  final ApiClient apiClient;

  ProductRepo({required this.apiClient});

  Future<Response> getAllProducts() async {
    return await apiClient.getData(AppConstants.GET_ALL_PRODUCTS_URI);
  }

  Future<Response> getProductById(int productId) async {
    return await apiClient.getData('${AppConstants.GET_PRODUCT_BY_ID_URI}/$productId');
  }

  Future<Response> getProductsByCategoryId(int categoryId) async {
    return await apiClient.getData('${AppConstants.GET_PRODUCTS_BY_CATEGORY_ID_URI}$categoryId');
  }

  Future<Response> getProductsBySubCategoryId(int categoryId,int subCategoryId) async {
    return await apiClient.getData('${AppConstants.GET_PRODUCTS_BY_CATEGORY_ID_URI}/$categoryId/$subCategoryId');
  }
}
