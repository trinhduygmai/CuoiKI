import { useState } from 'react';
import { useGlobal } from '../../context/GlobalContext';
import { ChevronLeft, MoreVertical, Trash2, Minus, Plus, Edit2 } from 'lucide-react';
import { cn } from '../../lib/utils';

export default function OrderPage() {
  const { cart, setCurrentScreen } = useGlobal();
  const [method, setMethod] = useState<'table' | 'delivery'>('delivery');

  const subtotal = cart.reduce((acc, item) => acc + (item.price * item.quantity), 0);
  const tax = subtotal * 0.1;
  const total = subtotal + tax;

  return (
    <div className="flex flex-col h-full bg-zinc-50">
      <div className="flex items-center justify-between px-6 pt-12 pb-4">
        <button onClick={() => setCurrentScreen('checkout')} className="w-10 h-10 rounded-full border border-zinc-200 flex items-center justify-center bg-white shadow-sm">
          <ChevronLeft className="w-5 h-5" />
        </button>
        <h1 className="text-lg font-bold">Order</h1>
        <button className="w-10 h-10 rounded-full border border-zinc-200 flex items-center justify-center bg-white shadow-sm">
          <MoreVertical className="w-5 h-5" />
        </button>
      </div>

      <div className="flex-1 overflow-y-auto px-6 pb-32">
        <div className="bg-zinc-100 p-1.5 rounded-2xl flex items-center mb-8 mt-2">
          <button
            onClick={() => setMethod('table')}
            className={cn(
              "flex-1 py-3 rounded-xl text-xs font-bold transition-all",
              method === 'table' ? "bg-white shadow-sm text-zinc-900" : "text-zinc-400"
            )}
          >
            Table reserve
          </button>
          <button
            onClick={() => setMethod('delivery')}
            className={cn(
              "flex-1 py-3 rounded-xl text-xs font-bold transition-all",
              method === 'delivery' ? "bg-white shadow-sm text-zinc-900" : "text-zinc-400"
            )}
          >
            Delivery
          </button>
        </div>

        <div className="space-y-6 mb-8">
           <h3 className="text-sm font-bold text-zinc-900">Items</h3>
           {cart.map((item) => (
              <div key={item.id} className="flex gap-4">
                 <div className="w-20 h-20 rounded-2xl overflow-hidden bg-zinc-100 shrink-0">
                    <img src={item.image} alt={item.name} className="w-full h-full object-cover" />
                 </div>
                 <div className="flex-1 flex flex-col justify-between py-1">
                    <div className="flex items-start justify-between">
                       <div>
                          <h4 className="text-sm font-bold text-zinc-900 leading-none">{item.name}</h4>
                          <p className="text-[10px] text-zinc-400 mt-1">Price Per 1: <span className="font-bold">${item.price.toFixed(2)}</span></p>
                       </div>
                       <button className="text-zinc-300 hover:text-red-400 transition-colors">
                          <Trash2 className="w-4 h-4" />
                       </button>
                    </div>
                    <div className="flex items-center justify-between">
                       <div className="flex items-center gap-3 bg-zinc-50 border border-zinc-100 rounded-full px-2 py-0.5">
                          <button className="text-zinc-400">
                             <Minus className="w-3 h-3" />
                          </button>
                          <span className="text-xs font-bold w-3 text-center">{item.quantity}</span>
                          <button className="text-brand">
                             <Plus className="w-3 h-3" />
                          </button>
                       </div>
                       <span className="text-sm font-bold text-zinc-900">${(item.price * item.quantity).toFixed(2)}</span>
                    </div>
                 </div>
              </div>
           ))}
        </div>

        <div className="mb-10">
           <h3 className="text-sm font-bold text-zinc-900 mb-4">Address</h3>
           <div className="flex items-start gap-4 bg-white p-4 rounded-2xl border border-zinc-100 shadow-sm">
              <div className="flex-1">
                 <p className="text-xs text-zinc-400 leading-relaxed">
                   1770 S Harbor Blvd, Ste 140, Anaheim, CA
                 </p>
              </div>
              <button className="text-zinc-300 hover:text-zinc-500">
                 <Edit2 className="w-4 h-4" />
              </button>
           </div>
           <button className="text-[10px] font-bold text-zinc-400 mt-3 flex items-center gap-1 hover:text-brand transition-colors">
              <Plus className="w-3 h-3" />
              Add new address
           </button>
        </div>

        <div className="space-y-3">
           <h3 className="text-sm font-bold text-zinc-900">Order Summary</h3>
           <div className="space-y-2">
              <div className="flex items-center justify-between text-xs">
                 <span className="text-zinc-400">Subtotal</span>
                 <span className="font-bold text-zinc-900">${subtotal.toFixed(2)}</span>
              </div>
              <div className="flex items-center justify-between text-xs">
                 <span className="text-zinc-400">Tax (10%)</span>
                 <span className="font-bold text-zinc-900">${tax.toFixed(2)}</span>
              </div>
              <div className="border-t border-zinc-100 pt-2 flex items-center justify-between">
                 <span className="text-sm font-bold text-zinc-900">Total</span>
                 <span className="text-sm font-bold text-zinc-900">${total.toFixed(2)}</span>
              </div>
           </div>
        </div>
      </div>

      <div className="absolute bottom-0 left-0 right-0 p-6 bg-white border-t border-zinc-100">
        <button className="w-full bg-brand text-white py-4 rounded-2xl font-bold shadow-lg shadow-brand/20 active:scale-95 transition-all">
          Process Transaction
        </button>
      </div>
    </div>
  );
}
