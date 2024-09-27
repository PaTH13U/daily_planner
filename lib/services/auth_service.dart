import 'package:flutter/material.dart';

class AuthService with ChangeNotifier {
  bool _isLoggedIn = false;
  String? _currentUser;

  bool get isLoggedIn => _isLoggedIn;
  String? get currentUser => _currentUser;

  Future<bool> login(String email, String password) async {
    // Simulating actual authentication logic
    // Replace this with your actual authentication logic, e.g., API call
    if (email == "123" && password == "123") {
      await Future.delayed(const Duration(seconds: 2)); // Simulating network request
      _isLoggedIn = true;
      _currentUser = email;
      notifyListeners();
      return true;
    } else {
      await Future.delayed(const Duration(seconds: 2)); // Simulating network request
      _isLoggedIn = false;
      _currentUser = null;
      notifyListeners();
      return false;
    }
  }

  Future<bool> loginWithSSO() async {
    try {
      // Simulating SSO login logic
      // Replace this with your actual SSO authentication logic, e.g., API call to SSO provider
      await Future.delayed(const Duration(seconds: 2)); // Simulating SSO process
      _isLoggedIn = true;
      _currentUser =
          "sso_user@example.com"; // This should be replaced with the actual user email from SSO response
      notifyListeners();
      return true;
    } catch (e) {
      // Handle any errors that occur during the SSO process
      _isLoggedIn = false;
      _currentUser = null;
      notifyListeners();
      return false;
    }
  }

  void logout() {
    _isLoggedIn = false;
    _currentUser = null;
    notifyListeners();
  }
}
