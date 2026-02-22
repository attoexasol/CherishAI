import { useNavigate } from 'react-router-dom';
import { Clock, Battery, Brain } from 'lucide-react';
import { motion } from 'motion/react';
import { ImageWithFallback } from '@/app/components/figma/ImageWithFallback';
import { useEffect } from 'react';
import cherishLogo from 'figma:asset/1ba0763b2c65c413d13ec69a501bf3eb00e15b25.png';

export default function InitialSplashScreen() {
  const navigate = useNavigate();

  useEffect(() => {
    // Auto-advance after 8 seconds
    const timer = setTimeout(() => {
      navigate('/language-selection');
    }, 8000);

    return () => clearTimeout(timer);
  }, [navigate]);

  const handleSkip = () => {
    navigate('/language-selection');
  };

  return (
    <div className="min-h-screen h-screen relative overflow-hidden flex items-center justify-center">
      {/* Soft Lavender / Blush Gradient Background */}
      <div className="absolute inset-0 bg-gradient-to-br from-purple-100 via-pink-50 to-rose-100" />
      <div className="absolute inset-0 bg-gradient-to-t from-pink-50/60 via-transparent to-lavender-50/40" />
      
      {/* Decorative Floating Gradient Orbs */}
      <motion.div
        className="absolute top-20 right-10 w-64 h-64 bg-rose-300/20 rounded-full blur-3xl"
        animate={{
          scale: [1, 1.2, 1],
          opacity: [0.3, 0.5, 0.3],
        }}
        transition={{
          duration: 8,
          repeat: Infinity,
          ease: "easeInOut"
        }}
      />
      <motion.div
        className="absolute bottom-20 left-10 w-64 h-64 bg-purple-300/20 rounded-full blur-3xl"
        animate={{
          scale: [1.2, 1, 1.2],
          opacity: [0.5, 0.3, 0.5],
        }}
        transition={{
          duration: 8,
          repeat: Infinity,
          ease: "easeInOut"
        }}
      />

      <div className="relative z-10 px-6 w-full max-w-lg mx-auto">
        <motion.div
          initial={{ opacity: 0, scale: 0.9 }}
          animate={{ opacity: 1, scale: 1 }}
          transition={{ duration: 0.8 }}
          className="relative"
        >
          <div className="relative overflow-hidden rounded-[32px] bg-gradient-to-br from-white/95 via-pink-50/80 to-purple-50/90 backdrop-blur-xl p-8 md:p-10 shadow-[0_12px_48px_rgba(147,51,234,0.15)]">
            {/* Inner Decorative Gradient Orbs */}
            <div className="absolute top-0 right-0 w-32 h-32 bg-rose-300/15 rounded-full blur-2xl" />
            <div className="absolute bottom-0 left-0 w-32 h-32 bg-purple-300/15 rounded-full blur-2xl" />
            
            <div className="relative">
              {/* Logo */}
              <motion.div
                className="flex justify-center mb-6"
                initial={{ scale: 0.8, opacity: 0 }}
                animate={{ scale: 1, opacity: 1 }}
                transition={{ delay: 0.3, duration: 0.6 }}
              >
                <motion.div 
                  className="w-48 h-48 md:w-56 md:h-56"
                  animate={{
                    scale: [1, 1.05, 1],
                  }}
                  transition={{
                    duration: 3,
                    repeat: Infinity,
                    ease: "easeInOut"
                  }}
                >
                  <ImageWithFallback
                    src={cherishLogo}
                    alt="Cherish AI Logo"
                    className="w-full h-full object-contain drop-shadow-2xl"
                  />
                </motion.div>
              </motion.div>

              {/* Headline */}
              <motion.h1
                className="text-2xl md:text-3xl text-center text-purple-800 mb-6 leading-tight px-2"
                initial={{ opacity: 0, y: 20 }}
                animate={{ opacity: 1, y: 0 }}
                transition={{ delay: 0.5 }}
              >
                Most relationship apps today still ask <br />
                <span className="text-rose-600">more from you.</span>
              </motion.h1>

              {/* Three Demands */}
              <div className="space-y-4 mb-6">
                <motion.div
                  className="flex items-center gap-4"
                  initial={{ opacity: 0, x: -30 }}
                  animate={{ opacity: 1, x: 0 }}
                  transition={{ delay: 0.7 }}
                >
                  <div className="flex items-center justify-center w-14 h-14 rounded-2xl bg-gradient-to-br from-rose-400 to-rose-500 shadow-xl shadow-rose-300/40 flex-shrink-0">
                    <Clock className="w-7 h-7 text-white" strokeWidth={2.5} />
                  </div>
                  <div className="flex-1">
                    <h3 className="text-xl text-purple-800 mb-0.5">Time</h3>
                    <p className="text-gray-600 text-sm leading-relaxed">
                      Endless manual logging and tracking
                    </p>
                  </div>
                </motion.div>

                <motion.div
                  className="flex items-center gap-4"
                  initial={{ opacity: 0, x: -30 }}
                  animate={{ opacity: 1, x: 0 }}
                  transition={{ delay: 0.9 }}
                >
                  <div className="flex items-center justify-center w-14 h-14 rounded-2xl bg-gradient-to-br from-pink-400 to-pink-500 shadow-xl shadow-pink-300/40 flex-shrink-0">
                    <Battery className="w-7 h-7 text-white" strokeWidth={2.5} />
                  </div>
                  <div className="flex-1">
                    <h3 className="text-xl text-purple-800 mb-0.5">Effort</h3>
                    <p className="text-gray-600 text-sm leading-relaxed">
                      Complex features you never asked for
                    </p>
                  </div>
                </motion.div>

                <motion.div
                  className="flex items-center gap-4"
                  initial={{ opacity: 0, x: -30 }}
                  animate={{ opacity: 1, x: 0 }}
                  transition={{ delay: 1.1 }}
                >
                  <div className="flex items-center justify-center w-14 h-14 rounded-2xl bg-gradient-to-br from-purple-400 to-purple-500 shadow-xl shadow-purple-300/40 flex-shrink-0">
                    <Brain className="w-7 h-7 text-white" strokeWidth={2.5} />
                  </div>
                  <div className="flex-1">
                    <h3 className="text-xl text-purple-800 mb-0.5">Emotional work</h3>
                    <p className="text-gray-600 text-sm leading-relaxed">
                      The burden of remembering everything
                    </p>
                  </div>
                </motion.div>
              </div>

              {/* Closing Statement */}
              <motion.div
                initial={{ opacity: 0, y: 20 }}
                animate={{ opacity: 1, y: 0 }}
                transition={{ delay: 1.3 }}
                className="text-center"
              >
                <p className="text-lg md:text-xl text-gray-700 leading-relaxed mb-2">
                  Cherish AI is different.
                </p>
                <p className="text-base text-gray-600 leading-relaxed">
                  We do the work, so you can focus on what matters:
                </p>
                <p className="text-xl md:text-2xl text-transparent bg-clip-text bg-gradient-to-r from-rose-500 via-pink-500 to-purple-500 mt-2">
                  showing love 💕
                </p>
              </motion.div>
            </div>
          </div>

          {/* Skip button */}
          <motion.button
            onClick={handleSkip}
            className="mt-6 mx-auto block text-purple-600 hover:text-purple-700 transition-colors text-sm"
            initial={{ opacity: 0 }}
            animate={{ opacity: 1 }}
            transition={{ delay: 1.5 }}
          >
            Skip →
          </motion.button>
        </motion.div>
      </div>
    </div>
  );
}