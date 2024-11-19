import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:inventory_management_system/data/models/catergorey/category_model.dart';

class CategoryListfield extends StatefulWidget {
  final TextEditingController controller;
  const CategoryListfield({
    super.key,
    required this.controller,
  });

  @override
  State<CategoryListfield> createState() => _CategoryfieldState();
}

class _CategoryfieldState extends State<CategoryListfield> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  List<String> categoryList = [];

  @override
  void initState() {
    super.initState();
    fetchProductCategories();
  }

  Future<void> fetchProductCategories() async {
    try {
      QuerySnapshot querySnapshot =
          await _firestore.collection('categories').get();
      List<CategoryModel> categories = querySnapshot.docs.map((doc) {
        return CategoryModel.fromFirestore(doc.data() as Map<String, dynamic>);
      }).toList();
      setState(() {
        categoryList = categories
            .map((category) => category.productCategory ?? 'Unknown Category')
            .toList();
      });
    } catch (e) {
      // Handle any errors
      print('Error fetching categories: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      readOnly: true,
      decoration: InputDecoration(
        border: const OutlineInputBorder(),
        prefixIcon: const Icon(CupertinoIcons.square_list),
        suffixIcon: PopupMenuButton<String>(
          icon: const Icon(Icons.arrow_drop_down),
          onSelected: (String value) {
            widget.controller.text = value;
          },
          itemBuilder: (BuildContext context) {
            return categoryList.map((String category) {
              return PopupMenuItem<String>(
                value: category,
                child: Text(category),
              );
            }).toList();
          },
        ),
      ),
    );
  }
}
