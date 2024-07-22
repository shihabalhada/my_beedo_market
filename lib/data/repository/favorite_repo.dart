import 'package:get/get.dart';
import 'package:my_beedo_market/data/api/api_client.dart';
import 'package:my_beedo_market/utils/app_constants.dart';

class FavoriteRepo extends GetxService {
  final ApiClient apiClient;

  FavoriteRepo({required this.apiClient});

  Future<Response> getFavorite(Map<String, dynamic> data) async{
    return await apiClient.postData(AppConstants.GET_FAVORITE_URI,data);
  }

  Future<Response> addToFavorite(Map<String, dynamic> data) async {
    return await apiClient.postData(AppConstants.ADD_TO_FAVORITE_URI, data);
  }

  Future<Response> deleteFromFavorite(Map<String, dynamic> data) async {
    return await apiClient.postData(AppConstants.DELETE_FROM_FAVORITE_URI, data);
  }
}
