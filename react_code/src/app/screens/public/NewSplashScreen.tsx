import { useNavigate } from 'react-router-dom';
import { Heart, ArrowRight, Sparkles, Star } from 'lucide-react';
import { motion } from 'motion/react';
import { ImageWithFallback } from '@/app/components/figma/ImageWithFallback';
import cherishLogo from 'figma:asset/1ba0763b2c65c413d13ec69a501bf3eb00e15b25.png';

export default function NewSplashScreen() {
  const navigate = useNavigate();

  return (
    <div className="min-h-screen h-screen relative overflow-hidden flex flex-col">
      {/* Premium Gradient Background */}
      <div className="absolute inset-0 bg-gradient-to-br from-purple-100 via-pink-50 to-rose-100" />
      <div className="absolute inset-0 bg-[radial-gradient(ellipse_at_top_right,_var(--tw-gradient-stops))] from-rose-200/30 via-transparent to-transparent" />
      <div className="absolute inset-0 bg-[radial-gradient(ellipse_at_bottom_left,_var(--tw-gradient-stops))] from-purple-200/30 via-transparent to-transparent" />
      
      {/* Animated Gradient Orbs */}
      <motion.div
        className="absolute top-1/4 right-1/4 w-96 h-96 bg-gradient-to-br from-rose-300/20 to-pink-300/20 rounded-full blur-3xl"
        animate={{
          scale: [1, 1.3, 1],
          opacity: [0.3, 0.6, 0.3],
          x: [0, 50, 0],
          y: [0, -30, 0],
        }}
        transition={{
          duration: 12,
          repeat: Infinity,
          ease: "easeInOut"
        }}
      />
      <motion.div
        className="absolute bottom-1/4 left-1/4 w-96 h-96 bg-gradient-to-br from-purple-300/20 to-indigo-300/20 rounded-full blur-3xl"
        animate={{
          scale: [1.2, 1, 1.2],
          opacity: [0.4, 0.7, 0.4],
          x: [0, -40, 0],
          y: [0, 40, 0],
        }}
        transition={{
          duration: 10,
          repeat: Infinity,
          ease: "easeInOut"
        }}
      />

      {/* Main Content Container */}
      <div className="relative z-10 flex-1 flex flex-col items-center justify-between px-6 py-12 max-w-lg mx-auto w-full">
        
        {/* Top Section - Logo & Branding */}
        <motion.div
          className="text-center w-full"
          initial={{ opacity: 0, y: -30 }}
          animate={{ opacity: 1, y: 0 }}
          transition={{ duration: 0.8 }}
        >
          {/* Logo */}
          <motion.div
            className="mb-6"
            animate={{
              scale: [1, 1.05, 1],
            }}
            transition={{
              duration: 4,
              repeat: Infinity,
              ease: "easeInOut"
            }}
          >
            <div className="w-52 h-52 mx-auto relative">
              <div className="absolute inset-0 bg-gradient-to-br from-rose-400/20 to-purple-400/20 rounded-full blur-2xl animate-pulse" />
              <ImageWithFallback
                src={cherishLogo}
                alt="Cherish AI"
                className="w-full h-full object-contain relative z-10 drop-shadow-2xl"
              />
            </div>
          </motion.div>

          {/* App Name */}
          <motion.div
            initial={{ opacity: 0 }}
            animate={{ opacity: 1 }}
            transition={{ delay: 0.3 }}
          >
            <h1 className="text-5xl mb-3 bg-gradient-to-r from-rose-600 via-pink-600 to-purple-600 bg-clip-text text-transparent">
              Cherish AI
            </h1>
            <p className="text-lg text-gray-600 mb-2">your personal love assistant 💕</p>
          </motion.div>
        </motion.div>

        {/* Middle Section - Value Props */}
        <motion.div
          className="w-full space-y-4"
          initial={{ opacity: 0, scale: 0.95 }}
          animate={{ opacity: 1, scale: 1 }}
          transition={{ delay: 0.5, duration: 0.6 }}
        >
          <div className="bg-white/60 backdrop-blur-xl rounded-3xl p-6 shadow-[0_8px_32px_rgba(147,51,234,0.1)] border border-white/40">
            <div className="flex items-start gap-4">
              <div className="w-12 h-12 rounded-2xl bg-gradient-to-br from-rose-400 to-rose-500 flex items-center justify-center flex-shrink-0 shadow-lg shadow-rose-300/50">
                <Heart className="w-6 h-6 text-white fill-white" />
              </div>
              <div>
                <h3 className="text-xl text-purple-800 mb-1">Remember Every Moment</h3>
                <p className="text-gray-600 text-sm leading-relaxed">
                  Never miss birthdays, anniversaries, or special occasions
                </p>
              </div>
            </div>
          </div>

          <div className="bg-white/60 backdrop-blur-xl rounded-3xl p-6 shadow-[0_8px_32px_rgba(147,51,234,0.1)] border border-white/40">
            <div className="flex items-start gap-4">
              <div className="w-12 h-12 rounded-2xl bg-gradient-to-br from-pink-400 to-pink-500 flex items-center justify-center flex-shrink-0 shadow-lg shadow-pink-300/50">
                <Sparkles className="w-6 h-6 text-white" />
              </div>
              <div>
                <h3 className="text-xl text-purple-800 mb-1">Thoughtful Gift Ideas</h3>
                <p className="text-gray-600 text-sm leading-relaxed">
                  Get personalized suggestions that truly show you care
                </p>
              </div>
            </div>
          </div>

          <div className="bg-white/60 backdrop-blur-xl rounded-3xl p-6 shadow-[0_8px_32px_rgba(147,51,234,0.1)] border border-white/40">
            <div className="flex items-start gap-4">
              <div className="w-12 h-12 rounded-2xl bg-gradient-to-br from-purple-400 to-purple-500 flex items-center justify-center flex-shrink-0 shadow-lg shadow-purple-300/50">
                <Star className="w-6 h-6 text-white fill-white" />
              </div>
              <div>
                <h3 className="text-xl text-purple-800 mb-1">Effortless Connection</h3>
                <p className="text-gray-600 text-sm leading-relaxed">
                  Stay present with the ones you love, automatically
                </p>
              </div>
            </div>
          </div>
        </motion.div>

        {/* Bottom Section - CTA */}
        <motion.div
          className="w-full space-y-4"
          initial={{ opacity: 0, y: 30 }}
          animate={{ opacity: 1, y: 0 }}
          transition={{ delay: 0.8, duration: 0.6 }}
        >
          {/* Main CTA Button */}
          <button
            onClick={() => navigate('/auth')}
            className="w-full py-5 px-8 bg-gradient-to-r from-rose-500 via-pink-500 to-purple-500 text-white rounded-2xl shadow-[0_8px_24px_rgba(219,39,119,0.3)] hover:shadow-[0_12px_32px_rgba(219,39,119,0.4)] transition-all duration-300 hover:scale-[1.02] active:scale-[0.98]"
          >
            <span className="flex items-center justify-center gap-2 text-lg">
              Get Started Free
              <ArrowRight className="w-5 h-5" />
            </span>
          </button>

          {/* Trust Indicators */}
          <div className="flex items-center justify-center gap-6 text-sm text-gray-600">
            <div className="flex items-center gap-1">
              <Star className="w-4 h-4 text-amber-400 fill-amber-400" />
              <span>4.9/5</span>
            </div>
            <div className="w-1 h-1 bg-gray-400 rounded-full" />
            <div>10k+ Users</div>
            <div className="w-1 h-1 bg-gray-400 rounded-full" />
            <div>Free Forever</div>
          </div>

          <p className="text-center text-xs text-gray-500 px-4">
            Join thousands who never miss a moment with their loved ones
          </p>
        </motion.div>
      </div>

      {/* Floating Hearts Animation */}
      {[...Array(6)].map((_, i) => (
        <motion.div
          key={i}
          className="absolute"
          style={{
            left: `${15 + i * 15}%`,
            bottom: -20,
          }}
          animate={{
            y: [-20, -600],
            opacity: [0, 0.4, 0],
            scale: [0.5, 1, 0.5],
            rotate: [0, 180, 360],
          }}
          transition={{
            duration: 8 + i * 0.5,
            delay: i * 1.2,
            repeat: Infinity,
            ease: "easeOut",
          }}
        >
          <Heart className="w-3 h-3 text-rose-300 fill-rose-300" />
        </motion.div>
      ))}
    </div>
  );
}