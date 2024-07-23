import 'package:get/get.dart';
import 'package:my_beedo_market/data/repository/profile_repo.dart';
import 'package:my_beedo_market/models/profile_model.dart';

class ProfileController extends GetxController {
  final ProfileRepo profileRepo;

  ProfileController({required this.profileRepo});

  var profile = [].obs;
  // var profile = Profile(email: '', name: '',phone: '',gender: '',birthday: '').obs;
  var isLoading = false.obs;

  Future<void> fetchProfile(String token) async {
    try {
      isLoading.value = true;
      Response response = await profileRepo.getProfile(token);
      if (response.statusCode == 200) {
        Get.snackbar('Success', 'get profile success');
        var profileList = List<Profile>.from(response.body.map((p) => Profile.fromJson(p)));
        profile(profileList);
        // profile = Profile.fromJson(response.body);
      } else {
        Get.snackbar('Error', response.statusText! +"  error"+response.statusCode.toString()?? 'Failed to fetch profile');
      }
    } catch (e) {
      Get.snackbar('Error', 'Failed to fetch profile');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> updateProfile(Profile profile) async {
    try {
      isLoading.value = true;
      Response response = await profileRepo.updateProfile(profile);
      if (response.statusCode == 200) {
        // this.profile.value = profile;
        Get.snackbar('Success', 'Profile updated successfully');
      } else {
        Get.snackbar('Error', response.statusText ?? 'Failed to update profile');
      }
    } catch (e) {
      Get.snackbar('Error', 'Failed to update profile');
    } finally {
      isLoading.value = false;
    }
  }
}
