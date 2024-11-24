import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inventory_management_system/data/models/sales_model.dart';
import 'package:inventory_management_system/presentation/bloc/customers/customers_bloc.dart';
import 'package:inventory_management_system/presentation/screeens/add_products/producteditpage.dart';
import 'package:inventory_management_system/presentation/screeens/sales_screen/purchase_page.dart';
import 'package:inventory_management_system/presentation/screeens/sales_screen/sales_page.dart';
import 'package:inventory_management_system/presentation/screeens/sales_screen/updatesale_page.dart';
import 'package:inventory_management_system/presentation/widgets/CustomText.dart';
import 'package:inventory_management_system/presentation/widgets/CustomeAppbar.dart';
import 'package:inventory_management_system/presentation/widgets/custome_snackbar.dart';
import 'package:inventory_management_system/presentation/widgets/shimmer_loading.dart';
import 'package:inventory_management_system/utilities/constants/constants.dart';

class CustomerDetailsPage extends StatefulWidget {
  final String customerName;
  const CustomerDetailsPage({super.key, required this.customerName});

  @override
  State<CustomerDetailsPage> createState() => _CustomerDetailsPageState();
}

class _CustomerDetailsPageState extends State<CustomerDetailsPage> {
  @override
  void initState() {
    super.initState();
    context.read<CustomersBloc>().add(
        OnFetchSaledDetailsCusomerEvent(customerName: widget.customerName));
  } // Added missing closing bracket for initState

 
  @override
Widget build(BuildContext context) {
  return Scaffold(appBar: CustomAppBar(title: 'Purchase History${widget.customerName}'),
    body: BlocConsumer<CustomersBloc, CustomersState>(
      listener: (context, state) {
        if (state is FetchAllSaledDetailsCustomerErrorState) {
          customSnackbar(context, state.error, red);
        }
      },
      builder: (context, state) {
        if (state is FetchAllSaledDetailsCustomerLoadingState) {
          return const Center(child: ShimmerLoading());
        } else if (state is FetchAllSaledDetailsCustomerInitialState) {
          final List<SalesDetailsModel> salesDetailsModel =
              state.customersalesreport;
    
          if (salesDetailsModel.isEmpty) {
            return const Center(
                child: CustomText(text: "No Sales data is available"));
          } else {
            return ListView.builder(
              shrinkWrap: true,
              // physics: NeverScrollableScrollPhysics(), // Add this if you want to disable scrolling
              itemCount: salesDetailsModel.length * 2 - 1,
              itemBuilder: (context, index) {
                if (index.isOdd) {
                  return const Divider();
                }
    
                final itemIndex = index ~/ 2;
                
                return GestureDetector(
                  onDoubleTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => UpdatesalePage(
                          updatesaledata: salesDetailsModel[itemIndex],
                        ),
                      ),
                    );
                  },
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => PurchasePage(
                          Purchase: salesDetailsModel[itemIndex],
                        ),
                      ),
                    );
                  },
                  child: SaleProductCard(
                    salesDetailsModel: salesDetailsModel[itemIndex],
                  ),
                );
              },
            );
          }
        }
        return const Center(child: CustomText(text: "Something went wrong"));
      },
    ),
  );
}}