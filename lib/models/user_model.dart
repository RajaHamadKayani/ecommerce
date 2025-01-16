class UserModel {
  final String id;
  final String email;
  final String phone;
  final String? imageUrl; // New field for image URL

  UserModel({
    required this.id,
    required this.email,
    required this.phone,
    this.imageUrl,
  });

  // Convert UserModel to Map for Firestore
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'email': email,
      'phone': phone,
      'imageUrl': imageUrl,
    };
  }

  // Create UserModel from Firestore Map
  factory UserModel.fromMap(Map<String, dynamic> map, String documentId) {
    return UserModel(
      id: documentId,
      email: map['email'] ?? '',
      phone: map['phone'] ?? '',
      imageUrl: map['imageUrl'],
    );
  }
}
