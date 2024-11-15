import 'package:flutter/material.dart';
import 'package:inventory_management_system/presentation/screeens/add_products/addpost_page/add_products.dart';

class HomePage extends StatelessWidget {
  // Sample list of products (you can replace this with your actual data)
  final List<Product> products = [

  Product(name: 'Product 1', price: 1900, quantity: 20),

  Product(name: 'Product 2', price: 1500, quantity: 10),

  // Add more products as needed

];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
      ),
      body: products.isEmpty
          ? const Center(
              child: Text(
                'Add Products',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
            )
          : GridView.builder(
              padding: const EdgeInsets.all(10),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2, 
                childAspectRatio: 0.75, 
                crossAxisSpacing: 10, 
                mainAxisSpacing: 10, 
              ),
              itemCount: products.length,
              itemBuilder: (context, index) {
                return ProductCard(product: products[index]);
              },
            ),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: const Color(0xff03dac6),
        foregroundColor: Colors.black,
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => AddProducts()),
          );
        },
        icon: const Icon(Icons.add),
        label: const Text('Add Product'),
      ),
    );
  }
}

class Product {
  final String name;
  final double price;
  final int quantity;

  Product({required this.name, required this.price, required this.quantity});
}

class ProductCard extends StatelessWidget {
  final Product product;

  const ProductCard({Key? key, required this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            product.name,
            style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),
          // Placeholder for product image
          Container(
            height: 100,
            width: 100,
            color: Colors.grey[300], // Placeholder color
            child: const Center(child: Text('Image')),
          ),
          const SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.fromLTRB(5, 0, 5, 0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("₹ ${product.price.toStringAsFixed(2)}"),
                Text("Quantity: ${product.quantity}"),
              ],
            ),
          ),
        ],
      ),
    );
  }
}