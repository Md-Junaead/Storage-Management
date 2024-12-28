import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class CategoryProvider with ChangeNotifier {
  // Firestore instance for cloud storage (optional if using Firebase)
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // List to hold categories
  List<String> _categories = [];

  List<String> get categories => _categories;

  // Fetch categories from Firestore
  Future<void> fetchCategories() async {
    try {
      final categorySnapshot = await _firestore.collection('categories').get();
      _categories =
          categorySnapshot.docs.map((doc) => doc['name'] as String).toList();
      notifyListeners();
    } catch (e) {
      print("Error fetching categories: $e");
    }
  }

  // Add a new category to Firestore
  Future<void> addCategory(String categoryName) async {
    try {
      await _firestore.collection('categories').add({
        'name': categoryName,
      });
      _categories.add(categoryName);
      notifyListeners();
    } catch (e) {
      print("Error adding category: $e");
    }
  }

  // Remove a category from Firestore
  Future<void> removeCategory(String categoryName) async {
    try {
      final categoryToRemove = await _firestore
          .collection('categories')
          .where('name', isEqualTo: categoryName)
          .get();
      if (categoryToRemove.docs.isNotEmpty) {
        await categoryToRemove.docs.first.reference.delete();
        _categories.remove(categoryName);
        notifyListeners();
      }
    } catch (e) {
      print("Error removing category: $e");
    }
  }

  // Update an existing category in Firestore
  Future<void> updateCategory(
      String oldCategoryName, String newCategoryName) async {
    try {
      final categoryToUpdate = await _firestore
          .collection('categories')
          .where('name', isEqualTo: oldCategoryName)
          .get();
      if (categoryToUpdate.docs.isNotEmpty) {
        await categoryToUpdate.docs.first.reference.update({
          'name': newCategoryName,
        });
        int index = _categories.indexOf(oldCategoryName);
        _categories[index] = newCategoryName;
        notifyListeners();
      }
    } catch (e) {
      print("Error updating category: $e");
    }
  }
}
