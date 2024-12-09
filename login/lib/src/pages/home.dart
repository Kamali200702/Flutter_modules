import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../services/provider/userdata.dart'; // Import the provider class
import '../auth/login.dart'; // Import the login page

class HomePage extends StatelessWidget {
  final String? username;
  final int? userId;
  final String? email;

  const HomePage({super.key, required this.username, this.userId, required this.email});

  @override
  Widget build(BuildContext context) {
    // Get user data from the provider
    final userProvider = Provider.of<UserProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Page'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout,color: Colors.red,),
            onPressed: () {
              // Clear user data from the provider
              userProvider.clearUserData();

              // Navigate back to the login page
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const LoginPage()),
              );
            },
          ),
        ],
      ),
      body: Center(
        child: Text(
          'Welcome, ${userProvider.username ?? 'Guest'}!',
          style: const TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}
