import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:inventory_management_system/data/models/customer_details_model.dart';
class Sales {
  final String cash;
  final String date;
  final String product;
  final String quantity;
  final String address;
  final CustomerDetailsModel? customerDetails; // Optional customer details

  // Constructor
  Sales({
    required this.cash,
    required this.date,
    required this.product,
    required this.quantity,
    required this.address,
    this.customerDetails, // Optional parameter
  });

  // Convert a Sales object into a Map (for sending to Firebase)
  Map<String, dynamic> toMap() {
    return {
      'cash': cash,
      'date': date,
      'product': product,
      'quantity': quantity,
      'address': address,
      'customerDetails': customerDetails?.toMap(), // Convert customer details to Map if present
    };
  }

  // Create a Sales object from a Map (for receiving from Firebase)
  factory Sales.fromMap(Map<String, dynamic> map) {
    return Sales(
      cash: map['cash'] ?? '',
      date: map['date'] ?? '',
      product: map['product'] ?? '',
      quantity: map['quantity'] ?? '',
      address: map['address'] ?? '',
      customerDetails: map['customerDetails'] != null
          ? CustomerDetailsModel.fromMap(map['customerDetails']) // Handle customer details if present
          : null,
    );
  }

  // Create a Sales object from a Firestore document snapshot
  factory Sales.fromFirestore(DocumentSnapshot<Map<String, dynamic>> snapshot) {
    final data = snapshot.data();
    return Sales(
      cash: data?['cash'] ?? '',
      date: data?['date'] ?? '',
      product: data?['product'] ?? '',
      quantity: data?['quantity'] ?? '',
      address: data?['address'] ?? '',
      customerDetails: data?['customerDetails'] != null
          ? CustomerDetailsModel.fromMap(data!['customerDetails'])
          : null,
    );
  }
}
