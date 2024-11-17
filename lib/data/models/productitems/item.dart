import 'package:cloud_firestore/cloud_firestore.dart';

class ItemModel {
  final String productId;
  final String productName;
  final String category;
  final int stockQuantity;
  final int unitsSold;
  final int reorderLevel;

  ItemModel({
    required this.productId,
    required this.productName,
    required this.category,
    required this.stockQuantity,
    required this.unitsSold,
    required this.reorderLevel,
  });

  // Create the 'fromFirestore' factory method if you don't have it
  factory ItemModel.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return ItemModel(
      productId: data['productId'] ?? '',
      productName: data['productName'] ?? '',
      category: data['category'] ?? '',
      stockQuantity: data['stockQuantity'] ?? 0,
      unitsSold: data['unitsSold'] ?? 0,
      reorderLevel: data['reorderLevel'] ?? 0,
    );
  }

  // Add the toString method for easy printing
  @override
  String toString() {
    return 'ItemModel(productId: $productId, productName: $productName, category: $category, stockQuantity: $stockQuantity, unitsSold: $unitsSold, reorderLevel: $reorderLevel)';
  }
}
