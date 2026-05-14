import 'package:unorm_dart/unorm_dart.dart' as unorm;

String normalizeText(String? text) {
  if (text == null || text.isEmpty) return '';
  return unorm.nfc(text);
}

class User {
  final String id;
  final String fullName;
  final String email;
  final String? profileImage;

  User({
    required this.id,
    required this.fullName,
    required this.email,
    this.profileImage,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    // Check if we are receiving the root login response or the nested user object
    final Map<String, dynamic> userMap = json['user'] ?? json;
    final Map<String, dynamic> profileMap = json['profile'] ?? {};
    final Map<String, dynamic> metadata =
        userMap['user_metadata'] ?? userMap['metadata'] ?? {};

    return User(
      id: userMap['id'] ?? '',
      fullName: normalizeText(profileMap['full_name'] ??
          metadata['full_name'] ??
          userMap['fullName'] ??
          'User'),
      email: normalizeText(userMap['email'] ?? ''),
      profileImage: profileMap['avatar_url'] ?? metadata['avatar_url'],
    );
  }
}

class Food {
  final String id;
  final String name;
  final String price;
  final String image;
  final String categoryName;
  final String description;

  Food({
    required this.id,
    required this.name,
    required this.price,
    required this.image,
    required this.categoryName,
    this.description = 'Chưa có mô tả cho món ăn này.',
  });

  factory Food.fromJson(Map<String, dynamic> json) {
    // Handle nested categories(name) from Supabase
    String catName = '';
    if (json['categories'] != null && json['categories'] is Map) {
      catName = json['categories']['name'] ?? '';
    } else {
      catName = json['category_name'] ?? json['category'] ?? '';
    }

    return Food(
      id: json['id']?.toString() ?? '',
      name: normalizeText(json['name'] ?? ''),
      price: json['price']?.toString() ?? '0.00',
      image: json['image_url'] ?? json['image'] ?? '',
      categoryName: normalizeText(catName),
      description:
          normalizeText(json['description'] ?? 'Chưa có mô tả cho món ăn này.'),
    );
  }
}

class CartItem {
  final Food food;
  int quantity;

  CartItem({required this.food, this.quantity = 1});

  factory CartItem.fromJson(Map<String, dynamic> json) {
    final menuItem = json['menu_items'];
    return CartItem(
      food: Food.fromJson(menuItem),
      quantity: json['quantity'] ?? 1,
    );
  }
}

class Category {
  final String id;
  final String name;
  final String image;

  Category({required this.id, required this.name, required this.image});

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      id: json['id']?.toString() ?? '',
      name: normalizeText(json['name'] ?? ''),
      image: json['image_url'] ?? json['image'] ?? '',
    );
  }
}

class AuthResponse {
  final String accessToken;
  final String refreshToken;
  final User user;

  AuthResponse({
    required this.accessToken,
    required this.refreshToken,
    required this.user,
  });

  factory AuthResponse.fromJson(Map<String, dynamic> json) {
    return AuthResponse(
      accessToken: json['access_token'] ?? json['accessToken'] ?? '',
      refreshToken: json['refresh_token'] ?? json['refreshToken'] ?? '',
      user: User.fromJson(
          json), // Passed entire root to pick up profile/user keys
    );
  }
}
