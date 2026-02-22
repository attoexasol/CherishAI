import { Heart, Sparkles, Star, Globe, Calendar } from 'lucide-react';
import { motion } from 'motion/react';
import familyIllustration from 'figma:asset/c5abe42ed0b9fbf185fb3afab3a63c164a92e403.png';
import cherishAIBrandedLogo from 'figma:asset/b9321a626bb492078cfc740f3911e32d7d7847ca.png';
import { useNavigate } from 'react-router-dom';
import { useState } from 'react';
import timeClockImage from 'figma:asset/18e444e6a0754359dd5861d75bd22280f3572ee3.png';
import effortsImage from 'figma:asset/173a2d824017e52434275f3f4f6fa54bb138f6c4.png';
import emotionalWorkImage from 'figma:asset/396ef3d84039d9c724035b5ecbc2a3fc0a478c6f.png';
import cherishAILogo from 'figma:asset/e8b604f0c3ff46a950f6de8039686bdf587fad28.png';
import cherishAIPurpleLogo from 'figma:asset/d861638b7f197188535a7e92c0ff01938810a016.png';
import cherishAILogoText from 'figma:asset/d88d7c41ef23467b5a012731343f1e4e022fdbca.png';
import cherishAILogoPink from 'figma:asset/9b6b67ca9953a0817ca7e99b65bdd215fced53de.png';

