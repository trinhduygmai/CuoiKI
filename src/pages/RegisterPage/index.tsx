import { useState } from 'react';
import { useNavigate } from 'react-router-dom';
import { ChevronLeft, Mail, Lock, User, UserPlus } from 'lucide-react';
import { motion } from 'motion/react';

export default function RegisterScreen() {
  const navigate = useNavigate();
  const [formData, setFormData] = useState({ fullName: '', email: '', password: '' });

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
        <h1 className="text-3xl font-bold text-zinc-900 mb-2">Create Account</h1>
        <p className="text-zinc-400">Join our foodies community</p>
      </motion.div>

      <div className="space-y-5">
        <div className="relative">
          <User className="absolute left-4 top-1/2 -translate-y-1/2 w-5 h-5 text-zinc-300" />
          <input
            type="text"
            placeholder="FULL NAME"
            className="w-full bg-zinc-50 border border-zinc-100 rounded-2xl pl-12 pr-4 py-4 text-xs font-bold tracking-wider outline-none focus:border-brand/40 transition-colors"
          />
        </div>

        <div className="relative">
          <Mail className="absolute left-4 top-1/2 -translate-y-1/2 w-5 h-5 text-zinc-300" />
          <input
            type="email"
            placeholder="EMAIL"
            className="w-full bg-zinc-50 border border-zinc-100 rounded-2xl pl-12 pr-4 py-4 text-xs font-bold tracking-wider outline-none focus:border-brand/40 transition-colors"
          />
        </div>

        <div className="relative">
          <Lock className="absolute left-4 top-1/2 -translate-y-1/2 w-5 h-5 text-zinc-300" />
          <input
            type="password"
            placeholder="PASSWORD"
            className="w-full bg-zinc-50 border border-zinc-100 rounded-2xl pl-12 pr-4 py-4 text-xs font-bold tracking-wider outline-none focus:border-brand/40 transition-colors"
          />
        </div>

        <button
          onClick={() => navigate('/login')}
          className="w-full bg-brand text-white py-4 rounded-2xl font-bold shadow-xl shadow-brand/20 flex items-center justify-center gap-2 active:scale-95 transition-all mt-6"
        >
          SIGN UP
          <UserPlus className="w-5 h-5" />
        </button>
      </div>

      <div className="mt-auto pb-12 flex flex-col items-center gap-4">
        <p className="text-zinc-400 text-sm">
          Already have an account?{' '}
          <button 
            onClick={() => navigate('/login')}
            className="text-brand font-bold"
          >
            Sign in
          </button>
        </p>
      </div>
    </div>
  );
}
