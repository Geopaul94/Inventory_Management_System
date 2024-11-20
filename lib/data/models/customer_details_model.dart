import 'package:cloud_firestore/cloud_firestore.dart';

class CustomerDetailsModel {
  final String customerId;
  final String customerName;
  final String phoneNumber;
  final String address;
  final String email;
  final Timestamp createdAt;

  CustomerDetailsModel(
      {required this.customerId,
      required this.customerName,
      required this.phoneNumber,
      required this.address,
      required this.createdAt,
      required this.email});

  // Convert CustomerDetailsModel to a Map
  Map<String, dynamic> toMap() {
    return {
      'customerId': customerId,
      'customerName': customerName, // Fixed the space here
      'phoneNumber': phoneNumber,
      'address': address,
      'createdAt': createdAt,
      'email': email,
    };
  }

  // Create CustomerDetailsModel from a Map
  factory CustomerDetailsModel.fromMap(Map<String, dynamic> map) {
    return CustomerDetailsModel(
      customerId: map['customerId'] as String? ?? '',
      customerName:
          map['customerName'] as String? ?? '', // Fixed the space here
      phoneNumber: map['phoneNumber'] as String? ?? '',
      address: map['address'] as String? ?? '',
      email: map['email'] as String? ?? '',
      createdAt: map['createdAt'] as Timestamp? ?? Timestamp.now(),
    );
  }

  // Create CustomerDetailsModel from a Firestore document snapshot
  factory CustomerDetailsModel.fromFirestore(
      DocumentSnapshot<Map<String, dynamic>> snapshot) {
    final data = snapshot.data();
    return CustomerDetailsModel(
      customerId: snapshot.id,
      customerName:
          data?['customerName'] as String? ?? '', // Fixed the space here
      phoneNumber: data?['phoneNumber'] as String? ?? '',
      address: data?['address'] as String? ?? '',
      email: data?['email'] as String? ?? '',

      createdAt: data?['createdAt'] as Timestamp? ?? Timestamp.now(),
    );
  }
}
