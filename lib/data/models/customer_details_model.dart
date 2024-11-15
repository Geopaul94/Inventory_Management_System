import 'package:cloud_firestore/cloud_firestore.dart';

class CustomerDetailsModel {
  final String customerName; // Use camelCase for Dart conventions
  final String phoneNumber;
  final String address;

  // Constructor
  CustomerDetailsModel({
    required this.customerName,
    required this.phoneNumber,
    required this.address,
  });

  // Convert a CustomerDetailsModel into a Map (for sending to Firebase)
  Map<String, dynamic> toMap() {
    return {
      'customerName': customerName,
      'phoneNumber': phoneNumber,
      'address': address,
    };
  }

  // Create a CustomerDetailsModel from a Map (for receiving from Firebase)
  factory CustomerDetailsModel.fromMap(Map<String, dynamic> map) {
    return CustomerDetailsModel(
      customerName: map['customerName'] ?? '',  // Provide defaults in case data is missing
      phoneNumber: map['phoneNumber'] ?? '',
      address: map['address'] ?? '',
    );
  }

  // Optionally, you can also include a method for creating a model from a Firestore document snapshot
  factory CustomerDetailsModel.fromFirestore(DocumentSnapshot<Map<String, dynamic>> snapshot) {
    final data = snapshot.data();
    return CustomerDetailsModel(
      customerName: data?['customerName'] ?? '',
      phoneNumber: data?['phoneNumber'] ?? '',
      address: data?['address'] ?? '',
    );
  }
}
