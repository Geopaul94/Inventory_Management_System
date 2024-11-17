import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inventory_management_system/data/models/customer_details_model.dart';
import 'package:inventory_management_system/presentation/bloc/customers/customers_bloc.dart';
import 'package:inventory_management_system/presentation/screeens/main_screens.dart';
import 'package:inventory_management_system/presentation/widgets/CustomText.dart';
import 'package:inventory_management_system/presentation/widgets/CustomeAppbar.dart';
import 'package:inventory_management_system/presentation/widgets/custome_snackbar.dart';
import 'package:inventory_management_system/presentation/widgets/custometextformfield.dart';
import 'package:inventory_management_system/presentation/widgets/validations.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:inventory_management_system/utilities/constants/constants.dart';

class AddNewCustomer extends StatelessWidget {
  final TextEditingController _customerNameController = TextEditingController();
  final TextEditingController _customerPhoneNumberController =
      TextEditingController();
  final TextEditingController _customerAddressController =
      TextEditingController();
  final _formKey = GlobalKey<FormState>();

  AddNewCustomer({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<CustomersBloc, CustomersState>(
        listener: (context, state) {
          if (state is CustomersAddSuccessState) {
            // Navigate to the next page upon success

            customSnackbar(context, "CustomerData added Successfully", green);
           FocusScope.of(context).unfocus();
      
      // Navigate to the next screen
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => MainScreens(initialIndex: 2)),
      );
          } else if (state is CustomersErrorState) {
            // Show error message if there is an error
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.errorMessage)),
            );
          }
        },
        builder: (context, state) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const CustomAppBar(title: "Add New Customer"),
                  const CustomText(
                    text: "Cusotmer Name",
                    color: black,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                  CustomTextFormField(
                    labelText: "Customer Name",
                    icon: CupertinoIcons.person,
                    controller: _customerNameController,
                    validator: validateUsername,
                  ),
                  const SizedBox(height: 20),
                  const CustomText(
                    text: "Cusotmer Address",
                    color: black,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                  CustomTextFormField(
                    labelText: "Address",
                    icon: CupertinoIcons.home,
                    controller: _customerAddressController,
                    minLines: 4,
                    maxLines: 8,
                    hintText: "e.g. Describe the product in detail",
                    hintTextColor: Colors.grey,
                    validator: validateCustomerAddress,
                  ),
                  h10,
                  const SizedBox(height: 20),
                  const CustomText(
                    text: "Phone Number",
                    color: black,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                  CustomTextFormField(
                    labelText: "Phone Number",
                    icon: CupertinoIcons.phone,
                    controller: _customerPhoneNumberController,
                    validator: validateMobileNumber,
                    keyboardType: TextInputType.number,
                  ),
                ],
              ),
            ),
          );
        },
      ),
      floatingActionButton: BlocBuilder<CustomersBloc, CustomersState>(
        builder: (context, state) {
          if (state is CustomersLoadingState) {
            // Show a circular progress indicator when loading
            return const FloatingActionButton(
              backgroundColor: Colors.grey,
              onPressed: null,
              child: CircularProgressIndicator(color: Colors.white),
            );
          }

          return FloatingActionButton.extended(
            backgroundColor: Colors.blue,
            foregroundColor: Colors.white,
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                // Create the customer model from the form data

                String NewCustomerId = FirebaseFirestore.instance
                    .collection('products')
                    .doc()
                    .id; // Generate a new ID
                Timestamp currentTime =
                    Timestamp.now(); // Get the current timestamp

                final newCustomer = CustomerDetailsModel(
                  customerId: NewCustomerId, // Generate a unique ID
                  customerName: _customerNameController.text,
                  phoneNumber: _customerPhoneNumberController.text,
                  address: _customerAddressController.text,
                  createdAt: currentTime,
                );

                // Trigger the Bloc event to add a new customer
                context.read<CustomersBloc>().add(
                      OnSaveButtonCustomerClikEvent(
                          customerDetailsModel: newCustomer),
                    );

                FocusScope.of(context).unfocus(); // Close the keyboard
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
