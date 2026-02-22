import { ReactNode } from 'react';
import { motion } from 'motion/react';

interface RomanticButtonProps {
  children: ReactNode;
  onClick?: () => void;
  variant?: 'primary' | 'secondary' | 'ghost';
  fullWidth?: boolean;
  disabled?: boolean;
  type?: 'button' | 'submit';
}

export default function RomanticButton({
  children,
  onClick,
  variant = 'primary',
  fullWidth = false,
  disabled = false,
  type = 'button',
}: RomanticButtonProps) {
  const variants = {
    primary: 'bg-gradient-to-r from-rose-500 via-pink-500 to-purple-500 text-white shadow-lg shadow-pink-300/50 hover:shadow-xl hover:shadow-pink-300/60',
    secondary: 'bg-white/90 text-rose-600 border-2 border-rose-200',
    ghost: 'bg-transparent text-rose-600 hover:bg-rose-50/50',
  };

  return (
    <motion.button
      type={type}
      className={`${variants[variant]} px-8 py-4 rounded-2xl transition-all ${
        fullWidth ? 'w-full' : ''
      } ${disabled ? 'opacity-50 cursor-not-allowed' : ''}`}
      onClick={onClick}
      disabled={disabled}
      whileHover={!disabled ? { scale: 1.02 } : {}}
      whileTap={!disabled ? { scale: 0.98 } : {}}
      transition={{ duration: 0.2 }}
    >
      <span className="font-semibold text-lg">{children}</span>
    </motion.button>
  );
}