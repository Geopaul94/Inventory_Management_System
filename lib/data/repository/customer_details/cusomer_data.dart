import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:inventory_management_system/data/models/customer_details_model.dart';
import 'package:inventory_management_system/data/models/sales_model.dart';

class FirestoreServiceCustomer {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;



  // Method to save customer details to Firestore with named parameters
  Future<void> saveCustomer({required CustomerDetailsModel customer}) async {
    await _firestore.collection('customers').doc(customer.customerId).set({
      'customerId': customer.customerId,
      'customerName': customer.customerName,
      'phoneNumber': customer.phoneNumber,
      'address': customer.address,
      'createdAt': customer.createdAt,
      'email': customer.email,
     
    });
  }

  // Update existing customer
  Future<void> updateCustomer(CustomerDetailsModel customer) async {
    try {
      await _firestore
          .collection('customers')
          .doc(customer.customerId)
          .update(customer.toMap());
    } catch (e) {
    }
  }

  // Delete a customer
  Future<void> deleteCustomer(String customerId) async {
    try {
      await _firestore.collection('customers').doc(customerId).delete();
    } catch (e) {
    }
  }

  Future<List<CustomerDetailsModel>> fetchAllCustomers() async {
    try {
      // Fetch all customers from the 'customers' collection
      QuerySnapshot querySnapshot =
          await _firestore.collection('customers').get();

      // Convert the documents into a list of CustomerDetailsModel
      List<CustomerDetailsModel> customers = querySnapshot.docs.map((doc) {
        return CustomerDetailsModel(
          customerId: doc['customerId'],
          customerName: doc['customerName'],
          phoneNumber: doc['phoneNumber'],
          address: doc['address'],
          createdAt: doc['createdAt'], 
          email: doc['email'],
        );
      }).toList();

      return customers;
    } catch (e) {
      // Handle error, you could throw a custom exception or return an empty list
      return [];
    }
  }


////////////////////////////////////


 Future<List<SalesDetailsModel>> fetchCustomerSalesDetails(String customerName) async {
    try {
      // Query Firestore to get sales details for the specified customer
      QuerySnapshot querySnapshot = await _firestore.collection('sales')
          .where('customername', isEqualTo: customerName.toUpperCase()) // Assuming names are stored in lowercase
          .get();

      // Convert the documents into a list of SalesDetailsModel
      List<SalesDetailsModel> salesDetailsList = querySnapshot.docs.map((doc) {
        return SalesDetailsModel.fromFirestore(doc as DocumentSnapshot<Map<String, dynamic>>);
      }).toList();

      return salesDetailsList;
    } catch (e) {
      // Handle error, you could throw a custom exception or return an empty list
      return [];
    }
  }

}
