import { Food, Category } from '../types/types';
import { CATEGORIES, MOCK_PIZZAS } from '../mocks/mockData';

export const categoryApi = {
  getCategories: async (): Promise<Category[]> => {
    return new Promise((resolve) => {
      setTimeout(() => resolve(CATEGORIES), 300);
    });
  }
};
