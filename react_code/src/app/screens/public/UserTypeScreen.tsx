import { useState } from 'react';
import { useNavigate } from 'react-router-dom';
import { Check, ArrowLeft } from 'lucide-react';
import { useApp } from '../../context/AppContext';
import { motion } from 'motion/react';
import { ImageWithFallback } from '../../components/figma/ImageWithFallback';
import cherishLogo from 'figma:asset/1ba0763b2c65c413d13ec69a501bf3eb00e15b25.png';
import individualIllustration from 'figma:asset/8f9dc6013a9b5bb901d3faf28067cbf21de37706.png';
import businessIllustration from 'figma:asset/c11c058f162e99a65ee5a7c510045780c1e6dad8.png';

export default function UserTypeScreen() {
  const navigate = useNavigate();
  const { setUserType } = useApp();
  const [selectedType, setSelectedType] = useState<'individual' | 'business' | null>(null);

  const handleSelect = (type: 'individual' | 'business') => {
    setSelectedType(type);
    // Auto-advance after a brief moment to show selection
    setTimeout(() => {
      setUserType(type);
      
      // Update user in localStorage with selected type
      const existingUsersJson = localStorage.getItem('cherish_users');
      if (existingUsersJson) {
        const existingUsers = JSON.parse(existingUsersJson);
        const userIndex = existingUsers.findIndex((u: any) => u.isNewUser === true);
        
        if (userIndex !== -1) {
          existingUsers[userIndex].userType = type;
          existingUsers[userIndex].isNewUser = false; // No longer a new user after selecting type
          localStorage.setItem('cherish_users', JSON.stringify(existingUsers));
        }
      }
      
      if (type === 'individual') {
        navigate('/individual/user-info');
      } else {
        navigate('/business/splash');
      }
    }, 600);
  };

  return (
    <div className="min-h-screen relative overflow-hidden">
      {/* Soft Lavender / Blush Gradient Background */}
      <div className="absolute inset-0 bg-gradient-to-br from-purple-100 via-pink-50 to-rose-100" />
      <div className="absolute inset-0 bg-gradient-to-t from-pink-50/60 via-transparent to-lavender-50/40" />
      
      {/* Back Button - Fixed at Top Left */}
      <motion.div
        className="fixed top-8 left-8 z-50"
        initial={{ opacity: 0, scale: 0.8 }}
        animate={{ opacity: 1, scale: 1 }}
        transition={{ duration: 0.8, delay: 0.5 }}
      >
        <motion.button
          onClick={() => navigate('/auth')}
          className="w-14 h-14 flex items-center justify-center rounded-full shadow-xl"
          style={{
            background: 'linear-gradient(135deg, rgba(255, 255, 255, 0.95) 0%, rgba(255, 241, 247, 0.9) 100%)',
            backdropFilter: 'blur(20px)',
            boxShadow: '0 8px 24px rgba(236, 72, 153, 0.25)',
            border: '2px solid rgba(251, 113, 133, 0.4)',
          }}
          whileHover={{ 
            scale: 1.1, 
            boxShadow: '0 12px 32px rgba(236, 72, 153, 0.35)',
            border: '2px solid rgba(251, 113, 133, 0.6)',
          }}
          whileTap={{ scale: 0.95 }}
          transition={{ duration: 0.2 }}
        >
          <ArrowLeft className="w-6 h-6 text-rose-500" />
        </motion.button>
      </motion.div>
      
      <div className="relative z-10 px-6 py-8 max-w-6xl mx-auto flex flex-col justify-center min-h-screen">
        {/* Logo & Title Section */}
        <motion.div
          className="text-center mb-12"
          initial={{ opacity: 0, y: -20 }}
          animate={{ opacity: 1, y: 0 }}
        >
          {/* CherishAI Logo with Glow */}
          <motion.div
            className="inline-flex items-center justify-center w-40 h-40 mb-6 relative"
            initial={{ scale: 0.8, opacity: 0 }}
            animate={{ scale: 1, opacity: 1 }}
            transition={{ duration: 0.5 }}
          >
            {/* Soft Glow Behind Logo */}
            <div className="absolute inset-0 bg-gradient-to-br from-rose-300/30 via-pink-300/30 to-purple-300/30 rounded-full blur-3xl scale-125" />
            
            <motion.div
              animate={{
                scale: [1, 1.05, 1],
              }}
              transition={{
                duration: 3,
                repeat: Infinity,
                ease: "easeInOut"
              }}
              className="relative w-full h-full"
            >
              <ImageWithFallback
                src={cherishLogo}
                alt="Cherish AI Logo"
                className="w-full h-full object-contain drop-shadow-2xl"
              />
            </motion.div>
          </motion.div>

          {/* Title with Premium Typography */}
          <h1 className="text-3xl md:text-4xl text-purple-800 px-4 leading-tight">
            How would you like to use <span className="text-rose-600">Cherish AI</span>?
          </h1>
          <p className="text-rose-500 mt-3 text-lg">Choose the path that's right for you 💕</p>
        </motion.div>

        {/* Premium Selection Cards with Glass-morphism */}
        <div className="grid grid-cols-1 md:grid-cols-2 gap-6 max-w-5xl mx-auto w-full md:items-stretch">
          {/* Individual Card */}
          <motion.div
            initial={{ opacity: 0, y: 30 }}
            animate={{ opacity: 1, y: 0 }}
            transition={{ delay: 0.2 }}
            onClick={() => handleSelect('individual')}
            whileHover={{ scale: 1.03, y: -6 }}
            whileTap={{ scale: 0.98 }}
            className="relative cursor-pointer group flex"
          >
            {/* Outer Glow Effect */}
            <div className={`absolute inset-0 rounded-[28px] transition-all duration-500 ${
              selectedType === 'individual'
                ? 'bg-gradient-to-br from-rose-400/30 via-pink-400/30 to-purple-400/30 blur-xl scale-110'
                : 'bg-gradient-to-br from-rose-300/20 to-pink-300/20 blur-lg scale-105 opacity-60 group-hover:opacity-100'
            }`} />
            
            <div
              className={`relative bg-white/80 backdrop-blur-xl rounded-[28px] p-8 transition-all duration-500 w-full ${
                selectedType === 'individual'
                  ? 'border-[3px] border-rose-400/70 shadow-[0_12px_40px_rgba(244,63,94,0.25),0_24px_72px_rgba(236,72,153,0.15),inset_0_1px_2px_rgba(255,255,255,0.9)]'
                  : 'border-[2.5px] border-rose-300/60 shadow-[0_8px_32px_rgba(244,63,94,0.15),inset_0_1px_1px_rgba(255,255,255,0.8)] hover:border-[3px] hover:border-rose-400/70 hover:shadow-[0_12px_40px_rgba(244,63,94,0.22)]'
              }`}
            >
              {/* Subtle Inner Gradient Overlay */}
              <div className={`absolute inset-0 rounded-[25px] transition-opacity duration-500 ${
                selectedType === 'individual'
                  ? 'bg-gradient-to-br from-rose-50/50 via-pink-50/40 to-transparent opacity-100'
                  : 'bg-gradient-to-br from-rose-50/30 via-pink-50/20 to-transparent opacity-70 group-hover:opacity-100'
              }`} />

              <div className="relative z-10">
                {/* Header */}
                <h3 className="text-2xl text-purple-800 text-center mb-6 font-semibold">
                  I am an individual
                </h3>

                {/* Central Illustration with Premium Frame */}
                <div className="relative w-full aspect-square max-w-[260px] mx-auto mb-6">
                  <div className="absolute inset-0 bg-gradient-to-br from-rose-100/50 to-pink-100/50 rounded-[24px] blur-sm scale-105" />
                  <div className="relative w-full h-full rounded-[24px] overflow-hidden shadow-lg border border-white/60">
                    <ImageWithFallback
                      src={individualIllustration}
                      alt="Caring couple illustration"
                      className="w-full h-full object-cover"
                    />
                  </div>
                </div>

                {/* Description */}
                <p className="text-gray-700 leading-relaxed text-center mb-8 px-2 text-base">
                  I have loved ones, and I want Cherish AI to help me care for them with intention - thinking for me, making the effort for me, and keeping love personal and alive.
                </p>

                {/* Bottom Center Checkmark Indicator */}
                <div className="flex justify-center">
                  <motion.div
                    initial={{ scale: 0 }}
                    animate={{ scale: selectedType === 'individual' ? 1 : 0 }}
                    className="w-14 h-14 rounded-full bg-gradient-to-br from-rose-400 via-pink-500 to-purple-500 flex items-center justify-center shadow-[0_4px_20px_rgba(244,63,94,0.4),0_0_0_4px_rgba(255,255,255,0.8),0_0_0_5px_rgba(244,63,94,0.2)]"
                  >
                    <Check className="w-8 h-8 text-white" strokeWidth={3.5} />
                  </motion.div>
                </div>
              </div>
            </div>
          </motion.div>

          {/* Business Card */}
          <motion.div
            initial={{ opacity: 0, y: 30 }}
            animate={{ opacity: 1, y: 0 }}
            transition={{ delay: 0.3 }}
            onClick={() => handleSelect('business')}
            whileHover={{ scale: 1.03, y: -6 }}
            whileTap={{ scale: 0.98 }}
            className="relative cursor-pointer group flex"
          >
            {/* Outer Glow Effect */}
            <div className={`absolute inset-0 rounded-[28px] transition-all duration-500 ${
              selectedType === 'business'
                ? 'bg-gradient-to-br from-rose-400/30 via-pink-400/30 to-purple-400/30 blur-xl scale-110'
                : 'bg-gradient-to-br from-purple-300/20 to-pink-300/20 blur-lg scale-105 opacity-60 group-hover:opacity-100'
            }`} />
            
            <div
              className={`relative bg-white/80 backdrop-blur-xl rounded-[28px] p-8 transition-all duration-500 w-full ${
                selectedType === 'business'
                  ? 'border-[3px] border-rose-400/70 shadow-[0_12px_40px_rgba(244,63,94,0.25),0_24px_72px_rgba(236,72,153,0.15),inset_0_1px_2px_rgba(255,255,255,0.9)]'
                  : 'border-[2.5px] border-purple-300/60 shadow-[0_8px_32px_rgba(147,51,234,0.15),inset_0_1px_1px_rgba(255,255,255,0.8)] hover:border-[3px] hover:border-purple-400/70 hover:shadow-[0_12px_40px_rgba(147,51,234,0.22)]'
              }`}
            >
              {/* Subtle Inner Gradient Overlay */}
              <div className={`absolute inset-0 rounded-[25px] transition-opacity duration-500 ${
                selectedType === 'business'
                  ? 'bg-gradient-to-br from-rose-50/50 via-pink-50/40 to-transparent opacity-100'
                  : 'bg-gradient-to-br from-purple-50/30 via-pink-50/20 to-transparent opacity-70 group-hover:opacity-100'
              }`} />

              <div className="relative z-10">
                {/* Header */}
                <h3 className="text-2xl text-purple-800 text-center mb-6 font-semibold">
                  I am a business
                </h3>

                {/* Central Illustration with Premium Frame */}
                <div className="relative w-full aspect-square max-w-[260px] mx-auto mb-6">
                  <div className="absolute inset-0 bg-gradient-to-br from-purple-100/50 to-pink-100/50 rounded-[24px] blur-sm scale-105" />
                  <div className="relative w-full h-full rounded-[24px] overflow-hidden shadow-lg border border-white/60">
                    <ImageWithFallback
                      src={businessIllustration}
                      alt="Gift shop illustration"
                      className="w-full h-full object-cover"
                    />
                  </div>
                </div>

                {/* Description */}
                <p className="text-gray-700 leading-relaxed text-center mb-8 px-2 text-base">
                  I offer products or services that help people express care and appreciation, and I want Cherish AI to thoughtfully connect my offerings to the moments and relationships where they matter most.
                </p>

                {/* Bottom Center Checkmark Indicator */}
                <div className="flex justify-center">
                  <motion.div
                    initial={{ scale: 0 }}
                    animate={{ scale: selectedType === 'business' ? 1 : 0 }}
                    className="w-14 h-14 rounded-full bg-gradient-to-br from-rose-400 via-pink-500 to-purple-500 flex items-center justify-center shadow-[0_4px_20px_rgba(244,63,94,0.4),0_0_0_4px_rgba(255,255,255,0.8),0_0_0_5px_rgba(244,63,94,0.2)]"
                  >
                    <Check className="w-8 h-8 text-white" strokeWidth={3.5} />
                  </motion.div>
                </div>
              </div>
            </div>
          </motion.div>
        </div>
      </div>
    </div>
  );
}
