import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:inventory_management_system/data/models/sales_model.dart';
import 'package:inventory_management_system/presentation/bloc/sales_bloc/sales_bloc.dart';
import 'package:inventory_management_system/presentation/screeens/main_screens.dart';
import 'package:inventory_management_system/presentation/screeens/sales_screen/categoryfield.dart';
import 'package:inventory_management_system/presentation/screeens/sales_screen/product_payment_textform.dart';
import 'package:inventory_management_system/presentation/widgets/CustomElevatedButton.dart';
import 'package:inventory_management_system/presentation/widgets/CustomText.dart';
import 'package:inventory_management_system/presentation/widgets/CustomeAppbar.dart';
import 'package:inventory_management_system/presentation/widgets/custome_snackbar.dart';
import 'package:inventory_management_system/presentation/widgets/custometextformfield.dart';
import 'package:inventory_management_system/presentation/widgets/errorstate_widget.dart';
import 'package:inventory_management_system/presentation/widgets/validations.dart';
import 'package:inventory_management_system/utilities/constants/constants.dart';
import 'package:inventory_management_system/utilities/functions/date_picker.dart';

// class UpdatesalePage extends StatefulWidget {
//   final SalesDetailsModel updatesaledata;
//   UpdatesalePage({super.key, required this.updatesaledata});

//   @override
//   State<UpdatesalePage> createState() => _UpdatesalePageState();
// }

// class _UpdatesalePageState extends State<UpdatesalePage> {
//   final List<String> _paymentMethods = [
//     'Card',
//     'Bank Transfer',
//     'UPI',
//     'Cash',
//   ];

//   final TextEditingController _productcategoryController =
//       TextEditingController();

//   final TextEditingController _productNameController = TextEditingController();

//   TextEditingController _purchasequantityController = TextEditingController();

//   final TextEditingController _customerNameController = TextEditingController();

//   final TextEditingController _Timecontroller = TextEditingController();

//   final TextEditingController _DateandTimeController = TextEditingController();

//   final TextEditingController _PaymentcontrollerController =
//       TextEditingController();

//   final TextEditingController _PricecontrollerController =
//       TextEditingController();

//   final _formKey = GlobalKey<FormState>();

//   @override
//   Widget build(BuildContext context) {
//     _productcategoryController.text =
//         widget.updatesaledata.productCategory.toString();

//     _productNameController.text = widget.updatesaledata.customerName.toString();
// // _purchasequantityController =widget.updatesaledata.quantity.toString();
//     ();

//     _customerNameController.text =
//         widget.updatesaledata.productCategory.toString();

//     _Timecontroller.text = widget.updatesaledata.productCategory.toString();

//     _DateandTimeController.text =
//         widget.updatesaledata.productCategory.toString();

//     _PaymentcontrollerController.text =
//         widget.updatesaledata.productCategory.toString();

//     return BlocConsumer<SalesBloc, SalesState>(
//         listener: (context, state) {
//           if (state is UpdateSaleLoadingState) {
//             Navigator.push(
//               context,
//               MaterialPageRoute(
//                 builder: (context) => MainScreens(
//                   initialIndex: 1,
//                 ),
//               ),
//             );

