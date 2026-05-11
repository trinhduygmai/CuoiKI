import { Menu } from 'lucide-react';
import { cn } from '../../lib/utils';

interface HeaderMenuButtonProps {
  onClick: () => void;
  className?: string;
}

export default function HeaderMenuButton({ onClick, className }: HeaderMenuButtonProps) {
  return (
    <button
      onClick={onClick}
      className={cn(
        "w-12 h-12 rounded-full bg-white flex items-center justify-center shadow-md shadow-black/5 border border-zinc-50 active:scale-90 transition-all",
        className
      )}
    >
      <Menu className="w-6 h-6 text-zinc-900" />
    </button>
  );
}
