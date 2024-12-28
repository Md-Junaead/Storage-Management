import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'screens/onboarding/splash_screen.dart'; // Splash Screen
import 'screens/auth/login_screen.dart'; // Login Screen
import 'screens/home/home_screen.dart'; // Home Screen
import 'screens/settings/settings_screen.dart'; // Settings Screen
import 'services/auth_service.dart'; // Auth Service
import 'services/storage_service.dart'; // Storage Service

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(); // Initialize Firebase
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthService()),
        ChangeNotifierProvider(create: (_) => StorageService()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Nelsis App',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        initialRoute: '/home', // Initial screen set to splash screen
        routes: {
          '/splash': (context) => const SplashScreen(), // Splash Screen route
          '/login': (context) => const LoginScreen(), // Login Screen route
          '/home': (context) => const HomeScreen(), // Home Screen route
          '/settings': (context) =>
              const SettingsScreen(), // Settings Screen route
        },
      ),
    );
  }
}
