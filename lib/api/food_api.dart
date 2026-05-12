import '../api/dio_client.dart';
import '../types/types.dart';
import '../constants.dart';

class FoodApi {
  static Future<List<FoodModel>> getPopularFoods() async {
    try {
      final response = await DioClient.instance.get('/restaurant/menu-items');
      final List data = response.data;
      return data.map((json) => FoodModel.fromJson(json)).toList();
    } catch (e) {
      return [];
    }
  }

  static Future<List<CategoryModel>> getCategories() async {
    try {
      final response = await DioClient.instance.get('/restaurant/categories');
      final List data = response.data;
      return data.map((json) => CategoryModel.fromJson(json)).toList();
    } catch (e) {
      return [];
    }
  }

  static Future<FoodModel?> getFoodById(String id) async {
    try {
      final response = await DioClient.instance.get('/restaurant/menu-items/$id');
      return FoodModel.fromJson(response.data);
    } catch (e) {
      return null;
    }
  }

  static Future<List<FoodModel>> getFoodsByCategory(String categoryId) async {
    try {
      final response = await DioClient.instance.get('/restaurant/menu-items/category/$categoryId');
      final List data = response.data;
      return data.map((json) => FoodModel.fromJson(json)).toList();
    } catch (e) {
      return [];
    }
  }
}
