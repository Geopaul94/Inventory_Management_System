import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:inventory_management_system/data/models/sales_model.dart';

class FirestoreServiceSales {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Fetch all sales from Firestore
  Future<List<SalesDetailsModel>> fetchAllSales() async {
    try {
      QuerySnapshot querySnapshot = await _firestore.collection('sales').get();

      // Convert the documents into a list of SalesDetailsModel
      List<SalesDetailsModel> sales = querySnapshot.docs.map((doc) {
        return SalesDetailsModel.fromFirestore(
            doc as DocumentSnapshot<Map<String, dynamic>>);
      }).toList();

      return sales;
    } catch (e) {
      print('Error fetching sales: $e');
      return [];
    }
  }

  Future<void> addNewSale(SalesDetailsModel sale) async {
    try {
      // Use the saleId as the document ID
      await _firestore.collection('sales').doc(sale.saleId).set(sale.toMap());
      print('Sale added successfully!');
    } catch (e) {
      print('Error adding sale: $e');
    }
  }

  // Delete a sale by saleId
  Future<void> deleteSale(String saleId) async {
    try {
      await _firestore.collection('sales').doc(saleId).delete();
      print('Sale deleted successfully!');
    } catch (e) {
      print('Error deleting sale: $e');
    }
  }

  // Update a sale by saleId
Future<void> updateSale(SalesDetailsModel sale) async {
  try {
    // Check if the document exists before attempting to update
    DocumentSnapshot<Map<String, dynamic>> docSnapshot =
        await _firestore.collection('sales').doc(sale.saleId).get();

    if (docSnapshot.exists) {
      // If the document exists, perform the update
      await _firestore.collection('sales').doc(sale.saleId).update(sale.toMap());
      print('Sale updated successfully!');
    } else {
      // If document does not exist, log the message
      print('Sale with saleId: ${sale.saleId} does not exist.');
    }
  } catch (e) {
    print('Error updating sale: $e');
  }
}

}