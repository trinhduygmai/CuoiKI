const ACCESS_TOKEN_KEY = 'food_delivery_access_token';
const REFRESH_TOKEN_KEY = 'food_delivery_refresh_token';

export const tokenService = {
  saveAccessToken: (token: string) => {
    localStorage.setItem(ACCESS_TOKEN_KEY, token);
  },
  getAccessToken: () => {
    return localStorage.getItem(ACCESS_TOKEN_KEY);
  },
  saveRefreshToken: (token: string) => {
    localStorage.setItem(REFRESH_TOKEN_KEY, token);
  },
  getRefreshToken: () => {
    return localStorage.getItem(REFRESH_TOKEN_KEY);
  },
  clearTokens: () => {
    localStorage.removeItem(ACCESS_TOKEN_KEY);
    localStorage.removeItem(REFRESH_TOKEN_KEY);
  }
};
