import 'package:cloud_firestore/cloud_firestore.dart';

class ProductModel {
  final String id;
  final String name;
  final String description;
  final double price;
  final int stock;
  final String category;
  final String? imageUrl;
  final Timestamp createdAt;
  final bool isTopProduct;
  final bool isNewItem;
  final bool isFlashSale;
  final bool isMostPopular;
  final double? offPercentage; // Only applicable for flash sales
  final List<String> wishList; // New field for wishlist user IDs
  final List<String> cart; // New field for cart user IDs

  ProductModel({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.stock,
    required this.category,
    this.imageUrl,
    required this.createdAt,
    this.isTopProduct = false,
    this.isNewItem = false,
    this.isFlashSale = false,
    this.isMostPopular = false,
    this.offPercentage,
      required this.wishList,
    required this.cart,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'price': price,
      'stock': stock,
      'category': category,
      'imageUrl': imageUrl,
      'createdAt': createdAt,
      'isTopProduct': isTopProduct,
      'isNewItem': isNewItem,
      'isFlashSale': isFlashSale,
      'isMostPopular': isMostPopular,
      'offPercentage': offPercentage,
         'wishList': wishList,
      'cart': cart,
    };
  }

  static ProductModel fromMap(Map<String, dynamic> map) {
    return ProductModel(
      id: map['id'],
      name: map['name'],
      description: map['description'],
      price: map['price'],
      stock: map['stock'],
      category: map['category'],
      imageUrl: map['imageUrl'],
      createdAt: map['createdAt'],
      isTopProduct: map['isTopProduct'] ?? false,
      isNewItem: map['isNewItem'] ?? false,
      isFlashSale: map['isFlashSale'] ?? false,
      isMostPopular: map['isMostPopular'] ?? false,
      offPercentage: map['offPercentage'],
        wishList: List<String>.from(map['wishList'] ?? []),
      cart: List<String>.from(map['cart'] ?? []),
    );
  }
}
