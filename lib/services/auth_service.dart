import '../api/user_api.dart';
import 'token_service.dart';
import '../types/types.dart';

class AuthService {
  static Future<AuthResponse> login(String email, String password) async {
    final response = await UserApi.login(email, password);
    if (response != null) {
      await TokenService.saveAccessToken(response.accessToken);
      await TokenService.saveRefreshToken(response.refreshToken);
      return response;
    }
    throw Exception('Login failed');
  }

  static Future<AuthResponse> register(String fullName, String email, String password) async {
    final response = await UserApi.register(fullName, email, password);
    if (response != null) {
      await TokenService.saveAccessToken(response.accessToken);
      await TokenService.saveRefreshToken(response.refreshToken);
      return response;
    }
    throw Exception('Registration failed');
  }

  static Future<void> logout() async {
    await TokenService.clearTokens();
  }

  static Future<User?> checkAuth() async {
    final token = await TokenService.getAccessToken();
    if (token == null) return null;
    
    try {
      return await UserApi.getCurrentUser();
    } catch (e) {
      await TokenService.clearTokens();
      return null;
    }
  }
}
