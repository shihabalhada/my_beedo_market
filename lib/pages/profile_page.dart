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
  final TextEditingController birthdayController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  String? selectedGender;

  ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    String token = GetStorage().read('token');
    profileController.fetchProfile(token);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Profile',
          style: TextStyle(
            color: Colors.white,
            fontSize: 24.0,
          ),
        ),
        backgroundColor: const Color(0xFFE27A22),
      ),
      body: Obx(() {
        if (profileController.isLoading.value) {
          return Center(child: CircularProgressIndicator());
        }

        // Convert the fetched gender to uppercase to match the dropdown values
        nameController.text = profileController.profile.first.name;
        phoneController.text = profileController.profile.first.phone ?? '';
        selectedGender = profileController.profile.first.gender
            ?.toUpperCase(); // Ensure it's uppercase
        birthdayController.text =
            profileController.profile.first.birthday ?? '';

        return SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    controller: nameController,
                    keyboardType: TextInputType.name,
                    decoration: const InputDecoration(
                      labelText: 'Name',
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.person),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Name is required';
                      }
                      return null;
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    controller: phoneController,
                    decoration: const InputDecoration(
                      labelText: 'Phone',
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.phone),
                    ),
                    validator: (value) {
                      if (value?.length != 9 || value == null) {
                        return 'Phone Number must be of 9 digits';
                      }
                      return null;
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: DropdownButtonFormField<String>(
                    decoration: const InputDecoration(
                      labelText: 'Gender',
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.person),
                    ),
                    value: selectedGender,
                    items: const [
                      DropdownMenuItem(value: 'M', child: Text('Male')),
                      DropdownMenuItem(value: 'F', child: Text('Female')),
                    ],
                    onChanged: (String? newValue) {
                      selectedGender = newValue;
                    },
                    validator: (value) {
                      if (value == null) {
                        return 'Please select a gender';
                      }
                      return null;
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    controller: birthdayController,
                    decoration: const InputDecoration(
                      labelText: 'Birthday',
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.calendar_month),
                    ),
                  ),
                ),
                SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: SizedBox(
                    width: double.infinity,
                    child: Material(
                      color: const Color(0xFFE27A22),
                      borderRadius: BorderRadius.circular(10),
                      child: InkWell(
                        onTap: () {
                          if (_formKey.currentState!.validate()) {
                            final updatedProfile = Profile(
                              token: token,
                              name: nameController.text,
                              phone: phoneController.text,
                              gender: selectedGender,
                              birthday: birthdayController.text,
                            );

                            Get.find<ProfileController>()
                                .updateProfile(updatedProfile);
                          }
                        },
                        child: const Padding(
                          padding: EdgeInsets.symmetric(
                              vertical: 15, horizontal: 40),
                          child: Center(
                            child: Text(
                              "Update Profile",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 25,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      }),
    );
  }
}
