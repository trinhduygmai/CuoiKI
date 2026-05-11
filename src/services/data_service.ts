import { foodApi } from '../api/food_api';
import { userApi } from '../api/user_api';
import { categoryApi } from '../api/category_api';
import { Food, Category, User } from '../types/types';

export const dataService = {
  getAllPizzas: async (): Promise<Food[]> => {
    return await foodApi.getFoods();
  },
  
  getPizzaById: async (id: string): Promise<Food | undefined> => {
    return await foodApi.getFoodById(id);
  },
  
  getCategories: async (): Promise<Category[]> => {
    return await categoryApi.getCategories();
  },

  login: async (email: string, password: string): Promise<User | null> => {
    return await userApi.login(email, password);
  }
};
