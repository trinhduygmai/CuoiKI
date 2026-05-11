import { CartItem } from '../types/types';

export const cartApi = {
  saveCart: async (cart: CartItem[]): Promise<boolean> => {
    return new Promise((resolve) => {
      setTimeout(() => resolve(true), 200);
    });
  }
};
