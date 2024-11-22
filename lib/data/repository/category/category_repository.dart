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

  // Delete category by categoryId
  Future<void> deleteCategory(String categoryId) async {
    try {
      await _firestore.collection('categories').doc(categoryId).delete();
      print('Category deleted successfully!');
    } catch (e) {
      throw Exception('Error deleting category: $e');
    }
  }

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
}