//             customSnackbar(context, 'Sale added successfully', green);
//           } else if (state is UpdateSaleErrorState) {
//             Navigator.pop(context);
//             ScaffoldMessenger.of(context).showSnackBar(
//               SnackBar(content: Text(state.error)),
//             );
//           }
//         },
//         builder: (context, state) {
//           return SafeArea(
//             child: Form(
//               key: _formKey,
//               autovalidateMode: AutovalidateMode.onUserInteraction,
//               child: SingleChildScrollView(
//                 child: Padding(
//                   padding: EdgeInsets.symmetric(horizontal: .03.sw),
//                   child: Column(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       h30,
//                       const CustomText(
//                         text: "Product",
//                         color: black,
//                         fontSize: 16,
//                         fontWeight: FontWeight.w600,
//                       ),
//                       CustomTextFormField(
//                         labelText: "Product",
//                         icon: CupertinoIcons.shopping_cart,
//                         controller: _productNameController,
//                         validator: validateProductName,
//                       ),
//                       const SizedBox(height: 15),
//                       const CustomText(
//                         text: "Customer Name",
//                         color: black,
//                         fontSize: 16,
//                         fontWeight: FontWeight.w600,
//                       ),
//                       CustomTextFormField(
//                         labelText: "Customer Name",
//                         icon: CupertinoIcons.person_2,
//                         controller: _customerNameController,
//                         validator: validateProductName,
//                       ),
//                       const SizedBox(height: 15),
//                       const CustomText(
//                         text: "Product Category",
//                         color: black,
//                         fontSize: 16,
//                         fontWeight: FontWeight.w600,
//                       ),
//                       CategoryListfield(
//                         controller: _productcategoryController,
//                       ),
//                       const SizedBox(height: 10),
//                       const CustomText(
//                         text: "Date and Time",
//                         color: black,
//                         fontSize: 16,
//                         fontWeight: FontWeight.w600,
//                       ),
//                       CustomTextFormField(
//                         labelText: "Purchase Date and Time",
//                         icon: CupertinoIcons.calendar,
//                         controller: _DateandTimeController,
//                         validator: validateDate,
//                         readOnly: true,
//                         onTap: () async {
//                           DateTimeResult? selectedDateTime =
//                               await selectDateTime(context);
//                           if (selectedDateTime != null) {
//                             setState(() {
//                               _DateandTimeController.text =
//                                   selectedDateTime.formattedDate.toString();
//                               _Timecontroller.text =
//                                   selectedDateTime.formattedTime.toString();
//                             });
//                           }
//                         },
//                       ),
//                       const SizedBox(height: 15),
//                       const CustomText(
//                         text: "Payment Method",
//                         color: black,
//                         fontSize: 16,
//                         fontWeight: FontWeight.w600,
//                       ),
//                       PaymentMethodSelectionField(
//                         controller: _PaymentcontrollerController,
//                         paymentMethods: _paymentMethods,
//                       ),
//                       const SizedBox(height: 10),
//                       const CustomText(
//                         text: "Quantity",
//                         color: black,
//                         fontSize: 16,
//                         fontWeight: FontWeight.w600,
//                       ),
//                       CustomTextFormField(
//                         labelText: "Number of product",
//                         icon: CupertinoIcons.list_number,
//                         controller: _purchasequantityController,
//                         validator: validateProductQuantity,
//                         keyboardType: TextInputType.number,
//                       ),
//                       const CustomText(
//                         text: "Price",
//                         color: black,
//                         fontSize: 16,
//                         fontWeight: FontWeight.w600,
//                       ),
//                       CustomTextFormField(
//                         labelText: "Price of the product",
//                         icon: CupertinoIcons.money_dollar,
//                         controller: _PricecontrollerController,
//                         validator: validateProductPrice,
//                         keyboardType: TextInputType.number,
//                       ),
//                       BlocBuilder<SalesBloc, SalesState>(
//                         builder: (context, state) {

//                           if (state is UpdateSaleLoadingState) {



//                             return CircularProgressIndicator();
//                           }
//                           else
//                           return CustomElevatedButton(text: "Update", onPressed: ()
//                                               async {
//                                       if (_formKey.currentState!.validate()) {
//                                         String updatedata = widget.updatesaledata.saleId;
                      
//                                         Timestamp currentTime = Timestamp.now();
                      
//                                         SalesDetailsModel salesDetailsModel = SalesDetailsModel(
//                                           saleId: updatedata,
//                                           customerName: _customerNameController.text,
//                                           date: _DateandTimeController.text,
//                                           paymentMethod: _PaymentcontrollerController.text,
//                                           product: _productNameController.text,
//                                           quantity: int.parse(_purchasequantityController.text),
//                                           cash: _PricecontrollerController.text,
//                                           createdAt: currentTime,
//                                           Time: _Timecontroller.text,
//                                           productCategory: _productcategoryController.text,
//                                         );
//                                         context.read<SalesBloc>().add(OnUpdateButtonClickedSaleEvent(
//                                               salesDetailsModel: salesDetailsModel,
//                                             ));
                      
//                                         _formKey.currentState!.reset();
//                                         FocusScope.of(context).unfocus();
//                                       } else {
//                                         ScaffoldMessenger.of(context).showSnackBar(
//                                           const SnackBar(
//                                               content: Text('Please fix the errors in the form')),
//                                         );
//                                       }
//                                     },
//                                             });
//                         },
//                       )
//                     ],
//                   ),
//                 ),
//               ),
//             ),
//           );
//         },
//       ),



//       floatingActionButton: BlocBuilder<SalesBloc, SalesState>(
//         builder: (context, state) {
//           if (state is UpdateSaleLoadingState) {
//             return Padding(
//               padding:
//                   EdgeInsets.symmetric(vertical: .090.sh, horizontal: .01.sw),
//               child: const FloatingActionButton(
//                 backgroundColor: Colors.blue,
//                 onPressed: null,
//                 child: CircularProgressIndicator(color: Colors.white),
//               ),
//             );
//           } else if (state is UpdateSaleErrorState) {
//             return errorStateWidget("Error occurred", TextStyle(), red);
//           }
//           return Padding(
//             padding: EdgeInsets.symmetric(vertical: .02.sh, horizontal: .01.sw),
//             child: FloatingActionButton.extended(
//               backgroundColor: floatingActionButtoncolor,
//               foregroundColor: white,
//               onPressed: () async {
//                 if (_formKey.currentState!.validate()) {
//                   String updatedata = widget.updatesaledata.saleId;

