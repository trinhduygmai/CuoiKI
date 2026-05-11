import 'package:flutter/material.dart';
import '../services/token_service.dart';
import '../services/auth_service.dart';
import '../types/types.dart';

class GlobalProvider extends ChangeNotifier {
  User? _currentUser;
  bool _isLoading = true;
  final List<CartItem> _cartItems = [];

  User? get currentUser => _currentUser;
  bool get isLoading => _isLoading;
  bool get isAuthenticated => _currentUser != null;
  List<CartItem> get cartItems => _cartItems;
  double get totalAmount => _cartItems.fold(0, (sum, item) => sum + (double.parse(item.food.price) * item.quantity));

  void addToCart(Food food, {int quantity = 1}) {
    final index = _cartItems.indexWhere((item) => item.food.id == food.id);
    if (index >= 0) {
      _cartItems[index].quantity += quantity;
    } else {
      _cartItems.add(CartItem(food: food, quantity: quantity));
    }
    notifyListeners();
  }

  void removeFromCart(String foodId) {
    _cartItems.removeWhere((item) => item.food.id == foodId);
    notifyListeners();
  }

  void updateQuantity(String foodId, int quantity) {
    if (quantity <= 0) {
      removeFromCart(foodId);
      return;
    }
    final index = _cartItems.indexWhere((item) => item.food.id == foodId);
    if (index >= 0) {
      _cartItems[index].quantity = quantity;
      notifyListeners();
    }
  }

  void clearCart() {
    _cartItems.clear();
    notifyListeners();
  }

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

  Future<bool> register(String fullName, String email, String password) async {
    try {
      final response = await AuthService.register(fullName, email, password);
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

  Future<bool> forgotPassword(String email) async {
    return await AuthService.forgotPassword(email);
  }

  Future<bool> resetPassword(String token, String password) async {
    return await AuthService.resetPassword(token, password);
  }
}
