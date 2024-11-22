import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:inventory_management_system/data/models/customer_details_model.dart';
import 'package:inventory_management_system/presentation/bloc/customers/customers_bloc.dart';
import 'package:inventory_management_system/presentation/screeens/main_screens.dart';
import 'package:inventory_management_system/presentation/widgets/CustomText.dart';
import 'package:inventory_management_system/presentation/widgets/CustomeAppbar.dart';
import 'package:inventory_management_system/presentation/widgets/custome_snackbar.dart';
import 'package:inventory_management_system/presentation/widgets/custometextformfield.dart';

import 'package:inventory_management_system/presentation/widgets/validations.dart';
import 'package:inventory_management_system/utilities/constants/constants.dart';

class CustomerUpdatePage extends StatelessWidget {
  final CustomerDetailsModel updatedata;
  final TextEditingController _customerNameController = TextEditingController();
  final TextEditingController _customerPhoneNumberController =
      TextEditingController();
  final TextEditingController _customerEmailcontroller =
      TextEditingController();
  final TextEditingController _customerAddressController =
      TextEditingController();
  final _formKey = GlobalKey<FormState>();

  CustomerUpdatePage({super.key, required this.updatedata});

  @override
  Widget build(BuildContext context) {
    _customerNameController.text = updatedata.customerName;

    _customerAddressController.text = updatedata.address;

    _customerPhoneNumberController.text = updatedata.phoneNumber.toString();

    _customerEmailcontroller.text = updatedata.email;

    return Scaffold(
      appBar: const CustomAppBar(title: "Updare Customer data"),
      body: BlocConsumer<CustomersBloc, CustomersState>(
        listener: (context, state) {
          if (state is CustomersUpdateSuccessState) {
            // Navigate to the next page upon success

            customSnackbar(context, "CustomerData Updated Successfully", green);
            FocusScope.of(context).unfocus();

            // Navigate to the next screen
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (context) => const MainScreens(initialIndex: 2)),
            );
          } else if (state is CustomersDeleteErrorState) {
            // Show error message if there is an error
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.error)),
            );
          }
        },
        builder: (context, state) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const CustomText(
                    text: "Customer Name",
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
                  const CustomText(
                    text: "Customer Email",
                    color: black,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                  CustomTextFormField(
                    labelText: "Customer Email",
                    icon: CupertinoIcons.mail_solid,
                    controller: _customerEmailcontroller,
                    validator: validateEmail,
                  ),
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
                ],
              ),
            ),
          );
        },
      ),
      floatingActionButton: BlocBuilder<CustomersBloc, CustomersState>(
        builder: (context, state) {
          if (state is CustomersLoadingUpdateState) {
            return Padding(
              padding:
                  EdgeInsets.symmetric(vertical: .090.sh, horizontal: .01.sw),
              child: const FloatingActionButton(
                backgroundColor: Colors.grey,
                onPressed: null,
                child: CircularProgressIndicator(color: Colors.white),
              ),
            );
          }

          return Padding(
            padding:
                EdgeInsets.symmetric(vertical: .090.sh, horizontal: .01.sw),
            child: FloatingActionButton.extended(
              backgroundColor: Colors.blue,
              foregroundColor: Colors.white,
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  // Create the customer model from the form data

                  String ustomerId = updatedata.customerId;
                  Timestamp currentTime =
                      Timestamp.now(); // Get the current timestamp

                  final newCustomer = CustomerDetailsModel(
                    customerId: ustomerId, // Generate a unique ID
                    customerName: _customerNameController.text,
                    phoneNumber: _customerPhoneNumberController.text,
                    address: _customerAddressController.text,
                    createdAt: currentTime,
                    email: _customerEmailcontroller.text,
                  );

                  // Trigger the Bloc event to add a new customer
                  context.read<CustomersBloc>().add(
                        OnUpdateCustomerButtonClikEvent(
                            customerDetailsModel: newCustomer),
                      );

                  FocusScope.of(context).unfocus(); // Close the keyboard
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
