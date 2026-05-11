import { userApi } from '../api/user_api';
import { tokenService } from './token_service';
import { AuthResponse } from '../types/types';

export const authService = {
  login: async (email: string, password: string): Promise<AuthResponse> => {
    const response = await userApi.login(email, password);
    if (response) {
      tokenService.saveAccessToken(response.accessToken);
      tokenService.saveRefreshToken(response.refreshToken);
      return response;
    }
    throw new Error('Login failed');
  },
  
  logout: () => {
    tokenService.clearTokens();
  },

  checkAuth: async () => {
    const token = tokenService.getAccessToken();
    if (!token) return null;
    
    try {
      // In a real app, you would verify the token with the backend
      // and maybe get the updated user profile.
      // For now, we'll just check if it exists.
      return await userApi.getCurrentUser();
    } catch (error) {
      tokenService.clearTokens();
      return null;
    }
  }
};
