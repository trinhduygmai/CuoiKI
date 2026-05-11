import { useNavigate } from 'react-router-dom';
import { ChevronLeft, Mail, Send } from 'lucide-react';
import { motion } from 'motion/react';

export default function ForgotPasswordScreen() {
  const navigate = useNavigate();

  return (
    <div className="flex flex-col h-full bg-white px-8 pt-12">
      <button onClick={() => navigate(-1)} className="w-10 h-10 rounded-full border border-zinc-100 flex items-center justify-center bg-zinc-50 mb-8 self-start">
        <ChevronLeft className="w-5 h-5" />
      </button>

      <motion.div 
        initial={{ opacity: 0, y: 10 }}
        animate={{ opacity: 1, y: 0 }}
        className="mb-12"
      >
        <h1 className="text-3xl font-bold text-zinc-900 mb-2">Forgot Password?</h1>
        <p className="text-zinc-400">Enter your email to receive recovery link</p>
      </motion.div>

      <div className="space-y-6">
        <div className="relative">
          <Mail className="absolute left-4 top-1/2 -translate-y-1/2 w-5 h-5 text-zinc-300" />
          <input
            type="email"
            placeholder="EMAIL"
            className="w-full bg-zinc-50 border border-zinc-100 rounded-2xl pl-12 pr-4 py-4 text-sm font-semibold tracking-wider outline-none focus:border-brand/40 transition-colors"
          />
        </div>

        <button
          onClick={() => { alert('Reset link sent!'); navigate('/login'); }}
          className="w-full bg-brand text-white py-4 rounded-2xl font-bold shadow-xl shadow-brand/20 flex items-center justify-center gap-2 active:scale-95 transition-all mt-8"
        >
          SEND LINK
          <Send className="w-5 h-5" />
        </button>
      </div>
    </div>
  );
}
