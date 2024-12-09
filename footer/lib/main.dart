import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import './src/services/provider/userdata.dart';
import './src/services/splashscreen/SplashScreen.dart'; // Import the splash screen
import 'src/pages/home/home.dart';
import './src/auth/login.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    ChangeNotifierProvider(
      create: (context) => UserProvider()..loadUserData(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false, // Disable debug banner
      home: SplashScreen(), // Start with the SplashScreen
    );
  }
}
