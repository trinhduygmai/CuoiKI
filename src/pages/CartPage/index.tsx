import { useNavigate } from 'react-router-dom';
import { useGlobal } from '../../context/GlobalContext';
import { Trash2, Minus, Plus, CreditCard } from 'lucide-react';
import { motion, AnimatePresence } from 'motion/react';
import HeaderBackButton from '../../components/buttons/HeaderBackButton';

export default function CartScreen() {
  const { cart, setCart } = useGlobal();
  const navigate = useNavigate();

  const subtotal = cart.reduce((acc, item) => acc + (item.price * item.quantity), 0);
  const tax = subtotal * 0.1;
  const delivery = subtotal > 0 ? 5.0 : 0;
  const total = subtotal + tax + delivery;

  const updateQuantity = (id: string, size: string, q: number) => {
    if (q < 1) return;
    setCart(prev => prev.map(item => 
      (item.id === id && item.selectedSize === size) 
        ? { ...item, quantity: q } 
        : item
    ));
  };

  const removeItem = (id: string, size: string) => {
    setCart(prev => prev.filter(item => !(item.id === id && item.selectedSize === size)));
  };

  return (
    <div className="flex flex-col h-full bg-zinc-50 overflow-hidden">
      {/* Header */}
      <div className="bg-white px-6 pt-12 pb-6 rounded-b-[2.5rem] shadow-sm border-b border-zinc-50">
        <div className="flex items-center justify-between gap-4">
          <HeaderBackButton />
          
          <h1 className="text-sm font-black text-zinc-900 uppercase tracking-[0.2em]">Your Cart</h1>
          
          <div className="w-12 h-12" />
        </div>
      </div>

      {/* Content */}
      <div className="flex-1 flex flex-col overflow-hidden px-6 pt-4">
        <div className="flex-1 overflow-y-auto pr-1 scrollbar-hide mb-6">
           <AnimatePresence mode="popLayout">
            {cart.length === 0 ? (
              <div key="empty" className="h-40 flex flex-col items-center justify-center text-zinc-400 text-sm italic">
                <span>Cart is currently empty.</span>
                <button onClick={() => navigate('/home')} className="mt-4 text-brand font-bold uppercase tracking-widest text-[10px]">Shop now</button>
              </div>
            ) : (
              cart.map((item) => (
                <motion.div
                  layout
                  key={`${item.id}-${item.selectedSize}`}
                  initial={{ opacity: 0, y: 20 }}
                  animate={{ opacity: 1, y: 0 }}
                  exit={{ opacity: 0, x: -100 }}
                  className="bg-white p-3 rounded-3xl border border-zinc-100 shadow-sm flex items-center gap-4 group mb-4"
                >
                  <div className="w-20 h-20 rounded-2xl overflow-hidden shrink-0">
                    <img src={item.image} alt={item.name} className="w-full h-full object-cover" />
                  </div>
                  <div className="flex-1 flex flex-col justify-between py-1">
                    <div className="flex justify-between items-start">
                       <div>
                          <h4 className="text-xs font-bold text-zinc-900 leading-tight">{item.name}</h4>
                          <div className="flex items-center gap-2 mt-1">
                             <span className="text-[10px] font-bold text-white bg-zinc-900 px-1.5 rounded uppercase">{item.selectedSize}</span>
                             <span className="text-[10px] font-bold text-brand">${item.price.toFixed(2)}</span>
                          </div>
                       </div>
                       <button onClick={() => removeItem(item.id, item.selectedSize)} className="text-zinc-200 hover:text-red-400">
                          <Trash2 className="w-4 h-4" />
                       </button>
                    </div>
                    <div className="flex items-center justify-between mt-2">
                       <div className="flex items-center gap-3 bg-zinc-50 border border-zinc-100 rounded-full px-2 py-0.5">
                          <button onClick={() => updateQuantity(item.id, item.selectedSize, item.quantity - 1)} className="text-zinc-400"><Minus className="w-3 h-3" /></button>
                          <span className="text-xs font-bold w-3 text-center">{item.quantity}</span>
                          <button onClick={() => updateQuantity(item.id, item.selectedSize, item.quantity + 1)} className="text-brand"><Plus className="w-3 h-3" /></button>
                       </div>
                    </div>
                  </div>
                </motion.div>
              ))
            )}
           </AnimatePresence>
        </div>

        {/* Summary */}
        <div className="bg-white p-6 rounded-t-[2.5rem] shadow-[0_-10px_25px_-5px_rgba(0,0,0,0.05)] -mx-6 relative z-10 border-t border-zinc-50 mt-auto">
           <div className="space-y-3 mb-6">
              <div className="flex justify-between items-center text-[10px] uppercase tracking-wider font-bold">
                 <span className="text-zinc-400">Subtotal</span>
                 <span className="text-zinc-900">${subtotal.toFixed(2)}</span>
              </div>
              <div className="flex justify-between items-center text-[10px] uppercase tracking-wider font-bold">
                 <span className="text-zinc-400">Tax & Fees (10%)</span>
                 <span className="text-zinc-900">${tax.toFixed(2)}</span>
              </div>
              <div className="flex justify-between items-center text-[10px] uppercase tracking-wider font-bold">
                 <span className="text-zinc-400">Delivery</span>
                 <span className="text-zinc-900">${delivery.toFixed(2)}</span>
              </div>
              <div className="h-px bg-zinc-100 my-4" />
              <div className="flex justify-between items-center">
                 <span className="text-sm font-bold text-zinc-900">Total Payment</span>
                 <span className="text-xl font-bold text-brand">${total.toFixed(2)}</span>
              </div>
           </div>

           <button
             onClick={() => navigate('/payment-success')}
             disabled={cart.length === 0}
             className="w-full bg-brand text-white py-4 rounded-2xl font-bold flex items-center justify-center gap-3 shadow-lg shadow-brand/20 active:scale-95 transition-all text-sm uppercase tracking-widest disabled:opacity-50"
           >
             Proceed To Pay
             <CreditCard className="w-5 h-5" />
           </button>
        </div>
      </div>
    </div>
  );
}
