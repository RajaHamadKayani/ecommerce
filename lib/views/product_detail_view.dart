import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:get/get.dart';
import 'package:ecommerce_app/controllers/product_controller.dart';

class ProductDetailView extends StatefulWidget {
  final String productImage;
  final String productPrice;
  final String productName;
  final String description;
  final String productId;
  final String userId;

  ProductDetailView({
    Key? key,
    required this.productImage,
    required this.description,
    required this.userId,
    required this.productId,
    required this.productName,
    required this.productPrice,
  }) : super(key: key);

  @override
  State<ProductDetailView> createState() => _ProductDetailViewState();
}

class _ProductDetailViewState extends State<ProductDetailView> {
  final ProductController _productController = Get.put(ProductController());
  bool isWishlisted = false; // State to track if the product is in the wishlist
  bool isInCart = false; // State to track if the product is in the cart

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height * 0.5,
            child: Image.network(
              widget.productImage,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(height: 18),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "\$${widget.productPrice}",
                      style: GoogleFonts.raleway(
                        color: const Color(0xff000000),
                        fontSize: 26,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SvgPicture.asset("assets/svgs/share_icon.svg"),
                  ],
                ),
                const SizedBox(height: 14),
                Text(
                  widget.description,
                  style: GoogleFonts.nunitoSans(
                    color: Colors.black,
                    fontSize: 15,
                    fontWeight: FontWeight.normal,
                  ),
                ),
                const SizedBox(height: 30),
                Row(
                  children: [
                    // Wishlist Button
                    Expanded(
                      child: GestureDetector(
                        onTap: () async {
                          setState(() {
                            isWishlisted = !isWishlisted;
                          });
                          await _productController.toggleWishList(
                            widget.productId,
                            widget.userId,
                            isWishlisted,
                            context
                          );
                        },
                        child: Container(
                          height: 40,
                          decoration: BoxDecoration(
                            color: const Color(0xffF9F9F9),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Center(
                            child: Icon(
                              isWishlisted
                                  ? Icons.favorite
                                  : Icons.favorite_outline,
                              color: isWishlisted
                                  ? Colors.red
                                  : Colors.black,
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 16),
                    // Add to Cart Button
                    Expanded(
                      flex: 4,
                      child: GestureDetector(
                        onTap: () async {
                          if (!isInCart) {
                            setState(() {
                              isInCart = true;
                            });
                            await _productController.addToCart(
                              widget.productId,
                              widget.userId,
                            );
                          }
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            color: const Color(0xff202020),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 22,
                              vertical: 8,
                            ),
                            child: Center(
                              child: Text(
                                isInCart ? "In Cart" : "Add to cart",
                                style: GoogleFonts.nunitoSans(
                                  color: const Color(0xffF3F3F3),
                                  fontSize: 16,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                      const SizedBox(width: 16),
                    // Add to Cart Button
                    Expanded(
                      flex: 4,
                      child: GestureDetector(
                        onTap: () async {
                         
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            color: const Color(0XFF004CFF),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 22,
                              vertical: 8,
                            ),
                            child: Center(
                              child: Text(
                                "Buy Now",
                                style: GoogleFonts.nunitoSans(
                                  color: const Color(0xffF3F3F3),
                                  fontSize: 16,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
