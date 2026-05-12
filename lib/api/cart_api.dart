import '../api/dio_client.dart';
import '../types/types.dart';

class CartApi {
  static Future<List<CartItem>> getCart() async {
    try {
      final response = await DioClient.instance.get('/cart');
      final List data = response.data;
      return data.map((json) {
        // Assuming the API returns full food object or we can map it
        return CartItem(
          food: FoodModel.fromJson(json['food']),
          quantity: json['quantity'] ?? 1,
        );
      }).toList();
    } catch (e) {
      return [];
    }
  }

  static Future<bool> addToCart(String foodId, int quantity) async {
    try {
      await DioClient.instance.post('/add', data: {
        'foodId': foodId,
        'quantity': quantity,
      });
      return true;
    } catch (e) {
      return false;
    }
  }

  static Future<bool> checkout() async {
    try {
      await DioClient.instance.post('/checkout');
      return true;
    } catch (e) {
      return false;
    }
  }
}
