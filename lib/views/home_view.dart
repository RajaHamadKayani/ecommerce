import 'package:ecommerce_app/controllers/product_controller.dart';
import 'package:ecommerce_app/models/product_model.dart';
import 'package:ecommerce_app/views/product_detail_view.dart';
import 'package:ecommerce_app/views/widgets/reusable_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:ecommerce_app/controllers/user_controller.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  var searchController = TextEditingController();
  ProductController productController = Get.put(ProductController());
  UserController userController = Get.put(UserController());

  @override
  void initState() {
    super.initState();
    userController.fetchCurrentUser(); // Fetch current user data on widget load
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Obx(
          () {
            // Check if the user data is loaded
            if (userController.currentUser.value.id.isEmpty) {
              return const Center(child: CircularProgressIndicator());
            }

            // User data is available
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 27),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Display profile photo and name
                  Row(
                    children: [
                      CircleAvatar(
                        radius: 25,
                        backgroundImage: NetworkImage(
                          userController.currentUser.value.imageUrl ??
                              'https://via.placeholder.com/150', // Fallback image
                        ),
                      ),
                      const SizedBox(width: 16),
                      Text(
                        userController.currentUser.value.email,
                        style: const TextStyle(
                            fontSize: 14, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  // Add additional UI elements here
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        "Shop",
                        style: GoogleFonts.raleway(
                            color: Color(0xff202020),
                            fontSize: 28,
                            fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Expanded(
                          child: ReusableTextFieldWidget(
                              controller: searchController,
                              hintText: "Search",
                              title: "Search Here"))
                    ],
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        "All Items",
                        style: GoogleFonts.raleway(
                            color: Color(0xff202020),
                            fontSize: 21,
                            fontWeight: FontWeight.bold),
                      ),
                      SvgPicture.asset("assets/svgs/filter_icon.svg")
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  // Real-time Product Grid
                  Expanded(
                    child: StreamBuilder<List<ProductModel>>(
                      stream: productController.productStream,
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const Center(
                              child: CircularProgressIndicator());
                        } else if (snapshot.hasError) {
                          return Center(
                              child: Text("Error: ${snapshot.error}"));
                        } else if (!snapshot.hasData ||
                            snapshot.data!.isEmpty) {
                          return const Center(
                              child: Text("No products available"));
                        }

                        final products = snapshot.data!;

                        return GridView.builder(
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2, // Two items per row
                            childAspectRatio: 0.75, // Adjust for image and text
                            mainAxisSpacing: 10,
                            crossAxisSpacing: 10,
                          ),
                          itemCount: products.length,
                          itemBuilder: (context, index) {
                            final product = products[index];
                            return GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => ProductDetailView(
                                              userId: userController
                                                  .currentUser.value.id,
                                              description: product.description,
                                              productPrice: product.price
                                                  .toStringAsFixed(2),
                                              productName: product.name,
                                              productImage:
                                                  product.imageUrl ?? "",
                                              productId: product.id,
                                            )));
                              },
                              child: Card(
                                elevation: 3,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    // Product Image
                                    Expanded(
                                      child: Image.network(
                                        product.imageUrl ??
                                            'https://via.placeholder.com/150', // Fallback image
                                        fit: BoxFit.cover,
                                        width: double.infinity,
                                      ),
                                    ),
                                    const SizedBox(height: 5),
                                    // Product Name
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 8),
                                      child: Text(
                                        product.name,
                                        style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 14,
                                        ),
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                    // Product Price
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 8),
                                      child: Text(
                                        "\$${product.price.toStringAsFixed(2)}",
                                        style: const TextStyle(
                                          color: Colors.green,
                                          fontSize: 12,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        );
                      },
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
