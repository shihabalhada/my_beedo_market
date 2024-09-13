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
      body: SingleChildScrollView(
        child: GetBuilder<LoginController>(
          builder: (loginController) {
            if (loginController.isLoading) {
              return const Center(child: CircularProgressIndicator());
            }
            return Form(
              key: _formKey,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(11.0),
                    child: TextFormField(
                      controller: emailController,
                      keyboardType: TextInputType.emailAddress,
                      decoration: const InputDecoration(
                        labelText: 'Email',
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(Icons.email),
                      ),
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
                  ),
                  Padding(
                    padding: const EdgeInsets.all(11.0),
                    child: TextFormField(
                      keyboardType: TextInputType.visiblePassword,
                      controller: passwordController,
                      decoration: const InputDecoration(
                        labelText: 'Password',
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(Icons.lock),
                      ),
                      obscureText: true,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Password is required';
                        }
                        return null;
                      },
                    ),
                  ),
                  SizedBox(height: 7),
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: SizedBox(
                      width: double.infinity,
                      child: Material(
                        color: const Color(0xFFE27A22),
                        borderRadius: BorderRadius.circular(10),
                        child: InkWell(
                          onTap: () {
                            if (_formKey.currentState?.validate() ?? false) {
                              LoginModel loginModel = LoginModel(
                                email: emailController.text,
                                password: passwordController.text,
                              );
                              loginController.login(loginModel);
                            }
                          },
                          child: const Padding(
                            padding:
                            EdgeInsets.symmetric(vertical: 15, horizontal: 40),
                            child: Center(
                              child: Text(
                                "Log In",
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
                  SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "Don't have any account?",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: Colors.black54,
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          Get.toNamed(RouteHelper.getSignUp());
                        },
                        child: const Text(
                          "Create Account",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFFE27A22),
                          ),
                        ),
                      ),
                    ],
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
