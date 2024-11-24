import 'package:cloud_firestore/cloud_firestore.dart';

import 'dart:io';
import 'package:inventory_management_system/data/models/product_model.dart';
import 'package:http/http.dart' as http;

import 'dart:convert';

// Function to handle product upload with image

Future<void> uploadProductWithImage(Products product) async {
  try {
    // Step 1: Upload the image to Cloudinary and get the download URL
    String? imageUrl = await uploadImageToCloudinary(product.imageUrl);

    // Check if image upload was successful
    if (imageUrl != null) {
      Products updatedProduct = Products(
        id: product.id,
        productName: product.productName,
        imageUrl: imageUrl,
        description: product.description,
        price: product.price,
        quantity: product.quantity,
        createdAt: product.createdAt,
        category: product.category,
      );

      // Step 3: Save the updated product to Firestore
      await saveProductToFirestore(updatedProduct);
      print('Product with image saved successfully!');
    } else {
      print('Failed to upload image to Cloudinary');
    }
  } catch (error) {
    print('Error uploading product: $error');
  }
}

// Function to upload image to Cloudinary
Future<String?> uploadImageToCloudinary(String imagePath) async {
  File file = File(imagePath);

  try {
    // Cloudinary API endpoint
    final url =
        Uri.parse('https://api.cloudinary.com/v1_1/duyqxp4er/image/upload');

    // Create a multipart request
    final request = http.MultipartRequest('POST', url)
      ..fields['upload_preset'] = 'vlbl4hxd' // Use your Cloudinary preset
      ..files.add(await http.MultipartFile.fromPath('file', file.path));

    // Send the request
    final response = await request.send();

    // Check if the upload is successful
    if (response.statusCode == 200) {
      final res = await http.Response.fromStream(response);
      final jsonMap = jsonDecode(res.body);

      // Get the URL of the uploaded image from Cloudinary
      String imageUrl = jsonMap['secure_url'];
      return imageUrl;
    } else {
      print(
          'Failed to upload image to Cloudinary. Status Code: ${response.statusCode}');
      return null;
    }
  } catch (e) {
    print('Error uploading image to Cloudinary: $e');
    return null;
  }
}

// Function to save product details to Firestore
Future<void> saveProductToFirestore(Products product) async {
  // Get a reference to the Firestore collection
  CollectionReference productsRef =
      FirebaseFirestore.instance.collection('products');

  // Convert product object to a Map and save to Firestore
  try {
    await productsRef.add(product.toMap());
    print('Product added successfully to Firestore');
  } catch (error) {
    print('Failed to add product: $error');
  }
}

// Function to fetch all products from Firestore

Future<List<Products>> fetchAllProducts() async {
  try {
    // Step 1: Get the reference to the Firestore 'products' collection
    CollectionReference productsRef =
        FirebaseFirestore.instance.collection('products');

    // Step 2: Fetch all documents from the collection
    QuerySnapshot querySnapshot = await productsRef
        .orderBy('createdAt', descending: true)
        .get(); // Order by createdAt

    // Step 3: Convert documents to a list of Products
    List<Products> productsList = querySnapshot.docs.map((doc) {
      // Get document data as a map
      Map<String, dynamic> data = doc.data() as Map<String, dynamic>;

      // Convert map to Products object using the factory constructor
      return Products.fromMap(data);
    }).toList();

    // Step 4: Return the list of Products
    return productsList;
  } catch (e) {
    print('Error fetching products: $e');
    return [];
  }
}


// Function to update a product in Firestore by its product ID
Future<void> updateProductById(String productIdField, Map<String, dynamic> updatedData) async {
  try {
    // Reference to the Firestore collection
    CollectionReference productsRef = FirebaseFirestore.instance.collection('products');

    // Query Firestore to find the document with the matching 'productId' field
    QuerySnapshot querySnapshot = await productsRef.where('id', isEqualTo: productIdField).get();

    // Check if any documents match the query
    if (querySnapshot.docs.isEmpty) {
      print('No product found with the provided ID: $productIdField');
      return;
    }

    // Get the document ID of the first matching document
    String documentId = querySnapshot.docs.first.id;

    // Proceed to update the document using its document ID
    await productsRef.doc(documentId).update(updatedData);
    
    print('Product with ID $productIdField updated successfully!');
  } catch (e) {
    print('Error updating product: $e');
    throw Exception('Failed to update product: $e');
  }
}
// Function to delete a product from Firestore by its 'id' field
Future<void> deleteProductById(String productIdField) async {
  try {
    // Query Firestore to find the document with the matching 'id' field
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('products')
        .where('id', isEqualTo: productIdField)
        .get();

    // Check if any documents match the query
    if (querySnapshot.docs.isEmpty) {
      print('No product found with the provided ID: $productIdField');
      return;
    }

    // Get the document ID of the first matching document (if more than one exists, handle accordingly)
    String documentId = querySnapshot.docs.first.id;

    // Proceed to delete the document using its document ID
    await FirebaseFirestore.instance
        .collection('products')
        .doc(documentId)
        .delete();

    print('Product with ID $productIdField deleted successfully!');
  } catch (e) {
    print('Error deleting product: $e');
    throw Exception('Failed to delete product: $e');
  }
}
