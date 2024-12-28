import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hive/hive.dart';

class CategoryService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Method to add a category to Firestore
  Future<void> addCategoryToFirestore(String categoryName) async {
    try {
      await _firestore.collection('categories').add({
        'categoryName': categoryName,
        'createdAt': FieldValue.serverTimestamp(),
      });
    } catch (e) {
      print("Error adding category to Firestore: $e");
    }
  }

  // Method to get categories from Firestore
  Future<List<Map<String, dynamic>>> getCategoriesFromFirestore() async {
    try {
      QuerySnapshot snapshot = await _firestore.collection('categories').get();
      return snapshot.docs
          .map((doc) => {
                'id': doc.id,
                'categoryName': doc['categoryName'],
              })
          .toList();
    } catch (e) {
      print("Error fetching categories from Firestore: $e");
      return [];
    }
  }

  // Method to add a category to Hive (local storage)
  Future<void> addCategoryToHive(String categoryName) async {
    var box = await Hive.openBox('categoriesBox');
    await box.add({'categoryName': categoryName});
  }

  // Method to get categories from Hive (local storage)
  Future<List<Map<String, dynamic>>> getCategoriesFromHive() async {
    var box = await Hive.openBox('categoriesBox');
    return box.values.cast<Map<String, dynamic>>().toList();
  }

  // Method to delete a category from Hive
  Future<void> deleteCategoryFromHive(int index) async {
    var box = await Hive.openBox('categoriesBox');
    await box.deleteAt(index);
  }

  // Method to delete a category from Firestore
  Future<void> deleteCategoryFromFirestore(String categoryId) async {
    try {
      await _firestore.collection('categories').doc(categoryId).delete();
    } catch (e) {
      print("Error deleting category from Firestore: $e");
    }
  }
}
