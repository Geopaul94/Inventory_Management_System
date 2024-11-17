import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:inventory_management_system/data/models/product_model.dart';
import 'package:inventory_management_system/presentation/screeens/add_products/producteditpage.dart';
import 'package:inventory_management_system/presentation/widgets/CustomText.dart';

import 'package:inventory_management_system/utilities/constants/constants.dart';

class ProductDetailsScreen extends StatelessWidget {
  final Products product;

  const ProductDetailsScreen({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60.0), // Set the height of the AppBar

        child: AppBar(
          title: const Text('My App'), 
          centerTitle: true,
          backgroundColor:  green,// Title of the AppBar

          flexibleSpace: Stack(
            children: [
          

              Positioned(
                right: .02.sw,
                top: .09.sw,
                child: ElevatedButton(
                  onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => Producteditpage(product: product),));
                  },
                  child: Text(
                    'Edit',
                    style: TextStyle(fontSize: .020.sh),
                  ),
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.blue,
                    backgroundColor: Colors.white, 
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Container(
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(
                          Radius.circular(10)), // Correctly use Radius.circular
                    ),
                    height: 350.h,
                    width: 380.w,
                    child: ClipRRect(
                      borderRadius: BorderRadius.all(Radius.circular(20.sp)),
                      child: Image.network(
                        product.imageUrl,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                h10,
                CustomText(
                  text: "Description",
                  fontSize: 24.sp,
                  fontWeight: FontWeight.bold,
                  color: const Color.fromARGB(255, 176, 117, 232),
                ),
                Container(
                  decoration: BoxDecoration(
                    color: const Color(0xFFF3F3F3), // Background color

                    borderRadius: BorderRadius.circular(10), // Rounded corners

                    border: Border.all(color: Colors.grey, width: 1), // Border

                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1), // Shadow color

                        spreadRadius: 2, // Spread radius

                        blurRadius: 5, // Blur radius

                        offset: const Offset(0, 3), // Offset for shadow
                      ),
                    ],
                  ),

                  height: 200.h, // Responsive height

                  width: double.infinity, // Full width

                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: Text(
                      product.description,

                      style: TextStyle(
                        fontSize: 20.sp,
                      ), // Responsive text size
                    ),
                  ),
                ),
                h20,
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Row(
                      children: [
                        CustomText(
                          text: "Price : ",
                          color: const Color.fromARGB(255, 176, 117, 232),
                          fontSize: 25.sp,
                          fontWeight: FontWeight.bold,
                        ),
                        CustomText(
                          text: product.price.round().toString(),

                          color: const Color(0xFF8A2BE2), // Violet color
                          fontSize: 30.sp,
                          fontWeight: FontWeight.bold,
                        ),
                        CustomText(
                          text: " ₹",
                          color: const Color.fromARGB(255, 126, 125, 125),
                          fontSize: 20.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ],
                    ),
                    w20,
                    Row(
                      children: [
                        CustomText(
                          text: "Qty : ",
                          color: const Color.fromARGB(
                              255, 176, 117, 232), // Violet color
                          fontSize: 20.sp,
                          fontWeight: FontWeight.bold,
                        ),
                        CustomText(
                          text: product.quantity.round().toString(),
                          color: const Color(0xFF8A2BE2), // Violet color
                          fontSize: 30.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ],
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
