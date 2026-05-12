import 'package:flutter/material.dart';
import '../services/token_service.dart';
import '../services/auth_service.dart';
import '../api/food_api.dart';
import '../api/cart_api.dart';
import '../types/types.dart';

class GlobalProvider extends ChangeNotifier {
  User? _currentUser;
  bool _isLoading = true;
  List<CartItem> _cartItems = [];
  List<Category> _categories = [];
  List<Food> _foods = [];
  bool _isDataLoading = false;

  User? get currentUser => _currentUser;
  bool get isLoading => _isLoading;
  bool get isDataLoading => _isDataLoading;
  bool get isAuthenticated => _currentUser != null;
  List<CartItem> get cartItems => _cartItems;
  List<Category> get categories => _categories;
  List<Food> get foods => _foods;
  double get totalAmount => _cartItems.fold(0, (sum, item) => sum + (double.parse(item.food.price) * item.quantity));

  Future<void> fetchCategories() async {
    _isDataLoading = true;
    notifyListeners();
    try {
      _categories = await FoodApi.getCategories();
    } catch (e) {
      _categories = [];
    } finally {
      _isDataLoading = false;
      notifyListeners();
    }
  }

  Future<void> fetchFoodsByCategory(String categoryId) async {
    _isDataLoading = true;
    notifyListeners();
    try {
      _foods = await FoodApi.getFoodsByCategory(categoryId);
    } catch (e) {
      _foods = [];
    } finally {
      _isDataLoading = false;
      notifyListeners();
    }
  }

  Future<Food?> fetchFoodDetail(String id) async {
    return await FoodApi.getFoodById(id);
  }

  Future<void> getCart() async {
    if (!isAuthenticated) return;
    try {
      _cartItems = await CartApi.getCart();
      notifyListeners();
    } catch (e) {
      print('Failed to fetch cart: $e');
    }
  }

  Future<bool> addToCart(Food food, {int quantity = 1}) async {
    if (!isAuthenticated) return false;
    
    final success = await CartApi.addToCart(food.id, quantity);
    if (success) {
      await getCart(); // Refresh cart from server
      return true;
    }
    return false;
  }

  Future<bool> checkout() async {
    if (!isAuthenticated) return false;
    final success = await CartApi.checkout();
    if (success) {
      _cartItems.clear();
      notifyListeners();
      return true;
    }
    return false;
  }

  void updateQuantityLocal(String foodId, int quantity) {
    if (quantity <= 0) {
      _cartItems.removeWhere((item) => item.food.id == foodId);
    } else {
      final index = _cartItems.indexWhere((item) => item.food.id == foodId);
      if (index >= 0) {
        _cartItems[index].quantity = quantity;
      }
    }
    notifyListeners();
  }

  void removeFromCartLocal(String foodId) {
    _cartItems.removeWhere((item) => item.food.id == foodId);
    notifyListeners();
  }

  Future<void> checkAuth() async {
    _isLoading = true;
    notifyListeners();

    try {
      final user = await AuthService.checkAuth();
      _currentUser = user;
      if (_currentUser != null) {
        await getCart();
      }
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
      await getCart();
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
      await getCart();
      notifyListeners();
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<void> logout() async {
    await AuthService.logout();
    _currentUser = null;
    _cartItems.clear();
    notifyListeners();
  }

  Future<bool> forgotPassword(String email) async {
    return await AuthService.forgotPassword(email);
  }

  Future<bool> resetPassword(String token, String password) async {
    return await AuthService.resetPassword(token, password);
  }
}
