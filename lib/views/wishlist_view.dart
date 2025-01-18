import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

class WishlistScreen extends StatelessWidget {
   String? userId;

  WishlistScreen({Key? key,  this.userId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
    
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Wishlist",
              style: GoogleFonts.raleway(color: Color(0xff202020),
              fontSize: 28,
              fontWeight: FontWeight.bold),),
              Expanded(
                child: StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestore.instance
                      .collection('products')
                      .where('wishList', arrayContains: userId)
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    }
                
                    if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                      return  Center(child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment:CrossAxisAlignment.center,
                        children: [
                          SvgPicture.asset("assets/svgs/empty_wishlist.svg"),
                          Text('No items in your wishlist.'),
                        ],
                      )); 
                    }
                
                    final products = snapshot.data!.docs;
                
                    return ListView.builder(
                      itemCount: products.length,
                      itemBuilder: (context, index) {
                        final product = products[index];
                        final productName = product['name'] as String;
                        final productPrice = product['price'];
                        final productImage = product['imageUrl'] as String;
                
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
                                          'wishList': FieldValue.arrayRemove(
                                              [userId]),
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
              height: 16, // Set the desired height
              width: 16,  // Set the desired width
            ),
          ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(width: 10,),
                              Expanded(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(productName,
                                     maxLines: 1,
                                     overflow: TextOverflow.ellipsis,
                                    style: GoogleFonts.nunitoSans(color: Colors.black,
                                    fontSize: 12,
                                    fontWeight: FontWeight.normal),),
                                    const SizedBox(height: 11,),
                                    Text("\$${productPrice.toStringAsFixed(2)}",
                                    style: GoogleFonts.raleway(fontSize: 18,
                                    fontWeight: FontWeight.bold),),
                                    Align(
                                      alignment: Alignment.bottomRight,
                                    child: SvgPicture.asset("assets/svgs/add_to_cart_icon.svg"),
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
      ),
    );
  }
}
