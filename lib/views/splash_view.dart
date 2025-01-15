
import 'package:ecommerce_app/views/widgets/reusable_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  @override
  void initState() {
    super.initState();

    // Navigate to LoginView or AllBooksView after 4 seconds
    // Timer(const Duration(seconds: 4), () {
    //   Get.to(LoginView());
    // });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Logo
            Stack(
              alignment: Alignment.center,
              children: [
                SvgPicture.asset(
                  'assets/svgs/splash_logo.svg',
              
                ),
                SvgPicture.asset(
                  'assets/svgs/splash_logo_1.svg',
               
                ),
              ],
            ),
            const SizedBox(height: 20), // Space between logo and text
            // App Name
             Text(
              'Shoppe',
              style: GoogleFonts.raleway(
                fontSize:52,
                fontWeight: FontWeight.bold,
                color: Color(0xff202020),
              ),
            ),
            const SizedBox(height: 18,),
              Text(
              'Beautiful eCommerce UI kit',
              style: GoogleFonts.nunitoSans(
                fontSize:16,
                fontWeight: FontWeight.normal,
                color: Color(0xff202020),
              ),
            ),
              Text(
              'for your online store',
              style: GoogleFonts.nunitoSans(
                fontSize:16,
                fontWeight: FontWeight.normal,
                color: Color(0xff202020),
              ),
            ),
            const SizedBox(height: 100,),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                
                children: [
                  ReusableContainer(borderRadius: BorderRadius.circular(16), color: 0xff004CFF, title: "Let's get started"),
                   const SizedBox(height: 18,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text("I already have an account",
                style: GoogleFonts.nunitoSans(
                  color: Colors.black,
                  fontWeight: FontWeight.normal,
                  fontSize: 15,

                ),),
                const SizedBox(width: 16,),
                Container(
                  height: 30,
                  width: 30,
                  decoration: BoxDecoration(
                    color: Color(0xff004CFF),
                    borderRadius: BorderRadius.circular(100)
                  ),
                  child: Center(
                    child: Icon(Icons.arrow_forward,
                    color: Colors.white,),
                  ),
                )
              ],
            )
                ],
              ),
            ),
           

          ],
        ),
      ),
    );
  }
}
