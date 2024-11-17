import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:inventory_management_system/data/models/productitems/item.dart';

class ItemsPage extends StatelessWidget {
  const ItemsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Items Report')),
      body: Center(
        child: ElevatedButton(
          onPressed: () async {
            List<ItemModel> items = await fetchItemsReport();

            // Print each item in the console
            for (var item in items) {
              print(item.toString());
            }

            // Optionally, show a simple dialog with the number of items fetched
            showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  content: Text('Fetched ${items.length} items'),
                );
              },
            );
          },
          child: const Text('Fetch Items Report'),
        ),
      ),
    );
  }
}

// Your existing fetchItemsReport method
Future<List<ItemModel>> fetchItemsReport() async {
  QuerySnapshot querySnapshot = await FirebaseFirestore.instance.collection('items').get();
  return querySnapshot.docs.map((doc) {
    return ItemModel.fromFirestore(doc);
  }).toList();
}
