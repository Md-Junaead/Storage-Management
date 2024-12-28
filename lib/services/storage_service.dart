import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hive/hive.dart';
import 'package:flutter/material.dart';
import 'package:st_management/models/storage_item.dart';

class StorageService with ChangeNotifier {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Method to add an item to the Firestore database
  Future<void> addItemToFirestore(Map<String, dynamic> itemData) async {
    try {
      await _firestore.collection('items').add(itemData);
      notifyListeners();
    } catch (e) {
      print("Error adding item to Firestore: $e");
    }
  }

  // Method to get items from Firestore
  Future<List<Map<String, dynamic>>> getItemsFromFirestore() async {
    try {
      QuerySnapshot snapshot = await _firestore.collection('items').get();
      return snapshot.docs
          .map((doc) => doc.data() as Map<String, dynamic>)
          .toList();
    } catch (e) {
      print("Error fetching items from Firestore: $e");
      return [];
    }
  }

  // Method to add an item to Hive database (local storage)
  Future<void> addItemToHive(Map<String, dynamic> itemData) async {
    var box = await Hive.openBox('itemsBox');
    await box.add(itemData);
    notifyListeners();
  }

  // Method to get items from Hive (local storage)
  Future<List<Map<String, dynamic>>> getItemsFromHive() async {
    var box = await Hive.openBox('itemsBox');
    return box.values.cast<Map<String, dynamic>>().toList();
  }

  // Method to delete an item from Hive
  Future<void> deleteItemFromHive(int index) async {
    var box = await Hive.openBox('itemsBox');
    await box.deleteAt(index);
    notifyListeners();
  }

  // Method to delete an item from Firestore
  Future<void> deleteItemFromFirestore(String itemId) async {
    try {
      await _firestore.collection('items').doc(itemId).delete();
      notifyListeners();
    } catch (e) {
      print("Error deleting item from Firestore: $e");
    }
  }

  // List to store items in memory (local list)
  final List<StorageItem> _items = []; // This is the correct declaration

  List<StorageItem> get items => _items;

  // Delete item by ID from the list
  void deleteItem(String id) {
    _items.removeWhere((item) => item.id == id);
    notifyListeners();
  }

  // Add a new item to the list
  void addItem(StorageItem item) {
    _items.add(item);
    notifyListeners(); // Notify listeners to update UI
  }

  // Update an existing item in the list
  void updateItem(StorageItem updatedItem) {
    final index = _items.indexWhere((item) => item.id == updatedItem.id);
    if (index != -1) {
      _items[index] = updatedItem; // Update the item at the found index
      notifyListeners(); // Notify listeners to update UI
    }
  }
}
