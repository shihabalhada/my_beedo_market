import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_beedo_market/controllers/login_controller.dart';
import 'package:my_beedo_market/models/login_model.dart';
import 'package:my_beedo_market/routes/route_helper.dart';

import '../data/api/api_client.dart';
import '../data/repository/login_repo.dart';
import '../utils/app_constants.dart';

class LoginPage extends StatelessWidget {
  final LoginController loginController=Get.find<LoginController>();
  // final LoginController loginController = Get.put(LoginController(
  //   loginRepo: LoginRepo(
  //     apiClient: ApiClient(appBaseUrl: AppConstants.BASE_URL),
  //   ),
  // ));

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: GetBuilder<LoginController>(
          builder: (loginController) {
            if (loginController.isLoading) {
              return const Center(child: CircularProgressIndicator());
            }

            return Form(
              key: _formKey,
              child: Column(
                children: [
                  TextFormField(
                    controller: emailController,
                    decoration: InputDecoration(labelText: 'Email'),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Email is required';
                      }
                      if (!GetUtils.isEmail(value)) {
                        return 'Enter a valid email address';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: passwordController,
                    decoration: InputDecoration(labelText: 'Password'),
                    obscureText: true,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Password is required';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState?.validate() ?? false) {
                        LoginModel loginModel = LoginModel(
                          email: emailController.text,
                          password: passwordController.text,
                        );
                        loginController.login(loginModel);
                      }
                    },
                    child: Text('Login'),
                  ),
                  SizedBox(height: 5),
                  GestureDetector(
                    onTap: (){
                      Get.toNamed(RouteHelper.getSignUp());
                    },
                    child: Text(
                      "Sign Up"
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
