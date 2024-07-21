import 'package:get/get.dart';
import 'package:my_beedo_market/data/repository/signup_repo.dart';
import 'package:my_beedo_market/models/user_model.dart';

class SignupController extends GetxController {
  final SignupRepo signupRepo;
  bool isLoading = false;

  SignupController({required this.signupRepo});

  Future<void> signup(User user) async {
    try {
      isLoading = true;
      update();

      Response response = await signupRepo.signup(user.toJson());

      if (response.statusCode == 200 || response.statusCode == 201) {

        Get.snackbar('Success', 'User signed up successfully');
      } else {
        Get.snackbar('Error', response.statusText ?? 'Signup failed');
      }
    } catch (e) {
      Get.snackbar('Error', 'Signup failed');
    } finally {
      isLoading = false;
      update();
    }
  }
}
