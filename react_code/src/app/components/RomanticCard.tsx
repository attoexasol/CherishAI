import { ReactNode, forwardRef } from 'react';
import { motion } from 'motion/react';

interface RomanticCardProps {
  children: ReactNode;
  className?: string;
  onClick?: () => void;
  gradient?: boolean;
}

export default forwardRef<HTMLDivElement, RomanticCardProps>(
  function RomanticCard({ children, className = '', onClick, gradient = false }, ref) {
    const baseClass = gradient
      ? 'bg-gradient-to-br from-rose-100/50 to-pink-100/50'
      : 'bg-white/80 backdrop-blur-sm';

    return (
      <motion.div
        ref={ref}
        className={`${baseClass} rounded-[20px] p-6 shadow-[0_8px_30px_rgb(0,0,0,0.08)] ${
          onClick ? 'cursor-pointer' : ''
        } ${className}`}
        style={{ touchAction: 'pan-x pan-y' }}
        onClick={onClick}
        whileHover={onClick ? { scale: 1.02, y: -2 } : {}}
        whileTap={onClick ? { scale: 0.98 } : {}}
        transition={{ duration: 0.2 }}
      >
        {children}
      </motion.div>
    );
  }
);