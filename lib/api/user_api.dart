import '../api/dio_client.dart';
import '../types/types.dart';
import '../constants.dart';

class UserApi {
  static Future<AuthResponse?> login(String email, String password) async {
    if (USE_MOCK_API) {
      await Future.delayed(const Duration(milliseconds: 500));
      return AuthResponse(
        accessToken: 'fake-jwt-token-${DateTime.now().millisecondsSinceEpoch}',
        refreshToken: 'fake-refresh-token-${DateTime.now().millisecondsSinceEpoch}',
        user: User(id: '1', fullName: email.split('@')[0], email: email),
      );
    }

    try {
      final response = await DioClient.instance.post('/login', data: {
        'email': email,
        'password': password,
      });
      return AuthResponse.fromJson(response.data);
    } catch (e) {
      return null;
    }
  }

  static Future<AuthResponse?> register(String fullName, String email, String password) async {
    if (USE_MOCK_API) {
      await Future.delayed(const Duration(milliseconds: 500));
      return AuthResponse(
        accessToken: 'fake-jwt-token-${DateTime.now().millisecondsSinceEpoch}',
        refreshToken: 'fake-refresh-token-${DateTime.now().millisecondsSinceEpoch}',
        user: User(id: '1', fullName: fullName, email: email),
      );
    }

    try {
      final response = await DioClient.instance.post('/register', data: {
        'fullName': fullName,
        'email': email,
        'password': password,
      });
      return AuthResponse.fromJson(response.data);
    } catch (e) {
      return null;
    }
  }

  static Future<User?> getCurrentUser() async {
    if (USE_MOCK_API) {
      await Future.delayed(const Duration(milliseconds: 300));
      return User(id: '1', fullName: 'John Doe', email: 'john@example.com');
    }

    try {
      final response = await DioClient.instance.get('/profile');
      return User.fromJson(response.data);
    } catch (e) {
      return null;
    }
  }

  static Future<bool> forgotPassword(String email) async {
    try {
      await DioClient.instance.post('/forgot-password', data: {'email': email});
      return true;
    } catch (e) {
      return false;
    }
  }

  static Future<bool> resetPassword(String token, String password) async {
    try {
      await DioClient.instance.post('/reset-password', data: {
        'token': token,
        'password': password,
      });
      return true;
    } catch (e) {
      return false;
    }
  }
}
