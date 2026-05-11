import React, { useState } from 'react';
import { useNavigate } from 'react-router-dom';
import { motion, AnimatePresence } from 'motion/react';
import { Home, ShoppingBag, User, LogOut, X, ShoppingCart } from 'lucide-react';
import { useGlobal } from '../context/GlobalContext';
import { cn } from '../lib/utils';
import HeaderMenuButton from './buttons/HeaderMenuButton';

export default function Layout({ children, showHeader = true }: { children: React.ReactNode, showHeader?: boolean }) {
  const { user, logout, cart, setCart, isDrawerOpen, setIsDrawerOpen } = useGlobal();
  const navigate = useNavigate();

  const cartCount = cart.reduce((acc, item) => acc + item.quantity, 0);

  const menuItems = [
    { label: 'Home', icon: Home, path: '/home' },
    { label: 'My Cart', icon: ShoppingBag, path: '/cart' },
    { label: 'Profile', icon: User, path: '/profile' },
  ];

  const handleLogout = () => {
    logout();
    setCart([]);
    navigate('/login');
  };

  if (!user) return <>{children}</>;

  return (
    <div className="h-full relative overflow-hidden bg-white">
      {/* Header */}
      {showHeader && (
        <div className="absolute top-0 left-0 right-0 z-40 h-28 flex items-center justify-between px-6 pointer-events-none pt-10">
           <HeaderMenuButton 
             onClick={() => setIsDrawerOpen(true)}
             className="pointer-events-auto"
           />
           
           <div className="flex items-center gap-3 pointer-events-auto">
              <button
                 onClick={() => navigate('/cart')}
                 className="relative w-12 h-12 rounded-full bg-white backdrop-blur-md border border-zinc-100 flex items-center justify-center shadow-md shadow-black/5 active:scale-95 transition-all"
              >
                 <ShoppingCart className="w-5 h-5 text-zinc-600" />
                 {cartCount > 0 && (
                    <motion.span 
                      initial={{ scale: 0 }}
                      animate={{ scale: 1 }}
                      className="absolute -top-1 -right-1 min-w-[20px] h-[20px] bg-brand text-white text-[10px] font-bold rounded-full border-2 border-white flex items-center justify-center px-1 shadow-sm"
                    >
                       {cartCount}
                    </motion.span>
                 )}
              </button>
           </div>
        </div>
      )}

      <AnimatePresence>
        {isDrawerOpen && (
          <>
            <motion.div
              initial={{ opacity: 0 }}
              animate={{ opacity: 0.3 }}
              exit={{ opacity: 0 }}
              onClick={() => setIsDrawerOpen(false)}
              className="absolute inset-0 bg-black z-40"
            />
            <motion.div
              initial={{ x: '-100%' }}
              animate={{ x: 0 }}
              exit={{ x: '-100%' }}
              transition={{ type: 'spring', stiffness: 300, damping: 30 }}
              className="absolute top-0 left-0 bottom-0 w-[260px] bg-white z-50 p-8 flex flex-col pt-16"
            >
              <div className="flex justify-end mb-8">
                 <button onClick={() => setIsDrawerOpen(false)} className="w-8 h-8 rounded-full bg-zinc-50 flex items-center justify-center">
                    <X className="w-4 h-4 text-zinc-400" />
                 </button>
              </div>

              <div className="mb-12">
                 <div className="w-20 h-20 rounded-3xl bg-zinc-100 overflow-hidden mb-4 border-4 border-white shadow-lg">
                    <img src="https://ui-avatars.com/api/?name=User" alt="User" />
                 </div>
                 <h3 className="font-bold text-zinc-900 text-lg leading-none">{user.fullName}</h3>
                 <p className="text-xs text-zinc-400 mt-1 font-medium italic">Premium Member</p>
              </div>

              <div className="space-y-4 flex-1">
                {menuItems.map((item) => (
                  <button
                    key={item.label}
                    onClick={() => {
                        navigate(item.path);
                        setIsDrawerOpen(false);
                    }}
                    className="flex items-center gap-4 w-full p-3 rounded-2xl group transition-all"
                  >
                    <div className="w-10 h-10 rounded-xl bg-zinc-50 flex items-center justify-center group-hover:bg-brand/10 transition-colors">
                       <item.icon className="w-5 h-5 text-zinc-400 group-hover:text-brand" />
                    </div>
                    <span className="text-sm font-bold text-zinc-600 group-hover:text-zinc-900">{item.label}</span>
                  </button>
                ))}
              </div>

              <button
                onClick={handleLogout}
                className="mt-auto flex items-center gap-4 w-full p-4 rounded-3xl bg-zinc-900 text-white shadow-xl shadow-black/10 active:scale-95 transition-all"
              >
                <LogOut className="w-5 h-5 text-zinc-400" />
                <span className="text-sm font-bold">Logout</span>
              </button>
            </motion.div>
          </>
        )}
      </AnimatePresence>

      <div className="h-full">
        {children}
      </div>
    </div>
  );
}
