import 'package:get/get.dart';
import 'package:my_beedo_market/data/api/api_client.dart';
import 'package:my_beedo_market/utils/app_constants.dart';

class LoginRepo extends GetxService {
  final ApiClient apiClient;

  LoginRepo({required this.apiClient});

  Future<Response> login(Map<String, dynamic> data) async {
    return await apiClient.postData(AppConstants.LOGIN_URI, data);
  }
}
