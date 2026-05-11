import { Food, Category } from '../types/types';

export const CATEGORIES: Category[] = [
  { id: '1', title: 'Italian', image: 'https://images.unsplash.com/photo-1546069901-ba9599a7e63c?q=80&w=200&auto=format&fit=crop' },
  { id: '2', title: 'Chinese', image: 'https://images.unsplash.com/photo-1525755662778-989d0524087e?q=80&w=200&auto=format&fit=crop' },
  { id: '3', title: 'Japanese', image: 'https://images.unsplash.com/photo-1579871494447-9811cf80d66c?q=80&w=200&auto=format&fit=crop' },
  { id: '4', title: 'Vietnamese', image: 'https://images.unsplash.com/photo-1541696432-82c6da8ce7bf?q=80&w=200&auto=format&fit=crop' },
  { id: '5', title: 'Indian', image: 'https://images.unsplash.com/photo-1585937421612-70a008356fbe?q=80&w=200&auto=format&fit=crop' },
  { id: '6', title: 'Fast Food', image: 'https://images.unsplash.com/photo-1561758033-d89a9ad46330?q=80&w=200&auto=format&fit=crop' },
];

export const MOCK_PIZZAS: Food[] = [
  {
    id: '1',
    name: 'Pepperoni Supreme',
    price: 12.00,
    image: 'https://images.unsplash.com/photo-1628840042765-356cda07504e?q=80&w=800&auto=format&fit=crop',
    description: 'Classic pepperoni with extra cheese and Italian crust.',
    category: 'Italian',
    kcal: 620,
    rating: 4.8,
    time: 18
  },
  {
    id: '2',
    name: 'Dim Sum Mix',
    price: 35.00,
    image: 'https://images.unsplash.com/photo-1496116218417-1a781b1c416c?q=80&w=800&auto=format&fit=crop',
    description: 'Freshly steamed shrimp and pork dumplings.',
    category: 'Chinese',
    kcal: 450,
    rating: 4.9,
    time: 15
  },
  {
    id: '3',
    name: 'Sushi Sashimi Duo',
    price: 40.00,
    image: 'https://images.unsplash.com/photo-1579871494447-9811cf80d66c?q=80&w=800&auto=format&fit=crop',
    description: 'Premium raw fish selection with authentic Japanese rice.',
    category: 'Japanese',
    kcal: 380,
    rating: 4.7,
    time: 25
  },
  {
    id: '4',
    name: 'Pho Bo Traditional',
    price: 15.00,
    image: 'https://images.unsplash.com/photo-1541696432-82c6da8ce7bf?q=80&w=800&auto=format&fit=crop',
    description: 'Traditional Vietnamese beef noodle soup with aromatic herbs.',
    category: 'Vietnamese',
    kcal: 550,
    rating: 4.9,
    time: 12
  }
];
