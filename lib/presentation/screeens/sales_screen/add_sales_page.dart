import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inventory_management_system/data/models/customer_details_model.dart';
import 'package:inventory_management_system/data/models/sales_model.dart';
import 'package:inventory_management_system/presentation/bloc/sales_bloc/sales_bloc.dart';
import 'package:inventory_management_system/presentation/screeens/main_screens.dart';
import 'package:inventory_management_system/presentation/screeens/sales_screen/product_payment_textform.dart';
import 'package:inventory_management_system/presentation/screeens/sales_screen/sales_page.dart';
import 'package:inventory_management_system/presentation/widgets/CustomeAppbar.dart';
import 'package:inventory_management_system/presentation/widgets/custom_text.dart';
import 'package:inventory_management_system/presentation/widgets/custometextformfield.dart';
import 'package:inventory_management_system/presentation/widgets/errorstate_widget.dart';
import 'package:inventory_management_system/presentation/widgets/validations.dart';
import 'package:inventory_management_system/utilities/constants/constants.dart';
import 'package:inventory_management_system/utilities/functions/date_picker.dart';

class AddSalesPage extends StatefulWidget {
  AddSalesPage({super.key});

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

  final TextEditingController _productNameController = TextEditingController();
  final TextEditingController _purchasequantityController = TextEditingController();
  final TextEditingController _customerNameController = TextEditingController();
  final TextEditingController _Timecontroller = TextEditingController();
  final TextEditingController _DateandTimeController = TextEditingController();
  final TextEditingController _PaymentcontrollerController = TextEditingController();
  final TextEditingController _PricecontrollerController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<SalesBloc, SalesState>(
        listener: (context, state) {
          if (state is AddNewSaleLoadingState) {
            // Show loading indicator
            showDialog(
              context: context,
              barrierDismissible: false,
              builder: (BuildContext context) {
                return const Center(child: CircularProgressIndicator());
              },
            );
          } else if (state is AddNewSaleSuccessState) {
            Navigator.pop(context); // Close the loading dialog
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Sale added successfully')),
            );
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => SalesPage()),
            );
          } else if (state is AddNewSaleErrorState) {
            Navigator.pop(context); // Close the loading dialog
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.error)),
            );
          }
        },
        builder: (context, state) {
          if (state is AddNewSaleLoadingState) {
            return const Center(child: CircularProgressIndicator());
          }

          return SingleChildScrollView(
            child: SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Form(
                  key: _formKey,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment .center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const CustomAppBar(title: "Add New Sale"),
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
            return const CircularProgressIndicator();
          } else if (state is AddNewSaleErrorState) {
            return errorStateWidget("Error occurred", TextStyle(), red);
          } else if (state is AddNewSaleSuccessState) {
             
          }
          return FloatingActionButton.extended(
              backgroundColor: floatingActionButtoncolor,
              foregroundColor: Colors.black,
              onPressed: () async {
                if (_formKey.currentState!.validate()) {
                  String newSaleId =
                      FirebaseFirestore.instance.collection('sales').doc().id;
                  Timestamp currentTime = Timestamp.now();

                  final SalesDetailsModel salesDetailsModel =  await SalesDetailsModel(
                    saleId: newSaleId,
                    customerName: _customerNameController.text,
                    date: _DateandTimeController.text,
                    paymentMethod: _PaymentcontrollerController.text,
                    product: _productNameController.text,
                    quantity: int.parse(_purchasequantityController.text),
                    cash: _PricecontrollerController.text,
                    createdAt: currentTime,
                    Time: _Timecontroller.text,
                  );
          context.read<SalesBloc>().add(OnAddNewSaleButtonClickedEvent(
                        salesDetailsModel: salesDetailsModel,
 
 
 
                      ));
       await  Navigator.push(context, MaterialPageRoute(builder: (context) => MainScreens(initialIndex: 1,),));
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
            );
        },
      ),
    );
  }
}