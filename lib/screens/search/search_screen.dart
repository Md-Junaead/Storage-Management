import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:st_management/models/storage_item.dart';
import 'package:st_management/screens/add_item/add_item_screen.dart';
import 'package:st_management/services/storage_service.dart';

class ItemDetailsScreen extends StatelessWidget {
  final StorageItem item;

  const ItemDetailsScreen({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Item Details'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Item Name: ${item.name}',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text(
              'Quantity: ${item.quantity}',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 10),
            Text(
              'Category: ${item.category}',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Navigate to the Edit Item screen with the current item data
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AddItemScreen(item: item),
                  ),
                );
              },
              child: Text('Edit Item'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Delete the item
                Provider.of<StorageService>(context, listen: false)
                    .deleteItem(item.id);
                Navigator.pop(context); // Return to the previous screen
              },
              style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
              child: Text('Delete Item'),
            ),
          ],
        ),
      ),
    );
  }
}
