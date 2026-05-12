import '../api/dio_client.dart';
import '../types/types.dart';

class CartApi {
  static Future<List<CartItem>> getCart() async {
    try {
      final response = await DioClient.instance.get('/cart');
      if (response.data['success'] == true) {
        final List items = response.data['data']['cart_items'] ?? [];
        return items.map((json) => CartItem.fromJson(json)).toList();
      }
      return [];
    } catch (e) {
      return [];
    }
  }

  static Future<bool> addToCart(String foodId, int quantity) async {
    try {
      await DioClient.instance.post('/add', data: {
        'menu_item_id': foodId,
        'quantity': quantity,
      });
      return true;
    } catch (e) {
      return false;
    }
  }

  static Future<bool> checkout() async {
    try {
      final response = await DioClient.instance.post('/checkout');
      return response.data['success'] == true;
    } catch (e) {
      return false;
    }
  }
}
