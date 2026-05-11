import { Food } from '../types/types';
import { MOCK_PIZZAS } from '../mocks/mockData';

export const foodApi = {
  getFoods: async (): Promise<Food[]> => {
    return new Promise((resolve) => {
      setTimeout(() => resolve(MOCK_PIZZAS), 300);
    });
  },
  getFoodById: async (id: string): Promise<Food | undefined> => {
    return new Promise((resolve) => {
      setTimeout(() => resolve(MOCK_PIZZAS.find(f => f.id === id)), 100);
    });
  }
};
