import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:inventory_management_system/data/models/catergorey/category_model.dart';
import 'package:inventory_management_system/presentation/bloc/category/category_bloc.dart';
import 'package:inventory_management_system/presentation/screeens/add_products/addpost_page/addphoto.dart';
import 'package:inventory_management_system/presentation/screeens/main_screens.dart';
import 'package:inventory_management_system/presentation/widgets/CustomText.dart';
import 'package:inventory_management_system/presentation/widgets/custome_snackbar.dart';
import 'package:inventory_management_system/presentation/widgets/custometextformfield.dart';
import 'package:inventory_management_system/presentation/widgets/validations.dart';
import 'package:inventory_management_system/utilities/constants/constants.dart';

class EditCategory extends StatefulWidget {
  final CategoryModel editcategory;

  const EditCategory({super.key, required this.editcategory});

  @override
  State<EditCategory> createState() => _EditCategoryState();
}

class _EditCategoryState extends State<EditCategory> {
  late TextEditingController _categoryController;

  File? croppedImage; // For handling image selection
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();

    _categoryController =
        TextEditingController(text: widget.editcategory.productCategory);
  }

  @override
  void dispose() {
    _categoryController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CategoryBloc, CategoryState>(
      listener: (context, state) {
        if (state is CategoryUpdateSuccessState) {
          // Handle success (e.g., show a success message or navigate)
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const MainScreens(
                  initialIndex: 0,
                ),
              ));
        } else if (state is CategoryDeleteSuccessState) {
          Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (context) {
            return const MainScreens(initialIndex: 0);
          }));
        } else if (state is CategoryDeleteErrorState) {
          customSnackbar(context, state.error, red);
        } else if (state is CategoryUpdateErrorState) {
          customSnackbar(
              context, "Failed to add category: ${state.error}", Colors.red);
        }
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
              automaticallyImplyLeading: false,
              title: Text(
                widget.editcategory.productCategory.toString(),
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
                        context.read<CategoryBloc>().add(OnDeleteCategoryEvent(
                            categoryId:
                                widget.editcategory.categoryId.toString()));
                        Navigator.push(context, MaterialPageRoute(
                          builder: (context) {
                            return MainScreens(
                              initialIndex: 0,
                            );
                          },
                        ));
                      },
                      child: Icon(
                        CupertinoIcons.delete,
                        color: black,
                        size: .038.sh,
                      )),
                ),
              ],
              backgroundColor: blue),
          body: Form(
            key: _formKey,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: .04.sh,
                  ),
                   AddPhotoContainer(
                  initialImageUrl: widget.editcategory.categoryImage, 
                  onImageSelected: (image) {
                    croppedImage = image;
                  },
                ),
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            SizedBox(
                              width: 0.03.sw,
                            ),
                            const CustomText(
                              text: "Category",
                              color: Colors.black,
                              fontSize: 20,
                              fontWeight: FontWeight.w600,
                            ),
                          ],
                        ),
                        ElevatedButton(
                            onPressed: () {
                           
                            },
                            child: Text("fkandkfn")),
                        h5,
                        CustomTextFormField(
                          width: .88.sw,
                          minLines: 1,
                          labelText: _categoryController.text,
                          icon: CupertinoIcons.add_circled,
                          controller: _categoryController,
                          hintText: _categoryController.text,
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
          floatingActionButton: state is CategoryUpdateLoadingState
              ? Padding(
                  padding: EdgeInsets.symmetric(
                      vertical: .090.sh, horizontal: .01.sw),
                  child: const FloatingActionButton(
                    backgroundColor: Colors.blue,
                    onPressed: null,
                    child: CircularProgressIndicator(color: Colors.black),
                  ),
                )
              : Padding(
                  padding: EdgeInsets.symmetric(
                      vertical: .090.sh, horizontal: .01.sw),
                  child: FloatingActionButton.extended(
                    backgroundColor: Colors.blue,
                    foregroundColor: Colors.white,
                    onPressed: () {
                      if (croppedImage == null) {
                        customSnackbar(context, "Add Category Image ", red);
                        return;
                      }

                      if (_formKey.currentState!.validate()) {
                        FocusScope.of(context).unfocus();

                        String updatecategory =
                            widget.editcategory.categoryId.toString();
                        Timestamp currentTime = Timestamp.now();
   String categoryImage = croppedImage?.path ?? widget.editcategory.categoryImage ?? '';

                        print(
                            "gggggggggggggggggggggggggggggggggg===============${updatecategory}");

                        final CategoryModel newCategory = CategoryModel(
                          categoryId: updatecategory,
                          categoryImage: categoryImage,
                          createdAt: currentTime,
                          productCategory: _categoryController.text,
                        );

                       // print("gggggggggggggggggggggggggggggggggg===============${widget.}");

                      context.read<CategoryBloc>().add(OnUpdateCategoryEvent(widget.editcategory.categoryId.toString(), categoryModel: newCategory));
                      }
                    },
                    icon: const Icon(Icons.add),
                    label: const Text('Update'),
                  ),
                ),
        );
      },
    );
  }

// void _showDeleteDialog(BuildContext context) {
//   // Show the dialog first
//   showDialog(
//     context: context,
//     builder: (BuildContext context) {
//       return AlertDialog(
//         title: const Text('Delete Confirmation'),
//         content: const Text('All data will be deleted permanently.'),
//         actions: <Widget>[
//           TextButton(
//             child: const Text('CANCEL'),
//             onPressed: () {
//               Navigator.of(context).pop(); // Close the dialog
//             },
//           ),
//           TextButton(
//             child: const Text('DELETE'),
//             onPressed: () async {
//               // Close the dialog first
//               Navigator.of(context).pop();

//               // Call the delete function
//               try {
//                 await deleteCategory(widget.editcategory.categoryId.toString());
//                 // Show success message
//                 print('Category deleted successfully!    ${widget.editcategory.categoryId.toString()}');
//                 // Optionally, you can show a snackbar or a dialog to inform the user
//                 ScaffoldMessenger.of(context).showSnackBar(
//                   const SnackBar(content: Text('Category deleted successfully!')),
//                 );
//               } catch (e) {
//                print(e.toString());

//               }
//             },
//           ),
//         ],
//       );
//     },
//   );
// }
// Future<void> deleteCategory(String N1iakl5zzdNJBdO56L8U) async {
//   try {
//   var doc = await FirebaseFirestore.instance.collection('categories').doc(N1iakl5zzdNJBdO56L8U).get();

// if (!doc.exists) {

//   print('Document does not exist!');

//   return;

// }  await FirebaseFirestore.instance.collection('categories').doc(N1iakl5zzdNJBdO56L8U).delete();
//     print('Category deleted successfully!');
//   } catch (e) {
//     print('Error deleting category: $e');
//     throw Exception('Error deleting category: $e');
//   }
  // }
}

