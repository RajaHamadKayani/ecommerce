import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_app/models/product_model.dart';

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
}
