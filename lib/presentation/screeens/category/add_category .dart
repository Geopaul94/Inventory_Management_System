import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:inventory_management_system/data/models/catergorey/category_model.dart';
import 'package:inventory_management_system/main.dart';
import 'package:inventory_management_system/presentation/bloc/category/category_bloc.dart';
import 'package:inventory_management_system/presentation/screeens/add_products/addpost_page/addphoto.dart';
import 'package:inventory_management_system/presentation/screeens/main_screens.dart';

import 'package:inventory_management_system/presentation/widgets/CustomText.dart';
import 'package:inventory_management_system/presentation/widgets/CustomeAppbar.dart';
import 'package:inventory_management_system/presentation/widgets/custome_snackbar.dart';
import 'package:inventory_management_system/presentation/widgets/custometextformfield.dart';
import 'package:inventory_management_system/presentation/widgets/validations.dart';
import 'package:inventory_management_system/utilities/constants/constants.dart';

class AddCategoryPage extends StatefulWidget {
  @override
  State<AddCategoryPage> createState() => _AddCategoryPageState();
}

class _AddCategoryPageState extends State<AddCategoryPage> {
  final TextEditingController _categoryController = TextEditingController();
  File? croppedImage;
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CategoryBloc, CategoryState>(
      listener: (context, state) {
        if (state is AddCategoryedSucessState) {
          // Handle success (e.g., show a success message or navigate)
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => MainScreens(
                  initialIndex: 0,
                ),
              ));
        } else if (state is AddCategoryErrorState) {
          customSnackbar(
              context, "Failed to add category: ${state.error}", Colors.red);
        }
      },
      builder: (context, state) {
        return Scaffold(
          appBar: CustomAppBar(
            title: "Add Category",
            backarrow: true,
          ),
          body: Form(
            key: _formKey,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: .15.sh,
                  ),
                  AddPhotoContainer(onImageSelected: (image) {
                    croppedImage = image;
                  }),
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            const CustomText(
                              text: "Category",
                              color: Colors.black,
                              fontSize: 20,
                              fontWeight: FontWeight.w600,
                            ),
                          ],
                        ),
                        h5,
                        CustomTextFormField(
                          labelText: "Product Category",
                          icon: CupertinoIcons.add_circled,
                          controller: _categoryController,
                          hintText: "e.g. Mobile, HeadPhone",
                          validator: validateProductName,
                        ),
                        h10,
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
          floatingActionButton: state is AddCategoryLoadingstate
              ? Padding(
                padding: EdgeInsets.symmetric(vertical: .090.sh,horizontal: .01.sw),
                child: const FloatingActionButton(
                    backgroundColor: Colors.blue,
                    onPressed: null,
                    child: CircularProgressIndicator(color: Colors.black),
                  ),
              )
              : Padding(
                padding:  EdgeInsets.symmetric(vertical: .090.sh,horizontal: .01.sw),
                child: FloatingActionButton.extended(
                    backgroundColor: Colors.blue,
                    foregroundColor: Colors.white,
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        FocusScope.of(context).unfocus();
                
                        String newCategoryId = FirebaseFirestore.instance
                            .collection('categories')
                            .doc()
                            .id;
                        Timestamp currentTime = Timestamp.now();
                
                        final CategoryModel newCategory = CategoryModel(
                          categoryId: newCategoryId,
                          categoryImage: croppedImage?.path ?? '',
                          createdAt: currentTime,
                          productCategory: _categoryController.text,
                        );
                
                        context.read<CategoryBloc>().add(
                            OnAddNewCategoryEvent(categoryModel: newCategory));
                      }
                    },
                    icon: const Icon(Icons.add),
                    label: const Text('Save'),
                  ),
              ),
        );
      },
    );
  }
}
