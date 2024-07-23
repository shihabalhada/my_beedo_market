import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:my_beedo_market/controllers/profile_controller.dart';
import 'package:my_beedo_market/models/profile_model.dart';
import 'package:my_beedo_market/data/repository/profile_repo.dart';
import 'package:my_beedo_market/data/api/api_client.dart';
import 'package:my_beedo_market/utils/app_constants.dart';

class ProfilePage extends StatelessWidget {
  final ProfileController profileController = Get.put(ProfileController(
    profileRepo: ProfileRepo(
      apiClient: ApiClient(appBaseUrl: AppConstants.BASE_URL),
    ),
  ));

  final TextEditingController nameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController genderController = TextEditingController();
  final TextEditingController birthdayController = TextEditingController();

  ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {

    String token = GetStorage().read('token');
    profileController.fetchProfile(token);
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
      ),
      body: Obx(() {
        if (profileController.isLoading.value) {
          return Center(child: CircularProgressIndicator());
        }

        nameController.text = profileController.profile.first.name;
        phoneController.text = profileController.profile.first.phone ?? '';
        genderController.text = profileController.profile.first.gender ?? '';
        birthdayController.text = profileController.profile.first.birthday ?? '';

        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              TextField(
                controller: nameController,
                decoration: InputDecoration(labelText: 'Name'),
              ),
              TextField(
                controller: phoneController,
                decoration: InputDecoration(labelText: 'Phone'),
              ),
              TextField(
                controller: genderController,
                decoration: InputDecoration(labelText: 'Gender'),
              ),
              TextField(
                controller: birthdayController,
                decoration: InputDecoration(labelText: 'Birthday'),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  final updatedProfile = Profile(
                    // email: profileController.profile.first.email,
                    token: token,
                    name: nameController.text,
                    phone: phoneController.text,
                    gender: genderController.text,
                    birthday: birthdayController.text,
                  );

                  Get.find<ProfileController>().updateProfile(updatedProfile);
                },
                child: Text('Update Profile'),
              ),
            ],
          ),
        );
      }),
    );
  }
}
