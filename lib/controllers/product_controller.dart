import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_app/models/product_model.dart';
import 'package:ecommerce_app/services/firestore_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uuid/uuid.dart';

class ProductController extends GetxController {
  final FirestoreService _firestoreService = FirestoreService();

  var nameController = TextEditingController();
  var descriptionController = TextEditingController();
  var priceController = TextEditingController();
  var stockController = TextEditingController();
  var categoryController = TextEditingController();

  var isLoading = false.obs;

  // Add a product
  Future<void> addProduct(String imageUrl) async {
    isLoading.value = true;

    try {
      final String productId = const Uuid().v4(); // Generate a unique ID for the product

      ProductModel newProduct = ProductModel(
        id: productId,
        name: nameController.text.trim(),
        description: descriptionController.text.trim(),
        price: double.parse(priceController.text.trim()),
        stock: int.parse(stockController.text.trim()),
        category: categoryController.text.trim(),
        imageUrl: imageUrl,
        createdAt: Timestamp.now(),
      );

      await _firestoreService.addProduct(newProduct);

      Get.snackbar("Success", "Product added successfully!");

      // Clear the form fields
      nameController.clear();
      descriptionController.clear();
      priceController.clear();
      stockController.clear();
      categoryController.clear();
    } catch (e) {
      Get.snackbar("Error", "Failed to add product: $e");
    } finally {
      isLoading.value = false;
    }
  }
}
