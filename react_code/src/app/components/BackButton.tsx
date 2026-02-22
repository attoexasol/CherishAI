import { useNavigate } from 'react-router';
import { ArrowLeft } from 'lucide-react';
import { motion } from 'motion/react';

interface BackButtonProps {
  to?: string;
  className?: string;
  position?: 'fixed' | 'absolute' | 'static';
}

export default function BackButton({ to, className = '', position = 'fixed' }: BackButtonProps) {
  const navigate = useNavigate();

  const handleBack = () => {
    if (to) {
      navigate(to);
    } else {
      navigate(-1);
    }
  };

  const positionClasses = position === 'fixed' 
    ? 'fixed top-6 left-6 z-[100]' 
    : position === 'absolute'
    ? 'absolute top-6 left-6 z-[100]'
    : '';

  return (
    <motion.button
      onClick={handleBack}
      className={`${positionClasses} w-14 h-14 flex items-center justify-center rounded-full ${className}`}
      style={{
        background: 'linear-gradient(135deg, #FFFFFF 0%, #FFE5EC 100%)',
        backdropFilter: 'blur(20px)',
        boxShadow: '0 8px 24px rgba(233, 30, 99, 0.35), 0 4px 12px rgba(236, 72, 153, 0.25), inset 0 1px 1px rgba(255, 255, 255, 0.9)',
        border: '2.5px solid rgba(233, 30, 99, 0.4)',
      }}
      whileHover={{ 
        scale: 1.1, 
        boxShadow: '0 12px 32px rgba(233, 30, 99, 0.45), 0 6px 16px rgba(236, 72, 153, 0.35), inset 0 1px 1px rgba(255, 255, 255, 0.9)',
        background: 'linear-gradient(135deg, #FFFFFF 0%, #FFD4E5 100%)',
      }}
      whileTap={{ scale: 0.95 }}
      transition={{ duration: 0.2 }}
      initial={{ opacity: 0, x: -20 }}
      animate={{ opacity: 1, x: 0 }}
      aria-label="Go back"
    >
      <ArrowLeft 
        className="w-6 h-6" 
        style={{ color: '#B71C5C', strokeWidth: 3 }}
      />
    </motion.button>
  );
}