export default function HeroBannerDemo() {
  const navigate = useNavigate();
  const [showLanguageMenu, setShowLanguageMenu] = useState(false);
  const [selectedLanguage, setSelectedLanguage] = useState('English');

  const languages = [
    { code: 'en', name: 'English', flag: '🇺🇸' },
    { code: 'es', name: 'Español', flag: '🇪🇸' },
    { code: 'fr', name: 'Français', flag: '🇫🇷' },
    { code: 'de', name: 'Deutsch', flag: '🇩🇪' },
    { code: 'it', name: 'Italiano', flag: '🇮🇹' },
    { code: 'pt', name: 'Português', flag: '🇵🇹' },
    { code: 'zh', name: '中文', flag: '🇨🇳' },
    { code: 'ja', name: '日本語', flag: '🇯🇵' },
    { code: 'ko', name: '한국어', flag: '🇰🇷' },
    { code: 'ar', name: 'العربية', flag: '🇸🇦' },
    { code: 'hi', name: 'हिन्दी', flag: '🇮🇳' },
    { code: 'ru', name: 'Русский', flag: '🇷🇺' },
  ];

  const handleLanguageSelect = (language: string) => {
    setSelectedLanguage(language);
    setShowLanguageMenu(false);
  };

  return (
    <div 
      className="min-h-screen w-full relative overflow-hidden"
      style={{
        background: '#FFFFFF',
      }}
    >
      {/* Decorative Floating Gradient Orbs - matching app theme */}
      <motion.div
        className="absolute top-20 right-10 w-96 h-96 bg-rose-300/20 rounded-full blur-3xl"
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
        className="absolute bottom-20 left-10 w-96 h-96 bg-purple-300/20 rounded-full blur-3xl"
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
      <motion.div
        className="absolute top-1/2 left-1/2 w-96 h-96 bg-pink-300/15 rounded-full blur-3xl"
        animate={{
          scale: [1, 1.3, 1],
          opacity: [0.2, 0.4, 0.2],
        }}
        transition={{
          duration: 10,
          repeat: Infinity,
          ease: "easeInOut"
        }}
      />

      {/* Main Content Container */}
      <div className="relative z-10 px-4 sm:px-6 lg:px-8 py-12 max-w-7xl mx-auto">
        <div className="space-y-6">
          {/* Main Hero Card - 3 Column Layout */}
          <motion.div
            className="relative overflow-hidden rounded-[28px] p-8 md:p-12"
            style={{
              background: 'linear-gradient(135deg, rgba(255, 255, 255, 0.95) 0%, rgba(255, 241, 247, 0.9) 100%)',
              backdropFilter: 'blur(20px)',
              boxShadow: '0 8px 32px rgba(236, 72, 153, 0.12)',
              border: '1px solid rgba(251, 207, 232, 0.3)',
            }}
            initial={{ opacity: 0, y: 30 }}
            animate={{ opacity: 1, y: 0 }}
            transition={{ duration: 0.8 }}
          >
            {/* Inner Decorative Gradient */}
            <div className="absolute top-0 right-0 w-64 h-64 bg-rose-200/10 rounded-full blur-3xl" />
            <div className="absolute bottom-0 left-0 w-64 h-64 bg-purple-200/10 rounded-full blur-3xl" />
            
            <div className="relative grid grid-cols-1 md:grid-cols-3 gap-8 md:gap-12 items-center">
              {/* LEFT COLUMN - Text Block */}
              <div className="space-y-6">
                <motion.h1 
                  className="font-semibold leading-tight"
                  style={{
                    fontSize: '24px',
                    color: '#7A3E55',
                    lineHeight: '1.4',
                  }}
                  initial={{ opacity: 0, x: -20 }}
                  animate={{ opacity: 1, x: 0 }}
                  transition={{ duration: 0.6, delay: 0.2 }}
                >
                  Most apps focused on maintaining relationships today still ask too much of you.
                </motion.h1>
                
                <div className="space-y-4">
                  {['Your time', 'Your efforts', 'Emotional work'].map((item, index) => (
                    <motion.div 
                      key={item}
                      className="flex items-center gap-3 group"
                      initial={{ opacity: 0, x: -20 }}
                      animate={{ opacity: 1, x: 0 }}
                      transition={{ duration: 0.5, delay: 0.3 + index * 0.1 }}
                    >
                      <div 
                        className="flex items-center justify-center w-11 h-11 rounded-full transition-all group-hover:scale-110 overflow-hidden"
                        style={{
                          background: '#FFFFFF',
                          boxShadow: '0 2px 8px rgba(236, 72, 153, 0.15)',
                          border: '1px solid rgba(251, 207, 232, 0.3)',
                        }}
                      >
                        {item === 'Your time' ? (
                          <img 
                            src={timeClockImage} 
                            alt="Time clock" 
                            className="w-full h-full object-cover"
                          />
                        ) : item === 'Your efforts' ? (
                          <img 
                            src={effortsImage} 
                            alt="Efforts" 
                            className="w-full h-full object-cover"
                          />
                        ) : (
                          <img 
                            src={emotionalWorkImage} 
                            alt="Emotional work" 
                            className="w-full h-full object-cover"
                          />
                        )}
                      </div>
                      <span 
                        className="font-medium"
                        style={{
                          fontSize: '17px',
                          color: '#A84968',
                          lineHeight: '1.5',
                        }}
                      >
                        {item}
                      </span>
                    </motion.div>
                  ))}
                </div>
              </div>

              {/* CENTER COLUMN - Family Illustration */}
              <div className="flex justify-center">
                <motion.div
                  className="relative"
                  initial={{ opacity: 0, scale: 0.8 }}
                  animate={{ opacity: 1, scale: 1 }}
                  transition={{ duration: 0.8, delay: 0.4 }}
                >
                  {/* Decorative sparkles around illustration */}
                  <motion.div
                    className="absolute -top-4 -right-4"
                    animate={{ 
                      rotate: [0, 10, 0],
                      scale: [1, 1.1, 1] 
                    }}
                    transition={{ 
                      duration: 3, 
                      repeat: Infinity,
                      ease: "easeInOut" 
                    }}
                  >
                    <Sparkles className="w-6 h-6 text-pink-400" fill="#F472B6" />
                  </motion.div>
                  <motion.div
                    className="absolute -bottom-2 -left-2"
                    animate={{ 
                      rotate: [0, -10, 0],
                      scale: [1, 1.15, 1] 
                    }}
                    transition={{ 
                      duration: 3.5, 
                      repeat: Infinity,
                      ease: "easeInOut",
                      delay: 0.5
                    }}
                  >
                    <Star className="w-5 h-5 text-purple-400" fill="#C084FC" />
                  </motion.div>
                  
                  <motion.img 
                    src={cherishAIBrandedLogo} 
                    alt="CherishAI - Family embracing with love" 
                    className="w-56 md:w-64 h-auto relative z-10"
                    style={{
                      filter: 'drop-shadow(0px 8px 24px rgba(236, 72, 153, 0.2))',
                    }}
                    animate={{
                      y: [0, -8, 0],
                    }}
                    transition={{
                      duration: 4,
                      repeat: Infinity,
                      ease: "easeInOut"
                    }}
                  />
                </motion.div>
              </div>

              {/* RIGHT COLUMN - Brand Area */}
              <div className="flex flex-col justify-center items-center md:items-end text-center md:text-right space-y-4">
                <motion.h1
                  className="font-semibold leading-tight"
                  style={{
                    fontSize: '20px',
                    color: '#7A3E55',
                    lineHeight: '1.3',
                  }}
                  initial={{ opacity: 0, y: -10 }}
                  animate={{ opacity: 1, y: 0 }}
                  transition={{ duration: 0.6, delay: 0.5 }}
                >
                  Not another relationship coach
                </motion.h1>
                
                <motion.img
                  src={cherishAILogoPink}
                  alt="CherishAI"
                  className="my-2"
                  style={{
                    width: 'auto',
                    height: '45px',
                    objectFit: 'cover',
                    objectPosition: 'center',
                    transform: 'scale(1.05)',
                    clipPath: 'inset(0 3% 0 3%)',
                  }}
                  initial={{ opacity: 0, scale: 0.9 }}
                  animate={{ opacity: 1, scale: 1 }}
                  transition={{ duration: 0.6, delay: 0.6 }}
                />
                
                <motion.p
                  className="font-medium"
                  style={{
                    fontSize: '22px',
                    color: '#8B4A65',
                    lineHeight: '1.5',
                  }}
                  initial={{ opacity: 0 }}
                  animate={{ opacity: 1 }}
                  transition={{ duration: 0.6, delay: 0.7 }}
                >
                  is your personal
                  <br />
                  love assistant
                </motion.p>
              </div>
            </div>
          </motion.div>

          {/* Bottom CTA Card */}
          <motion.div
            className="relative overflow-hidden rounded-[28px] py-8 px-8 md:px-12"
            style={{
              background: 'linear-gradient(135deg, rgba(255, 255, 255, 0.95) 0%, rgba(255, 241, 247, 0.9) 100%)',
              backdropFilter: 'blur(20px)',
              boxShadow: '0 8px 32px rgba(236, 72, 153, 0.12)',
              border: '1px solid rgba(251, 207, 232, 0.3)',
            }}
            initial={{ opacity: 0, y: 30 }}
            animate={{ opacity: 1, y: 0 }}
            transition={{ duration: 0.8, delay: 0.2 }}
          >
            {/* Decorative gradient orbs */}
            <div className="absolute top-0 right-0 w-48 h-48 bg-pink-200/15 rounded-full blur-2xl" />
            <div className="absolute bottom-0 left-0 w-48 h-48 bg-rose-200/15 rounded-full blur-2xl" />
            
            <div className="relative z-10 text-center">
              <motion.p
                className="font-semibold"
                style={{
                  fontSize: '19px',
                  color: '#7A3E55',
                  lineHeight: '1.6',
                }}
                initial={{ opacity: 0 }}
                animate={{ opacity: 1 }}
                transition={{ duration: 0.6, delay: 0.4 }}
              >
                It thinks for you, makes efforts for you and helps you love and care better.
              </motion.p>
            </div>
          </motion.div>

          {/* How It Works Section */}
          <motion.div
            className="mt-16 space-y-8"
            initial={{ opacity: 0 }}
            animate={{ opacity: 1 }}
            transition={{ duration: 0.8, delay: 0.4 }}
          >
            {/* How it works Header - Simple one line */}
            <motion.div
              className="text-center"
              initial={{ opacity: 0, y: 20 }}
              animate={{ opacity: 1, y: 0 }}
              transition={{ duration: 0.8, delay: 0.5 }}
            >
              <h2 
                className="font-bold italic inline-block"
                style={{
                  fontSize: '42px',
                  color: '#7A3E55',
                  lineHeight: '1.2',
                }}
              >
                HOW IT WORKS
              </h2>
            </motion.div>

            {/* Three Cards Grid */}
            <div className="grid grid-cols-1 md:grid-cols-3 gap-6">
              {/* Card 1 - You add (now with 5 points) */}
              <motion.div
                className="relative overflow-hidden rounded-[28px] p-8 cursor-pointer transition-all duration-300"
                style={{
                  background: 'linear-gradient(135deg, rgba(255, 255, 255, 0.85) 0%, rgba(255, 241, 247, 0.8) 100%)',
                  backdropFilter: 'blur(20px)',
                  boxShadow: '0 8px 32px rgba(236, 72, 153, 0.1)',
                  border: '2px solid rgba(251, 113, 133, 0.5)',
                }}
                initial={{ opacity: 0, y: 30 }}
                animate={{ opacity: 1, y: 0 }}
                transition={{ duration: 0.8, delay: 0.6 }}
                whileHover={{ 
                  scale: 1.02,
                  boxShadow: '0 12px 40px rgba(236, 72, 153, 0.18)',
                  border: '2px solid rgba(251, 113, 133, 0.7)',
                }}
              >
                <div className="space-y-5 relative z-10">
                  {/* Numbered Steps - Now 5 items */}
                  {[
                    { num: 1, text: 'You add yourself' },
                    { num: 2, text: 'You add your loved one' },
                    { num: 3, text: 'You set your relationship goal' },
                    { num: 4, text: 'You share their preferences' },
                    { num: 5, text: 'You share important dates (birthdays, first date, etc.)' }
                  ].map((step, idx) => (
                    <motion.div 
                      key={step.num}
                      className="flex items-start gap-4"
                      initial={{ opacity: 0, x: -20 }}
                      animate={{ opacity: 1, x: 0 }}
                      transition={{ duration: 0.5, delay: 0.7 + idx * 0.1 }}
                    >
                      <div 
                        className="flex-shrink-0 w-11 h-11 rounded-full flex items-center justify-center font-bold"
                        style={{
                          background: 'linear-gradient(135deg, rgba(251, 113, 133, 0.15) 0%, rgba(244, 114, 182, 0.15) 100%)',
                          border: '2px solid rgba(251, 113, 133, 0.3)',
                          fontSize: '18px',
                          color: '#A84968',
                        }}
                      >
                        {step.num}
                      </div>
                      <p 
                        className="font-medium pt-2"
                        style={{
                          fontSize: '16px',
                          color: '#7A3E55',
                          lineHeight: '1.5',
                        }}
                      >
                        {step.text}
                      </p>
                    </motion.div>
                  ))}

                  {/* That's all decoration */}
                  <motion.div
                    className="pt-4 text-center"
                    initial={{ opacity: 0 }}
                    animate={{ opacity: 1 }}
                    transition={{ duration: 0.6, delay: 1.2 }}
                  >
                    <div className="flex items-center justify-center gap-2">
                      <span 
                        className="text-2xl"
                        role="img" 
                        aria-label="gift"
                      >
                        🎁
                      </span>
                      <p 
                        className="font-medium italic"
                        style={{
                          fontSize: '18px',
                          color: '#B05A78',
                        }}
                      >
                        That's all...
                      </p>
                    </div>
                  </motion.div>
                </div>

                {/* Decorative elements */}
                <div className="absolute bottom-4 left-4 opacity-20">
                  <span className="text-4xl">🎀</span>
                </div>
              </motion.div>

              {/* Card 2 - CherishAI does the heavy lifting */}
              <motion.div
                className="relative overflow-hidden rounded-[28px] p-8 cursor-pointer transition-all duration-300"
                style={{
                  background: 'linear-gradient(135deg, rgba(255, 255, 255, 0.85) 0%, rgba(254, 242, 248, 0.8) 100%)',
                  backdropFilter: 'blur(20px)',
                  boxShadow: '0 8px 32px rgba(236, 72, 153, 0.1)',
                  border: '2px solid rgba(251, 113, 133, 0.5)',
                }}
                initial={{ opacity: 0, y: 30 }}
                animate={{ opacity: 1, y: 0 }}
                transition={{ duration: 0.8, delay: 0.7 }}
                whileHover={{ 
                  scale: 1.02,
                  boxShadow: '0 12px 40px rgba(236, 72, 153, 0.18)',
                  border: '2px solid rgba(251, 113, 133, 0.7)',
                }}
              >
                <div className="space-y-6 relative z-10">
                  {/* Header */}
                  <motion.h3
                    className="font-bold text-center"
                    style={{
                      fontSize: '22px',
                      color: '#7A3E55',
                      lineHeight: '1.3',
                      fontWeight: 700,
                    }}
                    initial={{ opacity: 0 }}
                    animate={{ opacity: 1 }}
                    transition={{ duration: 0.6, delay: 0.8 }}
                  >
                    CherishAI does the heavy lifting
                  </motion.h3>

                  {/* Subtext */}
                  <motion.p
                    className="text-center"
                    style={{
                      fontSize: '15px',
                      color: '#8B4A65',
                      lineHeight: '1.6',
                      fontWeight: 600,
                    }}
                    initial={{ opacity: 0 }}
                    animate={{ opacity: 1 }}
                    transition={{ duration: 0.6, delay: 0.9 }}
                  >
                    It thinks daily deeply on how to achieve your relationship goal
                  </motion.p>

                  {/* Bullet Points */}
                  <div className="space-y-4">
                    <motion.div
                      className="flex items-start gap-3"
                      initial={{ opacity: 0, x: -10 }}
                      animate={{ opacity: 1, x: 0 }}
                      transition={{ duration: 0.5, delay: 1.0 }}
                    >
                      <Heart className="w-5 h-5 flex-shrink-0 mt-1 text-pink-400" fill="#F9A8D4" />
                      <p 
                        style={{
                          fontSize: '15px',
                          color: '#7A3E55',
                          lineHeight: '1.5',
                          fontWeight: 600,
                        }}
                      >
                        Words you can share or say to them, thoughtfully prepared
                      </p>
                    </motion.div>

                    <motion.div
                      className="flex items-start gap-3"
                      initial={{ opacity: 0, x: -10 }}
                      animate={{ opacity: 1, x: 0 }}
                      transition={{ duration: 0.5, delay: 1.1 }}
                    >
                      <Heart className="w-5 h-5 flex-shrink-0 mt-1 text-pink-400" fill="#F9A8D4" />
                      <p 
                        style={{
                          fontSize: '15px',
                          color: '#7A3E55',
                          lineHeight: '1.5',
                          fontWeight: 600,
                        }}
                      >
                        Gifts you can offer for each special occasion, carefully chosen
                      </p>
                    </motion.div>

                    <motion.div
                      className="flex items-start gap-3"
                      initial={{ opacity: 0, x: -10 }}
                      animate={{ opacity: 1, x: 0 }}
                      transition={{ duration: 0.5, delay: 1.2 }}
                    >
                      <Heart className="w-5 h-5 flex-shrink-0 mt-1 text-pink-400" fill="#F9A8D4" />
                      <p 
                        style={{
                          fontSize: '15px',
                          color: '#7A3E55',
                          lineHeight: '1.5',
                          fontWeight: 600,
                        }}
                      >
                        Cherish remembers important dates so you can focus on being present
                      </p>
                    </motion.div>
                  </div>
                </div>

                {/* Decorative gifts */}
                <div className="absolute bottom-4 right-4 opacity-30 flex gap-1">
                  <span className="text-3xl">🎁</span>
                  <span className="text-2xl">🎀</span>
                </div>
              </motion.div>

              {/* Card 3 - Words to say & Business offering */}
              <motion.div
                className="relative overflow-hidden rounded-[28px] p-8 cursor-pointer transition-all duration-300"
                style={{
                  background: 'linear-gradient(135deg, rgba(255, 255, 255, 0.85) 0%, rgba(255, 241, 247, 0.8) 100%)',
                  backdropFilter: 'blur(20px)',
                  boxShadow: '0 8px 32px rgba(236, 72, 153, 0.1)',
                  border: '2px solid rgba(251, 113, 133, 0.5)',
                }}
                initial={{ opacity: 0, y: 30 }}
                animate={{ opacity: 1, y: 0 }}
                transition={{ duration: 0.8, delay: 0.8 }}
                whileHover={{ 
                  scale: 1.02,
                  boxShadow: '0 12px 40px rgba(236, 72, 153, 0.18)',
                  border: '2px solid rgba(251, 113, 133, 0.7)',
                }}
              >
                <div className="space-y-8 relative z-10 flex flex-col justify-center h-full">
                  {/* Standout Value Prop - Clean text without box */}
                  <motion.div
                    className="text-center"
                    initial={{ opacity: 0, scale: 0.95 }}
                    animate={{ opacity: 1, scale: 1 }}
                    transition={{ duration: 0.6, delay: 0.9 }}
                  >
                    <motion.p
                      className="font-bold"
                      style={{
                        fontSize: '22px',
                        background: 'linear-gradient(135deg, #E11D48 0%, #EC4899 50%, #A855F7 100%)',
                        WebkitBackgroundClip: 'text',
                        WebkitTextFillColor: 'transparent',
                        backgroundClip: 'text',
                        lineHeight: '1.5',
                        letterSpacing: '0.5px',
                      }}
                      animate={{
                        scale: [1, 1.02, 1],
                      }}
                      transition={{
                        duration: 2,
                        repeat: Infinity,
                        ease: "easeInOut"
                      }}
                    >
                      100% personal love,
                      <br />
                      0% emotional labor
                    </motion.p>
                  </motion.div>
                </div>
              </motion.div>
            </div>

            {/* Business Offering Card - Redesigned */}
            <motion.div
              className="relative overflow-hidden rounded-[28px] py-12 px-8 md:px-16"
              style={{
                background: 'linear-gradient(135deg, rgba(255, 255, 255, 0.95) 0%, rgba(254, 242, 248, 0.92) 100%)',
                backdropFilter: 'blur(20px)',
                boxShadow: '0 8px 32px rgba(168, 85, 247, 0.15)',
                border: '1px solid rgba(251, 207, 232, 0.4)',
              }}
              initial={{ opacity: 0, y: 30 }}
              animate={{ opacity: 1, y: 0 }}
              transition={{ duration: 0.8, delay: 1.3 }}
            >
              {/* Decorative gradient orbs */}
              <div className="absolute top-0 right-0 w-64 h-64 bg-pink-200/20 rounded-full blur-3xl" />
              <div className="absolute bottom-0 left-0 w-64 h-64 bg-purple-200/20 rounded-full blur-3xl" />

              {/* Decorative store/gift icons */}
              <motion.div
                className="absolute bottom-8 left-12"
                animate={{ 
                  scale: [1, 1.2, 1],
                  opacity: [0.4, 0.6, 0.4]
                }}
                transition={{ 
                  duration: 3.5, 
                  repeat: Infinity,
                  ease: "easeInOut",
                  delay: 1
                }}
              >
                <span className="text-4xl" role="img" aria-label="gift">🎁</span>
              </motion.div>

              <div className="text-center space-y-6 relative z-10 max-w-3xl mx-auto">
                <motion.h3
                  className="font-bold"
                  style={{
                    fontSize: '28px',
                    color: '#7A3E55',
                    lineHeight: '1.4',
                  }}
                  initial={{ opacity: 0 }}
                  animate={{ opacity: 1 }}
                  transition={{ duration: 0.8, delay: 1.5 }}
                >
                  Are you a business offering gifts and services that help people express love?
                </motion.h3>

                <motion.p
                  className="font-medium"
                  style={{
                    fontSize: '19px',
                    color: '#8B4A65',
                    lineHeight: '1.8',
                  }}
                  initial={{ opacity: 0 }}
                  animate={{ opacity: 1 }}
                  transition={{ duration: 0.8, delay: 1.7 }}
                >
                  Register with CherishAI so your products and services can be thoughtfully suggested to users when they're needed most - at the perfect moment of connection.
                </motion.p>

                <motion.div
                  className="flex items-center justify-center gap-2 pt-2"
                  initial={{ opacity: 0 }}
                  animate={{ opacity: 1 }}
                  transition={{ duration: 0.6, delay: 1.9 }}
                >
                  <Heart className="w-5 h-5 text-rose-400" fill="#FB7185" />
                  <p 
                    className="font-semibold italic"
                    style={{
                      fontSize: '17px',
                      color: '#A84968',
                    }}
                  >
                    Help people cherish those they love
                  </p>
                  <Heart className="w-5 h-5 text-rose-400" fill="#FB7185" />
                </motion.div>
              </div>
            </motion.div>

            {/* Continue Button */}
            <motion.div
              className="flex justify-center pt-8"
              initial={{ opacity: 0, y: 20 }}
              animate={{ opacity: 1, y: 0 }}
              transition={{ duration: 0.8, delay: 2.1 }}
            >
              <motion.button
                onClick={() => navigate('/auth')}
                className="px-16 py-5 rounded-full font-semibold text-white shadow-2xl"
                style={{
                  background: 'linear-gradient(135deg, #FB7185 0%, #F472B6 100%)',
                  fontSize: '22px',
                  boxShadow: '0 8px 24px rgba(251, 113, 133, 0.4)',
                }}
                whileHover={{ scale: 1.05, boxShadow: '0 12px 32px rgba(251, 113, 133, 0.5)' }}
                whileTap={{ scale: 0.98 }}
                transition={{ duration: 0.2 }}
              >
                Continue
              </motion.button>
            </motion.div>
          </motion.div>
        </div>
      </div>

      {/* Language Selection Button - Fixed at Top Right */}
      <motion.div
        className="fixed top-8 right-8 z-50"
        initial={{ opacity: 0, scale: 0.8 }}
        animate={{ opacity: 1, scale: 1 }}
        transition={{ duration: 0.8, delay: 0.5 }}
      >
        <div className="relative">
          {/* Language Dropdown Menu */}
          {showLanguageMenu && (
            <motion.div
              className="absolute top-full right-0 mt-4 rounded-[24px] overflow-hidden"
              style={{
                background: 'linear-gradient(135deg, rgba(255, 255, 255, 0.98) 0%, rgba(255, 241, 247, 0.95) 100%)',
                backdropFilter: 'blur(20px)',
                boxShadow: '0 8px 32px rgba(236, 72, 153, 0.2)',
                border: '1px solid rgba(251, 207, 232, 0.4)',
                maxHeight: '320px',
                width: '280px',
              }}
              initial={{ opacity: 0, scale: 0.9, y: -10 }}
              animate={{ opacity: 1, scale: 1, y: 0 }}
              exit={{ opacity: 0, scale: 0.9, y: -10 }}
              transition={{ duration: 0.3 }}
            >
              {/* Language Menu Header */}
              <div 
                className="px-6 py-4 border-b"
                style={{
                  borderColor: 'rgba(251, 207, 232, 0.3)',
                }}
              >
                <p 
                  className="font-semibold text-center"
                  style={{
                    fontSize: '16px',
                    color: '#7A3E55',
                  }}
                >
                  Select Language
                </p>
              </div>

              {/* Language Options - Scrollable */}
              <div 
                className="overflow-y-auto py-2"
                style={{
                  maxHeight: '260px',
                }}
              >
                {languages.map((lang) => (
                  <motion.button
                    key={lang.code}
                    onClick={() => handleLanguageSelect(lang.name)}
                    className="w-full px-6 py-3 flex items-center gap-3 transition-all"
                    style={{
                      backgroundColor: selectedLanguage === lang.name ? 'rgba(251, 113, 133, 0.1)' : 'transparent',
                    }}
                    whileHover={{
                      backgroundColor: 'rgba(251, 113, 133, 0.08)',
                    }}
                    whileTap={{ scale: 0.98 }}
                  >
                    <span className="text-2xl">{lang.flag}</span>
                    <span 
                      className="font-medium flex-1 text-left"
                      style={{
                        fontSize: '15px',
                        color: selectedLanguage === lang.name ? '#C2185B' : '#7A3E55',
                      }}
                    >
                      {lang.name}
                    </span>
                    {selectedLanguage === lang.name && (
                      <motion.div
                        initial={{ scale: 0 }}
                        animate={{ scale: 1 }}
                        transition={{ duration: 0.2 }}
                      >
                        <Heart className="w-4 h-4 text-pink-500" fill="#EC4899" />
                      </motion.div>
                    )}
                  </motion.button>
                ))}
              </div>
            </motion.div>
          )}

          {/* Language Button */}
          <motion.button
            onClick={() => setShowLanguageMenu(!showLanguageMenu)}
            className="w-14 h-14 flex items-center justify-center rounded-full shadow-xl"
            style={{
              background: 'linear-gradient(135deg, rgba(255, 255, 255, 0.95) 0%, rgba(255, 241, 247, 0.9) 100%)',
              backdropFilter: 'blur(20px)',
              boxShadow: '0 8px 24px rgba(236, 72, 153, 0.25)',
              border: '1px solid rgba(251, 207, 232, 0.4)',
            }}
            whileHover={{ 
              scale: 1.1, 
              boxShadow: '0 12px 32px rgba(236, 72, 153, 0.35)' 
            }}
            whileTap={{ scale: 0.95 }}
            transition={{ duration: 0.2 }}
          >
            <Globe className="w-8 h-8 text-purple-500" />
          </motion.button>
        </div>
      </motion.div>

      {/* Backdrop overlay when menu is open */}
      {showLanguageMenu && (
        <motion.div
          className="fixed inset-0 z-40"
          style={{
            background: 'rgba(0, 0, 0, 0.1)',
          }}
          initial={{ opacity: 0 }}
          animate={{ opacity: 1 }}
          exit={{ opacity: 0 }}
          onClick={() => setShowLanguageMenu(false)}
        />
      )}
    </div>
  );
}