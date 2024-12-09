import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../provider/userdata.dart';
import '../../pages/home/home.dart';
import '../../auth/login.dart';
import 'dart:async';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    // Navigate to the main screen after a delay of 3 seconds
    Future.delayed(const Duration(seconds: 3), () {
      final userProvider = Provider.of<UserProvider>(context, listen: false);

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => (userProvider.username != null &&
              userProvider.userId != null &&
              userProvider.email != null)
              ? HomePage(
            username: userProvider.username,
            userId: userProvider.userId,
            email: userProvider.email,
          )
              : const LoginPage(),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        // When the back button is pressed, navigate to the previous screen
        Navigator.pop(context); // This pops the splash screen from the stack
        return false; // Prevent the default back button behavior of exiting the app
      },
      child: Scaffold(
        backgroundColor: Colors.black, // Background color for splash screen
        body: Center(
          child: AnimatedIconWidget(), // Custom blinking bolt icon widget
        ),
      ),
    );
  }
}

class AnimatedIconWidget extends StatefulWidget {
  @override
  _AnimatedIconWidgetState createState() => _AnimatedIconWidgetState();
}

class _AnimatedIconWidgetState extends State<AnimatedIconWidget> {
  bool _isBlinking = true;
  late Timer _timer;

  @override
  void initState() {
    super.initState();

    // Set up blinking effect with a timer
    _timer = Timer.periodic(const Duration(milliseconds: 500), (timer) {
      setState(() {
        _isBlinking = !_isBlinking;
      });
    });
  }

  @override
  void dispose() {
    _timer.cancel(); // Cancel timer on dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        // Blinking Bolt Icon
        AnimatedOpacity(
          opacity: _isBlinking ? 1.0 : 0.0,
          duration: const Duration(milliseconds: 300),
          child: Icon(
            Icons.bolt_outlined,
            size: 150,
            color: Colors.green,
          ),
        ),
        const SizedBox(height: 20), // Adjust space
        // Static Image
        Image.asset(
          'assets/EV_Power.png',
          width: 200,
          height: 200,
        ),
      ],
    );
  }
}
