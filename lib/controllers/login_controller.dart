
import 'package:ecommerce_app/services/auth_services.dart';
import 'package:ecommerce_app/utils/toast_util.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';

class LoginController extends GetxController {
  final AuthService _authService = AuthService();

  var emailController = TextEditingController();
  var passwordController = TextEditingController();

  var isLoading = false.obs;

  Future<void> loginUser() async {
    isLoading.value = true;
    try {
      await _authService.loginUser(
        emailController.text,
        passwordController.text,
      );

    ToastUtil.showToast(message: "Login Successfully",
    );      // Navigate to the next screen
    } catch (e) {
    ToastUtil.showToast(message: "Login failed. Something went wrong",
    );    } finally {
      isLoading.value = false;
    }
  }
}
