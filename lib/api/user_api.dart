import '../api/dio_client.dart';
import '../types/types.dart';

class UserApi {
  static Future<AuthResponse?> login(String email, String password) async {
    try {
      final response =
          await DioClient.instance.post('/restaurant/login', data: {
        'email': email,
        'password': password,
      });
      return AuthResponse.fromJson(response.data);
    } catch (e) {
      return null;
    }
  }

  static Future<AuthResponse?> register(String email, String password) async {
    try {
      final response =
          await DioClient.instance.post('/restaurant/register', data: {
        'email': email,
        'password': password,
      });
      return AuthResponse.fromJson(response.data);
    } catch (e) {
      print('Registration error: $e');
      return null;
    }
  }

  static Future<User?> getCurrentUser() async {
    try {
      final response = await DioClient.instance.get('/restaurant/profile');
      if (response.data['success'] == true) {
        final userPayload =
            response.data['data'] ?? response.data['user'] ?? response.data;
        return User.fromJson(userPayload);
      }
      return null;
    } catch (e) {
      return null;
    }
  }

  static Future<bool> forgotPassword(String email) async {
    try {
      await DioClient.instance
          .post('/restaurant/forgot-password', data: {'email': email});
      return true;
    } catch (e) {
      return false;
    }
  }

  static Future<bool> resetPassword(String token, String password) async {
    try {
      await DioClient.instance.post('/restaurant/reset-password', data: {
        'token': token,
        'password': password,
      });
      return true;
    } catch (e) {
      return false;
    }
  }
}
