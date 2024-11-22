import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inventory_management_system/data/models/product_model.dart';
import 'package:inventory_management_system/presentation/bloc/add_product/addproduct_bloc.dart';
import 'package:inventory_management_system/presentation/bloc/add_product/addproduct_event.dart';
import 'package:inventory_management_system/presentation/bloc/fetchproductlist/fetchproductlist_bloc.dart';
import 'package:inventory_management_system/presentation/screeens/add_products/addpost_page/addphoto.dart';
import 'package:inventory_management_system/presentation/screeens/main_screens.dart';
import 'package:inventory_management_system/presentation/widgets/CustomElevatedButton.dart';
import 'package:inventory_management_system/presentation/widgets/CustomText.dart';
import 'package:inventory_management_system/presentation/widgets/CustomeAppbar.dart';
import 'package:inventory_management_system/presentation/widgets/custometextformfield.dart';
import 'package:inventory_management_system/presentation/widgets/validations.dart';
import 'package:inventory_management_system/utilities/constants/constants.dart';

class AddProducts extends StatelessWidget {
  final String productCategory;
  AddProducts({super.key, required this.productCategory});
  final TextEditingController _productcategory_controller =
      TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _productnameController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _quantityController = TextEditingController();

  File? croppedImage; // Change type to File for easier handling

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => AddProductBloc(),
      child: Scaffold(
        appBar: const CustomAppBar(
          title: "Add Product Details",
          backgroundColor: lightgrey,
          leadingIcon: Icons.arrow_back,
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AddPhotoContainer(onImageSelected: (image) {
                      croppedImage = image; // Store the selected/cropped image
                    }),
                    const CustomText(
                      text: "Name",
                      color: black,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                    CustomTextFormField(
                      labelText: "Product Name",
                      icon: CupertinoIcons.add_circled,
                      controller: _productnameController,
                      hintText: "e.g. Mobile, Headset",
                      validator: validateProductName,
                    ),
                    h10,
                    const CustomText(
                      text: "Description",
                      color: black,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                    CustomTextFormField(
                      labelText: "Description",
                      icon: CupertinoIcons.add_circled,
                      controller: _descriptionController,
                      minLines: 4,
                      maxLines: 8,
                      hintText: "e.g. Describe the product in detail",
                      hintTextColor: Colors.grey,
                      validator: validateProductDescription,
                    ),
                    h10,
                    Row(children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const CustomText(
                              text: "Price",
                              color: black,
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                            CustomTextFormField(
                              labelText: "Price",
                              icon: CupertinoIcons.add_circled,
                              controller: _priceController,
                              keyboardType: TextInputType.number,
                              hintText: "e.g. 2000",
                              validator: validateProductPrice,
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const CustomText(
                              text: "Quantity",
                              color: black,
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                            CustomTextFormField(
                              labelText: "Quantity",
                              icon: CupertinoIcons.add_circled,
                              controller: _quantityController,
                              keyboardType: TextInputType.number,
                              hintText: "e.g.12",
                              hintTextColor: black,
                              validator: validateProductQuantity,
                            ),
                          ],
                        ),
                      ),
                    ]),
                    h20,
                    Center(
                      child: CustomElevatedButton(
                          text: "Add Product",
                          onPressed: () async {
                            if (_formKey.currentState!.validate()) {
                              // Generate a new ID for the product
                              String newProductId = FirebaseFirestore.instance
                                  .collection('products')
                                  .doc()
                                  .id; // Generate a new ID
                              Timestamp currentTime =
                                  Timestamp.now(); // Get the current timestamp

                              // Create a Product instance from the form data
                              final product = Products(
                                id: newProductId, // Include the generated ID
                                productName: _productnameController.text,
                                imageUrl: croppedImage?.path ?? '',
                                description: _descriptionController.text,
                                price: double.tryParse(_priceController.text) ??
                                    0.0,
                                quantity:
                                    double.tryParse(_quantityController.text) ??
                                        0.0,
                                createdAt: currentTime,
                                category:
                                    productCategory, // Include the current timestamp
                              );

                              // Add product to BLoC
                              context.read<AddProductBloc>().add(
                                  AddProductButtonClickedEvent(
                                      product: product));
                              FocusScope.of(context).unfocus();

                              context
                                  .read<FetchProductListBloc>()
                                  .add(FetchProductListInitialEvent());

                              // Use pushReplacement to navigate back to MainScreens and refresh the UI
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      const MainScreens(initialIndex: 0),
                                ),
                              );

                              print('Form is valid. Product added.');
                            } else {
                              print(
                                  'Form is invalid. Please correct the errors.');
                            }
                          }),
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
