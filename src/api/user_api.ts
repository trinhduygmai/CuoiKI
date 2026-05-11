import { User, AuthResponse } from '../types/types';
import axiosClient from './axios_client';
import { USE_MOCK_API } from '../constants';

export const userApi = {
  login: async (email: string, password: string): Promise<AuthResponse | null> => {
    if (USE_MOCK_API) {
      return new Promise((resolve) => {
        setTimeout(() => {
          resolve({
            accessToken: 'fake-jwt-token-' + Date.now(),
            refreshToken: 'fake-refresh-token-' + Date.now(),
            user: { id: '1', fullName: email.split('@')[0], email }
          });
        }, 500);
      });
    }

    try {
      const response = await axiosClient.post<AuthResponse>('/login', { email, password });
      return response as any; // axiosClient interceptor returns data directly
    } catch (error) {
      console.error('Login error:', error);
      return null;
    }
  },

  getCurrentUser: async (): Promise<User | null> => {
    if (USE_MOCK_API) {
      return new Promise((resolve) => {
        setTimeout(() => {
          resolve({ id: '1', fullName: 'John Doe', email: 'john@example.com' });
        }, 300);
      });
    }

    try {
      const response = await axiosClient.get<User>('/profile');
      return response as any;
    } catch (error) {
      console.error('Get profile error:', error);
      return null;
    }
  },

  register: async (fullName: string, email: string, password: string): Promise<AuthResponse | null> => {
    if (USE_MOCK_API) {
      return new Promise((resolve) => {
        setTimeout(() => {
          resolve({
            accessToken: 'fake-jwt-token-' + Date.now(),
            refreshToken: 'fake-refresh-token-' + Date.now(),
            user: { id: '2', fullName, email }
          });
        }, 500);
      });
    }

    try {
      const response = await axiosClient.post<AuthResponse>('/register', { fullName, email, password });
      return response as any;
    } catch (error) {
      return null;
    }
  },

  forgotPassword: async (email: string): Promise<boolean> => {
    if (USE_MOCK_API) {
      return new Promise((resolve) => {
        setTimeout(() => resolve(true), 500);
      });
    }

    try {
      await axiosClient.post('/forgot-password', { email });
      return true;
    } catch (error) {
      return false;
    }
  },

  resetPassword: async (email: string, code: string, password: string): Promise<boolean> => {
    if (USE_MOCK_API) {
      return new Promise((resolve) => {
        setTimeout(() => resolve(true), 500);
      });
    }

    try {
      await axiosClient.post('/reset-password', { email, code, password });
      return true;
    } catch (error) {
      return false;
    }
  }
};
