import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:st_management/screens/settings/edit_profile_screen.dart';
import 'package:st_management/services/auth_service.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
        actions: [
          IconButton(
            icon: Icon(Icons.exit_to_app),
            onPressed: () {
              // Trigger logout
              Provider.of<AuthService>(context, listen: false).logout();
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            ListTile(
              title: Text('Profile'),
              subtitle: Text('Edit your profile details'),
              leading: Icon(Icons.person),
              onTap: () {
                // Navigate to edit profile screen
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => EditProfileScreen()),
                );
              },
            ),
            ListTile(
              title: Text('Notifications'),
              subtitle: Text('Manage notification preferences'),
              leading: Icon(Icons.notifications),
              onTap: () {
                // Navigate to notification preferences screen (if implemented)
                // For now, no screen defined for notifications.
              },
            ),
            ListTile(
              title: Text('Help & Support'),
              subtitle: Text('Get assistance and support'),
              leading: Icon(Icons.help),
              onTap: () {
                // Navigate to help and support screen (if implemented)
                // For now, no screen defined for help and support.
              },
            ),
            Spacer(),
            ElevatedButton(
              onPressed: () {
                // Perform logout
                Provider.of<AuthService>(context, listen: false).logout();
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                minimumSize: Size(double.infinity, 50),
              ),
              child: Text('Logout'),
            ),
          ],
        ),
      ),
    );
  }
}
