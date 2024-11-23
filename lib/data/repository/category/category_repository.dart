import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:inventory_management_system/data/models/catergorey/category_model.dart';

import 'package:inventory_management_system/data/repository/product_data/product_data.dart';

class FirestoreServiceCategoryModel {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Fetch all categories
  Future<List<CategoryModel>> fetchCategories() async {
    try {
      QuerySnapshot querySnapshot =
          await _firestore.collection('categories').get();

      List<CategoryModel> categories = querySnapshot.docs.map((doc) {
        return CategoryModel.fromFirestore(doc.data() as Map<String, dynamic>);
      }).toList();

      return categories;
    } catch (e) {
      throw Exception('Error fetching categories: $e');
    }
  }

 
// Addcategorywith image

  Future<void> addCategorywithImage(CategoryModel category) async {
    try {
      // Step 1: Upload the image to Cloudinary and get the download URL
      String? imageUrl = await uploadImageToCloudinary(category.categoryImage!);

      // Check if image upload was successful
      if (imageUrl != null) {
        // Step 2: Update the category model with the image URL
        CategoryModel updatedCategory = CategoryModel(
          categoryId: category.categoryId,
          categoryImage: imageUrl, // Set the Cloudinary image URL
          productCategory: category.productCategory,
          createdAt:
              category.createdAt, // Keep the original createdAt timestamp
        );

        // Step 3: Save the updated category to Firestore
        await saveCategoryToFirestore(updatedCategory);
        print('Category with image saved successfully!');
      } else {
        print('Failed to upload image to Cloudinary');
      }
    } catch (error) {
      print('Error uploading category with image: $error');
    }
  }

// Function to save category details to Firestore

  Future<void> saveCategoryToFirestore(CategoryModel category) async {
    // Get a reference to the Firestore collection
    CollectionReference categoriesRef =
        FirebaseFirestore.instance.collection('categories');

    // Convert category object to a Map and save to Firestore
    try {
      await categoriesRef.add(category.toFirestore());
      print('Category added successfully to Firestore');
    } catch (error) {
      print('Failed to add category: $error');
    }
  }


// Function to update category details in Firestore with image upload
Future<void> updateCategoryByField(
    String categoryIdField, CategoryModel updatedCategory) async {
  try {
    // Check if the image path is local (indicating an edited image)
    if (updatedCategory.categoryImage != null &&
        updatedCategory.categoryImage!.startsWith('/data')) {
      
      // Upload the image to Cloudinary and get the URL
      String? imageUrl = await uploadImageToCloudinary(updatedCategory.categoryImage!);

      // If the image was uploaded successfully, update the category with the Cloudinary image URL
      if (imageUrl != null) {
        updatedCategory = updatedCategory.copyWith(
          categoryImage: imageUrl, // Use the new image URL
        );
      } else {
        print('Failed to upload image to Cloudinary');
        return; // Stop execution if the image upload fails
      }
    }

    // Query Firestore to find the document with the matching 'categoryId' field
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('categories')
        .where('categoryId', isEqualTo: categoryIdField)
        .get();

    // If no matching document is found, return
    if (querySnapshot.docs.isEmpty) {
      print('No category found with the provided categoryId');
      return;
    }

    // Get the document ID of the first matching document
    String documentId = querySnapshot.docs.first.id;

    // Proceed to update the document using its document ID
    await FirebaseFirestore.instance
        .collection('categories')
        .doc(documentId)
        .update(updatedCategory.toFirestore());

    print('Category updated successfully!');
  } catch (e) {
    print('Error updating category: $e');
    throw Exception('Failed to update category: $e');
  }
}











// delete categoryfield



  Future<void> deleteCategoryByField(String categoryIdField) async {
    try {
      // Query Firestore to find the document with the matching 'categoryId' field
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('categories')
          .where('categoryId', isEqualTo: categoryIdField)
          .get();

      // Check if any documents match the query
      if (querySnapshot.docs.isEmpty) {
        print('No category found with the provided categoryId');
        return;
      }

      // Get the document ID of the first matching document (if more than one exists, handle accordingly)
      String documentId = querySnapshot.docs.first.id;

      // Proceed to delete the document using its document ID
      await FirebaseFirestore.instance
          .collection('categories')
          .doc(documentId)
          .delete();

      print('Category deleted successfully!');
    } catch (e) {
      print('Error deleting category: $e');
      throw Exception('Failed to delete category: $e');
    }
  }
}
