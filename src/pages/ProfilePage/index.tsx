import { useNavigate } from 'react-router-dom';
import { useGlobal } from '../../context/GlobalContext';
import { User, Mail, Settings, Shield, Bell, ChevronRight, LogOut, Settings2 } from 'lucide-react';
import HeaderBackButton from '../../components/buttons/HeaderBackButton';

export default function ProfileScreen() {
  const { user, setUser, setCart } = useGlobal();
  const navigate = useNavigate();

  const handleLogout = () => {
    setUser(null);
    setCart([]);
    navigate('/login');
  };

  return (
    <div className="flex flex-col h-full bg-zinc-50 overflow-hidden">
      {/* Header Section */}
      <div className="bg-white px-6 pt-12 pb-6 rounded-b-[2.5rem] shadow-sm border-b border-zinc-50 sticky top-0 z-30">
        <div className="flex items-center justify-between gap-4">
          <HeaderBackButton />
          
          <div className="flex-1 text-center">
             <h1 className="text-sm font-black text-zinc-900 uppercase tracking-[0.2em]">Profile Settings</h1>
          </div>
          
          <button className="w-12 h-12 rounded-full border border-zinc-50 flex items-center justify-center bg-white shadow-md shadow-black/5 text-zinc-400 active:scale-95 transition-all">
             <Settings2 className="w-6 h-6" />
          </button>
        </div>
      </div>

      <div className="flex-1 overflow-y-auto scrollbar-hide pt-6">
        <div className="px-6 pb-6 mt-2">
          <div className="flex flex-col items-center bg-white p-6 rounded-[2.5rem] shadow-sm border border-zinc-50 relative overflow-hidden">
             <div className="absolute top-0 left-0 w-full h-1 bg-brand" />
             <div className="w-24 h-24 rounded-3xl bg-zinc-100 overflow-hidden mb-4 border-4 border-white shadow-lg relative">
                <img src="https://ui-avatars.com/api/?name=User" alt="Avatar" className="w-full h-full object-cover" />
             </div>
             <h2 className="text-xl font-bold text-zinc-900">{user?.fullName}</h2>
             <p className="text-xs text-zinc-400 mt-1 uppercase tracking-widest font-bold">Premium Member</p>
          </div>
        </div>

        <div className="px-6 space-y-4 pb-24">
        <h3 className="px-2 text-[10px] font-bold text-zinc-400 uppercase tracking-[0.2em] mb-2">Account Settings</h3>
        
        <ProfileItem icon={User} label="Profile Information" />
        <ProfileItem icon={Mail} label="Email Notifications" />
        <ProfileItem icon={Settings} label="General Settings" />
        <ProfileItem icon={Shield} label="Security & Privacy" />
        <ProfileItem icon={Bell} label="Push Notifications" />

        <div className="pt-4">
           <button 
             onClick={handleLogout}
             className="w-full flex items-center justify-between p-4 bg-white rounded-2xl border border-red-50 text-red-500 hover:bg-red-50 transition-colors shadow-sm"
           >
             <div className="flex items-center gap-4">
               <div className="w-10 h-10 rounded-xl bg-red-50 flex items-center justify-center">
                 <LogOut className="w-5 h-5" />
               </div>
               <span className="text-sm font-bold">Logout Session</span>
             </div>
           </button>
        </div>
      </div>
    </div>
  </div>
  );
}

function ProfileItem({ icon: Icon, label }: { icon: any, label: string }) {
  return (
    <button className="w-full flex items-center justify-between p-4 bg-white rounded-2xl border border-zinc-50 hover:bg-zinc-50 transition-all group shadow-sm">
      <div className="flex items-center gap-4">
        <div className="w-10 h-10 rounded-xl bg-zinc-50 flex items-center justify-center group-hover:bg-white transition-colors">
          <Icon className="w-5 h-5 text-zinc-400 group-hover:text-brand" />
        </div>
        <span className="text-sm font-bold text-zinc-600 group-hover:text-zinc-900">{label}</span>
      </div>
      <ChevronRight className="w-4 h-4 text-zinc-300" />
    </button>
  );
}
