class UserModel {
  final String id;
  final String name;
  final String email;
  final String address;
  final String phone;
  final String dob;

  UserModel({
    required this.id,
    required this.name,
    required this.email,
    required this.address,
    required this.phone,
    required this.dob,
  });

  // Convert UserModel to Map for Firestore
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'address': address,
      'phone': phone,
      'dob': dob,
    };
  }

  // Create UserModel from Firestore Map
  factory UserModel.fromMap(Map<String, dynamic> map, String documentId) {
    return UserModel(
      id: documentId,
      name: map['name'] ?? '',
      email: map['email'] ?? '',
      address: map['address'] ?? '',
      phone: map['phone'] ?? '',
      dob: map['dob'] ?? '',
    );
  }
}
