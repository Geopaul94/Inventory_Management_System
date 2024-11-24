import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:inventory_management_system/data/models/customer_details_model.dart';
import 'package:inventory_management_system/presentation/bloc/customers/customers_bloc.dart';
import 'package:inventory_management_system/presentation/bloc/searchuser/searchuser_bloc.dart';
import 'package:inventory_management_system/presentation/bloc/searchuser/searchuser_event.dart';
import 'package:inventory_management_system/presentation/screeens/addcustomer/add_customer.dart';
import 'package:inventory_management_system/presentation/screeens/addcustomer/customer_details_page.dart';
import 'package:inventory_management_system/presentation/screeens/addcustomer/customer_update_page.dart';
import 'package:inventory_management_system/presentation/screeens/main_screens.dart';
import 'package:inventory_management_system/presentation/widgets/CustomElevatedButton.dart';
import 'package:inventory_management_system/presentation/widgets/CustomText.dart';

import 'package:inventory_management_system/presentation/widgets/CustomeAppbar.dart';
import 'package:inventory_management_system/presentation/widgets/shimmer_loading.dart';
import 'package:inventory_management_system/utilities/constants/constants.dart';

class CustomersPage extends StatefulWidget {
  const CustomersPage({super.key});

  @override
  State<CustomersPage> createState() => _CustomersPageState();
}

class _CustomersPageState extends State<CustomersPage> {
  final TextEditingController _searchController = TextEditingController();
  List<CustomerDetailsModel> _filteredCustomers =
      []; // To hold filtered customer list

  @override
  void initState() {
    super.initState();
    // Fetch all customers when the page loads
    context.read<CustomersBloc>().add(const FetchAllCustomersEvent());

    // Listen for changes in the search field
    _searchController.addListener(() {
      // Trigger filtering based on input
    });
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
                  Text(state.Error),
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

            // Filter customers based on the search input
            _filteredCustomers = state.customerDetails.where((customer) {
              return customer.customerName
                  .toLowerCase()
                  .contains(_searchController.text.toLowerCase());
            }).toList();

            // If customers are loaded, display them in a list
            return Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: TextField(
                    controller: _searchController,
                    decoration: InputDecoration(
                      labelText: 'Search Customer',
                      border: OutlineInputBorder(),
                      suffixIcon: IconButton(
                        icon: Icon(Icons.clear),
                        onPressed: () {
                          _searchController.clear(); // Clear search input
                        },
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: _filteredCustomers.length,
                    itemBuilder: (context, index) {
                      final customer = _filteredCustomers[index];
                      return GestureDetector(
                        onTap: () {
                          CustomerPageBottomSheet(
                            updatedata: customer,
                            customerId: customer.customerId,
                            context: context,
                            builder: (context) {
                              return Container(
                                padding: const EdgeInsets.all(16.0),
                              );
                            },
                          );
                        },
                        child: CustomerCard(customer: customer),
                      );
                    },
                  ),
                ),
              ],
            );
          }

          // Default view
          return const Center(child: Text("No Customers "));
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: floatingActionButtoncolor,
        foregroundColor: white,
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

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }
}

class CustomerCard extends StatelessWidget {
  final CustomerDetailsModel customer;

  const CustomerCard({super.key, required this.customer});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: .01.sh,
                    ),
                    CustomText(
                      text: customer.customerName,
                      fontSize: 24,
                      fontStyle: FontStyle.italic,
                      fontWeight: FontWeight.bold,
                      color: black,
                    ),
                    SizedBox(
                      height: .01.sh,
                    ),
                    CustomText(
                      text: customer.email,
                      fontSize: 18,
                      fontStyle: FontStyle.italic,
                      fontWeight: FontWeight.normal,
                      color: black,
                    ),
                    SizedBox(
                      height: .01.sh,
                    ),
                    CustomText(
                      text: customer.phoneNumber,
                      fontSize: 18,
                      fontStyle: FontStyle.italic,
                      fontWeight: FontWeight.bold,
                      color: black,
                    ),
                    h10,
                    CustomText(
                      text: customer.address,
                      fontSize: 16,
                      fontStyle: FontStyle.italic,
                      fontWeight: FontWeight.bold,
                      color: black,
                    ),
                    SizedBox(
                      height: .01.sh,
                    ),
                    h10,
                    SizedBox(
                      height: .01.sh,
                    ),
                  ],
                ),
                const Spacer(),
                Column(
                  children: [
                    const CircleAvatar(
                      radius: 50,
                      backgroundColor: blue,
                      child: CircleAvatar(
                        radius: 49,
                        backgroundColor: Colors.white,
                        child: Icon(CupertinoIcons.person,
                            size: 50, color: Colors.black),
                      ),
                    ),
                    SizedBox(
                      height: .01.sh,
                    ),
                    CustomElevatedButton(
                        text: 'Purchase Details',
                        paddingHorizontal: 0,
                        paddingVertical: 0,
                        fontSize: 11.sp,
                        height: 0.05.sh,
                        width: 0.25.sw,
                        color: blue,
                        onPressed: () async {
                          await Navigator.push(context, MaterialPageRoute(
                            builder: (context) {
                              return CustomerDetailsPage(
                                customerName: customer.customerName,
                              );
                            },
                          ));
                        })
                  ],
                ),
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
    required Container Function(dynamic context) builder,
    required String customerId,
    required CustomerDetailsModel updatedata}) {
  showModalBottomSheet(
    context: context,
    backgroundColor: const Color.fromARGB(255, 114, 109, 109),
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
                          BlocBuilder<CustomersBloc, CustomersState>(
                            builder: (context, state) {
                              if (state is CustomersDeleteLoadingState) {
                                return const TextButton(
                                  onPressed:
                                      null, // Disable button while loading

                                  child: Text('Deleting...'),
                                );
                              }

                              return TextButton(
                                onPressed: () async {
                                  // Trigger the delete event

                                  context.read<CustomersBloc>().add(
                                        OnDeleteCustomerButtonClikEvent(
                                            customerId: customerId),
                                      );

                                  Navigator.pushReplacement(context,
                                      MaterialPageRoute(
                                    builder: (context) {
                                      return const MainScreens(
                                        initialIndex: 2,
                                      );
                                    },
                                  )); // Close the dialog
                                },
                                child: const Text('Delete'),
                              );
                            },
                          ),
                        ],
                      );
                    },
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(14.0),
              child: CustomElevatedButton(
                text: "Edit",
                height: .07.sh,
                width: .30.sw,
                fontSize: 22.sp,
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(
                    builder: (context) {
                      return CustomerUpdatePage(
                        updatedata: updatedata,
                      );
                    },
                  ));
                },
              ),
            ),
          ],
        ),
      );
    },
  );
}
