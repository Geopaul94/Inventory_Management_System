// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import 'package:inventory_management_system/data/models/customer_details_model.dart';
// import 'package:inventory_management_system/data/repository/customer_details/cusomer_data.dart';
// import 'package:inventory_management_system/presentation/screeens/sales_screen/add_sales_page.dart';
// import 'package:inventory_management_system/presentation/widgets/CustomElevatedButton.dart';
// import 'package:inventory_management_system/presentation/widgets/CustomeAppbar.dart';
// import 'package:inventory_management_system/utilities/constants/constants.dart';

// class SalesPage extends StatelessWidget {
 

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: const CustomAppBar(title: "Customers"),
//       body: Column(children: [],),
      
    
//       floatingActionButton: FloatingActionButton.extended(
//         backgroundColor: floatingActionButtoncolor,
//         foregroundColor: black,
//         onPressed: () async {
//           await Navigator.of(context).push(
//             MaterialPageRoute(builder: (context) => AddSalesPage()),
//           );
//         },
//         icon: const Icon(Icons.add),
//         label: const Text('Add Customer'),
//       ),
//     );
//   }
// }

// class CustomerCard extends StatelessWidget {
//   final CustomerDetailsModel customer;

//   const CustomerCard({Key? key, required this.customer}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Card(
//       elevation: 5,
//       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
//       child: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Row(
//               children: [
//                 Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     h10,
                 
//                 const SizedBox(height: 16),
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }


import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:inventory_management_system/data/models/sales.dart';
import 'package:inventory_management_system/data/repository/customer_details/cusomer_data.dart';
import 'package:inventory_management_system/data/repository/sale/sales_data.dart';
import 'package:inventory_management_system/presentation/screeens/sales_screen/add_sales_page.dart';
import 'package:inventory_management_system/presentation/widgets/CustomElevatedButton.dart';
import 'package:inventory_management_system/utilities/constants/constants.dart';

class SalesPage extends StatelessWidget {
  const SalesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(







      body: Center(
      ),
      floatingActionButton: FloatingActionButton.extended(
  backgroundColor: floatingActionButtoncolor, // Use your defined color
  foregroundColor: Colors.white,
  onPressed: () {
   Navigator.push(context, MaterialPageRoute(builder: (context) => AddSalesPage(),));
  },
  icon: const Icon(Icons.add),
  label: const Text('Add New Sale'),
),
    );
  }
}




//   final FirebaseFirestore _firestore = FirebaseFirestore.instance;
// Future<List<SalesDetailsModel>> fetchAllSales() async {
//   try {
//     QuerySnapshot querySnapshot = await _firestore.collection('sales').get();

//     // Convert the documents into a list of SalesDetailsModel
//     List<SalesDetailsModel> sales = querySnapshot.docs.map((doc) {
//       return SalesDetailsModel.fromFirestore(doc as DocumentSnapshot<Map<String, dynamic>>);
//     }).toList();

//     // Loop through sales and print the details
//     sales.forEach((sale) {
//       print('Customer Name: ${sale.customerName}');
//       print('Date: ${sale.date}');
//       print('Payment Method: ${sale.paymentMethod}');
//       print('Product: ${sale.product}');
//       print('Quantity: ${sale.quantity}');
//       print('Cash: ${sale.cash}');
//     });

//     return sales;
//   } catch (e) {
//     print('Error fetching sales: $e');
//     return [];
//   }
// }

// Future<void> fetchAllSales() async {
//   try {
//     List<SalesDetailsModel> salesList = await FirestoreServiceSales().fetchAllSales();
//     for (var sale in salesList) {
//       print('Fetched Sale: saleId=${sale.saleId}, ${sale.toMap()}');
//     }
//   } catch (e) {
//     print('Error fetching all sales: $e');
//   }
// }




// void addSale() {
//   final newSale = SalesDetailsModel(
//     saleId: '4',  // This is the saleId you will use to update or delete
//     customerName: 'geo paulson ',
//     date: '2024-11-17',
//     paymentMethod: 'Cash',
//     product: 'Product A',
//     quantity: 1,
//     cash: '100',
//   );

//   FirestoreServiceSales().addNewSale(newSale);
// }

// void updateSpecificSale() {
//   final updatedSale = SalesDetailsModel(
//     saleId: 'w6dNdG0y29EBqL6ub2ew',  // Ensure this is the same saleId
//     customerName: 'Updated Customer',
//     date: '2024-11-18',
//     paymentMethod: 'Credit Card',
//     product: 'Updated Product',
//     quantity: 2,
//     cash: '200',
//   );

//   FirestoreServiceSales().updateSale(updatedSale);
// }

// void deleteSpecificSale(String saleId) {
//   FirestoreServiceSales().deleteSale(saleId);
// }
