import 'package:flutter/material.dart';

class ProfilePage extends StatefulWidget {
  final String? username;
  final int? userId;
  final String? email_id;

  const ProfilePage({
    super.key,
    this.username,
    this.userId,
    this.email_id,
  });

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    // Print the fetched parameters to debug console
    print('Username: ${widget.username}');
    print('User ID: ${widget.userId}');
    print('Email ID: ${widget.email_id}');

    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile Page'),

      ),
      body: const Center(
        child: Text('Profile Page'),
      ),
    );
  }
}
