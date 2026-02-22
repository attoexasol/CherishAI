import { useNavigate } from 'react-router-dom';
import { ArrowRight, Heart, Sparkles } from 'lucide-react';
import { motion } from 'motion/react';
import BackButton from '@/app/components/BackButton';
import backgroundImage from 'figma:asset/28d4c22fb590b3b1ac67e00069eacc779556f431.png';

export default function OnboardingStep6Screen() {
  const navigate = useNavigate();

  return (
    <div className="h-screen w-full relative overflow-hidden flex flex-col">
      {/* Back Button */}
      <BackButton to="/onboarding-step5" />

      {/* Background Image Layer */}
      <div 
        className="absolute inset-0 bg-cover bg-center bg-no-repeat"
        style={{
          backgroundImage: `url(${backgroundImage})`,
        }}
      />
      
      {/* Premium Multi-Layer Overlay for Perfect Readability */}
      <div className="absolute inset-0 bg-gradient-to-br from-pink-50/60 via-purple-50/50 to-rose-50/60" />
      <div className="absolute inset-0 bg-white/20 backdrop-blur-[1px]" />
      
      {/* Soft Vignette Effect */}
      <div className="absolute inset-0 bg-[radial-gradient(ellipse_at_center,_transparent_20%,_rgba(0,0,0,0.04)_100%)]" />
      
      {/* Animated Gradient Orbs for Depth */}
      <motion.div
        className="absolute top-1/3 right-1/3 w-[400px] h-[400px] bg-gradient-to-br from-rose-400/10 to-pink-400/10 rounded-full blur-3xl"
        animate={{
          scale: [1, 1.15, 1],
          opacity: [0.3, 0.5, 0.3],
          x: [0, 20, 0],
          y: [0, -15, 0],
        }}
        transition={{
          duration: 11,
          repeat: Infinity,
          ease: "easeInOut"
        }}
      />
      <motion.div
        className="absolute bottom-1/3 left-1/3 w-[400px] h-[400px] bg-gradient-to-br from-purple-400/10 to-indigo-400/10 rounded-full blur-3xl"
        animate={{
          scale: [1.1, 1, 1.1],
          opacity: [0.4, 0.6, 0.4],
          x: [0, -20, 0],
          y: [0, 15, 0],
        }}
        transition={{
          duration: 9,
          repeat: Infinity,
          ease: "easeInOut"
        }}
      />

      {/* Decorative Sparkles */}
      <motion.div
        className="absolute top-10 right-10 z-20"
        animate={{
          rotate: [0, 360],
          scale: [1, 1.3, 1],
        }}
        transition={{
          duration: 10,
          repeat: Infinity,
          ease: "linear"
        }}
      >
        <Sparkles className="w-7 h-7 text-purple-600/60 drop-shadow-lg" />
      </motion.div>

      <motion.div
        className="absolute top-16 left-10 z-20"
        animate={{
          rotate: [360, 0],
          scale: [1, 1.2, 1],
        }}
        transition={{
          duration: 9,
          repeat: Infinity,
          ease: "linear"
        }}
      >
        <Sparkles className="w-6 h-6 text-rose-600/60 drop-shadow-lg" />
      </motion.div>

      {/* Main Content Container - Fixed Single Screen Layout */}
      <div className="relative z-10 h-full flex flex-col px-6 py-6 max-w-md mx-auto w-full">
        
        {/* Top Section - Headline (20% height) */}
        <motion.div
          className="flex flex-col items-center justify-center"
          style={{ minHeight: '18vh' }}
          initial={{ opacity: 0, y: -20 }}
          animate={{ opacity: 1, y: 0 }}
          transition={{ duration: 0.8 }}
        >
          {/* Header with Decorative Elements */}
          <div className="flex items-center justify-center gap-2">
            {/* Left Leaf */}
            <Leaf className="w-4 h-4 text-pink-600/70 rotate-[-20deg] drop-shadow-sm" strokeWidth={2} />
            
            {/* Small Dot */}
            <div className="w-1 h-1 rounded-full bg-pink-500/60 drop-shadow-sm" />
            
            {/* Heading */}
            <h1 className="text-[32px] text-transparent bg-clip-text bg-gradient-to-r from-purple-900 via-pink-800 to-rose-800 drop-shadow-sm leading-tight">
              How it works
            </h1>
            
            {/* Small Dot */}
            <div className="w-1 h-1 rounded-full bg-pink-500/60 drop-shadow-sm" />
            
            {/* Right Leaf */}
            <Leaf className="w-4 h-4 text-pink-600/70 rotate-[20deg] scale-x-[-1] drop-shadow-sm" strokeWidth={2} />
          </div>
        </motion.div>

        {/* Center Section - Glass Card (52% height) */}
        <div className="flex items-center justify-center" style={{ minHeight: '50vh' }}>
          <motion.div
            className="relative w-full"
            initial={{ opacity: 0, scale: 0.95 }}
            animate={{ opacity: 1, scale: 1 }}
            transition={{ delay: 0.3, duration: 0.7 }}
          >
            {/* Outer Glow */}
            <div className="absolute -inset-2 bg-gradient-to-br from-pink-300/30 to-purple-300/30 rounded-[28px] blur-2xl" />
            
            {/* Premium Glass Card */}
            <div 
              className="relative rounded-[28px] px-8 py-8 overflow-hidden"
              style={{
                background: 'linear-gradient(135deg, rgba(255, 255, 255, 0.75) 0%, rgba(255, 255, 255, 0.65) 100%)',
                backdropFilter: 'blur(24px)',
                WebkitBackdropFilter: 'blur(24px)',
                border: '2px solid rgba(255, 255, 255, 0.8)',
                boxShadow: '0 24px 60px rgba(147, 51, 234, 0.2), inset 0 2px 16px rgba(255, 255, 255, 0.6)',
              }}
            >
              {/* Inner Light Effect */}
              <div className="absolute inset-0 bg-gradient-to-br from-white/40 via-transparent to-transparent rounded-[28px] pointer-events-none" />
              
              <div className="relative space-y-6">
                {/* Card Title */}
                <h2 className="text-center text-2xl text-transparent bg-clip-text bg-gradient-to-r from-purple-900 via-pink-800 to-rose-800 leading-tight font-semibold">
                  Words to say
                </h2>

                {/* Bullet Points */}
                <div className="space-y-4">
                  {/* Bullet 1 */}
                  <motion.div 
                    className="flex items-center gap-3"
                    initial={{ opacity: 0, x: -20 }}
                    animate={{ opacity: 1, x: 0 }}
                    transition={{ delay: 0.5 }}
                  >
                    <Heart className="w-5 h-5 text-pink-500 fill-pink-500 flex-shrink-0 drop-shadow-sm" />
                    <p className="text-gray-900 text-xl font-medium">
                      Ideas to try
                    </p>
                  </motion.div>

                  {/* Bullet 2 */}
                  <motion.div 
                    className="flex items-start gap-3"
                    initial={{ opacity: 0, x: -20 }}
                    animate={{ opacity: 1, x: 0 }}
                    transition={{ delay: 0.6 }}
                  >
                    <Heart className="w-5 h-5 text-pink-500 fill-pink-500 flex-shrink-0 mt-1 drop-shadow-sm" />
                    <p className="text-gray-900 text-xl font-medium leading-tight">
                      Memories<br />to remember
                    </p>
                  </motion.div>
                </div>

                {/* Premium Divider */}
                <motion.div 
                  className="relative py-3"
                  initial={{ opacity: 0 }}
                  animate={{ opacity: 1 }}
                  transition={{ delay: 0.7 }}
                >
                  <div className="absolute inset-0 flex items-center">
                    <div className="w-full h-px bg-gradient-to-r from-transparent via-pink-400/60 to-transparent" />
                  </div>
                  <div className="relative flex justify-center">
                    <div className="w-2 h-2 rounded-full bg-gradient-to-r from-pink-500 to-purple-500 shadow-lg" />
                  </div>
                </motion.div>

                {/* Bottom Statement */}
                <motion.div 
                  className="text-center space-y-1"
                  initial={{ opacity: 0, scale: 0.95 }}
                  animate={{ opacity: 1, scale: 1 }}
                  transition={{ delay: 0.8 }}
                >
                  <p className="text-gray-900 text-xl font-semibold">
                    100% personal.
                  </p>
                  <p className="text-gray-900 text-xl font-semibold">
                    0% emotional labor.
                  </p>
                </motion.div>
              </div>
            </div>
          </motion.div>
        </div>

        {/* Bottom CTA Section (28% height) */}
        <motion.div
          className="flex flex-col items-center justify-end space-y-3 pb-4"
          style={{ minHeight: '24vh' }}
          initial={{ opacity: 0, y: 40 }}
          animate={{ opacity: 1, y: 0 }}
          transition={{ delay: 0.6, duration: 0.7 }}
        >
          {/* Get Started Button */}
          <button
            onClick={() => navigate('/onboarding-step7')}
            className="w-full py-4 px-8 bg-gradient-to-r from-rose-500 via-pink-500 to-purple-500 text-white rounded-[20px] shadow-[0_10px_30px_rgba(219,39,119,0.4)] hover:shadow-[0_15px_40px_rgba(219,39,119,0.5)] transition-all duration-300 hover:scale-[1.02] active:scale-[0.98] relative overflow-hidden group"
          >
            {/* Shine Effect */}
            <motion.div
              className="absolute inset-0 bg-gradient-to-r from-transparent via-white/30 to-transparent skew-x-12"
              animate={{
                x: ['-200%', '200%'],
              }}
              transition={{
                duration: 2.5,
                repeat: Infinity,
                ease: "linear",
                repeatDelay: 1,
              }}
            />
            <div className="absolute inset-0 bg-gradient-to-r from-transparent via-white/10 to-transparent rounded-[20px]" />
            
            <span className="flex items-center justify-center gap-2.5 text-lg font-medium relative z-10">
              Continue
              <ArrowRight className="w-5 h-5 group-hover:translate-x-1 transition-transform duration-300" />
            </span>
          </button>

          {/* Progress Indicator */}
          <div className="flex items-center justify-center gap-2.5 py-1">
            <div className="w-2 h-2 rounded-full bg-purple-300/80" />
            <div className="w-2 h-2 rounded-full bg-purple-300/80" />
            <div className="w-2 h-2 rounded-full bg-purple-300/80" />
            <div className="w-2 h-2 rounded-full bg-purple-300/80" />
            <div className="w-3.5 h-3.5 rounded-full bg-gradient-to-r from-rose-500 to-purple-500 shadow-lg shadow-purple-400/60 ring-4 ring-purple-200/60" />
            <div className="w-2 h-2 rounded-full bg-purple-300/80" />
          </div>

          {/* Skip Option */}
          <button
            onClick={() => navigate('/auth')}
            className="text-purple-600 hover:text-purple-700 text-sm transition-colors font-medium"
          >
            Skip
          </button>
        </motion.div>
      </div>

      {/* Floating Sparkles */}
      {[...Array(14)].map((_, i) => (
        <motion.div
          key={i}
          className="absolute w-1 h-1 rounded-full bg-pink-300"
          style={{
            top: `${Math.random() * 100}%`,
            left: `${Math.random() * 100}%`,
          }}
          animate={{
            opacity: [0, 0.8, 0],
            scale: [0, 1.5, 0],
            y: [0, -30, -60],
          }}
          transition={{
            duration: 4 + Math.random() * 2,
            delay: i * 0.4,
            repeat: Infinity,
            ease: "easeOut"
          }}
        />
      ))}
    </div>
  );
}