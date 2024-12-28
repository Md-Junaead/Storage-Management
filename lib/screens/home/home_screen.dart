import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:st_management/services/auth_service.dart';
import 'package:st_management/widgets/bottom_nav_bar.dart';
import 'package:st_management/widgets/drawer_menu.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // Here, you can add logic for fetching the user's current location if needed
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Home"),
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () {
              // Call logout method from AuthService
              Provider.of<AuthService>(context, listen: false).logout();
            },
          )
        ],
      ),

      drawer: DrawerMenu(),
      body: Column(
        children: [
          // Search bar to enter destination (removed Google Map)
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                labelText: 'Search destination...',
                border: OutlineInputBorder(),
                suffixIcon: Icon(Icons.search),
              ),
            ),
          ),
          // Recent/Upcoming trips section
          Expanded(
            child: ListView.builder(
              itemCount: 5, // Example, replace with actual data
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text("Trip #$index"),
                  subtitle: Text("Details of the trip."),
                  trailing: Icon(Icons.arrow_forward),
                  onTap: () {
                    // Navigate to booking details
                    Navigator.pushNamed(context, '/bookingDetails');
                  },
                );
              },
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavBar(), // Custom bottom navigation bar
    );
  }
}
