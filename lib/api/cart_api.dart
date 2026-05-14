import 'package:flutter/foundation.dart';
import '../api/dio_client.dart';
import '../types/types.dart';

bool _isSuccess(dynamic value) {
  if (value is bool) return value;
  if (value is num) return value != 0;
  if (value is String) {
    final normalized = value.toLowerCase().trim();
    return normalized == 'true' || normalized == '1';
  }
  return false;
}

dynamic _resolveSuccess(dynamic responseData) {
  if (responseData == null) return null;
  if (responseData is Map) {
    if (responseData.containsKey('success')) {
      return responseData['success'];
    }
    if (responseData.containsKey('data') && responseData['data'] is Map) {
      return responseData['data']['success'];
    }
  }
  return responseData;
}

class CartApi {
  static Future<List<CartItem>> getCart() async {
    try {
      final response = await DioClient.instance.get('/restaurant/cart');
      if (response.data['success'] == true) {
        final List items =
            response.data['data']['cart_items'] ?? response.data['data'] ?? [];
        return items
            .map((json) => CartItem.fromJson(json))
            .where((item) => item.quantity > 0)
            .toList();
      }
      return [];
    } catch (e) {
      debugPrint('Get cart error: $e');
      return [];
    }
  }

  static Future<bool> addToCart(String foodId, int quantity) async {
    try {
      final response = await DioClient.instance.post('/restaurant/add', data: {
        'menu_item_id': foodId,
        'quantity': quantity,
      });
      return _isSuccess(_resolveSuccess(response.data));
    } catch (e) {
      debugPrint('Add to cart error: $e');
      return false;
    }
  }

  static Future<bool> checkout() async {
    try {
      final response = await DioClient.instance.post('/restaurant/checkout');
      return _isSuccess(_resolveSuccess(response.data));
    } catch (e) {
      debugPrint('Checkout error: $e');
      return false;
    }
  }
}
