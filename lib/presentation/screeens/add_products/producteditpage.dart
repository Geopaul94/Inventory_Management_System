import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:inventory_management_system/data/models/product_model.dart';
import 'package:inventory_management_system/presentation/bloc/add_product/addproduct_bloc.dart';
import 'package:inventory_management_system/presentation/bloc/add_product/addproduct_event.dart';
import 'package:inventory_management_system/presentation/screeens/add_products/addpost_page/addphoto.dart';
import 'package:inventory_management_system/presentation/screeens/main_screens.dart';
import 'package:inventory_management_system/presentation/widgets/CustomElevatedButton.dart';
import 'package:inventory_management_system/presentation/widgets/CustomText.dart';

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

  @override
  void initState() {
    super.initState();

    // Initialize controllers with product data
    _descriptionController = TextEditingController(text: widget.product.description);
    _productnameController = TextEditingController(text: widget.product.productName);
    _priceController = TextEditingController(text: widget.product.price.toString());
    _quantityController = TextEditingController(text: widget.product.quantity.toString());
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
    return    Scaffold(
   appBar: PreferredSize(
  preferredSize: const Size.fromHeight(60.0),
  child: AppBar(
    title: const Text('Edit Product'), 
    centerTitle: true,
    backgroundColor: green, 
    actions: [
      IconButton(
        icon: const Icon(Icons.delete), // Use an icon for the delete action
        onPressed: () async {
          // Dispatch the delete event with the product ID
          context.read<AddProductBloc>().add(DeleteProductButtonClickedEvent(productId: widget.product.id));

          // Navigate back to the previous screen or a list of products
      Navigator.pop(context); // This will go back to the previous screen
        },
      ),
    ],
  ),
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
                       
                      validator: validateProductName, labelText: '',
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
                              validator: validateProductQuantity, labelText: '',
                            ),
                          ],
                        ),
                      ),
                    ]),
                    h20,

                    
                    Center(
                
                  child: CustomElevatedButton(
                      text: "Update product",
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          // Generate the new product object with updated data
                          Timestamp currentTime = Timestamp.now(); 
                          final updatedProduct = Products(
                            id: widget.product.id, // Keep the same ID
                            productName: _productnameController.text.isNotEmpty
                                ? _productnameController.text
                                : widget.product.productName,
                            imageUrl: croppedImage?.path ?? widget.product.imageUrl,
                            description: _descriptionController.text.isNotEmpty
                                ? _descriptionController.text
                                : widget.product.description,
                            price: double.tryParse(_priceController.text) ?? widget.product.price,
                            quantity: double.tryParse(_quantityController.text) ?? widget.product.quantity,
                            createdAt: currentTime, category: widget.product.category,
                          );

                          // Trigger BLoC to update the product
                          context.read<AddProductBloc>().add(UpdateProductButtonClickedEvent(product: updatedProduct));

                          // Navigate back to main screen
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const MainScreens(initialIndex: 0),
                            ),
                          );
                        }
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}