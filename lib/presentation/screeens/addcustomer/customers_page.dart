import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:inventory_management_system/data/models/catergorey/category_model.dart';
import 'package:inventory_management_system/data/models/customer_details_model.dart';
import 'package:inventory_management_system/main.dart';
import 'package:inventory_management_system/presentation/bloc/customers/customers_bloc.dart';
import 'package:inventory_management_system/presentation/screeens/addcustomer/add_customer.dart';
import 'package:inventory_management_system/presentation/widgets/CustomElevatedButton.dart';
import 'package:inventory_management_system/presentation/widgets/CustomText.dart';

import 'package:inventory_management_system/presentation/widgets/CustomeAppbar.dart';
import 'package:inventory_management_system/presentation/widgets/custome_snackbar.dart';
import 'package:inventory_management_system/presentation/widgets/shimmer_loading.dart';
import 'package:inventory_management_system/utilities/constants/constants.dart';

class CustomersPage extends StatefulWidget {
  @override
  State<CustomersPage> createState() => _CustomersPageState();
}

class _CustomersPageState extends State<CustomersPage> {
  @override
  void initState() {
    super.initState();
    // Fetch all customers when the page loads
    context.read<CustomersBloc>().add(const FetchAllCustomersEvent());

  











}
  @override
  Widget build(BuildContext context) {





    return Scaffold(
      appBar: const CustomAppBar(title: "Customers"),
      body: BlocConsumer<CustomersBloc, CustomersState>(
        listener: (context, state) {
          if (state is CustomersAddSuccessState) {}
        },
        builder: (context, state) {
          if (state is FetchCustomersLoadingState) {
            return const Center(child: ShimmerLoading());
          } else if (state is FetchCustomersErrorState) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(state.Error), // Display error message
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () {
                      context
                          .read<CustomersBloc>()
                          .add(const FetchAllCustomersEvent());
                    },
                    child: const Text('Retry'),
                  ),
                ],
              ),
            );
          } else if (state is FetchCustomersInitialState) {
            if (state.customerDetails.isEmpty) {
              return const Center(child: Text("No Customers Available"));
            }
            // If customers are loaded, display them in a list
            return ListView.builder(
              itemCount: state.customerDetails.length,
              itemBuilder: (context, index) {
                final customer = state.customerDetails[index];
                return GestureDetector(
                  onTap: () {
                    CustomerPageBottomSheet(
                      context: context,
                      builder: (context) {
                        return Container(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              ElevatedButton(
                                onPressed: () {
                                  // Delete the customer
                                  // Implement your deletion logic here, e.g., using a provider or BLoC to update the state
                                  if (kDebugMode) {
                                    print(
                                        'Deleting customer ${customer.customerId}');
                                  }
                                },
                                child: const Text('Delete'),
                              ),
                              ElevatedButton(
                                onPressed: () {
                                  // Navigate to the edit page, passing the customer data
                                  // Navigator.push(
                                  //   context,
                                  //   MaterialPageRoute(
                                  //     builder: (context) => EditCustomerPage(customer: customer),
                                  //   ),
                                  // );
                                },
                                child: const Text('Edit'),
                              ),
                            ],
                          ),
                        );
                      },
                    );
                  },
                  child: CustomerCard(customer: customer),
                );
              },
            );
          }

          // Default view
          return const Center(child: Text("No Customers "));
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: floatingActionButtoncolor,
        foregroundColor: black,
        onPressed: () async {
          await Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => AddNewCustomer()),
          );
        },
        icon: const Icon(Icons.add),
        label: const Text('Add Customer'),
      ),
    );
  }
}

class CustomerCard extends StatelessWidget {
  final CustomerDetailsModel customer;

  const CustomerCard({Key? key, required this.customer}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    h10,
                    CustomText(
                      text: customer.customerName,
                      fontSize: 24,
                      fontStyle: FontStyle.italic,
                      fontWeight: FontWeight.bold,
                      color: black,
                    ),
                    const SizedBox(height: 8),
                    h10,
                    CustomText(
                      text: customer.address,
                      fontSize: 20,
                      fontStyle: FontStyle.italic,
                      fontWeight: FontWeight.bold,
                      color: black,
                    ),
                    const SizedBox(height: 8),
                    h10,
                    CustomText(
                      text: customer.phoneNumber,
                      fontSize: 24,
                      fontStyle: FontStyle.italic,
                      fontWeight: FontWeight.bold,
                      color: black,
                    ),
                    const SizedBox(height: 8),
                  ],
                ),
                const Spacer(),
                const CircleAvatar(
                  radius: 50,
                  backgroundColor: Colors.green,
                  child: CircleAvatar(
                    radius: 48,
                    backgroundColor: Colors.white,
                    child: Icon(CupertinoIcons.person, color: Colors.black),
                  ),
                ),
                const SizedBox(height: 16),
              ],
            ),
          ],
        ),
      ),
    );
  }
}




void CustomerPageBottomSheet(
    {required BuildContext context,
    required Container Function(dynamic context) builder}) {
  showModalBottomSheet(
    context: context,
    backgroundColor: Colors.grey[700],
    builder: (BuildContext context) {
      return Padding(
        padding: const EdgeInsets.all(2.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Padding(
              padding: const EdgeInsets.all(14.0),
              child: CustomElevatedButton(
                  height: .07.sh,
                  width: .30.sw,
                  fontSize: 22.sp,
                  color: red,
                  text: "Delete",
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: const Text('Confirm Deletion'),
                          content: const Text(
                              'Are you sure you want to delete the customer data?'),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.pop(context); // Close the dialog
                              },
                              child: const Text('Cancel'),
                            ),
                            TextButton(
                              onPressed: () {
                                // Delete the customer data here
                                print('Deleting customer data...');
                                Navigator.pop(context); // Close the dialog
                                Navigator.pop(
                                    context); // Close the bottom sheet
                              },
                              child: const Text('Delete'),
                            ),
                          ],
                        );
                      },
                    );
                  }),
            ),
            //   Spacer(),

            Padding(
              padding: const EdgeInsets.all(14.0),
              child: CustomElevatedButton(
                  text: "Edit",
                  height: .07.sh,
                  width: .30.sw,
                  fontSize: 22.sp,
                  onPressed: () {}),
            ),
          ],
        ),
      );
    },
  );
}
