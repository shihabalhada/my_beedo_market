import 'package:my_beedo_market/routes/route_helper.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:my_beedo_market/data/repository/login_repo.dart';
import 'package:my_beedo_market/models/login_model.dart';

class LoginController extends GetxController {
  final LoginRepo loginRepo;
  final GetStorage storage = GetStorage();
  bool isLoading = false;

  LoginController({required this.loginRepo});

  Future<void> login(LoginModel loginModel) async {
    try {
      isLoading = true;
      update();

      Response response = await loginRepo.login(loginModel.toJson());

      if (response.statusCode == 200 || response.statusCode == 201) {
        String token = response.body['access_token'];
        await storage.write('token', token);
        Get.toNamed(RouteHelper.home);
        Get.snackbar('Success', 'User logged in successfully');
      } else {
        Get.snackbar('Error', response.statusText ?? 'Login failed');
      }
    } catch (e) {
      Get.snackbar('Error', 'Login failed');
    } finally {
      isLoading = false;
      update();
    }
  }
}
