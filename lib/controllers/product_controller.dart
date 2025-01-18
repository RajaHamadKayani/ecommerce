import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_app/models/product_model.dart';
import 'package:ecommerce_app/services/auth_services.dart';
import 'package:ecommerce_app/services/firestore_service.dart';
import 'package:ecommerce_app/views/cart_view.dart';
import 'package:ecommerce_app/views/wishlist_view.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uuid/uuid.dart';

class ProductController extends GetxController {
  final FirestoreService _firestoreService = FirestoreService();
  AuthService _authService = AuthService();
  var nameController = TextEditingController();
  var descriptionController = TextEditingController();
  var priceController = TextEditingController();
  var stockController = TextEditingController();
  var categoryController = TextEditingController();
  var flashSaleController = TextEditingController();

  var isLoading = false.obs;

  // Add a product
  Future<void> addProduct(File? imageFile, bool isTopProduct, bool isNewItem,
      bool isFlashSale, bool isMostPopular, String offPercentage) async {
    isLoading.value = true;

    try {
      double formattedOffPercentage=double.parse(offPercentage);
      // Existing validation...
      if (isFlashSale &&
          (formattedOffPercentage == null ||
              formattedOffPercentage <= 0 ||
              formattedOffPercentage > 100)) {
        throw Exception(
            "Please provide a valid off percentage for the flash sale.");
      }

      String id = const Uuid().v4();

      ProductModel newProduct = ProductModel(
        cart: [],
        wishList: [],
        id: id,
        name: nameController.text.trim(),
        description: descriptionController.text.trim(),
        price: double.parse(priceController.text.trim()),
        stock: int.parse(stockController.text.trim()),
        category: categoryController.text.trim(),
        imageUrl: imageFile != null
            ? await _authService.uploadImageToCloudinary(imageFile)
            : null,
        createdAt: Timestamp.now(),
        isTopProduct: isTopProduct,
        isNewItem: isNewItem,
        isFlashSale: isFlashSale,
        isMostPopular: isMostPopular,
        offPercentage: isFlashSale ? formattedOffPercentage : null,
      );

      await _firestoreService.addProduct(newProduct);
      Get.snackbar("Success", "Product added successfully!");
    } catch (e) {
      Get.snackbar("Error", e.toString());
      if (kDebugMode) {
        print("Error while uploading the product: ${e.toString()}");
      }
    } finally {
      isLoading.value = false;
    }
  }
   // Stream for real-time updates
  Stream<List<ProductModel>> get productStream => _firestoreService.streamAllProducts();
    Future<void> toggleWishList(String productId, String userId, bool isInWishlist, BuildContext context) async {
    if (isInWishlist) {
      await _firestoreService.removeFromWishList(productId, userId);
    } else {
      await _firestoreService.addToWishList(productId, userId);
      Navigator.push(context, MaterialPageRoute(builder: (context)=> WishlistScreen(userId: userId)));
    }
  }

  Future<void> addToCart(String productId, String userId, BuildContext context) async {
    await _firestoreService.addToCart(productId, userId);
          Navigator.push(context, MaterialPageRoute(builder: (context)=> CartView(userId: userId)));

  }

  Future<void> removeFromCart(String productId, String userId) async {
    await _firestoreService.removeFromCart(productId, userId);
  }
}
