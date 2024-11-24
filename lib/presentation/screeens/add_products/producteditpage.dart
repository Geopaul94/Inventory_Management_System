import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:inventory_management_system/data/models/product_model.dart';
import 'package:inventory_management_system/data/repository/product_data/product_data.dart';
import 'package:inventory_management_system/presentation/bloc/add_product/addproduct_bloc.dart';
import 'package:inventory_management_system/presentation/bloc/add_product/addproduct_event.dart';
import 'package:inventory_management_system/presentation/bloc/add_product/addproduct_state.dart';
import 'package:inventory_management_system/presentation/screeens/add_products/addpost_page/addphoto.dart';
import 'package:inventory_management_system/presentation/screeens/main_screens.dart';
import 'package:inventory_management_system/presentation/widgets/CustomElevatedButton.dart';
import 'package:inventory_management_system/presentation/widgets/CustomText.dart';
import 'package:inventory_management_system/presentation/widgets/custome_button.dart';
import 'package:inventory_management_system/presentation/widgets/custome_snackbar.dart';

import 'package:inventory_management_system/presentation/widgets/custometextformfield.dart';
import 'package:inventory_management_system/presentation/widgets/validations.dart';
import 'package:inventory_management_system/utilities/constants/constants.dart';

class Producteditpage extends StatefulWidget {
  final Products product;

  const Producteditpage({super.key, required this.product});

  @override
  _ProducteditpageState createState() => _ProducteditpageState();
}

class _ProducteditpageState extends State<Producteditpage> {
  // Declare controllers
  late TextEditingController _descriptionController;
  late TextEditingController _productnameController;
  late TextEditingController _priceController;
  late TextEditingController _quantityController;

  File? croppedImage; // For handling image selection
  final _formKey = GlobalKey<FormState>();
  bool isLoading = false;
  @override
  void initState() {
    super.initState();

    // Initialize controllers with product data
    _descriptionController =
        TextEditingController(text: widget.product.description);
    _productnameController =
        TextEditingController(text: widget.product.productName);
    _priceController =
        TextEditingController(text: widget.product.price.toString());
    _quantityController =
        TextEditingController(text: widget.product.quantity.toString());
  }

  @override
  void dispose() {
    // Dispose controllers to free up resources
    _descriptionController.dispose();
    _productnameController.dispose();
    _priceController.dispose();
    _quantityController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Text(
            widget.product.category.toString(),
            style: const TextStyle(
                fontSize: 20, fontWeight: FontWeight.normal, color: white),
          ),
          centerTitle: true, // Center the title
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 12.0),
              child: GestureDetector(
                  onTap: () async {
                    //  _showDeleteDialog(context);

                    _showDeleteDialog(context, isLoading);
                  },
                  child: Icon(
                    CupertinoIcons.delete,
                    color: black,
                    size: .038.sh,
                  )),
            ),
          ],
          backgroundColor: blue),
      body: BlocConsumer<AddProductBloc, AddProductState>(
        listener: (context, state) {
          if (state is DeleteProductErrorState) {
            customSnackbar(context, state.errorMessage, red);
          } else if (state is DeleteProductSuccessState) {
            Navigator.push(context, MaterialPageRoute(
              builder: (context) {
                return MainScreens();
              },
            ));
          } else if (state is UpdateProductErrorState) {
            customSnackbar(context, state.errorMessage, red);
          } else if (state is UpdateProductSuccessState) {
            Navigator.push(context, MaterialPageRoute(
              builder: (context) {
                return MainScreens();
              },
            ));
          }
        },
        builder: (context, state) {
          return SafeArea(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AddPhotoContainer(
                        initialImageUrl: widget.product.imageUrl,
                        onImageSelected: (image) {
                          croppedImage = image;
                        },
                      ),
                      const CustomText(
                        text: "Name",
                        color: black,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                      CustomTextFormField(
                        icon: CupertinoIcons.add_circled,
                        controller: _productnameController,
                        validator: validateProductName,
                        labelText: '',
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
                                icon: CupertinoIcons.add_circled,
                                controller: _quantityController,
                                keyboardType: TextInputType.number,
                                hintText: "e.g.12",
                                hintTextColor: black,
                                validator: validateProductQuantity,
                                labelText: '',
                              ),
                            ],
                          ),
                        ),
                      ]),
                      h20,
                      Center(
                        child: BlocBuilder<AddProductBloc, AddProductState>(
                            builder: (context, state) {
                          if (state is UpdateProductLoadingState) {
                            return loadingButton(
                                onPressed: () {},
                                gradientStartColor: green,
                                gradientEndColor: blue,
                                loadingIndicatorColor: Colors.orange);
                          }
                          return CustomElevatedButton(
                              text: "Update product",
                              color: blue,
                              width: double.infinity,
                              onPressed: () async {
                                if (_formKey.currentState!.validate()) {
                                  Timestamp currentTime = Timestamp.now();
                                  final updatedProduct = Products(
                                    id: widget.product.id,
                                    productName:
                                        _productnameController.text.isNotEmpty
                                            ? _productnameController.text
                                            : widget.product.productName,
                                    imageUrl: croppedImage?.path ??
                                        widget.product.imageUrl,
                                    description:
                                        _descriptionController.text.isNotEmpty
                                            ? _descriptionController.text
                                            : widget.product.description,
                                    price: double.tryParse(
                                            _priceController.text) ??
                                        widget.product.price,
                                    quantity: double.tryParse(
                                            _quantityController.text) ??
                                        widget.product.quantity,
                                    createdAt: currentTime,
                                    category: widget.product.category,
                                  );

                                  // Log before calling update function
                                  print(
                                      'Updated Product Details: ${updatedProduct.toMap()}');

                                  print(
                                      'lllllllllllllllllllllllllllll${widget.product.id.toString()}');
                                  context.read<AddProductBloc>().add(
                                      UpdateProductButtonClickedEvent(
                                          widget.product.id,
                                          product: updatedProduct));

                                  Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          const MainScreens(initialIndex: 0),
                                    ),
                                  );
                                }
                              });
                        }),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  void _showDeleteDialog(BuildContext context, bool isLoading) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              title: const Text('Delete Confirmation'),
              content: isLoading
                  ? const SizedBox(
                      height: 50,
                      child: Center(child: CircularProgressIndicator()))
                  : const Text('All data will be deleted permanently.'),
              actions: <Widget>[
                TextButton(
                  child: const Text('CANCEL'),
                  onPressed: () {
                    if (!isLoading) {
                      Navigator.of(context).pop(); // Close the dialog
                    }
                  },
                ),
                TextButton(
                  child: const Text('DELETE'),
                  onPressed: () async {
                    // Show loading indicator and trigger delete action
                    setState(() {
                      isLoading = true; // Show loading
                    });

                    // Dispatch the delete event
                    context.read<AddProductBloc>().add(
                        DeleteProductButtonClickedEvent(
                            productId: widget.product.id));
                  },
                ),
              ],
            );
          },
        );
      },
    );
  }
}
