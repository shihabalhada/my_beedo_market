import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_beedo_market/controllers/signup_controller.dart';
import 'package:my_beedo_market/models/user_model.dart';
import 'package:my_beedo_market/routes/route_helper.dart';

import '../data/api/api_client.dart';
import '../data/repository/signup_repo.dart';
import '../utils/app_constants.dart';

class SignupPage extends StatelessWidget {
  final SignupController signupController = Get.find<SignupController>();

  final TextEditingController usernameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController passwordConfirmationController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  SignupPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Signup'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: GetBuilder<SignupController>(
          builder: (signupController) {
            if (signupController.isLoading) {
              return const Center(child: CircularProgressIndicator());
            }

            return Form(
              key: _formKey,
              child: Column(
                children: [
                  TextFormField(
                    controller: usernameController,
                    decoration: const InputDecoration(labelText: 'Username'),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Username is required';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: emailController,
                    decoration: const InputDecoration(labelText: 'Email'),
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
                    decoration: const InputDecoration(labelText: 'Password'),
                    obscureText: true,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Password is required';
                      }
                      if (value.length < 6) {
                        return 'Password must be more than 6 characters';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: passwordConfirmationController,
                    decoration: const InputDecoration(labelText: 'Confirm Password'),
                    obscureText: true,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Password confirmation is required';
                      }
                      if (value != passwordController.text) {
                        return 'Passwords do not match';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState?.validate() ?? false) {
                        User user = User(
                          username: usernameController.text,
                          email: emailController.text,
                          password: passwordController.text,
                          passwordConfirmation: passwordConfirmationController.text,
                        );
                        signupController.signup(user);
                      }
                    },
                    child: const Text('Signup'),
                  ),
                  const SizedBox(height: 10),
                  GestureDetector(
                    onTap: (){
                      Get.toNamed(RouteHelper.getLogin());
                    },
                    child: Text("Log In"),
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
