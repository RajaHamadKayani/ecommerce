import 'package:ecommerce_app/views/authentication_view/forget_password_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ecommerce_app/controllers/login_controller.dart';
import 'package:ecommerce_app/views/authentication_view/signup_view.dart';
import 'package:ecommerce_app/views/widgets/reusable_container.dart';
import 'package:ecommerce_app/views/widgets/reusable_text_field.dart';
import 'package:google_fonts/google_fonts.dart';

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
              'assets/images/login_bg.png',
              fit: BoxFit.cover,
            ),
          ),
          // Foreground content
          SafeArea(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric( horizontal: 24),
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                  const SizedBox(height: 320,),
                       Text(
                        "Login",
                        style: GoogleFonts.nunitoSans(
                              color: Color(0xff202020),
                          fontSize: 52,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                       Row(
                         children: [
                           Text(
                            "Good to see you back!",
                            style: GoogleFonts.nunitoSans(
                              color: Color(0xff202020),
                              fontSize: 19,
                              fontWeight: FontWeight.normal,
                            ),
                                                 ),
                                                 const SizedBox(width: 3,),
                                                 Icon(Icons.favorite,
                                                 color: Colors.black,)
                         ],
                       ),
                      const SizedBox(height: 28),
                      ReusableTextFieldWidget(
                        controller: loginController.emailController,
                        hintText: "Enter your Email",
                        title: 'Email',
                        focusNode: emailController,
                        textInputAction: TextInputAction.next,
                        onFieldSubmitted: (_) {
                          FocusScope.of(context).requestFocus(passwordController);
                        },
                      ),
                      const SizedBox(height: 8,),
                      ReusableTextFieldWidget(
                        controller: loginController.passwordController,
                        hintText: "Enter your Password",
                        title: 'Password',
                        focusNode: passwordController,
                        textInputAction: TextInputAction.done,
                        onFieldSubmitted: (_) {},
                      ),
                     Align(
                      alignment: Alignment.bottomRight,
                      child: InkWell(
                        onTap: (){
                          Get.to(ForgetPasswordView());
                        },
                        child: Text("Forget Password?",
                        style: GoogleFonts.nunitoSans(color: Colors.black,
                        fontSize: 14,
                        fontWeight: FontWeight.w300),),
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
                                  child:  ReusableContainer(borderRadius: BorderRadius.circular(16), color: 0xff004CFF, title: "Done"),
                                ),
                        ),
                      ),
                    const SizedBox(height: 20,),
                  Center(
                    child: GestureDetector(
                      onTap: () {
                        Get.back();
                      },
                      child:Text("Cancel",
                      style: GoogleFonts.nunitoSans(color: Color(0xff202020),
                      fontSize: 15,
                      fontWeight: FontWeight.w300,),),
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
