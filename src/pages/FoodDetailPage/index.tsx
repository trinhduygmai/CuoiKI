import { useState } from 'react';
import { useParams, useNavigate } from 'react-router-dom';
import { useGlobal } from '../../context/GlobalContext';
import { Heart, Minus, Plus, Star, Flame, Clock } from 'lucide-react';
import { motion } from 'motion/react';
import { cn } from '../../lib/utils';
import { MOCK_PIZZAS } from '../../mocks/mockData';
import HeaderBackButton from '../../components/buttons/HeaderBackButton';

export default function FoodDetailScreen() {
  const { id } = useParams<{ id: string }>();
  const navigate = useNavigate();
  const { setCart } = useGlobal();
  const [size, setSize] = useState<'S' | 'M' | 'L'>('M');
  const [quantity, setQuantity] = useState(1);

  const food = MOCK_PIZZAS.find(f => f.id === id);

  if (!food) return <div className="p-10">Food not found</div>;

  const sizes = [
    { label: 'S', scale: 0.8 },
    { label: 'M', scale: 1.0 },
    { label: 'L', scale: 1.2 },
  ];

  const handleAddToCart = () => {
    setCart(prev => {
      const existing = prev.find(item => item.id === food.id && item.selectedSize === size);
      if (existing) {
        return prev.map(item => 
          (item.id === food.id && item.selectedSize === size)
            ? { ...item, quantity: item.quantity + quantity }
            : item
        );
      }
      return [...prev, { ...food, quantity, selectedSize: size }];
    });
    navigate('/cart');
  };

  return (
    <div className="flex flex-col h-full bg-white relative overflow-y-auto scrollbar-hide">
      <div className="flex items-center justify-between px-6 pt-12 absolute top-0 left-0 right-0 z-20 w-full pointer-events-none">
        <HeaderBackButton className="pointer-events-auto" />
        <button className="w-12 h-12 rounded-full border border-zinc-50 flex items-center justify-center bg-white shadow-md shadow-black/5 text-zinc-300 pointer-events-auto active:scale-95 transition-all">
          <Heart className="w-6 h-6" />
        </button>
      </div>

      <div className="relative pt-24 pb-12 overflow-hidden flex flex-col items-center bg-zinc-50 rounded-b-[4rem]">
        <motion.div
           animate={{ scale: sizes.find(s => s.label === size)?.scale }}
           transition={{ type: 'spring', stiffness: 300, damping: 20 }}
           className="w-64 h-64 rounded-full shadow-2xl relative z-10"
        >
           <img src={food.image} alt={food.name} className="w-full h-full object-cover rounded-full rotate-[15deg]" />
        </motion.div>

        <div className="flex items-center gap-6 mt-12 relative z-10">
          {sizes.map((s) => (
            <button
              key={s.label}
              onClick={() => setSize(s.label as any)}
              className={cn(
                "w-10 h-10 rounded-full flex items-center justify-center transition-all duration-300 shadow-sm",
                size === s.label ? "bg-zinc-900 text-white scale-110" : "bg-white text-zinc-400 border border-zinc-100"
              )}
            >
              <span className="text-xs font-bold">{s.label}</span>
            </button>
          ))}
        </div>
      </div>

      <div className="px-6 pt-8 flex-1 flex flex-col">
          <div className="flex items-start justify-between mb-2">
             <h1 className="text-2xl font-bold text-zinc-900 leading-tight">{food.name}</h1>
             <div className="flex items-center gap-3 bg-zinc-100 rounded-full px-3 py-1 scale-90 -mr-2">
                 <button onClick={() => setQuantity(Math.max(1, quantity - 1))} className="text-zinc-500"><Minus className="w-4 h-4" /></button>
                 <span className="text-sm font-bold w-4 text-center">{quantity}</span>
                 <button onClick={() => setQuantity(quantity + 1)} className="text-brand"><Plus className="w-4 h-4" /></button>
             </div>
          </div>

          <div className="flex items-baseline gap-1 mb-6">
             <span className="text-lg font-bold text-brand">$</span>
             <span className="text-3xl font-bold text-zinc-900">{(food.price * quantity).toFixed(2)}</span>
          </div>

          <div className="grid grid-cols-3 gap-3 mb-8">
            <div className="flex items-center gap-2 bg-orange-50 px-3 py-2 rounded-xl text-brand">
              <Star className="w-4 h-4 fill-brand" />
              <span className="text-[10px] font-bold">{food.rating}</span>
            </div>
            <div className="flex items-center gap-2 bg-orange-50 px-3 py-2 rounded-xl text-brand">
              <Flame className="w-4 h-4" />
              <span className="text-[10px] font-bold">{food.kcal} Kcal</span>
            </div>
            <div className="flex items-center gap-2 bg-orange-50 px-3 py-2 rounded-xl text-brand">
              <Clock className="w-4 h-4" />
              <span className="text-[10px] font-bold">{food.time} Min</span>
            </div>
          </div>

          <h3 className="text-sm font-bold text-zinc-900 mb-2">Description</h3>
          <p className="text-xs text-zinc-400 leading-relaxed mb-8 flex-1">
            {food.description}
          </p>

          <div className="pb-8">
             <button
               onClick={handleAddToCart}
               className="w-full bg-brand text-white py-4 rounded-2xl font-bold shadow-xl shadow-brand/20 active:scale-95 transition-all text-sm uppercase tracking-widest"
             >
               Add to cart
             </button>
          </div>
      </div>
    </div>
  );
}
