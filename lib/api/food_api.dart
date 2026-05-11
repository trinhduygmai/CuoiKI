import '../api/dio_client.dart';
import '../types/types.dart';
import '../constants.dart';

class FoodApi {
  static Future<List<Food>> getPopularFoods() async {
    if (USE_MOCK_API) {
      return []; // We are removing mocks, but keeping the structure
    }

    try {
      final response = await DioClient.instance.get('/foods'); // Adjust endpoint as needed
      final List data = response.data;
      return data.map((json) => Food.fromJson(json)).toList();
    } catch (e) {
      return [];
    }
  }

  static Future<List<Food>> getFoodsByCategory(String category) async {
    if (USE_MOCK_API) {
      return [];
    }

    try {
      final response = await DioClient.instance.get('/foods', queryParameters: {'category': category});
      final List data = response.data;
      return data.map((json) => Food.fromJson(json)).toList();
    } catch (e) {
      return [];
    }
  }
}
