import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inventory_management_system/data/models/sales_model.dart';
import 'package:inventory_management_system/presentation/bloc/sales_bloc/sales_bloc.dart';
import 'package:inventory_management_system/presentation/screeens/sales_screen/add_sales_page.dart';
import 'package:inventory_management_system/presentation/widgets/CustomText.dart';
import 'package:inventory_management_system/utilities/constants/constants.dart';

// class SalesPage extends StatefulWidget {
//   SalesPage({super.key});

//   @override
//   State<SalesPage> createState() => _SalesPageState();
// }

// class _SalesPageState extends State<SalesPage> {
//   final List<String> _paymentMethods = [
//     'Card',
//     'Bank Transfer',
//     'UPI',
//     'Cash',
//   ];

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: BlocConsumer<SalesBloc, SalesState>(
//         listener: (context, state) {
         
//         },
//         builder: (context, state) {


// if (state is FetchAllSaleLoadingState) {


// return CircularProgressIndicator();


// } else if (state is FetchAllSaleSuccessState)
// {

// final List<SalesDetailsModel>  salesDetailsModel =state.salesDetailsModel;



// if (salesDetailsModel.isEmpty ) {
// return Center(child: CustomText(text: "No Sales data is availabel "),);


// }
// else {

//   ListView.builder(
//       itemCount: salesDetailsModel.length * 2 - 1, 
//       itemBuilder: (context, index) {
//         if (index.isOdd) {
//           return Divider(); 
//         }

//         final itemIndex = index ~/ 2; // Calculate the actual item index
//         return SaleProductCard(salesDetailsModel: state.salesDetailsModel[index]);





// });




// }


      







// } return const Center();


//         }
//       ),
//       floatingActionButton: FloatingActionButton.extended(
//         backgroundColor: floatingActionButtoncolor, // Use your defined color
//         foregroundColor: Colors.black,
//         onPressed: () {
//           Navigator.push(
//               context,
//               MaterialPageRoute(
//                 builder: (context) => AddSalesPage(),
//               ));
//         },
//         icon: const Icon(Icons.add),
//         label: const Text('Add New Sale'),
//       ),
//     );
//   }
// }



















// class SaleProductCard extends StatelessWidget {
//   final SalesDetailsModel salesDetailsModel;
//   const SaleProductCard({super.key, required this.salesDetailsModel});

//   @override
//   Widget build(BuildContext context) {
//     return Card(
//       elevation: 5,
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.circular(15),
//       ),
//       margin: const EdgeInsets.all(15),
//       child:  Padding(
//         padding:  EdgeInsets.all(15),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: <Widget>[
          

// CustomText(text: salesDetailsModel.product ),

// CustomText(text: salesDetailsModel.customerName ),

// CustomText(text: salesDetailsModel.date ),

// CustomText(text: salesDetailsModel.quantity.toString() ),



// CustomText(text: salesDetailsModel.paymentMethod ),

// CustomText(text: salesDetailsModel.cash ),



// CustomText(text: salesDetailsModel.product ),

// CustomText(text: salesDetailsModel.customerName ),

//           ],
//         ),
//       ),
//     );
//   }
// }








import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// Assuming you have imported your necessary classes like SalesBloc, SalesState, SalesDetailsModel, etc.

class SalesPage extends StatefulWidget {
  SalesPage({super.key});

  @override
  State<SalesPage> createState() => _SalesPageState();
}

class _SalesPageState extends State<SalesPage> {
  final List<String> _paymentMethods = [
    'Card',
    'Bank Transfer',
    'UPI',
    'Cash',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<SalesBloc, SalesState>(
        listener: (context, state) {
          // Add your state listener code here if needed
        },
        builder: (context, state) {
          if (state is FetchAllSaleLoadingState) {
            return Center(child: CircularProgressIndicator());
          } else if (state is FetchAllSaleSuccessState) {
            final List<SalesDetailsModel> salesDetailsModel = state.salesDetailsModel;

            if (salesDetailsModel.isEmpty) {
              return Center(child: CustomText(text: "No Sales data is available"));
            } else {
              return ListView.builder(
                itemCount: salesDetailsModel.length * 2 - 1,
                itemBuilder: (context, index) {
                  if (index.isOdd) {
                    return Divider();
                  }

                  final itemIndex = index ~/ 2; // Calculate the actual item index
                  return SaleProductCard(salesDetailsModel: salesDetailsModel[itemIndex]);
                },
              );
            }
          } else if (state is FetchAllSaleErrorState) {
            return Center(child: CustomText(text: "An error occurred: ${state.error}"));
          } else {
            return Center(child: CustomText(text: "Unexpected error occurred"));
          }
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: floatingActionButtoncolor, // Use your defined color
        foregroundColor: Colors.black,
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => AddSalesPage(),
              ));
        },
        icon: const Icon(Icons.add),
        label: const Text('Add New Sale'),
      ),
    );
  }
}

class SaleProductCard extends StatelessWidget {
  final SalesDetailsModel salesDetailsModel;
  const SaleProductCard({super.key, required this.salesDetailsModel});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      margin: const EdgeInsets.all(15),
      child: Padding(
        padding: EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            CustomText(text: salesDetailsModel.product),
            Divider(),
            CustomText(text: salesDetailsModel.customerName),
            Divider(),
            CustomText(text: salesDetailsModel.date),
            Divider(),
            CustomText(text: salesDetailsModel.quantity.toString()),
            Divider(),
            CustomText(text: salesDetailsModel.paymentMethod),
            Divider(),
            CustomText(text: salesDetailsModel.cash),
          ],
        ),
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
