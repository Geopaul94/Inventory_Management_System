import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:inventory_management_system/data/models/sales_model.dart';

import 'package:inventory_management_system/presentation/bloc/sales_bloc/sales_bloc.dart';
import 'package:inventory_management_system/presentation/screeens/sales_screen/add_sales_page.dart';
import 'package:inventory_management_system/presentation/screeens/sales_screen/purchase_page.dart';
import 'package:inventory_management_system/presentation/screeens/sales_screen/updatesale_page.dart';
import 'package:inventory_management_system/presentation/widgets/CustomText.dart';
import 'package:inventory_management_system/presentation/widgets/shimmer_loading.dart';
import 'package:inventory_management_system/utilities/constants/constants.dart';

class SalesPage extends StatefulWidget {
  const SalesPage({super.key});

  @override
  State<SalesPage> createState() => _SalesPageState();
}

class _SalesPageState extends State<SalesPage> {
  @override
  void initState() {
    super.initState();

    context.read<SalesBloc>().add(FetchAllSalesInitialEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<SalesBloc, SalesState>(
        listener: (context, state) {},
        builder: (context, state) {
          if (state is FetchAllSaleLoadingState) {
            return const Center(child: ShimmerLoading());
          } else if (state is FetchAllSaleSuccessState) {
            final List<SalesDetailsModel> salesDetailsModel =
                state.salesDetailsModel;

            if (salesDetailsModel.isEmpty) {
              return const Center(
                  child: CustomText(text: "No Sales data is available"));
            } else {
              return ListView.builder(
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
                                updatesaledata: salesDetailsModel[index]),
                          ));
                    },
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => PurchasePage(
                                Purchase: salesDetailsModel[itemIndex]),
                          ));
                    },
                    child: SaleProductCard(
                        salesDetailsModel: salesDetailsModel[itemIndex]),
                  );
                },
              );
            }
          } else if (state is FetchAllSaleErrorState) {
            return Center(
                child: CustomText(text: "An error occurred: ${state.error}"));
          } else {
            return const Center(
                child: CustomText(text: "Unexpected error occurred"));
          }
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: floatingActionButtoncolor,
        foregroundColor: white,
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const AddSalesPage(),
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
        padding: const EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CustomText(
                  text: "Prduct Name ",
                  fontSize: 20.sp,
                  color: black,
                ),
                CustomText(
                  text: salesDetailsModel.product,
                  color: black,
                  fontSize: 20.sp,
                ),
              ],
            ),
            const Divider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CustomText(
                  text: "Customer Name",
                  fontSize: 20.sp,
                  color: black,
                ),
                CustomText(
                  text: salesDetailsModel.customerName,
                  fontSize: 20.sp,
                  color: blue,
                ),
              ],
            ),
            const Divider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CustomText(
                  text: "Purchase Date ",
                  fontSize: 20.sp,
                  color: black,
                ),
                CustomText(
                  text: salesDetailsModel.date,
                  fontSize: 16.sp,
                  color: blue,
                ),
              ],
            ),
            const Divider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CustomText(
                  text: "Quantity",
                  fontSize: 20.sp,
                  color: black,
                ),
                CustomText(
                  text: salesDetailsModel.quantity.toString(),
                  fontSize: 20.sp,
                  color: blue,
                ),
              ],
            ),
            const Divider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CustomText(
                  text: "Payment Mode",
                  fontSize: 20.sp,
                  color: black,
                ),
                CustomText(
                  text: salesDetailsModel.paymentMethod,
                  fontSize: 20.sp,
                  color: blue,
                ),
              ],
            ),
            const Divider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CustomText(
                  text: "Price ",
                  fontSize: 20.sp,
                  color: black,
                ),
                CustomText(
                  text: salesDetailsModel.cash,
                  fontSize: 20.sp,
                  color: blue,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
