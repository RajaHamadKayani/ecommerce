import 'package:ecommerce_app/controllers/user_controller.dart';
import 'package:ecommerce_app/views/widgets/reusable_container.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class PaymentView extends StatefulWidget {
  String shippingAdress;

   PaymentView({super.key,required this.shippingAdress});

  @override
  State<PaymentView> createState() => _PaymentViewState();
}

class _PaymentViewState extends State<PaymentView> {
    UserController userController = Get.put(UserController());

    var shippingAdressController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(child:
      Obx((){
         // Check if the user data is loaded
            if (userController.currentUser.value.id.isEmpty) {
              return const Center(child: CircularProgressIndicator());
            }
        return  Padding(padding: EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 4
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Payment",
          style: GoogleFonts.raleway(color: Color(0xff202020),
          fontSize: 28,
          fontWeight: FontWeight.bold),),
          const SizedBox(height: 11,),
             Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                        color: Color(0xffF9F9F9),
                        borderRadius: BorderRadius.circular(10)),
                    child: Padding(
                      padding:
                          EdgeInsets.symmetric(vertical: 9, horizontal: 16),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Shipping Address",
                                  style: GoogleFonts.raleway(
                                      color: Color(0xff202020),
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold),
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  widget.shippingAdress,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: GoogleFonts.nunitoSans(
                                      color: Colors.black,
                                      fontSize: 12,
                                      fontWeight: FontWeight.normal),
                                )
                              ],
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              _showImageSourceBottomSheet(context);
                            },
                            child: Container(
                              height: 30,
                              width: 30,
                              decoration: BoxDecoration(
                                  color: Color(0xff004CFF),
                                  borderRadius: BorderRadius.circular(100)),
                              child: Center(
                                child: Icon(
                                  Icons.edit,
                                  color: Colors.white,
                                  size: 15,
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                     const SizedBox(height: 11,),
             Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                        color: Color(0xffF9F9F9),
                        borderRadius: BorderRadius.circular(10)),
                    child: Padding(
                      padding:
                          EdgeInsets.symmetric(vertical: 9, horizontal: 16),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Contact Information",
                                  style: GoogleFonts.raleway(
                                      color: Color(0xff202020),
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold),
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                 Text(
                                  userController.currentUser.value.phone,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: GoogleFonts.nunitoSans(
                                      color: Colors.black,
                                      fontSize: 12,
                                      fontWeight: FontWeight.normal),
                                ),
                                Text(
                                  userController.currentUser.value.email,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: GoogleFonts.nunitoSans(
                                      color: Colors.black,
                                      fontSize: 12,
                                      fontWeight: FontWeight.normal),
                                )
                              ],
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              _showImageSourceBottomSheet(context);
                            },
                            child: Container(
                              height: 30,
                              width: 30,
                              decoration: BoxDecoration(
                                  color: Color(0xff004CFF),
                                  borderRadius: BorderRadius.circular(100)),
                              child: Center(
                                child: Icon(
                                  Icons.edit,
                                  color: Colors.white,
                                  size: 15,
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
        ],
      ),);
      })
      ),
    );
  }
   void _showImageSourceBottomSheet(BuildContext context) {
    showModalBottomSheet(
      backgroundColor: Colors.transparent, // Make the background transparent
      context: context,
      isScrollControlled: true, // Allow the bottom sheet to be full screen
      builder: (context) {
        return GestureDetector(
          onTap: () => Navigator.pop(
              context), // Close the sheet when background is tapped
          child: Stack(
            children: [
              // Semi-transparent background overlay
              Container(
                color: Colors.black
                    .withOpacity(0.5), // Semi-transparent background
              ),
              Align(
                alignment:
                    Alignment.bottomCenter, // Align the content at the bottom
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: LayoutBuilder(
                    builder: (context, constraints) {
                      return Padding(
                        padding: EdgeInsets.only(
                          bottom: MediaQuery.of(context)
                              .viewInsets
                              .bottom, // Adjust for keyboard
                        ),
                        child: Container(
                          decoration: BoxDecoration(
                            color:
                                Theme.of(context).textTheme.bodyLarge?.color ==
                                        Colors.white
                                    ? const Color(0xff100C26)
                                    : Colors.white,
                            borderRadius: BorderRadius.circular(36),
                            border: Border.all(
                                color: Colors
                                    .transparent), // Transparent side borders
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 32),
                            child: SingleChildScrollView(
                              child: Column(
                                mainAxisSize: MainAxisSize
                                    .min, // Adjust the height based on content
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    "Edit Your Shipping Address",
                                    style: TextStyle(
                                      color: Theme.of(context)
                                                  .textTheme
                                                  .bodyLarge
                                                  ?.color ==
                                              Colors.white
                                          ? Colors.white
                                          : const Color(0xff0C091C),
                                      fontFamily: "Pulp",
                                      fontSize: 20,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                  const SizedBox(height: 16),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: TextFormField(
                                      style: GoogleFonts.raleway(
                                          color: Colors.black,
                                          fontSize: 14,
                                          fontWeight: FontWeight.w700),
                                      controller: shippingAdressController,
                                      decoration: InputDecoration(
                                          border: InputBorder.none,
                                          hintText:
                                              "Search Shipping Address here...",
                                          hintStyle: GoogleFonts.raleway(
                                              color: Color(0xffD2D2D2),
                                              fontSize: 14,
                                              fontWeight: FontWeight.w700)),
                                    ),
                                  ),
                                  const SizedBox(height: 20),
                                  GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        widget.shippingAdress =
                                            shippingAdressController.text
                                                .trim();
                                      });
                                      Navigator.pop(context);
                                      shippingAdressController.clear();
                                    },
                                    child: ReusableContainer(
                                        borderRadius: BorderRadius.circular(16),
                                        color: 0xff004CFF,
                                        title: "Done"),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}