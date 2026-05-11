import { Routes, Route, Navigate } from 'react-router-dom';
import { useGlobal } from '../context/GlobalContext';
import HomePage from '../pages/HomePage';
import CheckoutPage from '../pages/CheckoutPage';
import OrderPage from '../pages/OrderPage';
import LoginPage from '../pages/LoginPage';
import RegisterPage from '../pages/RegisterPage';
import ForgotPasswordPage from '../pages/ForgotPasswordPage';
import FoodListPage from '../pages/FoodListPage';
import FoodDetailPage from '../pages/FoodDetailPage';
import CartPage from '../pages/CartPage';
import PaymentSuccessPage from '../pages/PaymentSuccessPage';
import ProfilePage from '../pages/ProfilePage';
import Layout from '../components/Layout';

export default function AppRouter() {
  const { user, isLoading } = useGlobal();

  if (isLoading) {
    return (
      <div className="h-full flex flex-col items-center justify-center bg-white">
        <div className="w-16 h-16 border-4 border-brand border-t-transparent rounded-full animate-spin mb-4" />
        <span className="text-zinc-400 text-xs font-bold uppercase tracking-widest">Checking Auth...</span>
      </div>
    );
  }

  return (
    <Routes>
      <Route path="/login" element={!user ? <LoginPage /> : <Navigate to="/home" />} />
      <Route path="/register" element={<RegisterPage />} />
      <Route path="/forgot-password" element={<ForgotPasswordPage />} />
      
      {/* Protected Routes */}
      <Route path="/home" element={user ? <Layout showHeader={false}><HomePage /></Layout> : <Navigate to="/login" />} />
      <Route path="/food-list/:category" element={user ? <Layout showHeader={false}><FoodListPage /></Layout> : <Navigate to="/login" />} />
      <Route path="/food-detail/:id" element={user ? <Layout showHeader={false}><FoodDetailPage /></Layout> : <Navigate to="/login" />} />
      <Route path="/cart" element={user ? <Layout showHeader={false}><CartPage /></Layout> : <Navigate to="/login" />} />
      <Route path="/checkout" element={user ? <Layout><CheckoutPage /></Layout> : <Navigate to="/login" />} />
      <Route path="/order" element={user ? <Layout><OrderPage /></Layout> : <Navigate to="/login" />} />
      <Route path="/payment-success" element={user ? <Layout showHeader={false}><PaymentSuccessPage /></Layout> : <Navigate to="/login" />} />
      <Route path="/profile" element={user ? <Layout showHeader={false}><ProfilePage /></Layout> : <Navigate to="/login" />} />
      
      <Route path="/" element={<Navigate to={user ? "/home" : "/login"} />} />
      <Route path="*" element={<Navigate to="/" />} />
    </Routes>
  );
}
