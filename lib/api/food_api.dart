import '../api/dio_client.dart';
import '../types/types.dart';
import '../constants.dart';

class FoodApi {
  static Future<List<Food>> getPopularFoods() async {
    if (USE_MOCK_API) {
      await Future.delayed(const Duration(milliseconds: 500));
      return [
        Food(
          id: '1',
          name: 'Pepperoni Supreme',
          price: '12.00',
          image: 'https://images.unsplash.com/photo-1513104890138-7c749659a591?w=400&h=300&fit=crop',
          category: 'Pizza',
        ),
        Food(
          id: '2',
          name: 'Dim Sum Mix',
          price: '35.00',
          image: 'https://images.unsplash.com/photo-1498654896293-37aacf113fd9?w=400&h=300&fit=crop',
          category: 'Chinese',
        ),
        Food(
          id: '3',
          name: 'Sushi Sashimi Duo',
          price: '45.00',
          image: 'https://images.unsplash.com/photo-1579871494447-9811cf80d66c?w=400&h=300&fit=crop',
          category: 'Japanese',
        ),
      ];
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
      await Future.delayed(const Duration(milliseconds: 500));
      return [
        Food(
          id: '10',
          name: '$category Special',
          price: '15.99',
          image: 'https://images.unsplash.com/photo-1546069901-ba9599a7e63c?w=400&h=300&fit=crop',
          category: category,
        ),
        Food(
          id: '11',
          name: 'Classic $category',
          price: '10.50',
          image: 'https://images.unsplash.com/photo-1512621776951-a57141f2eefd?w=400&h=300&fit=crop',
          category: category,
        ),
      ];
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
