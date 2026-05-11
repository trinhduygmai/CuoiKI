import React, { createContext, useContext, useState, ReactNode, useEffect } from 'react';
import { User, CartItem, Category } from '../types/types';
import { CATEGORIES } from '../mocks/mockData';
import { authService } from '../services/auth_service';
import { tokenService } from '../services/token_service';

interface GlobalContextType {
  user: User | null;
  setUser: (user: User | null) => void;
  cart: CartItem[];
  setCart: React.Dispatch<React.SetStateAction<CartItem[]>>;
  categories: Category[];
  isLoading: boolean;
  setIsLoading: (loading: boolean) => void;
  isDrawerOpen: boolean;
  setIsDrawerOpen: (open: boolean) => void;
  logout: () => void;
  isAuthenticated: boolean;
}

const GlobalContext = createContext<GlobalContextType | undefined>(undefined);

export const GlobalProvider = ({ children }: { children: ReactNode }) => {
  const [user, setUser] = useState<User | null>(null);
  const [cart, setCart] = useState<CartItem[]>([]);
  const [isLoading, setIsLoading] = useState(true);
  const [isDrawerOpen, setIsDrawerOpen] = useState(false);

  useEffect(() => {
    const initAuth = async () => {
      const user = await authService.checkAuth();
      if (user) {
        setUser(user);
      }
      setIsLoading(false);
    };
    initAuth();
  }, []);

  const logout = () => {
    authService.logout();
    setUser(null);
  };

  return (
    <GlobalContext.Provider value={{ 
      user, setUser, 
      cart, setCart, 
      categories: CATEGORIES,
      isLoading, setIsLoading,
      isDrawerOpen, setIsDrawerOpen,
      logout,
      isAuthenticated: !!user
    }}>
      {children}
    </GlobalContext.Provider>
  );
};

export const useGlobal = () => {
  const context = useContext(GlobalContext);
  if (!context) throw new Error('useGlobal must be used within a GlobalProvider');
  return context;
};
