
import 'dart:io';

import 'package:ecommerce_app/models/user_model.dart';
import 'package:ecommerce_app/services/auth_services.dart';
import 'package:ecommerce_app/utils/toast_util.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';

class SignupController extends GetxController {
  final AuthService _authService = AuthService();

  // TextEditingControllers
  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var addressController = TextEditingController();
  var phoneController = TextEditingController();
  var dobController = TextEditingController();
  var passwordController = TextEditingController();

  var isLoading = false.obs;
 Future<void> registerUser(File? imageFile) async {
    isLoading.value = true;
    try {
      // Register the user
      UserCredential userCredential = await _authService.registerUser(
        emailController.text,
        passwordController.text,
      );

      // Upload the image to Cloudinary
      String? imageUrl;
      if (imageFile != null) {
        imageUrl = await _authService.uploadImageToCloudinary(imageFile);
      }

      // Create UserModel with image URL
      UserModel newUser = UserModel(
        id: userCredential.user!.uid,
        email: emailController.text,
        phone: phoneController.text,
        imageUrl: imageUrl,
      );

      // Save user details to Firestore
      await _authService.saveUserToFirestore(newUser);

      ToastUtil.showToast(message: "User registered successfully!");
    } catch (e) {
      ToastUtil.showToast(message: "Error: $e");
    } finally {
      isLoading.value = false;
    }
  }

}
