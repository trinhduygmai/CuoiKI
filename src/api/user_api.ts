import { User } from '../types/types';

export const userApi = {
  login: async (email: string, password: string): Promise<User | null> => {
    return new Promise((resolve) => {
      setTimeout(() => {
        resolve({ fullName: email.split('@')[0], email });
      }, 500);
    });
  },
  register: async (fullName: string, email: string, password: string): Promise<User | null> => {
    return new Promise((resolve) => {
      setTimeout(() => {
        resolve({ fullName, email });
      }, 500);
    });
  },
  forgotPassword: async (email: string): Promise<boolean> => {
    return new Promise((resolve) => {
      setTimeout(() => resolve(true), 500);
    });
  }
};
