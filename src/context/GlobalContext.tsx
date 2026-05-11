import React, { createContext, useContext, useState, ReactNode } from 'react';
import { User, CartItem, Category } from '../types/types';
import { CATEGORIES } from '../mocks/mockData';

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
}

const GlobalContext = createContext<GlobalContextType | undefined>(undefined);

export const GlobalProvider = ({ children }: { children: ReactNode }) => {
  const [user, setUser] = useState<User | null>(null);
  const [cart, setCart] = useState<CartItem[]>([]);
  const [isLoading, setIsLoading] = useState(false);
  const [isDrawerOpen, setIsDrawerOpen] = useState(false);

  return (
    <GlobalContext.Provider value={{ 
      user, setUser, 
      cart, setCart, 
      categories: CATEGORIES,
      isLoading, setIsLoading,
      isDrawerOpen, setIsDrawerOpen
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
