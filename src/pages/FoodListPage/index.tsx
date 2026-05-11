import { useState } from 'react';
import { useParams, useNavigate } from 'react-router-dom';
import { useGlobal } from '../../context/GlobalContext';
import { Search, Star, Heart, SlidersHorizontal, Plus } from 'lucide-react';
import { motion, AnimatePresence } from 'motion/react';
import { MOCK_PIZZAS } from '../../mocks/mockData';
import HeaderBackButton from '../../components/buttons/HeaderBackButton';

export default function FoodListScreen() {
  const { category } = useParams<{ category: string }>();
  const navigate = useNavigate();
  const [search, setSearch] = useState('');

  const filteredFoods = MOCK_PIZZAS.filter(f => 
    (!category || category.toLowerCase() === 'all' || f.category.toLowerCase() === category.toLowerCase()) &&
    f.name.toLowerCase().includes(search.toLowerCase())
  );

  return (
    <div className="flex flex-col h-full bg-zinc-50 overflow-hidden">
      {/* Header Section */}
      <div className="bg-white px-6 pt-12 pb-6 rounded-b-[2.5rem] shadow-sm border-b border-zinc-50 sticky top-0 z-30 mb-2">
        <div className="flex items-center justify-between gap-4">
          <HeaderBackButton />
          
          <div className="flex-1 text-center">
             <h1 className="text-sm font-black text-zinc-900 capitalize tracking-[0.2em]">{category || 'Explore'} Foods</h1>
          </div>
          
          <div className="w-12 h-12" />
        </div>
      </div>

      <div className="flex-1 px-6 overflow-y-auto scrollbar-hide pb-24 pt-4">
        <div className="flex gap-3 mb-8">
          <div className="flex-1 relative">
            <Search className="absolute left-4 top-1/2 -translate-y-1/2 w-4 h-4 text-zinc-300" />
            <input
              type="text"
              value={search}
              onChange={(e) => setSearch(e.target.value)}
              placeholder="SEARCH DISHES..."
              className="w-full bg-white border border-zinc-100 rounded-2xl pl-12 pr-4 py-4 text-[10px] font-bold tracking-widest outline-none focus:border-brand/40 transition-colors shadow-sm"
            />
          </div>
          <button className="w-12 h-12 rounded-2xl bg-brand text-white flex items-center justify-center shadow-lg shadow-brand/20">
            <SlidersHorizontal className="w-5 h-5" />
          </button>
        </div>

        <div className="grid grid-cols-1 gap-4 pr-1">
          <AnimatePresence mode="popLayout">
            {filteredFoods.length === 0 ? (
              <div className="text-center py-20 text-zinc-400 text-xs italic">
                No items found in this section.
              </div>
            ) : (
              filteredFoods.map((food) => (
                <motion.div
                  layout
                  initial={{ opacity: 0, x: -20 }}
                  animate={{ opacity: 1, x: 0 }}
                  exit={{ opacity: 0, scale: 0.9 }}
                  key={food.id}
                  onClick={() => navigate(`/food-detail/${food.id}`)}
                  className="bg-white rounded-3xl p-3 shadow-sm border border-zinc-50 flex items-center gap-4 group active:scale-98 transition-all"
                >
                  <div className="relative w-24 h-24 rounded-2xl overflow-hidden shrink-0">
                    <img src={food.image} alt={food.name} className="w-full h-full object-cover group-hover:scale-110 transition-transform duration-500" />
                  </div>
                  <div className="flex-1">
                    <div className="flex justify-between items-start mb-1">
                      <h3 className="text-sm font-bold text-zinc-900">{food.name}</h3>
                      <Heart className="w-4 h-4 text-zinc-200" />
                    </div>
                    <div className="flex items-center gap-1 mb-2">
                       <Star className="w-3 h-3 text-orange-400 fill-orange-400" />
                       <span className="text-[10px] font-bold text-zinc-400">{food.rating}</span>
                    </div>
                    <div className="flex items-center justify-between">
                      <span className="text-sm font-bold text-brand">${food.price.toFixed(2)}</span>
                      <button className="w-8 h-8 rounded-full bg-zinc-900 text-white flex items-center justify-center shadow-md shadow-black/10">
                         <Plus className="w-4 h-4" />
                      </button>
                    </div>
                  </div>
                </motion.div>
              ))
            )}
          </AnimatePresence>
        </div>
      </div>
    </div>
  );
}
