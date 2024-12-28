import 'package:hive/hive.dart';

@HiveType(typeId: 0)
class StorageItem {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String name;

  @HiveField(2)
  final int quantity;

  @HiveField(3)
  final String category;

  StorageItem({
    required this.id,
    required this.name,
    required this.quantity,
    required this.category,
  });

  // Method to convert StorageItem to Map (useful for saving to Firebase or other APIs)
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'quantity': quantity,
      'category': category,
    };
  }

  // Factory method to create StorageItem from a Map
  factory StorageItem.fromMap(Map<String, dynamic> map) {
    return StorageItem(
      id: map['id'] ?? '',
      name: map['name'] ?? '',
      quantity: map['quantity'] ?? 0,
      category: map['category'] ?? '',
    );
  }
}
