
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
Future<void> registerUser() async {
  isLoading.value = true;
  try {
    // Register the user and get the userCredential
    UserCredential userCredential = await _authService.registerUser(
      emailController.text,
      passwordController.text,
    );

    // Create a UserModel with the generated UID
    UserModel newUser = UserModel(
      id: userCredential.user!.uid, // Use the UID from Firebase
      name: nameController.text,
      email: emailController.text,
      address: addressController.text,
      phone: phoneController.text,
      dob: dobController.text,
    );

    // Save the user data to Firestore
    await _authService.saveUserToFirestore(newUser);


    ToastUtil.showToast(message: "User registered Successfully",
    );        } catch (e) {

    ToastUtil.showToast(message: "Error. Unable to register user",
    );        } 
    finally {
    isLoading.value = false;
  }
}


}
