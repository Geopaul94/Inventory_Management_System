import 'package:flutter/material.dart';

class Samplepage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Text('ListView.builder with Separators')),
        body: MyListView(),
      ),
    );
  }
}

class MyListView extends StatelessWidget {
  // Sample data
  final List<Map<String, String>> items = List.generate(
    20,
    (index) => {
      "title": "Item $index",
      "subtitle": "Subtitle for item $index",
    },
  );

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: items.length * 2 - 1, // Total number of widgets (cards + dividers)
      itemBuilder: (context, index) {
        if (index.isOdd) {
          return Divider(); // Add a divider between cards
        }

        final itemIndex = index ~/ 2; // Calculate the actual item index
        return Card(
          margin: EdgeInsets.all(10),
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Title: ${items[itemIndex]['title']}', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                Text('Subtitle: ${items[itemIndex]['subtitle']}', style: TextStyle(fontSize: 16)),
              ],
            ),
          ),
        );
      },
    );
  }
}
