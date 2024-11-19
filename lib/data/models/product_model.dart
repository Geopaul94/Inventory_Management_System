import 'package:cloud_firestore/cloud_firestore.dart';

class Products {
  String id; // Unique identifier for the product
  String productName;
  String imageUrl;
  String description;
  double price;
  double quantity;
  String category; // New category field
  final Timestamp createdAt; // Timestamp for when the product was created

  // Constructor
  Products({
    required this.id, // Include id in the constructor
    required this.productName,
    required this.imageUrl,
    required this.description,
    required this.price,
    required this.quantity,
    required this.category, // Include category in the constructor
    required this.createdAt, // Include createdAt in the constructor
  });

  // Method to convert a product to a Map to send data to Firebase
  Map<String, dynamic> toMap() {
    return {
      'id': id, // Include id in the map
      'productName': productName,
      'image': imageUrl,
      'description': description,
      'price': price,
      'quantity': quantity,
      'category': category, // Include category in the map
      'createdAt': createdAt, // Include createdAt in the map
    };
  }

  // Method to create a product object from Firebase data (Map)
  factory Products.fromMap(Map<String, dynamic> map) {
    return Products(
      id: map['id'] ?? '', // Extract id from the map
      productName: map['productName'] ?? '',
      imageUrl: map['image'] ?? '',
      description: map['description'] ?? '',
      price: map['price']?.toDouble() ?? 0.0,
      quantity: map['quantity']?.toDouble() ?? 0.0,
      category: map['category'] ?? '', // Extract category from the map
      createdAt: map['createdAt'] ?? Timestamp.now(), // Extract createdAt from the map
    );
  }
}
