
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_app/models/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Register a new user
 // Register user and return UserCredential
  Future<UserCredential> registerUser(String email, String password) async {
    try {
      return await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
    } catch (e) {
      throw Exception("Error registering user: $e");
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

  // Login user
  Future<User?> loginUser(String email, String password) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return userCredential.user;
    } catch (e) {
      throw Exception("Error logging in user: $e");
    }
  }

  // Fetch current user data
  Future<UserModel?> fetchCurrentUser() async {
    try {
      final User? user = _auth.currentUser;
      if (user != null) {
        final DocumentSnapshot doc =
            await _firestore.collection('users').doc(user.uid).get();
        if (doc.exists) {
          return UserModel.fromMap(doc.data() as Map<String, dynamic>, doc.id);
        }
      }
    } catch (e) {
      throw Exception("Error fetching current user data: $e");
    }
    return null;
  }
}
