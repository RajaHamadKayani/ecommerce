import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_app/views/payment_view.dart';
import 'package:ecommerce_app/views/widgets/reusable_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

class CartView extends StatefulWidget {
  String? userId;

  CartView({Key? key, this.userId}) : super(key: key);

  @override
  State<CartView> createState() => _CartViewState();
}

class _CartViewState extends State<CartView> {
  var shippingAdressController = TextEditingController();
  String shippingAddress =
      "26, Doung So 2, Thei Dain Ward, An Phu, District 2, Ho Chi Min City"; // Default address
  int counter = 1;
  Map<String, int> quantities = {}; // Tracks quantities of items

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Cart",
                    style: GoogleFonts.raleway(
                        color: Color(0xff202020),
                        fontSize: 28,
                        fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 11,
                  ),
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
                                  shippingAddress,
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
                  Expanded(
                    child: StreamBuilder<QuerySnapshot>(
                      stream: FirebaseFirestore.instance
                          .collection('products')
                          .where('cart', arrayContains: widget.userId)
                          .snapshots(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const Center(
                              child: CircularProgressIndicator());
                        }

                        if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                          return Center(
                              child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              SvgPicture.asset("assets/svgs/empty_cart.svg"),
                              Text('No items in your cart.'),
                            ],
                          ));
                        }

                        final products = snapshot.data!.docs;
                        double totalPrice = 0;
                        products.forEach((product) {
                          final productId = product.id;
                          final productPrice = product['price'];
                          final quantity = quantities[productId] ?? 1;
                          totalPrice += productPrice * quantity;
                        });

                        return ListView.builder(
                          itemCount: products.length,
                          itemBuilder: (context, index) {
                            final product = products[index];
                            final productName = product['name'] as String;
                            final productId = product.id;

                            final productPrice = product['price'];
                            final productImage = product['imageUrl'] as String;
                            final quantity = quantities[productId] ?? 1;

                            return Padding(
                              padding: const EdgeInsets.only(bottom: 14),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Stack(
                                    children: [
                                      ClipRRect(
                                        borderRadius: BorderRadius.circular(10),
                                        child: Image.network(
                                          productImage,
                                          height: 101,
                                          width: 121,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                      Positioned(
                                        bottom: 8,
                                        left: 8,
                                        child: GestureDetector(
                                          onTap: () {
                                            // Add functionality to remove the product from the wishlist
                                            FirebaseFirestore.instance
                                                .collection('products')
                                                .doc(product.id)
                                                .update({
                                              'cart': FieldValue.arrayRemove(
                                                  [widget.userId]),
                                            });
                                          },
                                          child: Container(
                                            height: 35,
                                            width: 35,
                                            decoration: BoxDecoration(
                                              color: Colors.white,
                                              shape: BoxShape.circle,
                                            ),
                                            child: Center(
                                              child: SvgPicture.asset(
                                                "assets/svgs/delete_icon.svg",
                                                height:
                                                    16, // Set the desired height
                                                width:
                                                    16, // Set the desired width
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Expanded(
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          productName,
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          style: GoogleFonts.nunitoSans(
                                              color: Colors.black,
                                              fontSize: 12,
                                              fontWeight: FontWeight.normal),
                                        ),
                                        const SizedBox(
                                          height: 11,
                                        ),
                                        Text(
                                          "\$${(productPrice * quantity).toStringAsFixed(2)}",
                                          style: GoogleFonts.raleway(
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        Align(
                                          alignment: Alignment.bottomRight,
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              GestureDetector(
                                                onTap: () {
                                                  setState(() {
                                                    if (quantity > 1) {
                                                      quantities[productId] =
                                                          quantity - 1;
                                                    }
                                                  });
                                                },
                                                child: Container(
                                                  height: 30,
                                                  width: 30,
                                                  decoration: BoxDecoration(
                                                      border: Border.all(
                                                          color:
                                                              Color(0xff004BFE),
                                                          width: 1),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              100)),
                                                  child: Center(
                                                    child: Icon(
                                                      Icons.remove,
                                                      color: Color(0xff004BFE),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              const SizedBox(
                                                width: 6,
                                              ),
                                              Container(
                                                  decoration: BoxDecoration(
                                                      color: Color(0xffE5EBFC),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10)),
                                                  child: Padding(
                                                    padding: const EdgeInsets
                                                        .symmetric(
                                                        vertical: 4,
                                                        horizontal: 16),
                                                    child: Text(
                                                      quantity.toString(),
                                                      style:
                                                          GoogleFonts.raleway(
                                                        color: Colors.black,
                                                        fontSize: 16,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                      ),
                                                    ),
                                                  )),
                                              const SizedBox(
                                                width: 6,
                                              ),
                                              GestureDetector(
                                                onTap: () {
                                                  setState(() {
                                                    quantities[productId] =
                                                        quantity + 1;
                                                  });
                                                },
                                                child: Container(
                                                  height: 30,
                                                  width: 30,
                                                  decoration: BoxDecoration(
                                                      border: Border.all(
                                                          color:
                                                              Color(0xff004BFE),
                                                          width: 1),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              100)),
                                                  child: Center(
                                                    child: Icon(
                                                      Icons.add,
                                                      color: Color(0xff004BFE),
                                                    ),
                                                  ),
                                                ),
                                              )
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            );
                          },
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Color(0xffF5F5F5),
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Total ",
                            style: GoogleFonts.raleway(
                              color: Colors.black,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          // Display total price here
                          StreamBuilder<QuerySnapshot>(
                            stream: FirebaseFirestore.instance
                                .collection('products')
                                .where('cart', arrayContains: widget.userId)
                                .snapshots(),
                            builder: (context, snapshot) {
                              if (!snapshot.hasData ||
                                  snapshot.data!.docs.isEmpty) {
                                return Text(
                                  "\$0.00",
                                  style: GoogleFonts.raleway(
                                    color: Colors.black,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                );
                              }

                              final products = snapshot.data!.docs;
                              double totalPrice = 0;

                              // Calculate total price
                              products.forEach((product) {
                                final productId = product.id;
                                final productPrice = product['price'];
                                final quantity = quantities[productId] ?? 1;
                                totalPrice += productPrice * quantity;
                              });

                              return Text(
                                "\$${totalPrice.toStringAsFixed(2)}",
                                style: GoogleFonts.raleway(
                                  color: Colors.black,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                      GestureDetector(
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>  PaymentView(
                            shippingAdress: shippingAddress,
                          )));
                        },
                        child: Container(
                          decoration: BoxDecoration(
                              color: Color(0xff004CFF),
                              borderRadius: BorderRadius.circular(10)),
                          child: Padding(
                            padding:
                                EdgeInsets.symmetric(vertical: 8, horizontal: 25),
                            child: Center(
                              child: Text(
                                "Checkout",
                                style: GoogleFonts.nunitoSans(
                                    color: Color(0xffF3F3F3),
                                    fontWeight: FontWeight.w300,
                                    fontSize: 16),
                              ),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
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
                                        shippingAddress =
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