//                   Timestamp currentTime = Timestamp.now();

//                   SalesDetailsModel salesDetailsModel = SalesDetailsModel(
//                     saleId: updatedata,
//                     customerName: _customerNameController.text,
//                     date: _DateandTimeController.text,
//                     paymentMethod: _PaymentcontrollerController.text,
//                     product: _productNameController.text,
//                     quantity: int.parse(_purchasequantityController.text),
//                     cash: _PricecontrollerController.text,
//                     createdAt: currentTime,
//                     Time: _Timecontroller.text,
//                     productCategory: _productcategoryController.text,
//                   );
//                   context.read<SalesBloc>().add(OnUpdateButtonClickedSaleEvent(
//                         salesDetailsModel: salesDetailsModel,
//                       ));

//                   _formKey.currentState!.reset();
//                   FocusScope.of(context).unfocus();
//                 } else {
//                   ScaffoldMessenger.of(context).showSnackBar(
//                     const SnackBar(
//                         content: Text('Please fix the errors in the form')),
//                   );
//                 }
//               },
//               icon: const Icon(Icons.add),
//               label: const Text('Update'),
//             ),
//           );
//         },
//       ),
//     );
//   }
// }


class UpdatesalePage extends StatefulWidget {
  final SalesDetailsModel updatesaledata;

  UpdatesalePage({super.key, required this.updatesaledata});

  @override
  State<UpdatesalePage> createState() => _UpdatesalePageState();
}

class _UpdatesalePageState extends State<UpdatesalePage> {
  final List<String> _paymentMethods = ['Card', 'Bank Transfer', 'UPI', 'Cash'];

  final TextEditingController _productcategoryController = TextEditingController();
  final TextEditingController _productNameController = TextEditingController();
  final TextEditingController _purchasequantityController = TextEditingController();
  final TextEditingController _customerNameController = TextEditingController();
  final TextEditingController _Timecontroller = TextEditingController();
  final TextEditingController _DateandTimeController = TextEditingController();
  final TextEditingController _PaymentcontrollerController = TextEditingController();
  final TextEditingController _PricecontrollerController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    // Initialize controllers with the sale data
    _productcategoryController.text = widget.updatesaledata.productCategory;
    _productNameController.text = widget.updatesaledata.product;
    _purchasequantityController.text = widget.updatesaledata.quantity.toString();
    _customerNameController.text = widget.updatesaledata.customerName;
    _Timecontroller.text = widget.updatesaledata.Time;
    _DateandTimeController.text = widget.updatesaledata.date;
    _PaymentcontrollerController.text = widget.updatesaledata.paymentMethod;
    _PricecontrollerController.text = widget.updatesaledata.cash;
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SalesBloc, SalesState>(
      listener: (context, state) {
        if (state is UpdateSaleSuccessState) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => MainScreens(
                initialIndex: 1,
              ),
            ),
          );
          customSnackbar(context, 'Sale updated successfully', green);
        } else if (state is UpdateSaleErrorState) {
          Navigator.pop(context);
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(state.error)));
        }
      },
      builder: (context, state) {
        return SafeArea(
          child: SingleChildScrollView(
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
                      CategoryListfield(controller: _productcategoryController),
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
                          DateTimeResult? selectedDateTime = await selectDateTime(context);
                          if (selectedDateTime != null) {
                            setState(() {
                              _DateandTimeController.text = selectedDateTime.formattedDate;
                              _Timecontroller.text = selectedDateTime.formattedTime;
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
                      state is UpdateSaleLoadingState
                          ? Center(child: CircularProgressIndicator())
                          : CustomElevatedButton(
                              text: "Update",
                              onPressed: () async {
                                if (_formKey.currentState!.validate()) {
                                  // Prepare sales data
                                  String updatedata = widget.updatesaledata.saleId;
                                  Timestamp currentTime = Timestamp.now();
                                  SalesDetailsModel salesDetailsModel = SalesDetailsModel(
                                    saleId: updatedata,
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
            
                                  // Trigger the update event
                                  context.read<SalesBloc>().add(OnUpdateButtonClickedSaleEvent(
                                        salesDetailsModel: salesDetailsModel,
                                      ));
            
                                  // Reset form after successful submission
                                  _formKey.currentState!.reset();
                                  FocusScope.of(context).unfocus();
                                } else {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(content: Text('Please fix the errors in the form')),
                                  );
                                }
                              },
                            ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
