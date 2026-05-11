export interface Category {
  id: string;
  title: string;
  image: string;
}

export interface Food {
  id: string;
  name: string;
  price: number;
  image: string;
  description: string;
  category: string;
  rating: number;
  kcal: number;
  time: number;
}

export interface CartItem extends Food {
  quantity: number;
  selectedSize: 'S' | 'M' | 'L';
}

export interface User {
  id: string;
  fullName: string;
  email: string;
}

export interface AuthResponse {
  accessToken: string;
  refreshToken: string;
  user: User;
}

export type Screen = 'details' | 'checkout' | 'order';
