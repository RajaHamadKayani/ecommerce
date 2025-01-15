

import 'package:ecommerce_app/controllers/sign_up_controller.dart';
import 'package:ecommerce_app/views/authentication_view/login_view.dart';
import 'package:ecommerce_app/views/widgets/reusable_container.dart';
import 'package:ecommerce_app/views/widgets/reusable_text_field.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uuid/uuid.dart';
import 'package:intl/intl.dart';

class SignUpView extends StatefulWidget {
  const SignUpView({super.key});

  @override
  State<SignUpView> createState() => _SignUpViewState();
}

class _SignUpViewState extends State<SignUpView> {
  SignupController signupController = Get.put(SignupController());
  String selectedDate = "Select Date"; // Initial text

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime(2100),
      builder: (context, child) {
        return Theme(
          data: ThemeData.light().copyWith(
            primaryColor: const Color(0xFF3CBBB1), // Header background color
            // accentColor: const Color(0xFF3CBBB1), // Selection color
            colorScheme: ColorScheme.light(primary: const Color(0xFF3CBBB1)),
            buttonTheme: const ButtonThemeData(
              textTheme: ButtonTextTheme.primary, // Text button theme
            ),
          ),
          child: child!,
        );
      },
    );

    if (picked != null && picked != DateTime.now()) {
      setState(() {
        selectedDate = DateFormat('dd-MM-yyyy').format(picked); // Format date
        signupController.dobController.text = selectedDate;
      });
    }
  }

  final _formKey = GlobalKey<FormState>();

  // Focus nodes for the text fields
  final emailController = FocusNode();
  final passwordController = FocusNode();
  final nameController = FocusNode();
  final addressController = FocusNode();
  final phoneController = FocusNode();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset:
          true, // Allow the screen to resize when the keyboard is open
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap: () {
                          Get.back(); // Navigate back
                        },
                        child: Container(
                          height: 46,
                          width: 46,
                          decoration: BoxDecoration(
                              color: const Color(0xffF2F2F5),
                              borderRadius: BorderRadius.circular(50)),
                          child: const Center(
                            child: Padding(
                              padding: EdgeInsets.only(left: 4),
                              child: Icon(
                                Icons.arrow_back_ios,
                                size: 18,
                                color: Color(0xff1F1C33),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Center(
                        child: const Text(
                          "BOOK HIVE",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 20,
                            fontFamily: "Pulp",
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      const SizedBox(),
                    ],
                  ),
                  const SizedBox(
                    height: 28,
                  ),
                  Text(
                    "SignUp",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 38,
                      fontFamily: "Pulp",
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(
                    height: 28,
                  ),
                  ReusableTextFieldWidget(
                    controller: signupController.emailController,
                    hintText: "Enter your Email",
                    suffixIcon: const Icon(Icons.email, color: Colors.black),
                    title: 'Email',
                    focusNode: emailController, // Assign focus node
                    textInputAction: TextInputAction
                        .next, // Set the action to move to the next field
                    onFieldSubmitted: (_) {
                      FocusScope.of(context).requestFocus(passwordController);
                    },
                  ),
                  ReusableTextFieldWidget(
                    controller: signupController.passwordController,
                    hintText: "Enter your Password",
                    suffixIcon: const Icon(Icons.password, color: Colors.black),
                    title: 'Password',
                    focusNode: passwordController, // Assign focus node
                    textInputAction: TextInputAction
                        .next, // Set the action to move to the next field
                    onFieldSubmitted: (_) {
                      FocusScope.of(context).requestFocus(nameController);
                    },
                  ),
                  ReusableTextFieldWidget(
                    controller: signupController.nameController,
                    hintText: "Enter your Name",
                    suffixIcon: const Icon(Icons.person, color: Colors.black),
                    title: 'Name',
                    focusNode: nameController, // Assign focus node
                    textInputAction: TextInputAction
                        .next, // Set the action to move to the next field
                    onFieldSubmitted: (_) {
                      FocusScope.of(context).requestFocus(addressController);
                    },
                  ),
                  ReusableTextFieldWidget(
                    controller: signupController.addressController,
                    hintText: "Enter your Address",
                    suffixIcon:
                        const Icon(Icons.location_city, color: Colors.black),
                    title: 'Address',
                    focusNode: addressController, // Assign focus node
                    textInputAction: TextInputAction
                        .next, // Set the action to move to the next field
                    onFieldSubmitted: (_) {
                      FocusScope.of(context).requestFocus(phoneController);
                    },
                  ),
                  ReusableTextFieldWidget(
                    controller: signupController.phoneController,
                    hintText: "Enter your Phone",
                    suffixIcon: const Icon(Icons.phone, color: Colors.black),
                    title: 'Phone',
                    focusNode: phoneController, // Assign focus node
                    textInputAction: TextInputAction
                        .next, // Set the action to move to the next field
                    onFieldSubmitted: (_) {
                      FocusScope.of(context).requestFocus(phoneController);
                    },
                  ),
                  Text(
                    "Date Of Birth",
                    style: const TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w500,
                        fontSize: 16,
                        fontFamily: "Pulp"),
                  ),
                  const SizedBox(height: 16),
                  GestureDetector(
                    onTap: () {
                      _selectDate(context);
                    },
                    child: Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: Colors.black, width: 1),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 20, horizontal: 12),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              selectedDate,
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w400,
                                  fontFamily: "Pulp",
                                  fontSize: 14),
                            ),
                            Icon(Icons.calendar_month)
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Align(
                    alignment: Alignment.bottomRight,
                    child: RichText(
                        text: TextSpan(children: [
                      TextSpan(
                          text: "Forgot ",
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 14,
                              fontWeight: FontWeight.w300,
                              fontFamily: "Pulp")),
                      TextSpan(
                          text: "Password?",
                          style: TextStyle(
                              color: Color(0XFF3CBBB1),
                              fontSize: 14,
                              fontWeight: FontWeight.w300,
                              fontFamily: "Pulp"))
                    ])),
                  ),
                  const SizedBox(height: 20),
                  Center(
                    child: Obx(
                      () => signupController.isLoading.value
                          ? const CircularProgressIndicator()
                          : GestureDetector(
                              onTap: () async {
                                if (_formKey.currentState!.validate()) {
                                  await signupController.registerUser();

                                  // Clear the text fields after successful upload
                                  signupController.nameController.clear();
                                  signupController.emailController.clear();
                                  signupController.passwordController.clear();
                                  signupController.phoneController.clear();
                                  signupController.addressController.clear();
                                  signupController.dobController.clear();
                                  Get.off(() => const LoginView());
                                }
                              },
                              child: ReusableContainer(
                                borderRadius: BorderRadius.circular(50),
                                color: 0XFF3CBBB1,
                                title: "SignUp",
                              ),
                            ),
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Center(
                    child: GestureDetector(
                      onTap: () {
                        Get.back();
                      },
                      child: RichText(
                          text: TextSpan(children: [
                        TextSpan(
                            text: "Already Registered? ",
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 14,
                                fontWeight: FontWeight.w300,
                                fontFamily: "Pulp")),
                        TextSpan(
                            text: "Login",
                            style: TextStyle(
                                color: Color(0XFF3CBBB1),
                                fontSize: 14,
                                fontWeight: FontWeight.w300,
                                fontFamily: "Pulp"))
                      ])),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
