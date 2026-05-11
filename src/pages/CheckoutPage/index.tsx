import { useState } from 'react';
import { useGlobal } from '../../context/GlobalContext';
import { ChevronLeft, MoreVertical, MapPin, Clock, Edit2 } from 'lucide-react';
import { cn } from '../../lib/utils';

export default function CheckoutPage() {
  const { setCurrentScreen } = useGlobal();
  const [method, setMethod] = useState<'pickup' | 'delivery'>('pickup');

  return (
    <div className="flex flex-col h-full bg-zinc-50">
      <div className="flex items-center justify-between px-6 pt-12 pb-4">
        <button onClick={() => setCurrentScreen('details')} className="w-10 h-10 rounded-full border border-zinc-200 flex items-center justify-center bg-white shadow-sm">
          <ChevronLeft className="w-5 h-5" />
        </button>
        <h1 className="text-lg font-bold">Checkout</h1>
        <button className="w-10 h-10 rounded-full border border-zinc-200 flex items-center justify-center bg-white shadow-sm">
          <MoreVertical className="w-5 h-5" />
        </button>
      </div>

      <div className="flex-1 overflow-y-auto px-6 pb-24">
        <div className="bg-zinc-100 p-1.5 rounded-2xl flex items-center mb-8 mt-2">
          <button
            onClick={() => setMethod('pickup')}
            className={cn(
              "flex-1 py-3 rounded-xl text-xs font-bold transition-all",
              method === 'pickup' ? "bg-white shadow-sm text-zinc-900" : "text-zinc-400"
            )}
          >
            Pickup
            <span className="block text-[10px] font-medium opacity-60">15 minutes</span>
          </button>
          <button
            onClick={() => setMethod('delivery')}
            className={cn(
              "flex-1 py-3 rounded-xl text-xs font-bold transition-all",
              method === 'delivery' ? "bg-white shadow-sm text-zinc-900" : "text-zinc-400"
            )}
          >
            Delivery
            <span className="block text-[10px] font-medium opacity-60">20-30 minutes</span>
          </button>
        </div>

        <div className="space-y-6 mb-10">
          <div className="flex items-start gap-4">
            <div className="w-10 h-10 rounded-full bg-zinc-100 flex items-center justify-center shrink-0">
              <MapPin className="w-5 h-5 text-zinc-400" />
            </div>
            <div className="flex-1">
              <h3 className="text-sm font-bold text-zinc-900 mb-1">Pickup address</h3>
              <p className="text-xs text-zinc-400 leading-relaxed">
                1234 Broadway st, Chicago, IL 13475,<br />United States
              </p>
            </div>
          </div>

          <div className="flex items-start gap-4">
            <div className="w-10 h-10 rounded-full bg-zinc-100 flex items-center justify-center shrink-0">
              <Clock className="w-5 h-5 text-zinc-400" />
            </div>
            <div className="flex-1">
              <h3 className="text-sm font-bold text-zinc-900 mb-1">Pickup Time</h3>
              <p className="text-xs text-zinc-400">11:48 AM</p>
            </div>
            <button className="text-zinc-300 hover:text-zinc-500">
              <Edit2 className="w-4 h-4" />
            </button>
          </div>
        </div>

        <div className="space-y-4 mb-10">
          <h3 className="text-sm font-bold text-zinc-900">Contact Details</h3>
          <input type="text" placeholder="Full name *" className="w-full bg-white border border-zinc-100 rounded-xl px-4 py-4 text-sm outline-none focus:border-brand/30 transition-colors" />
          <input type="tel" placeholder="Phone number *" className="w-full bg-white border border-zinc-100 rounded-xl px-4 py-4 text-sm outline-none focus:border-brand/30 transition-colors" />
          <input type="email" placeholder="Email *" className="w-full bg-white border border-zinc-100 rounded-xl px-4 py-4 text-sm outline-none focus:border-brand/30 transition-colors" />
        </div>

        <div className="space-y-3">
          <h3 className="text-sm font-bold text-zinc-900">Add Coupon</h3>
          <input type="text" placeholder="Insert your coupon code" className="w-full bg-white border border-zinc-100 rounded-xl px-4 py-4 text-sm outline-none focus:border-brand/30 transition-colors" />
        </div>
      </div>

      <div className="absolute bottom-0 left-0 right-0 p-6 bg-white border-t border-zinc-100">
        <button
          onClick={() => setCurrentScreen('order')}
          className="w-full bg-brand text-white py-4 rounded-2xl font-bold shadow-lg shadow-brand/20 active:scale-95 transition-all"
        >
          Place Order
        </button>
      </div>
    </div>
  );
}
