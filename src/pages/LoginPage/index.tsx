import { useState } from 'react';
import { useNavigate } from 'react-router-dom';
import { useGlobal } from '../../context/GlobalContext';
import { motion } from 'motion/react';
import { Mail, Lock, LogIn, Loader2 } from 'lucide-react';
import { dataService } from '../../services/data_service';

export default function LoginScreen() {
  const [email, setEmail] = useState('');
  const [password, setPassword] = useState('');
  const [isSubmitting, setIsSubmitting] = useState(false);
  const { setUser } = useGlobal();
  const navigate = useNavigate();

  const handleLogin = async () => {
    if (!email || !password) return alert('Please enter both email and password');
    
    setIsSubmitting(true);
    try {
      const user = await dataService.login(email, password);
      if (user) {
        setUser(user);
        navigate('/home');
      } else {
        alert('Invalid credentials');
      }
    } catch (error) {
      alert('An error occurred during login');
    } finally {
      setIsSubmitting(false);
    }
  };

  return (
    <div className="flex flex-col h-full bg-white px-8 pt-20">
      <motion.div 
        initial={{ opacity: 0, y: 20 }}
        animate={{ opacity: 1, y: 0 }}
        className="mb-12"
      >
        <h1 className="text-4xl font-bold text-zinc-900 mb-2 mt-4">Login</h1>
        <p className="text-zinc-400">Please sign in to continue</p>
      </motion.div>

      <div className="space-y-6">
        <div className="relative">
          <Mail className="absolute left-4 top-1/2 -translate-y-1/2 w-5 h-5 text-zinc-300" />
          <input
            type="email"
            value={email}
            onChange={(e) => setEmail(e.target.value)}
            placeholder="EMAIL"
            className="w-full bg-zinc-50 border border-zinc-100 rounded-2xl pl-12 pr-4 py-4 text-sm font-semibold tracking-wider outline-none focus:border-brand/40 transition-colors"
          />
        </div>

        <div className="relative">
          <Lock className="absolute left-4 top-1/2 -translate-y-1/2 w-5 h-5 text-zinc-300" />
          <input
            type="password"
            value={password}
            onChange={(e) => setPassword(e.target.value)}
            placeholder="PASSWORD"
            className="w-full bg-zinc-50 border border-zinc-100 rounded-2xl pl-12 pr-4 py-4 text-sm font-semibold tracking-wider outline-none focus:border-brand/40 transition-colors"
          />
          <button 
            onClick={() => navigate('/forgot-password')}
            className="absolute right-4 top-1/2 -translate-y-1/2 text-[10px] font-bold text-brand uppercase"
          >
            Forgot?
          </button>
        </div>

        <button
          onClick={handleLogin}
          disabled={isSubmitting}
          className="w-full bg-brand text-white py-4 rounded-2xl font-bold shadow-xl shadow-brand/20 flex items-center justify-center gap-2 active:scale-95 transition-all mt-8 disabled:opacity-70 disabled:active:scale-100"
        >
          {isSubmitting ? (
            <Loader2 className="w-5 h-5 animate-spin" />
          ) : (
            <>
              LOGIN
              <LogIn className="w-5 h-5" />
            </>
          )}
        </button>
      </div>

      <div className="mt-auto pb-12 flex flex-col items-center gap-4">
        <p className="text-zinc-400 text-sm">
          Don't have an account?{' '}
          <button 
            onClick={() => navigate('/register')}
            className="text-brand font-bold"
          >
            Sign up
          </button>
        </p>
      </div>
    </div>
  );
}
