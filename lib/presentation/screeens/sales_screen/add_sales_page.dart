import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:inventory_management_system/data/models/sales_model.dart';
import 'package:inventory_management_system/presentation/bloc/sales_bloc/sales_bloc.dart';
import 'package:inventory_management_system/presentation/screeens/main_screens.dart';
import 'package:inventory_management_system/presentation/screeens/sales_screen/categoryfield.dart';
import 'package:inventory_management_system/presentation/screeens/sales_screen/product_payment_textform.dart';
import 'package:inventory_management_system/presentation/widgets/CustomeAppbar.dart';
import 'package:inventory_management_system/presentation/widgets/custom_text.dart';
import 'package:inventory_management_system/presentation/widgets/custome_snackbar.dart';
import 'package:inventory_management_system/presentation/widgets/custometextformfield.dart';
import 'package:inventory_management_system/presentation/widgets/errorstate_widget.dart';
import 'package:inventory_management_system/presentation/widgets/validations.dart';
import 'package:inventory_management_system/utilities/constants/constants.dart';
import 'package:inventory_management_system/utilities/functions/date_picker.dart';

class AddSalesPage extends StatefulWidget {
  const AddSalesPage({super.key});

  @override
  State<AddSalesPage> createState() => _AddSalesPageState();
}

class _AddSalesPageState extends State<AddSalesPage> {
  final List<String> _paymentMethods = [
    'Card',
    'Bank Transfer',
    'UPI',
    'Cash',
  ];
  final TextEditingController _productcategoryController =
      TextEditingController();
  final TextEditingController _productNameController = TextEditingController();
  final TextEditingController _purchasequantityController =
      TextEditingController();
  final TextEditingController _customerNameController = TextEditingController();
  final TextEditingController _Timecontroller = TextEditingController();
  final TextEditingController _DateandTimeController = TextEditingController();
  final TextEditingController _PaymentcontrollerController =
      TextEditingController();
  final TextEditingController _PricecontrollerController =
      TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: "Add New Sale"),
      body: BlocConsumer<SalesBloc, SalesState>(
        listener: (context, state) {
          if (state is AddNewSaleSuccessState) {
          Navigator.push(
  context,
  MaterialPageRoute(
    builder: (context) => const MainScreens(
      initialIndex: 1,
    ),
  ),
);

            customSnackbar(context, 'Sale added successfully', green);
          } else if (state is AddNewSaleErrorState) {
            Navigator.pop(context);
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.error)),
            );
          }
        },
        builder: (context, state) {
          return SafeArea(
            child: Form(
              key: _formKey,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              child: SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: .03.sw),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      h30,
                      const CustomText(
                        text: "Product",
                        color: black,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                      CustomTextFormField(
                        labelText: "Product",
                        icon: CupertinoIcons.shopping_cart,
                        controller: _productNameController,
                        validator: validateProductName,
                      ),
                      const SizedBox(height: 15),
                      const CustomText(
                        text: "Customer Name",
                        color: black,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                      CustomTextFormField(
                        labelText: "Customer Name",
                        icon: CupertinoIcons.person_2,
                        controller: _customerNameController,
                        validator: validateProductName,
                      ),
                      const SizedBox(height: 15),
                      const CustomText(
                        text: "Product Category",
                        color: black,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                      CategoryListfield(
                        controller: _productcategoryController,
                      ),
                      const SizedBox(height: 10),
                      const CustomText(
                        text: "Date and Time",
                        color: black,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                      CustomTextFormField(
                        labelText: "Purchase Date and Time",
                        icon: CupertinoIcons.calendar,
                        controller: _DateandTimeController,
                        validator: validateDate,
                        readOnly: true,
                        onTap: () async {
                          DateTimeResult? selectedDateTime =
                              await selectDateTime(context);
                          if (selectedDateTime != null) {
                            setState(() {
                              _DateandTimeController.text =
                                  selectedDateTime.formattedDate.toString();
                              _Timecontroller.text =
                                  selectedDateTime.formattedTime.toString();
                            });
                          }
                        },
                      ),
                      const SizedBox(height: 15),
                      const CustomText(
                        text: "Payment Method",
                        color: black,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                      PaymentMethodSelectionField(
                        controller: _PaymentcontrollerController,
                        paymentMethods: _paymentMethods,
                      ),
                      const SizedBox(height: 10),
                      const CustomText(
                        text: "Quantity",
                        color: black,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                      CustomTextFormField(
                        labelText: "Number of product",
                        icon: CupertinoIcons.list_number,
                        controller: _purchasequantityController,
                        validator: validateProductQuantity,
                        keyboardType: TextInputType.number,
                      ),
                      const CustomText(
                        text: "Price",
                        color: black,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                      CustomTextFormField(
                        labelText: "Price of the product",
                        icon: CupertinoIcons.money_dollar,
                        controller: _PricecontrollerController,
                        validator: validateProductPrice,
                        keyboardType: TextInputType.number,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
      floatingActionButton: BlocBuilder<SalesBloc, SalesState>(
        builder: (context, state) {
          if (state is AddNewSaleLoadingState) {
            return Padding(
              padding:
                  EdgeInsets.symmetric(vertical: .090.sh, horizontal: .01.sw),
              child: const FloatingActionButton(
                backgroundColor: Colors.blue,
                onPressed: null,
                child: CircularProgressIndicator(color: Colors.white),
              ),
            );
          } else if (state is AddNewSaleErrorState) {
            return errorStateWidget("Error occurred", const TextStyle(), red);
          }
          return Padding(
            padding: EdgeInsets.symmetric(vertical: .02.sh, horizontal: .01.sw),
            child: FloatingActionButton.extended(
              backgroundColor: floatingActionButtoncolor,
              foregroundColor: white,
              onPressed: () async {
                if (_formKey.currentState!.validate()) {
                  String newSaleId =
                      FirebaseFirestore.instance.collection('sales').doc().id;
                  Timestamp currentTime = Timestamp.now();

                  final SalesDetailsModel salesDetailsModel = SalesDetailsModel(
                    saleId: newSaleId,
                    customerName: _customerNameController.text,
                    date: _DateandTimeController.text,
                    paymentMethod: _PaymentcontrollerController.text,
                    product: _productNameController.text,
                    quantity: int.parse(_purchasequantityController.text),
                    cash: _PricecontrollerController.text,
                    createdAt: currentTime,
                    Time: _Timecontroller.text,
                    productCategory: _productcategoryController.text,
                  );
                  context.read<SalesBloc>().add(OnAddNewSaleButtonClickedEvent(
                        salesDetailsModel: salesDetailsModel,
                      ));

                  _formKey.currentState!.reset();
                  FocusScope.of(context).unfocus();
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                        content: Text('Please fix the errors in the form')),
                  );
                }
              },
              icon: const Icon(Icons.add),
              label: const Text('Save'),
            ),
          );
        },
      ),
    );
  }
}



// void _showCustomerSearchDialog(BuildContext context) {
//   final TextEditingController _mobileNumberController = TextEditingController();

//   showDialog(
//     context: context,
//     builder: (context) {
//       return AlertDialog(
//         title: Text('Search Customer'),
//         content: Column(
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             TextField(
//               controller: _mobileNumberController,
//               keyboardType: TextInputType.phone,
//               decoration: InputDecoration(
//                 labelText: 'Enter Mobile Number',
//                 prefixIcon: Icon(CupertinoIcons.phone),
//                 border: OutlineInputBorder(),
//               ),
//             ),
//           ],
//         ),
//         actions: [
//           TextButton(
//             onPressed: () {
//               // Close the dialog
//               Navigator.of(context).pop();
//             },
//             child: Text('Cancel'),
//           ),
//           ElevatedButton(
//             onPressed: () {
//               // Trigger search function
//               _searchCustomer(_mobileNumberController.text.trim(), context);
//             },
//             child: Text('Search'),
//           ),
//         ],
//       );
//     },
//   );
// }

// Future<void> _searchCustomer(String phoneNumber, BuildContext context) async {
//   final FirebaseFirestore _firestore = FirebaseFirestore.instance;
//   try {
//     // Query customers based on mobile number
//     QuerySnapshot querySnapshot = await _firestore
//         .collection('customers')
//         .where('phone', isEqualTo: phoneNumber)
//         .get();

//     if (querySnapshot.docs.isEmpty) {
//       // No customer found
//       _showNoCustomerFound(context, phoneNumber);
//     } else {
//       // Customer found
//       final customerData = querySnapshot.docs.first.data();
//       // Navigate back with customer data
//       Navigator.pop(context, customerData);
//       _populateCustomerDetails(customerData); // Function to populate data in AddSalesPage
//     }
//   } catch (e) {
//     print('Error searching customer: $e');
//   }
// }

// void _showNoCustomerFound(BuildContext context, String phoneNumber) {
//   showDialog(
//     context: context,
//     builder: (context) {
//       return AlertDialog(
//         title: Text('No Customer Found'),
//         content: Text('No customer found with mobile number $phoneNumber.'),
//         actions: [
//           TextButton(
//             onPressed: () {
//               Navigator.of(context).pop(); // Close this dialog
//             },
//             child: Text('Cancel'),
//           ),
//           ElevatedButton(
//             onPressed: () {
//               Navigator.of(context).pop(); // Close the dialog
//               // Navigate to the AddCustomer page and pass the phone number
//               Navigator.push(
//                 context,
//                 MaterialPageRoute(
//                   builder: (context) => AddSalesPage(phoneNumber: phoneNumber),
//                 ),
//               );
//             },
//             child: Text('Add Customer'),
//           ),
//         ],
//       );
//     },
//   );
// }


