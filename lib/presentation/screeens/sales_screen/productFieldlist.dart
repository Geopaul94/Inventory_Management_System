import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Productfieldlist extends StatefulWidget {
  final TextEditingController controller;
  const Productfieldlist({super.key, required this.controller});

  @override
  State<Productfieldlist> createState() => _ProductfieldlistState();
}

class _ProductfieldlistState extends State<Productfieldlist> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  List<String> productNameList = [];

  @override
  void initState() {
    super.initState();
    fetchProductNames();
  }

  Future<void> fetchProductNames() async {
    try {
      // Get all documents from the products collection
      QuerySnapshot querySnapshot = await _firestore.collection('products').get();
      
      setState(() {
        // Extract product names from all documents
        productNameList = querySnapshot.docs.map((doc) {
          Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
          return data['productName']?.toString() ?? 'Unknown Product';
        }).toList();
      });
    } catch (e) {
      print('Error fetching product names: $e');
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
            return productNameList.map((String productName) {
              return PopupMenuItem<String>(
                value: productName,
                child: Text(productName),
              );
            }).toList();
          },
        ),
      ),
    );
  }
}