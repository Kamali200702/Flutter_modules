import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserProvider extends ChangeNotifier {
  int? _userId;
  String? _username;
  String? _email;
  bool _isLoading = true; // Add loading state

  int? get userId => _userId;
  String? get username => _username;
  String? get email => _email;
  bool get isLoading => _isLoading;

  void setUserData(int userId, String username, String email) async {
    _userId = userId;
    _username = username;
    _email = email;

    // Save session data locally
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('userId', userId);
    await prefs.setString('username', username);
    await prefs.setString('email', email);

    _isLoading = false; // Stop loading
    notifyListeners();
  }

  Future<void> loadUserData() async {
    final prefs = await SharedPreferences.getInstance();
    _userId = prefs.getInt('userId');
    _username = prefs.getString('username');
    _email = prefs.getString('email');

    _isLoading = false; // Stop loading
    notifyListeners();
  }

  void clearUserData() async {
    _userId = null;
    _username = null;
    _email = null;

    // Clear session data locally
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();

    _isLoading = false; // Stop loading
    notifyListeners();
  }
}

