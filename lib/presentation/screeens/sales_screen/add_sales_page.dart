import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:inventory_management_system/data/models/customer_details_model.dart';
import 'package:inventory_management_system/presentation/widgets/CustomeAppbar.dart';
import 'package:inventory_management_system/presentation/widgets/custom_text.dart';
import 'package:inventory_management_system/presentation/widgets/custometextformfield.dart';
import 'package:inventory_management_system/presentation/widgets/validations.dart';
import 'package:inventory_management_system/utilities/constants/constants.dart';

class AddSalesPage extends StatelessWidget {
  final TextEditingController _productNameController = TextEditingController();
  final TextEditingController _purchasequantityController =
      TextEditingController();
  final TextEditingController _customerNameController = TextEditingController();

  final TextEditingController _DateandTimeController = TextEditingController();
  final TextEditingController _PaymentcontrollerController =
      TextEditingController();

  final TextEditingController _PricecontrollerController =
      TextEditingController();

  final _formKey = GlobalKey<FormState>();

  AddSalesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
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
              h15,
              const CustomText(
                text: "Cusotmer Name",
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
              h15,
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
                keyboardType: TextInputType.number,
              ),
              h15,
              const CustomText(
                text: "paymentmethod",
                color: black,
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
              CustomTextFormField(
                labelText: "Payment Method",
                icon: CupertinoIcons.qrcode_viewfinder,
                controller: _PaymentcontrollerController,
                validator: validateProductName,
              ),
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
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: floatingActionButtoncolor, // Use your defined color
        foregroundColor: Colors.white,
        onPressed: () {
          if (_formKey.currentState!.validate()) {
            // Create the customer model from the form data

            // Show a progress indicator while saving
            showDialog(
              context: context,
              barrierDismissible:
                  false, // Disable user interaction while saving
              builder: (BuildContext context) {
                return const Center(child: CircularProgressIndicator());
              },
            );

            // Save the customer data using your BLoC or provider
            // context.read<CustomersBloc>().add(AddCustomerEvent(customer: customer));

            // Close the progress dialog on successful save (implement in BLoC)
            // ...

            // Optionally, clear the form after successful save
            _formKey.currentState!.reset();
            FocusScope.of(context).unfocus(); // Close the keyboard
          } else {
            // Show an error message if validation fails
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Please fix the errors in the form'),
              ),
            );
          }
        },
        icon: const Icon(Icons.add),
        label: const Text('Save'),
      ),
    );
  }
}
