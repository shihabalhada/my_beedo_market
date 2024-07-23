import 'package:get/get.dart';
import 'package:my_beedo_market/data/api/api_client.dart';
import 'package:my_beedo_market/utils/app_constants.dart';

import '../../models/profile_model.dart';

class ProfileRepo {
  final ApiClient apiClient;

  ProfileRepo({required this.apiClient});

  Future<Response> getProfile(String token) async {
    return await apiClient.getData(AppConstants.PROFILE_URI+"?token=$token");
  }

  Future<Response> updateProfile(Profile profile) async {
    return await apiClient.postData(AppConstants.UPDATE_PROFILE_URI, profile.toJson());
  }
}
