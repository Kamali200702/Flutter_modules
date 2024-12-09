import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../services/provider/userdata.dart'; // Replace with your actual provider import
import '../../auth/login.dart'; // Replace with your LoginPage import

class HomeContentPage extends StatefulWidget {
  final String? username;
  final int? userId;
  final String? email;

  const HomeContentPage({
    super.key,
    this.username,
    this.userId,
    this.email,
  });

  @override
  State<HomeContentPage> createState() => _HomeContentPageState();
}

class _HomeContentPageState extends State<HomeContentPage> {
  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Page'),
        actions: [
          IconButton(
            icon: const Icon(
              Icons.logout,
              color: Colors.red,
            ),
            onPressed: () {
              // Clear user data from the provider
              userProvider.clearUserData();

              // Navigate back to the login page
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => const LoginPage(),
                ),
              );
            },
          ),
        ],
      ),
      body: Center(
        child: Text(
          'Welcome, ${widget.username ?? 'Guest'}!',
          style: const TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}
