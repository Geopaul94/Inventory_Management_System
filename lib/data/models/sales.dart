import 'package:cloud_firestore/cloud_firestore.dart';

class SalesDetailsModel {
  final String saleId;
  final String customerName;
  final String date;
  final String paymentMethod;
  final String product;
  final int quantity;
  final String cash;

  SalesDetailsModel({
    required this.saleId,
    required this.customerName,
    required this.date,
    required this.paymentMethod,
    required this.product,
    required this.quantity,
    required this.cash,
  });

  // Convert SalesDetailsModel to a Map to pass data to Firestore
  Map<String, dynamic> toMap() {
    return {
      'saleId': saleId,
      'customername': customerName,
      'date': date,
      'paymentmethod': paymentMethod,
      'product': product,
      'quantity': quantity,
      'cash': cash,
    };
  }

  // Create SalesDetailsModel from a Firestore document snapshot
  factory SalesDetailsModel.fromFirestore(DocumentSnapshot<Map<String, dynamic>> snapshot) {
    final data = snapshot.data();
    return SalesDetailsModel(
      saleId: snapshot.id,
      customerName: data?['customername'] ?? '',
      date: data?['date'] ?? '',
      paymentMethod: data?['paymentmethod'] ?? '',
      product: data?['product'] ?? '',
      quantity: data?['quantity'] ?? 1,
      cash: data?['cash'] ?? '',
    );
  }
}
