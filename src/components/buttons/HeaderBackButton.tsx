import { ChevronLeft } from 'lucide-react';
import { cn } from '../../lib/utils';
import { useNavigate } from 'react-router-dom';

interface HeaderBackButtonProps {
  className?: string;
  onClick?: () => void;
}

export default function HeaderBackButton({ className, onClick }: HeaderBackButtonProps) {
  const navigate = useNavigate();
  
  return (
    <button
      onClick={onClick || (() => navigate(-1))}
      className={cn(
        "w-12 h-12 rounded-full bg-white flex items-center justify-center shadow-md shadow-black/5 border border-zinc-50 active:scale-90 transition-all",
        className
      )}
    >
      <ChevronLeft className="w-6 h-6 text-zinc-900" />
    </button>
  );
}
