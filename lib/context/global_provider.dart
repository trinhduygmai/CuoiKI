import 'package:flutter/material.dart';
import '../services/token_service.dart';
import '../services/auth_service.dart';
import '../types/types.dart';

class GlobalProvider extends ChangeNotifier {
  User? _currentUser;
  bool _isLoading = true;

  User? get currentUser => _currentUser;
  bool get isLoading => _isLoading;
  bool get isAuthenticated => _currentUser != null;

  Future<void> checkAuth() async {
    _isLoading = true;
    notifyListeners();

    try {
      final user = await AuthService.checkAuth();
      _currentUser = user;
    } catch (e) {
      _currentUser = null;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<bool> login(String email, String password) async {
    try {
      final response = await AuthService.login(email, password);
      _currentUser = response.user;
      notifyListeners();
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<void> logout() async {
    await AuthService.logout();
    _currentUser = null;
    notifyListeners();
  }
}
