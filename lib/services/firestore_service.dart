import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_app/models/product_model.dart';
import 'package:ecommerce_app/models/user_model.dart';
import 'package:ecommerce_app/utils/toast_util.dart';

class FirestoreService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Add a product to Firestore
  Future<void> addProduct(ProductModel product) async {
    try {
      await _firestore.collection('products').doc(product.id).set(product.toMap());
    } catch (e) {
      throw Exception("Error adding product: $e");
    }
  }
   // Stream of products for real-time updates
  Stream<List<ProductModel>> streamAllProducts() {
    return _firestore.collection('products').snapshots().map((snapshot) {
      return snapshot.docs.map((doc) {
        return ProductModel.fromMap(doc.data());
      }).toList();
    });
  }
   // Upload image to Cloudinary
  Future<String> uploadImageToCloudinary(File imageFile) async {
    final cloudName = 'dqs1y6urv'; // Replace with your Cloudinary Cloud Name
    final apiKey = '463369248646777'; // Replace with your Cloudinary API Key
    final preset = 'ecommerce_preset'; // Replace with your Cloudinary Upload Preset

   
  final url = Uri.parse('https://api.cloudinary.com/v1_1/$cloudName/image/upload');
  final request = http.MultipartRequest('POST', url)
    ..fields['upload_preset'] = preset
    ..files.add(await http.MultipartFile.fromPath('file', imageFile.path));

  final response = await request.send();
  if (response.statusCode == 200) {
    ToastUtil.showToast(message: "Image uploaded to Cloudinary successfully");
    final res = await http.Response.fromStream(response);
    final data = jsonDecode(res.body);
    return data['secure_url']; // Image URL from Cloudinary
  } else {
    ToastUtil.showToast(message: "Failed to upload image to Cloudinary");
    throw Exception('Failed to upload image to Cloudinary');
  }
  }
  // Save user details to Firestore
  Future<void> saveUserToFirestore(UserModel user) async {
    try {
      await _firestore.collection('users').doc(user.id).set(user.toMap());
    } catch (e) {
      throw Exception("Error saving user data: $e");
    }
  }
   Future<void> addToWishList(String productId, String userId) async {
    try {
      await _firestore.collection('products').doc(productId).update({
        'wishList': FieldValue.arrayUnion([userId]),
      });
    } catch (e) {
      print("Error adding to wishlist: $e");
    }
  }

  Future<void> removeFromWishList(String productId, String userId) async {
    try {
      await _firestore.collection('products').doc(productId).update({
        'wishList': FieldValue.arrayRemove([userId]),
      });
    } catch (e) {
      print("Error removing from wishlist: $e");
    }
  }

  Future<void> addToCart(String productId, String userId) async {
    try {
      await _firestore.collection('products').doc(productId).update({
        'cart': FieldValue.arrayUnion([userId]),
      });
    } catch (e) {
      print("Error adding to cart: $e");
    }
  }

  Future<void> removeFromCart(String productId, String userId) async {
    try {
      await _firestore.collection('products').doc(productId).update({
        'cart': FieldValue.arrayRemove([userId]),
      });
    } catch (e) {
      print("Error removing from cart: $e");
    }
  }

}
