import '../api/dio_client.dart';
import '../types/types.dart';
import '../constants.dart';

class FoodApi {
  static Future<List<Food>> getPopularFoods() async {
    try {
      final response = await DioClient.instance.get('/restaurant/menu-items');
      final List data = response.data['data'] ?? [];
      return data.map((json) => Food.fromJson(json)).toList();
    } catch (e) {
      return [];
    }
  }

  static Future<List<Category>> getCategories() async {
    try {
      final response = await DioClient.instance.get('/restaurant/categories');
      final List data = response.data['data'] ?? [];
      return data.map((json) => Category.fromJson(json)).toList();
    } catch (e) {
      return [];
    }
  }

  static Future<Food?> getFoodById(String id) async {
    try {
      final response = await DioClient.instance.get('/restaurant/menu-items/$id');
      if (response.data['success'] == true) {
        return Food.fromJson(response.data['data']);
      }
      return null;
    } catch (e) {
      return null;
    }
  }

  static Future<List<Food>> getFoodsByCategory(String categoryId) async {
    try {
      final response = await DioClient.instance.get('/restaurant/menu-items/category/$categoryId');
      final List data = response.data['data'] ?? [];
      return data.map((json) => Food.fromJson(json)).toList();
    } catch (e) {
      return [];
    }
  }
}
