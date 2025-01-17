import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_app/services/auth_services.dart';
import 'package:get/get.dart';
import 'package:ecommerce_app/models/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UserController extends GetxController {
  var currentUser = UserModel(id: '', email: '', phone: '', imageUrl: '').obs;

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _db = FirebaseFirestore.instance;
AuthService _authService=AuthService();
  // Fetch current logged-in user data
   Future<void> fetchCurrentUser() async {
    try {
      User? user = _auth.currentUser; // Get the currently authenticated user
      if (user != null) {
        // Fetch user data from Firestore
        currentUser.value = await _authService. fetchUserById(user.uid); // Fetch user by ID
      }
    } catch (e) {
      print("Error fetching user: $e");
    }
  }
}
