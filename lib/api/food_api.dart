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
      final response = await DioClient.instance.get('/menu-items');
      final List data = response.data;
      return data.map((json) => Food.fromJson(json)).toList();
    } catch (e) {
      return [];
    }
  }

  static Future<List<Category>> getCategories() async {
    if (USE_MOCK_API) {
      await Future.delayed(const Duration(milliseconds: 500));
      return [
        Category(id: '1', name: 'Italian', image: 'https://images.unsplash.com/photo-1546069901-ba9599a7e63c?w=100&h=100&fit=crop'),
        Category(id: '2', name: 'Chinese', image: 'https://images.unsplash.com/photo-1512621776951-a57141f2eefd?w=100&h=100&fit=crop'),
        Category(id: '3', name: 'Japanese', image: 'https://images.unsplash.com/photo-1555939594-58d7cb561ad1?w=100&h=100&fit=crop'),
        Category(id: '4', name: 'Vietnamese', image: 'https://images.unsplash.com/photo-1540189549336-e6e99c3679fe?w=100&h=100&fit=crop'),
      ];
    }

    try {
      final response = await DioClient.instance.get('/categories');
      final List data = response.data;
      return data.map((json) => Category.fromJson(json)).toList();
    } catch (e) {
      return [];
    }
  }

  static Future<Food?> getFoodById(String id) async {
    if (USE_MOCK_API) {
      return null;
    }
    try {
      final response = await DioClient.instance.get('/menu-items/$id');
      return Food.fromJson(response.data);
    } catch (e) {
      return null;
    }
  }

  static Future<List<Food>> getFoodsByCategory(String categoryId) async {
    if (USE_MOCK_API) {
      await Future.delayed(const Duration(milliseconds: 500));
      return [
        Food(
          id: '10',
          name: 'Special Item',
          price: '15.99',
          image: 'https://images.unsplash.com/photo-1546069901-ba9599a7e63c?w=400&h=300&fit=crop',
          category: 'Selected',
        ),
      ];
    }

    try {
      final response = await DioClient.instance.get('/menu-items/category/$categoryId');
      final List data = response.data;
      return data.map((json) => Food.fromJson(json)).toList();
    } catch (e) {
      return [];
    }
  }
}
