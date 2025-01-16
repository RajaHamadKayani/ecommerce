import 'package:ecommerce_app/controllers/forget_password_controller.dart';
import 'package:ecommerce_app/views/widgets/reusable_container.dart';
import 'package:ecommerce_app/views/widgets/reusable_text_field.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class ForgetPasswordView extends StatefulWidget {
  const ForgetPasswordView({super.key});

  @override
  State<ForgetPasswordView> createState() => _ForgetPasswordViewState();
}

class _ForgetPasswordViewState extends State<ForgetPasswordView> {
  ForgetPasswordController forgetPasswordController =
      Get.put(ForgetPasswordController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              'assets/images/forget_password_bg.png',
              fit: BoxFit.cover,
            ),
          ),
          SafeArea(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 16),
                child: Center(
                            child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
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
                            const SizedBox(height: 150,),
                  Center(
                    child: Text(
                      "Password Recovery",
                      style: GoogleFonts.raleway(
                          color: const Color(0xff202020),
                          fontSize: 21,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                  Column(
                    children: [
                      ReusableTextFieldWidget(
                        controller: forgetPasswordController.emailController,
                        hintText: "Enter your Email",
                        title: "Email",
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Obx(
                        () => forgetPasswordController.isLoading.value
                            ? const CircularProgressIndicator()
                            : GestureDetector(
                                onTap: () async {
                                  await forgetPasswordController.resetPassword();
                                },
                                child: ReusableContainer(
                                  borderRadius: BorderRadius.circular(16),
                                  color: 0xff004CFF,
                                  title: "Done",
                                ),
                              ),
                      ),
                    ],
                  ),
                ],
                            ),
                          ),
              ))
        ],
      ),
    );
  }
}
