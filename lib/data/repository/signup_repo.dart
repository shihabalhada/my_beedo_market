import 'package:my_beedo_market/data/api/api_client.dart';
import 'package:my_beedo_market/utils/app_constants.dart';
import 'package:get/get.dart';

class SignupRepo extends GetxService {
  final ApiClient apiClient;

  SignupRepo({required this.apiClient});

  Future<Response> signup(Map<String, dynamic> data) async {
    return await apiClient.postData(AppConstants.SIGNUP_URI, data);
  }
}
