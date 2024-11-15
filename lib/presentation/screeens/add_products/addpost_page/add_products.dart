

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:inventory_management_system/presentation/screeens/add_products/addpost_page/addphoto.dart';
import 'package:inventory_management_system/presentation/screeens/main_screens.dart';
import 'package:inventory_management_system/presentation/widgets/CustomElevatedButton.dart';
import 'package:inventory_management_system/presentation/widgets/CustomText.dart';
import 'package:inventory_management_system/presentation/widgets/CustomeAppbar.dart';
import 'package:inventory_management_system/presentation/widgets/custometextformfield.dart';
import 'package:inventory_management_system/presentation/widgets/validations.dart';
import 'package:inventory_management_system/utilities/constants/constants.dart';





class AddProducts extends StatelessWidget {
  AddProducts({super.key});

  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _productnameController = TextEditingController(); 
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _quantityController = TextEditingController();
  
  // Global key to manage form state
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
              key: _formKey, // Attach form key
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
             AddPhotoContainer(),

                  // Product Name
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
                    validator: validateProductName, // Validate product name
                  ),

                  h10,

                  // Description
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
                    validator: validateProductDescription, // Validate description
                  ),

                  h10,

                  // Price and Quantity
                  Row(
                    children: [
                      // Price
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
                              validator: validateProductPrice, // Validate price
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(width: 10),

                      // Quantity
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
                              hintText: "e.g. 12",
                              hintTextColor: black,
                              validator: validateProductQuantity, // Validate quantity
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),

                  h20,

                  // Add Product Button
                  Center(
                    child: CustomElevatedButton(
                      text: "Add Product",
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
Navigator.push(
  context,
  MaterialPageRoute(
    builder: (context) => MainScreens(initialIndex: 0), // SalesPage has index 1
  ),
);

                    
                          print('Form is valid. Proceed to add product.');
                        } else {
                         
                          print('Form is invalid. Please correct the errors.');
                        }
                      },
                    ),
                  ),

                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
