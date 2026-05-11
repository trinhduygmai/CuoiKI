import { useState, useEffect } from 'react';
import { useGlobal } from '../../context/GlobalContext';
import { dataService } from '../../services/data_service';
import { Food } from '../../types/types';
import { Search, ShoppingCart, Heart } from 'lucide-react';
import { motion } from 'motion/react';
import { useNavigate } from 'react-router-dom';
import HeaderMenuButton from '../../components/buttons/HeaderMenuButton';

export default function HomePage() {
  const { categories, user, setIsDrawerOpen, cart } = useGlobal();
  const [featuredFoods, setFeaturedFoods] = useState<Food[]>([]);
  const navigate = useNavigate();

  const cartCount = cart.reduce((acc, item) => acc + item.quantity, 0);

  useEffect(() => {
    const fetchFoods = async () => {
      const data = await dataService.getAllPizzas();
      setFeaturedFoods(data);
    };
    fetchFoods();
  }, []);

  return (
    <div className="flex flex-col h-full bg-zinc-50 overflow-y-auto scrollbar-hide">
      {/* SafeArea & Header Section */}
      <div className="bg-white px-6 pt-12 pb-6 rounded-b-[2.5rem] shadow-sm border-b border-zinc-50 sticky top-0 z-30">
        <div className="flex items-center justify-between gap-4">
          {/* Menu Button */}
          <HeaderMenuButton onClick={() => setIsDrawerOpen(true)} />

          {/* Delivery Address */}
          <div className="flex-1 flex flex-col items-center overflow-hidden">
             <div className="flex items-center gap-1.5">
                <span className="text-[10px] uppercase font-black text-zinc-300 tracking-[0.2em] leading-none">Deliver to</span>
                <div className="w-1.5 h-1.5 rounded-full bg-brand" />
             </div>
             <span className="text-sm font-bold text-zinc-900 mt-1 truncate w-full text-center">123 Broadway St, NYC</span>
          </div>

          {/* Cart Button */}
          <button 
            onClick={() => navigate('/cart')} 
            className="w-12 h-12 rounded-full bg-white flex items-center justify-center border border-zinc-50 shadow-md shadow-black/5 relative active:scale-90 transition-all"
          >
            <ShoppingCart className="w-5 h-5 text-zinc-600" />
            {cartCount > 0 && (
               <motion.span 
                 initial={{ scale: 0 }}
                 animate={{ scale: 1 }}
                 className="absolute -top-1 -right-1 bg-brand text-white text-[10px] font-bold w-5 h-5 rounded-full flex items-center justify-center border-2 border-white shadow-sm"
               >
                  {cartCount}
               </motion.span>
            )}
          </button>
        </div>
      </div>

      <div className="px-6 pb-24">
        {/* Welcome Section */}
        <div className="py-8">
           <h1 className="text-[28px] font-bold text-zinc-900 leading-[1.1] tracking-tight">
             Good morning,<br />
             <span className="text-brand">{user?.fullName || 'Foodie'}!</span>
           </h1>
           <p className="text-sm text-zinc-400 mt-2 font-medium">Ready for your favorite meal?</p>
        </div>

        {/* Search Bar */}
        <div className="relative mb-8">
           <div className="absolute left-4 top-1/2 -translate-y-1/2 w-5 h-5 text-zinc-300">
              <Search className="w-full h-full" />
           </div>
           <input 
             type="text" 
             placeholder="Search for sandwiches, pizza..."
             className="w-full bg-white border border-zinc-100 rounded-2xl pl-12 pr-4 py-4 text-[13px] outline-none shadow-sm focus:border-brand/30 transition-all font-medium"
           />
        </div>

        {/* Categories */}
        <div className="mb-10">
           <div className="flex items-center justify-between mb-5">
              <h2 className="text-lg font-bold text-zinc-900">Categories</h2>
              <button className="text-zinc-400 text-xs font-bold">See all</button>
           </div>
           <div className="flex gap-4 overflow-x-auto pb-2 scrollbar-hide -mx-2 px-2">
              {categories.map((cat) => (
                <button
                  key={cat.id}
                  onClick={() => navigate(`/food-list/${cat.title}`)}
                  className="min-w-[80px] flex flex-col items-center gap-3 transition-transform active:scale-95"
                >
                  <div className="w-16 h-16 rounded-[1.5rem] bg-white flex items-center justify-center shadow-sm border border-zinc-50 overflow-hidden p-2 group-hover:border-brand/20">
                    <img src={cat.image} alt={cat.title} className="w-full h-full object-contain" />
                  </div>
                  <span className="text-xs font-bold text-zinc-500">{cat.title}</span>
                </button>
              ))}
           </div>
        </div>

        {/* Featured */}
        <div className="flex-1">
           <div className="flex items-center justify-between mb-4">
              <h2 className="text-sm font-bold text-zinc-900">Featured items</h2>
              <button className="text-brand text-[10px] font-bold uppercase tracking-wider">See all</button>
           </div>
           <div className="grid grid-cols-1 gap-4 pb-24">
              {featuredFoods.map((food) => (
                 <motion.div
                   key={food.id}
                   whileTap={{ scale: 0.98 }}
                   onClick={() => navigate(`/food-detail/${food.id}`)}
                   className="bg-white rounded-3xl p-4 shadow-sm border border-zinc-50 flex items-center gap-4 group"
                 >
                   <div className="w-24 h-24 rounded-2xl overflow-hidden bg-zinc-50 shrink-0">
                      <img src={food.image} alt={food.name} className="w-full h-full object-cover" />
                   </div>
                   <div className="flex-1">
                      <div className="flex justify-between items-start mb-1">
                         <h3 className="text-sm font-bold text-zinc-900">{food.name}</h3>
                         <Heart className="w-4 h-4 text-zinc-200" />
                      </div>
                      <p className="text-[10px] text-zinc-400 line-clamp-1 mb-3">{food.description}</p>
                      <div className="flex items-center justify-between">
                         <span className="text-sm font-bold text-brand">${food.price.toFixed(2)}</span>
                         <div className="flex items-center gap-1">
                             <span className="text-[10px] font-bold text-zinc-900">{food.rating}</span>
                         </div>
                      </div>
                   </div>
                 </motion.div>
              ))}
           </div>
        </div>
      </div>
    </div>
  );
}
