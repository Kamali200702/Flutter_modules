import 'package:flutter/material.dart';
import './src/auth/login.dart';
import 'package:provider/provider.dart';
import './src/services/provider/userdata.dart';
import './src/pages/home.dart';

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
    return Consumer<UserProvider>(
      builder: (context, userProvider, _) {
        if (userProvider.isLoading) {
          // Show a loading screen while session data is loading
          return MaterialApp(
            debugShowCheckedModeBanner: false, // Disable debug banner
            home: Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            ),
          );
        }

        // Navigate based on session data
        return MaterialApp(
          debugShowCheckedModeBanner: false, // Disable debug banner
          home: (userProvider.username != null &&
              userProvider.userId != null &&
              userProvider.email != null)
              ? HomePage(
            username: userProvider.username,
            userId: userProvider.userId,
            email: userProvider.email,
          )
              : const LoginPage(),
        );
      },
    );
  }
}
