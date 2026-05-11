import { foodApi } from '../api/food_api';
import { userApi } from '../api/user_api';
import { categoryApi } from '../api/category_api';
import { foodApi as pizzaApi } from '../api/food_api'; // For backward compatibility if needed
import { authService } from './auth_service';
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
    try {
      const response = await authService.login(email, password);
      return response.user;
    } catch (error) {
      return null;
    }
  }
};
