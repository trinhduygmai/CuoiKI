class UserModel {
  final String id;
  final String fullName;
  final String email;

  UserModel({required this.id, required this.fullName, required this.email});

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'] ?? '',
      fullName: json['fullName'] ?? '',
      email: json['email'] ?? '',
    );
  }
}

class FoodModel {
  final String id;
  final String name;
  final String price;
  final String image;
  final String category;
  final String description;

  FoodModel({
    required this.id,
    required this.name,
    required this.price,
    required this.image,
    required this.category,
    this.description = 'Chưa có mô tả cho món ăn này.',
  });

  factory FoodModel.fromJson(Map<String, dynamic> json) {
    return FoodModel(
      id: json['id']?.toString() ?? '',
      name: json['name'] ?? '',
      price: json['price']?.toString() ?? '0.00',
      image: json['image'] ?? '',
      category: json['category'] ?? '',
      description: json['description'] ?? 'Chưa có mô tả cho món ăn này.',
    );
  }
}

class CartItem {
  final FoodModel food;
  int quantity;

  CartItem({required this.food, this.quantity = 1});
}

class CategoryModel {
  final String id;
  final String name;
  final String image;

  CategoryModel({required this.id, required this.name, required this.image});

  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    return CategoryModel(
      id: json['id']?.toString() ?? '',
      name: json['name'] ?? '',
      image: json['image'] ?? '',
    );
  }
}

class AuthResponse {
  final String accessToken;
  final String refreshToken;
  final UserModel user;

  AuthResponse({
    required this.accessToken,
    required this.refreshToken,
    required this.user,
  });

  factory AuthResponse.fromJson(Map<String, dynamic> json) {
    return AuthResponse(
      accessToken: json['accessToken'] ?? '',
      refreshToken: json['refreshToken'] ?? '',
      user: UserModel.fromJson(json['user']),
    );
  }
}
