import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:st_management/models/storage_item.dart';
import 'package:st_management/services/storage_service.dart';
import 'package:uuid/uuid.dart';

class AddItemScreen extends StatefulWidget {
  final StorageItem? item; // Optional, for editing existing item
  const AddItemScreen({super.key, this.item});

  @override
  _AddItemScreenState createState() => _AddItemScreenState();
}

class _AddItemScreenState extends State<AddItemScreen> {
  final _nameController = TextEditingController();
  final _quantityController = TextEditingController();
  String _category = 'Electronics'; // Default category
  bool _isEditing = false;

  @override
  void initState() {
    super.initState();
    if (widget.item != null) {
      _isEditing = true;
      _nameController.text = widget.item!.name;
      _quantityController.text = widget.item!.quantity.toString();
      _category = widget.item!.category;
    }
  }

  void _saveItem() {
    final uuid = Uuid();
    final item = StorageItem(
      id: _isEditing ? widget.item!.id : uuid.v4(), // Generate ID for new items
      name: _nameController.text,
      quantity: int.parse(_quantityController.text),
      category: _category,
    );

    if (_isEditing) {
      // Update the item
      Provider.of<StorageService>(context, listen: false).updateItem(item);
    } else {
      // Add new item
      Provider.of<StorageService>(context, listen: false).addItem(item);
    }

    Navigator.pop(context); // Close the screen after saving
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_isEditing ? 'Edit Item' : 'Add Item'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: _nameController,
              decoration: InputDecoration(labelText: 'Item Name'),
            ),
            TextField(
              controller: _quantityController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(labelText: 'Quantity'),
            ),
            DropdownButton<String>(
              value: _category,
              onChanged: (String? newCategory) {
                setState(() {
                  _category = newCategory!;
                });
              },
              items: <String>['Electronics', 'Books', 'Clothes', 'Furniture']
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _saveItem,
              child: Text(_isEditing ? 'Save Changes' : 'Add Item'),
            ),
          ],
        ),
      ),
    );
  }
}
