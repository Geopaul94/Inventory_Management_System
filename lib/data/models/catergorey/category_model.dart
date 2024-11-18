import 'package:cloud_firestore/cloud_firestore.dart';

class CategoryModel {
  final String? categoryId;
  final String? categoryImage;
  final String? productCategory;
  final Timestamp createdAt;

  // Constructor
  CategoryModel({
    this.categoryId,
    this.categoryImage,
    this.productCategory,
    required this.createdAt,
  });

  // Factory constructor to create a CategoryModel from Firebase document
  factory CategoryModel.fromFirestore(Map<String, dynamic> json) {
    return CategoryModel(
      categoryId: json['categoryId'] ?? '',
      categoryImage: json['categoryImage'] ?? '',
      productCategory: json['productCategory'] ?? '',
      createdAt: json['createdAt'] ?? Timestamp.now(), // Use json instead of map
    );
  }

  // Method to convert CategoryModel into a Map (for adding/updating data in Firebase)
  Map<String, dynamic> toFirestore() {
    return {
      'categoryId': categoryId ?? '',
      'categoryImage': categoryImage ?? '',
      'productCategory': productCategory ?? '',
      'createdAt': createdAt,
    };
  }
}
