import { useNavigate } from 'react-router-dom';
import { Heart, Sparkles, Star, ArrowRight, CheckCircle2, Gift, Calendar, Users, Zap, Shield, TrendingUp } from 'lucide-react';
import { motion, useScroll, useTransform, useSpring } from 'motion/react';
import { useState, useEffect, useRef } from 'react';

export default function SplashScreen() {
  const navigate = useNavigate();
  const [activeFeature, setActiveFeature] = useState(0);
  const containerRef = useRef(null);
  const heroRef = useRef(null);

  const { scrollYProgress } = useScroll({
    target: containerRef,
    offset: ["start start", "end end"]
  });

  const { scrollYProgress: heroProgress } = useScroll({
    target: heroRef,
    offset: ["start start", "end start"]
  });

  const smoothProgress = useSpring(scrollYProgress, { stiffness: 100, damping: 30 });
  
  const heroScale = useTransform(heroProgress, [0, 0.5], [1, 0.9]);
  const heroOpacity = useTransform(heroProgress, [0, 0.3], [1, 0]);
  const heroY = useTransform(heroProgress, [0, 0.5], [0, -50]);

  const features = [
    {
      icon: Heart,
      title: 'Never Miss a Moment',
      description: 'AI-powered reminders for birthdays, anniversaries, and every special occasion that matters',
      color: '#E91E63',
      accentColor: '#F06292',
      bgGradient: 'linear-gradient(135deg, #FFE5EC 0%, #FFF0F5 100%)',
      iconGradient: 'linear-gradient(135deg, #E91E63 0%, #F06292 100%)',
    },
    {
      icon: Calendar,
      title: 'Perfect Timing, Always',
      description: 'Intelligent scheduling ensures you reach out at just the right moment to show you care',
      color: '#9C27B0',
      accentColor: '#BA68C8',
      bgGradient: 'linear-gradient(135deg, #F3E5F5 0%, #FAF0FF 100%)',
      iconGradient: 'linear-gradient(135deg, #9C27B0 0%, #BA68C8 100%)',
    },
    {
      icon: Gift,
      title: 'Thoughtful Gift Discovery',
      description: 'Personalized suggestions based on interests, preferences, and meaningful connections',
      color: '#F06292',
      accentColor: '#F48FB1',
      bgGradient: 'linear-gradient(135deg, #FCE4EC 0%, #FFF5F8 100%)',
      iconGradient: 'linear-gradient(135deg, #F06292 0%, #F48FB1 100%)',
    },
  ];

  useEffect(() => {
    const interval = setInterval(() => {
      setActiveFeature((prev) => (prev + 1) % features.length);
    }, 4500);
    return () => clearInterval(interval);
  }, []);

  // Premium floating elements
  const FloatingOrb = ({ delay = 0, duration = 8, size = 'large', color = '#E91E63' }) => (
    <motion.div
      className="absolute rounded-full blur-3xl pointer-events-none"
      style={{
        width: size === 'large' ? '400px' : '250px',
        height: size === 'large' ? '400px' : '250px',
        background: `radial-gradient(circle, ${color}30 0%, transparent 70%)`,
        left: Math.random() * 100 + '%',
        top: Math.random() * 100 + '%',
      }}
      animate={{
        x: [0, Math.random() * 100 - 50, 0],
        y: [0, Math.random() * 100 - 50, 0],
        scale: [1, 1.2, 1],
        opacity: [0.3, 0.5, 0.3],
      }}
      transition={{
        duration,
        delay,
        repeat: Infinity,
        ease: "easeInOut",
      }}
    />
  );

  const MicroParticle = ({ index }) => (
    <motion.div
      className="absolute w-1 h-1 rounded-full"
      style={{
        background: index % 2 === 0 ? '#E91E63' : '#9C27B0',
        left: `${Math.random() * 100}%`,
        top: `${Math.random() * 100}%`,
      }}
      animate={{
        y: [0, -20, 0],
        opacity: [0, 1, 0],
        scale: [0, 1, 0],
      }}
      transition={{
        duration: 3 + Math.random() * 2,
        delay: Math.random() * 2,
        repeat: Infinity,
        ease: "easeOut",
      }}
    />
  );

  return (
    <div 
      ref={containerRef}
      className="min-h-screen relative overflow-hidden"
      style={{
        background: 'linear-gradient(180deg, #FFFBFC 0%, #FFF5F7 25%, #FFEFF3 50%, #FCE8ED 75%, #F5E0E7 100%)',
      }}
    >
      {/* Animated Background Layer */}
      <div className="absolute inset-0 overflow-hidden pointer-events-none">
        <FloatingOrb delay={0} duration={10} size="large" color="#E91E63" />
        <FloatingOrb delay={2} duration={12} size="medium" color="#9C27B0" />
        <FloatingOrb delay={4} duration={14} size="large" color="#F06292" />
        
        {[...Array(20)].map((_, i) => (
          <MicroParticle key={i} index={i} />
        ))}
      </div>

      {/* Main Content */}
      <div className="relative z-10 max-w-md mx-auto px-6">
        {/* Hero Section */}
        <motion.div
          ref={heroRef}
          className="min-h-screen flex flex-col items-center justify-center py-20"
          style={{
            scale: heroScale,
            opacity: heroOpacity,
            y: heroY,
          }}
        >
          {/* Premium Logo */}
          <motion.div
            className="relative mb-8"
            initial={{ scale: 0, rotate: -180 }}
            animate={{ scale: 1, rotate: 0 }}
            transition={{
              duration: 1.2,
              ease: [0.34, 1.56, 0.64, 1],
              type: "spring",
            }}
          >
            {/* Glow layers */}
            <motion.div
              className="absolute inset-0 -m-8"
              animate={{
                opacity: [0.4, 0.7, 0.4],
                scale: [1, 1.1, 1],
              }}
              transition={{
                duration: 3,
                repeat: Infinity,
                ease: "easeInOut",
              }}
            >
              <div 
                className="w-full h-full rounded-full blur-3xl"
                style={{
                  background: 'radial-gradient(circle, #E91E63 0%, #9C27B0 100%)',
                  opacity: 0.5,
                }}
              />
            </motion.div>

            {/* Main logo container */}
            <motion.div
              className="relative w-36 h-36 rounded-[40px] flex items-center justify-center"
              style={{
                background: 'linear-gradient(135deg, #E91E63 0%, #9C27B0 100%)',
                boxShadow: '0 25px 70px rgba(233, 30, 99, 0.45), inset 0 1px 20px rgba(255, 255, 255, 0.4)',
              }}
              animate={{
                y: [0, -12, 0],
                rotateY: [0, 5, 0],
              }}
              transition={{
                duration: 4,
                repeat: Infinity,
                ease: "easeInOut",
              }}
            >
              {/* Inner glow */}
              <div 
                className="absolute inset-4 rounded-[28px] opacity-40"
                style={{
                  background: 'radial-gradient(circle at 30% 30%, rgba(255, 255, 255, 0.5) 0%, transparent 60%)',
                }}
              />
              
              <motion.div
                animate={{
                  scale: [1, 1.15, 1],
                  rotate: [0, 8, -8, 0],
                }}
                transition={{
                  duration: 3,
                  repeat: Infinity,
                  ease: "easeInOut",
                }}
              >
                <Heart className="w-20 h-20 text-white fill-white drop-shadow-2xl" />
              </motion.div>

              {/* Orbiting particles */}
              {[0, 1, 2].map((i) => (
                <motion.div
                  key={i}
                  className="absolute w-3 h-3 rounded-full bg-white/80"
                  style={{
                    boxShadow: '0 0 12px rgba(255, 255, 255, 0.8)',
                  }}
                  animate={{
                    rotate: 360,
                    scale: [1, 1.3, 1],
                  }}
                  transition={{
                    rotate: { duration: 4, repeat: Infinity, ease: "linear", delay: i * 1.33 },
                    scale: { duration: 2, repeat: Infinity, ease: "easeInOut", delay: i * 0.66 },
                  }}
                  style={{
                    left: '50%',
                    top: '50%',
                    transformOrigin: `${35 + i * 5}px center`,
                  }}
                />
              ))}
            </motion.div>
          </motion.div>

          {/* Brand Name */}
          <motion.h1
            className="font-black text-center mb-4"
            style={{
              fontSize: 'clamp(42px, 10vw, 56px)',
              background: 'linear-gradient(135deg, #C2185B 0%, #E91E63 25%, #9C27B0 75%, #7B1FA2 100%)',
              WebkitBackgroundClip: 'text',
              WebkitTextFillColor: 'transparent',
              backgroundClip: 'text',
              letterSpacing: '-2px',
              lineHeight: 1,
            }}
            initial={{ opacity: 0, y: 30 }}
            animate={{ opacity: 1, y: 0 }}
            transition={{ delay: 0.4, duration: 0.8 }}
          >
            Cherish AI
          </motion.h1>

          {/* Premium Badge */}
          <motion.div
            className="inline-flex items-center gap-2 px-6 py-3 rounded-full mb-6"
            style={{
              background: 'linear-gradient(135deg, rgba(233, 30, 99, 0.1) 0%, rgba(156, 39, 176, 0.1) 100%)',
              border: '2px solid',
              borderImage: 'linear-gradient(135deg, #E91E63, #9C27B0) 1',
              backdropFilter: 'blur(10px)',
              boxShadow: '0 8px 32px rgba(233, 30, 99, 0.2)',
            }}
            initial={{ opacity: 0, scale: 0.8 }}
            animate={{ opacity: 1, scale: 1 }}
            transition={{ delay: 0.6, duration: 0.6 }}
          >
            <Sparkles className="w-4 h-4" style={{ color: '#E91E63' }} />
            <span className="font-bold text-sm tracking-widest" style={{ color: '#C2185B' }}>
              LOVE • CARE • CONNECT
            </span>
            <Sparkles className="w-4 h-4" style={{ color: '#9C27B0' }} />
          </motion.div>

          {/* Headline */}
          <motion.h2
            className="text-3xl font-bold text-center mb-5 px-4 leading-tight"
            style={{ color: '#4A1942' }}
            initial={{ opacity: 0, y: 20 }}
            animate={{ opacity: 1, y: 0 }}
            transition={{ delay: 0.8, duration: 0.8 }}
          >
            Make Every Moment
            <br />
            <span 
              style={{
                background: 'linear-gradient(135deg, #E91E63, #9C27B0)',
                WebkitBackgroundClip: 'text',
                WebkitTextFillColor: 'transparent',
                backgroundClip: 'text',
              }}
            >
              Unforgettable
            </span>
          </motion.h2>

          {/* Subheadline */}
          <motion.p
            className="text-lg text-center px-6 mb-10 leading-relaxed max-w-sm"
            style={{ color: '#6B2C4D' }}
            initial={{ opacity: 0 }}
            animate={{ opacity: 1 }}
            transition={{ delay: 1, duration: 0.8 }}
          >
            The AI-powered companion that helps you nurture relationships and celebrate what truly matters
          </motion.p>

          {/* Stats */}
          <motion.div
            className="grid grid-cols-3 gap-4 w-full mb-10"
            initial={{ opacity: 0, y: 30 }}
            animate={{ opacity: 1, y: 0 }}
            transition={{ delay: 1.2, duration: 0.6 }}
          >
            {[
              { value: '10k+', label: 'Happy Users', icon: Users, gradient: 'linear-gradient(135deg, #E91E63, #F06292)' },
              { value: '50k+', label: 'Moments Tracked', icon: Heart, gradient: 'linear-gradient(135deg, #9C27B0, #BA68C8)' },
              { value: '4.9★', label: 'App Rating', icon: Star, gradient: 'linear-gradient(135deg, #F06292, #F48FB1)' },
            ].map((stat, i) => (
              <motion.div
                key={stat.label}
                className="relative rounded-3xl p-5 text-center overflow-hidden"
                style={{
                  background: 'rgba(255, 255, 255, 0.7)',
                  backdropFilter: 'blur(20px)',
                  border: '1px solid rgba(233, 30, 99, 0.15)',
                  boxShadow: '0 8px 32px rgba(233, 30, 99, 0.12)',
                }}
                initial={{ opacity: 0, scale: 0.8, y: 20 }}
                animate={{ opacity: 1, scale: 1, y: 0 }}
                transition={{ delay: 1.3 + i * 0.1, duration: 0.5 }}
                whileHover={{ 
                  scale: 1.05, 
                  y: -5,
                  boxShadow: '0 12px 40px rgba(233, 30, 99, 0.2)',
                }}
              >
                {/* Background gradient on hover */}
                <motion.div
                  className="absolute inset-0 opacity-0"
                  style={{ background: stat.gradient }}
                  whileHover={{ opacity: 0.05 }}
                  transition={{ duration: 0.3 }}
                />
                
                <div className="relative z-10">
                  <motion.div
                    className="w-10 h-10 mx-auto mb-3 rounded-2xl flex items-center justify-center"
                    style={{ background: stat.gradient }}
                    whileHover={{ rotate: 10, scale: 1.1 }}
                  >
                    <stat.icon className="w-5 h-5 text-white" />
                  </motion.div>
                  <div 
                    className="text-2xl font-black mb-1"
                    style={{ 
                      background: stat.gradient,
                      WebkitBackgroundClip: 'text',
                      WebkitTextFillColor: 'transparent',
                      backgroundClip: 'text',
                    }}
                  >
                    {stat.value}
                  </div>
                  <div className="text-xs font-semibold" style={{ color: '#6B2C4D' }}>
                    {stat.label}
                  </div>
                </div>
              </motion.div>
            ))}
          </motion.div>

          {/* Scroll indicator */}
          <motion.div
            className="flex flex-col items-center gap-2"
            initial={{ opacity: 0 }}
            animate={{ opacity: 1 }}
            transition={{ delay: 1.5, duration: 0.8 }}
          >
            <p className="text-xs font-semibold tracking-wide" style={{ color: '#9C7B8A' }}>
              SCROLL TO EXPLORE
            </p>
            <motion.div
              animate={{ y: [0, 8, 0] }}
              transition={{ duration: 1.5, repeat: Infinity, ease: "easeInOut" }}
            >
              <div 
                className="w-6 h-10 rounded-full flex items-start justify-center pt-2"
                style={{
                  border: '2px solid #E91E63',
                }}
              >
                <motion.div
                  className="w-1.5 h-1.5 rounded-full"
                  style={{ background: '#E91E63' }}
                  animate={{ y: [0, 16, 0] }}
                  transition={{ duration: 1.5, repeat: Infinity, ease: "easeInOut" }}
                />
              </div>
            </motion.div>
          </motion.div>
        </motion.div>

        {/* Feature Showcase with Glassmorphism Cards */}
        <div className="py-16 space-y-8">
          <motion.div
            className="text-center mb-12"
            initial={{ opacity: 0, y: 30 }}
            whileInView={{ opacity: 1, y: 0 }}
            viewport={{ once: true, margin: "-100px" }}
            transition={{ duration: 0.6 }}
          >
            <h2 className="text-3xl font-black mb-3" style={{ color: '#4A1942' }}>
              Everything You Need
            </h2>
            <p className="text-base" style={{ color: '#6B2C4D' }}>
              Powerful features designed for meaningful connections
            </p>
          </motion.div>

          {features.map((feature, index) => {
            const FeatureIcon = feature.icon;
            return (
              <motion.div
                key={index}
                className="relative rounded-[32px] p-8 overflow-hidden"
                style={{
                  background: 'rgba(255, 255, 255, 0.6)',
                  backdropFilter: 'blur(20px)',
                  border: '2px solid rgba(233, 30, 99, 0.15)',
                  boxShadow: '0 20px 60px rgba(233, 30, 99, 0.15)',
                }}
                initial={{ opacity: 0, y: 50 }}
                whileInView={{ opacity: 1, y: 0 }}
                viewport={{ once: true, margin: "-50px" }}
                transition={{ duration: 0.6, delay: index * 0.15 }}
                whileHover={{ 
                  y: -8,
                  boxShadow: '0 25px 70px rgba(233, 30, 99, 0.25)',
                }}
              >
                {/* Gradient accent bar */}
                <div 
                  className="absolute top-0 left-0 right-0 h-1.5"
                  style={{ background: feature.iconGradient }}
                />

                {/* Background pattern */}
                <div 
                  className="absolute inset-0 opacity-[0.03]"
                  style={{ background: feature.bgGradient }}
                />

                <div className="relative z-10">
                  {/* Icon */}
                  <motion.div
                    className="w-16 h-16 mb-5 rounded-[24px] flex items-center justify-center"
                    style={{
                      background: feature.iconGradient,
                      boxShadow: `0 12px 32px ${feature.color}40`,
                    }}
                    whileHover={{ 
                      rotate: [0, -5, 5, 0],
                      scale: 1.1,
                    }}
                    transition={{ duration: 0.5 }}
                  >
                    <FeatureIcon className="w-8 h-8 text-white" />
                  </motion.div>

                  {/* Content */}
                  <h3 className="text-2xl font-bold mb-3" style={{ color: '#4A1942' }}>
                    {feature.title}
                  </h3>
                  <p className="text-base leading-relaxed" style={{ color: '#6B2C4D' }}>
                    {feature.description}
                  </p>

                  {/* Decorative element */}
                  <motion.div
                    className="absolute bottom-8 right-8 w-24 h-24 rounded-full opacity-10 blur-2xl"
                    style={{ background: feature.color }}
                    whileHover={{ scale: 1.5, opacity: 0.15 }}
                  />
                </div>
              </motion.div>
            );
          })}
        </div>

        {/* Trust Section */}
        <motion.div
          className="py-12"
          initial={{ opacity: 0, y: 40 }}
          whileInView={{ opacity: 1, y: 0 }}
          viewport={{ once: true }}
          transition={{ duration: 0.6 }}
        >
          <div 
            className="rounded-[32px] p-8 relative overflow-hidden"
            style={{
              background: 'rgba(255, 255, 255, 0.7)',
              backdropFilter: 'blur(20px)',
              border: '2px solid rgba(233, 30, 99, 0.15)',
              boxShadow: '0 20px 60px rgba(233, 30, 99, 0.15)',
            }}
          >
            <div className="flex items-center justify-center gap-2 mb-6">
              <CheckCircle2 className="w-6 h-6" style={{ color: '#10B981' }} />
              <h3 className="text-xl font-bold" style={{ color: '#4A1942' }}>
                Built on Trust
              </h3>
            </div>

            <div className="grid grid-cols-3 gap-6">
              {[
                { icon: Shield, label: 'Bank-Level Security', color: '#9C27B0' },
                { icon: Heart, label: 'Ad-Free Forever', color: '#E91E63' },
                { icon: TrendingUp, label: 'Always Improving', color: '#F06292' },
              ].map((item, i) => (
                <motion.div
                  key={i}
                  className="text-center"
                  initial={{ opacity: 0, scale: 0.8 }}
                  whileInView={{ opacity: 1, scale: 1 }}
                  viewport={{ once: true }}
                  transition={{ delay: i * 0.1, duration: 0.4 }}
                  whileHover={{ scale: 1.1, y: -4 }}
                >
                  <motion.div
                    className="w-14 h-14 mx-auto mb-3 rounded-2xl flex items-center justify-center"
                    style={{
                      background: `linear-gradient(135deg, ${item.color}15, ${item.color}25)`,
                      border: `1.5px solid ${item.color}30`,
                    }}
                    whileHover={{ rotate: 10 }}
                  >
                    <item.icon className="w-7 h-7" style={{ color: item.color }} />
                  </motion.div>
                  <p className="text-xs font-bold leading-tight" style={{ color: '#6B2C4D' }}>
                    {item.label}
                  </p>
                </motion.div>
              ))}
            </div>
          </div>
        </motion.div>

        {/* Premium CTA */}
        <motion.div
          className="pb-20 pt-8"
          initial={{ opacity: 0, y: 40 }}
          whileInView={{ opacity: 1, y: 0 }}
          viewport={{ once: true }}
          transition={{ duration: 0.6 }}
        >
          <motion.button
            onClick={() => navigate('/auth')}
            className="w-full relative rounded-[28px] py-6 px-8 font-black text-xl overflow-hidden group"
            style={{
              background: 'linear-gradient(135deg, #E91E63 0%, #9C27B0 100%)',
              color: '#FFFFFF',
              boxShadow: '0 20px 60px rgba(233, 30, 99, 0.45)',
            }}
            whileHover={{
              scale: 1.02,
              boxShadow: '0 25px 70px rgba(233, 30, 99, 0.55)',
            }}
            whileTap={{ scale: 0.98 }}
          >
            {/* Animated shimmer */}
            <motion.div
              className="absolute inset-0"
              style={{
                background: 'linear-gradient(90deg, transparent 0%, rgba(255, 255, 255, 0.4) 50%, transparent 100%)',
              }}
              animate={{
                x: ['-200%', '200%'],
              }}
              transition={{
                duration: 2,
                repeat: Infinity,
                ease: "easeInOut",
              }}
            />

            {/* Pulsing background */}
            <motion.div
              className="absolute inset-0"
              style={{
                background: 'radial-gradient(circle at center, rgba(255, 255, 255, 0.2) 0%, transparent 70%)',
              }}
              animate={{
                scale: [1, 1.2, 1],
                opacity: [0.5, 0.8, 0.5],
              }}
              transition={{
                duration: 2,
                repeat: Infinity,
                ease: "easeInOut",
              }}
            />

            <span className="relative z-10 flex items-center justify-center gap-3">
              <Sparkles className="w-6 h-6" />
              Start Your Journey
              <motion.div
                animate={{ x: [0, 6, 0] }}
                transition={{ duration: 1.5, repeat: Infinity }}
              >
                <ArrowRight className="w-6 h-6" />
              </motion.div>
            </span>
          </motion.button>

          <motion.p
            className="text-center text-sm mt-5 font-medium"
            style={{ color: '#9C7B8A' }}
            initial={{ opacity: 0 }}
            whileInView={{ opacity: 1 }}
            viewport={{ once: true }}
            transition={{ delay: 0.3 }}
          >
            ✨ Free forever • No credit card required
          </motion.p>
        </motion.div>
      </div>
    </div>
  );
}
