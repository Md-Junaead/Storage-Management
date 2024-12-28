import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class StorageProvider with ChangeNotifier {
  // Hive box for local storage
  Box? _storageBox;

  // Firestore instance for cloud storage (optional if using Firebase)
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Initialize Hive box
  Future<void> initHiveBox() async {
    _storageBox = await Hive.openBox('storageItems');
    notifyListeners();
  }

  // Fetch all items from Hive or Firestore
  Future<List<Map<String, dynamic>>> getItems() async {
    List<Map<String, dynamic>> items = [];
    if (_storageBox != null) {
      items = List<Map<String, dynamic>>.from(_storageBox!.values);
    } else {
      // Fetch from Firestore if desired (or fallback to local storage)
      final querySnapshot = await _firestore.collection('storage').get();
      for (var doc in querySnapshot.docs) {
        items.add(doc.data());
      }
    }
    return items;
  }

  // Add item to local storage (Hive or Firestore)
  Future<void> addItem(Map<String, dynamic> item) async {
    if (_storageBox != null) {
      await _storageBox!.add(item);
    } else {
      await _firestore.collection('storage').add(item);
    }
    notifyListeners();
  }

  // Update an existing item in local storage (Hive or Firestore)
  Future<void> updateItem(int index, Map<String, dynamic> updatedItem) async {
    if (_storageBox != null) {
      await _storageBox!.putAt(index, updatedItem);
    } else {
      // Update Firestore (using Firestore document id)
      var docId = updatedItem['id'];
      await _firestore.collection('storage').doc(docId).update(updatedItem);
    }
    notifyListeners();
  }

  // Delete item from local storage (Hive or Firestore)
  Future<void> deleteItem(int index) async {
    if (_storageBox != null) {
      await _storageBox!.deleteAt(index);
    } else {
      // Delete from Firestore (using Firestore document id)
      var docId = await _storageBox!.getAt(index)['id'];
      await _firestore.collection('storage').doc(docId).delete();
    }
    notifyListeners();
  }

  // Clear all items (from both local and cloud storage if needed)
  Future<void> clearAllItems() async {
    if (_storageBox != null) {
      await _storageBox!.clear();
    } else {
      // Clear Firestore collection
      await _firestore.collection('storage').get().then((snapshot) {
        for (var doc in snapshot.docs) {
          doc.reference.delete();
        }
      });
    }
    notifyListeners();
  }
}
