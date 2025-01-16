import 'package:ecommerce_app/services/auth_services.dart';
import 'package:ecommerce_app/utils/toast_util.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';

class ForgetPasswordController extends GetxController {
  final emailController = TextEditingController();
  final AuthService _authService = AuthService();

  var isLoading = false.obs;

  // Function to reset password
  Future<void> resetPassword() async {
    isLoading.value = true;
    try {
      await _authService.sendPasswordResetEmail(emailController.text.trim());
      ToastUtil.showToast(
        message: "Password reset email sent. Please check your inbox.",
      );
      Get.back();
    } catch (e) {
      ToastUtil.showToast(
        message: "Error: Unable to send reset email. ${e.toString()}",
      );
    } finally {
      isLoading.value = false;
    }
  }
}
