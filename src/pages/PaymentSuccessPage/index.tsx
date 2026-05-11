import { useNavigate } from 'react-router-dom';
import { motion } from 'motion/react';
import { CheckCircle2, ShoppingBag } from 'lucide-react';
import { useGlobal } from '../../context/GlobalContext';
import { useEffect } from 'react';

export default function PaymentSuccessScreen() {
  const navigate = useNavigate();
  const { setCart } = useGlobal();

  useEffect(() => {
    setCart([]);
  }, [setCart]);

  return (
    <div className="flex flex-col h-full bg-white items-center justify-center px-10 text-center">
      <motion.div
        initial={{ scale: 0 }}
        animate={{ scale: 1, rotate: 360 }}
        transition={{ type: 'spring', duration: 0.5 }}
        className="w-32 h-32 rounded-full bg-green-50 flex items-center justify-center mb-8"
      >
        <CheckCircle2 className="w-20 h-20 text-green-500" />
      </motion.div>

      <motion.h1
        initial={{ opacity: 0, y: 20 }}
        animate={{ opacity: 1, y: 0 }}
        transition={{ delay: 0.3 }}
        className="text-2xl font-bold text-zinc-900 mb-4"
      >
        Payment Success!
      </motion.h1>

      <motion.p
        initial={{ opacity: 0, y: 20 }}
        animate={{ opacity: 1, y: 0 }}
        transition={{ delay: 0.4 }}
        className="text-zinc-400 text-sm leading-relaxed mb-12"
      >
        Your order has been placed successfully.<br />Our team is preparing your delicious meal.
      </motion.p>

      <motion.button
        initial={{ opacity: 0, scale: 0.9 }}
        animate={{ opacity: 1, scale: 1 }}
        transition={{ delay: 0.6 }}
        onClick={() => navigate('/home')}
        className="w-full bg-brand text-white py-4 rounded-2xl font-bold flex items-center justify-center gap-3 shadow-lg shadow-brand/20"
      >
        Back To Home
        <ShoppingBag className="w-5 h-5" />
      </motion.button>
    </div>
  );
}
