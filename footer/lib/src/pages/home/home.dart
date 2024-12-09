import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../profile.dart';
import '../wallet.dart';
import '../settings.dart';
import '../home/homecontent.dart';
import '../../auth/footer/footer.dart';

class HomePage extends StatefulWidget {
  final String? username;
  final int? userId;
  final String? email;

  const HomePage({
    super.key,
    required this.username,
    required this.userId,
    required this.email,
  });

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0; // Tracks the selected tab
  List<int> _navigationStack = [0]; // Initial stack with the Home tab

  // List of navigator keys for each tab
  late final List<GlobalKey<NavigatorState>> _navigatorKeys;

  // List of pages for the tabs
  late final List<Widget> _pages;

  @override
  void initState() {
    super.initState();
    _navigatorKeys = [
      GlobalKey<NavigatorState>(), // Home Navigator
      GlobalKey<NavigatorState>(), // Profile Navigator
      GlobalKey<NavigatorState>(), // Wallet Navigator
      GlobalKey<NavigatorState>(), // Settings Navigator
    ];

    _pages = [
      HomeContentPage(username: widget.username),
      ProfilePage(
        username: widget.username,
        userId: widget.userId,
        email_id: widget.email,
      ),
      walletpage(),
      settingspage(),
    ];
  }

  // Function to handle back button press behavior
  void _onBackPressed() {
    if (_navigatorKeys[_currentIndex].currentState!.canPop()) {
      // Pop from the current navigator stack
      _navigatorKeys[_currentIndex].currentState!.pop();
    } else if (_navigationStack.length > 1) {
      setState(() {
        _navigationStack.removeLast(); // Remove the current tab from the stack
        _currentIndex = _navigationStack.last; // Set the current index to the previous tab
      });
    } else if (_currentIndex == 0) {
      // Exit the app when on the Home tab and no more pages in the stack
      SystemNavigator.pop(); // Completely exits the app
    }
  }

  // Function to handle tab selection
  void _onTabSelected(int index) {
    if (_currentIndex != index) {
      setState(() {
        _navigationStack.add(index); // Add the new tab to the stack
        _currentIndex = index; // Update the current index
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: WillPopScope(
        onWillPop: () async {
          _onBackPressed(); // Handle back button press
          return false; // Prevent default back behavior
        },
        child: Navigator(
          key: _navigatorKeys[_currentIndex], // Use navigator key for each tab
          onGenerateRoute: (routeSettings) {
            // Generate the corresponding route for the current tab
            return MaterialPageRoute(
              builder: (context) => _pages[_currentIndex],
            );
          },
        ),
      ),
      bottomNavigationBar: Footer(
        currentIndex: _currentIndex,
        onTabSelected: _onTabSelected,
      ),
    );
  }
}
