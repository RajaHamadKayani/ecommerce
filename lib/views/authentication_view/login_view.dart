import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ecommerce_app/controllers/login_controller.dart';
import 'package:ecommerce_app/views/authentication_view/signup_view.dart';
import 'package:ecommerce_app/views/widgets/reusable_container.dart';
import 'package:ecommerce_app/views/widgets/reusable_text_field.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final LoginController loginController = Get.put(LoginController());
  final _formKey = GlobalKey<FormState>();

  // Focus nodes for the text fields
  final emailController = FocusNode();
  final passwordController = FocusNode();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true, // Allow screen to resize when keyboard opens
      body: Stack(
        children: [
          // Background Image
          Positioned.fill(
            child: Image.asset(
              'assets/images/bg.png',
              fit: BoxFit.cover,
            ),
          ),
          // Foreground content
          SafeArea(
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
                          const SizedBox(),
                          const SizedBox(),
                          const Center(
                            child: Text(
                              "BOOK HIVE",
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 20,
                                fontFamily: "Pulp",
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          const SizedBox(width: 46), // Spacer for alignment
                        ],
                      ),
                      const SizedBox(height: 28),
                      const Text(
                        "Login",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 38,
                          fontFamily: "Pulp",
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 28),
                      ReusableTextFieldWidget(
                        controller: loginController.emailController,
                        hintText: "Enter your Email",
                        suffixIcon: const Icon(Icons.email, color: Colors.black),
                        title: 'Email',
                        focusNode: emailController,
                        textInputAction: TextInputAction.next,
                        onFieldSubmitted: (_) {
                          FocusScope.of(context).requestFocus(passwordController);
                        },
                      ),
                      ReusableTextFieldWidget(
                        controller: loginController.passwordController,
                        hintText: "Enter your Password",
                        suffixIcon: const Icon(Icons.password, color: Colors.black),
                        title: 'Password',
                        focusNode: passwordController,
                        textInputAction: TextInputAction.done,
                        onFieldSubmitted: (_) {},
                      ),
                      Align(
                        alignment: Alignment.bottomRight,
                        child: RichText(
                          text: const TextSpan(
                            children: [
                              TextSpan(
                                text: "Forgot ",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w300,
                                  fontFamily: "Pulp",
                                ),
                              ),
                              TextSpan(
                                text: "Password?",
                                style: TextStyle(
                                  color: Color(0XFF3CBBB1),
                                  fontSize: 14,
                                  fontWeight: FontWeight.w300,
                                  fontFamily: "Pulp",
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      Center(
                        child: Obx(
                          () => loginController.isLoading.value
                              ? const CircularProgressIndicator(color: Colors.white)
                              : GestureDetector(
                                  onTap: () async {
                                    if (_formKey.currentState!.validate()) {
                                      loginController.loginUser();
                                      loginController.emailController.clear();
                                      loginController.passwordController.clear();
                                    }
                                  },
                                  child: ReusableContainer(
                                    borderRadius: BorderRadius.circular(50),
                                    color: 0XFF3CBBB1,
                                    title: "Login",
                                  ),
                                ),
                        ),
                      ),
                      const SizedBox(height: 30),
                      Center(
                        child: GestureDetector(
                          onTap: () {
                            Get.to(SignUpView());
                          },
                          child: RichText(
                            text: const TextSpan(
                              children: [
                                TextSpan(
                                  text: "Do not have an account? ",
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w300,
                                    fontFamily: "Pulp",
                                  ),
                                ),
                                TextSpan(
                                  text: "SignUp",
                                  style: TextStyle(
                                    color: Color(0XFF3CBBB1),
                                    fontSize: 14,
                                    fontWeight: FontWeight.w300,
                                    fontFamily: "Pulp",
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
