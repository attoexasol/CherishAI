import { useNavigate, useLocation } from 'react-router';
import { Home, Heart, Gift, User, Search, Bell } from 'lucide-react';
import { motion, AnimatePresence } from 'motion/react';

export default function BottomNav() {
  const navigate = useNavigate();
  const location = useLocation();

  const navItems = [
    { path: '/individual/home', icon: Home, label: 'Home' },
    { path: '/individual/search', icon: Search, label: 'Search' },
    { path: '/individual/loved-ones-list', icon: Heart, label: 'Loved Ones' },
    { path: '/individual/notifications-list', icon: Bell, label: 'Alerts' },
    { path: '/individual/user-profile', icon: User, label: 'Profile' },
  ];

  return (
    <div className="fixed bottom-0 left-0 right-0 z-40 pointer-events-none px-4 pb-4">
      <div className="pointer-events-auto relative bg-white/90 backdrop-blur-2xl border border-rose-100/50 rounded-[28px] px-2 py-3 safe-area-bottom shadow-[0_10px_60px_rgba(244,63,94,0.15),0_-5px_30px_rgba(255,182,193,0.1)] max-w-md mx-auto overflow-hidden">
        {/* Animated gradient background */}
        <motion.div
          className="absolute inset-0 bg-gradient-to-r from-rose-100 via-pink-100 to-purple-100 opacity-85 shadow-[inset_0_0_40px_rgba(219,39,119,0.15)]"
          animate={{
            backgroundPosition: ['0% 50%', '100% 50%', '0% 50%'],
          }}
          transition={{
            duration: 12,
            repeat: Infinity,
            ease: "easeInOut"
          }}
          style={{ 
            backgroundSize: '200% 200%',
            background: 'linear-gradient(135deg, rgba(251,207,232,0.9) 0%, rgba(252,231,243,0.95) 25%, rgba(243,232,255,0.9) 50%, rgba(233,213,255,0.95) 75%, rgba(251,207,232,0.9) 100%)'
          }}
        />
        
        {/* Decorative gradient lines */}
        <div className="absolute top-0 left-0 right-0 h-[2px] bg-gradient-to-r from-transparent via-rose-400/40 to-transparent" />
        <div className="absolute bottom-0 left-0 right-0 h-[1px] bg-gradient-to-r from-rose-200/20 via-pink-200/20 to-purple-200/20" />
        
        {/* Floating particles effect */}
        {[...Array(3)].map((_, i) => (
          <motion.div
            key={i}
            className="absolute w-1 h-1 bg-rose-300/30 rounded-full"
            style={{
              left: `${20 + i * 30}%`,
              top: '50%',
            }}
            animate={{
              y: [-10, -20, -10],
              opacity: [0.3, 0.6, 0.3],
              scale: [1, 1.5, 1],
            }}
            transition={{
              duration: 3 + i,
              repeat: Infinity,
              ease: "easeInOut",
              delay: i * 0.5,
            }}
          />
        ))}
        
        <div className="flex justify-around items-center relative z-10">
          {navItems.map(({ path, icon: Icon, label }, index) => {
            // Enhanced active state logic for gift-related pages
            let isActive = location.pathname === path;
            
            // Special handling for Loved Ones tab - highlight for loved one list and details
            if (path === '/individual/loved-ones-list') {
              isActive = location.pathname === '/individual/loved-ones-list' || 
                         location.pathname.startsWith('/individual/loved-one-details');
            }
            
            // Special handling for Home tab
            if (path === '/individual/home') {
              isActive = location.pathname === '/individual/home' || 
                         location.pathname === '/individual/home-dashboard';
            }
            
            return (
              <motion.button
                key={path}
                onClick={() => navigate(path)}
                className="relative flex flex-col items-center gap-1.5 px-4 py-2 rounded-[20px] transition-all min-w-[75px]"
                whileTap={{ scale: 0.88 }}
                whileHover={{ scale: 1.08 }}
                initial={{ opacity: 0, y: 20 }}
                animate={{ opacity: 1, y: 0 }}
                transition={{ delay: index * 0.1 }}
              >
                {/* Active background with beautiful gradient */}
                <AnimatePresence>
                  {isActive && (
                    <>
                      <motion.div
                        layoutId="activeTab"
                        className="absolute inset-0 bg-gradient-to-br from-rose-200 via-pink-200 to-rose-100 rounded-[20px] shadow-[0_4px_20px_rgba(244,63,94,0.25)]"
                        initial={{ opacity: 0, scale: 0.8 }}
                        animate={{ opacity: 1, scale: 1 }}
                        exit={{ opacity: 0, scale: 0.8 }}
                        transition={{ duration: 0.4, ease: "easeInOut" }}
                      />
                      {/* Glowing border effect */}
                      <motion.div
                        className="absolute inset-0 rounded-[20px] border-2 border-rose-300/50"
                        initial={{ opacity: 0 }}
                        animate={{ opacity: [0.5, 1, 0.5] }}
                        transition={{ duration: 2, repeat: Infinity }}
                      />
                      {/* Inner glow */}
                      <motion.div
                        className="absolute inset-2 bg-white/40 rounded-[16px] blur-sm"
                        initial={{ opacity: 0 }}
                        animate={{ opacity: [0.3, 0.6, 0.3] }}
                        transition={{ duration: 2, repeat: Infinity }}
                      />
                    </>
                  )}
                </AnimatePresence>

                {/* Icon container with enhanced effects */}
                <motion.div 
                  className="relative z-10"
                  animate={isActive ? {
                    y: [0, -2, 0],
                  } : {}}
                  transition={{
                    duration: 2,
                    repeat: Infinity,
                    ease: "easeInOut"
                  }}
                >
                  <Icon 
                    className={`w-5 h-5 transition-all duration-300 ${
                      isActive 
                        ? 'text-rose-600 drop-shadow-[0_3px_12px_rgba(244,63,94,0.5)]' 
                        : 'text-gray-400'
                    }`}
                    strokeWidth={isActive ? 2.8 : 2}
                  />
                  
                  {/* Active indicator sparkle */}
                  <AnimatePresence>
                    {isActive && (
                      <>
                        <motion.div
                          className="absolute -top-1 -right-1 w-2 h-2 bg-gradient-to-br from-rose-400 to-pink-500 rounded-full shadow-[0_0_10px_rgba(244,63,94,0.8)]"
                          initial={{ scale: 0, opacity: 0 }}
                          animate={{ 
                            scale: [1, 1.3, 1],
                            opacity: [1, 0.8, 1],
                          }}
                          exit={{ scale: 0, opacity: 0 }}
                          transition={{ 
                            duration: 1.5,
                            repeat: Infinity,
                          }}
                        />
                        {/* Sparkle rays */}
                        <motion.div
                          className="absolute -top-1 -right-1 w-2 h-2"
                          initial={{ rotate: 0, scale: 0 }}
                          animate={{ 
                            rotate: 180,
                            scale: [1, 1.5, 1],
                            opacity: [0.6, 0, 0.6],
                          }}
                          transition={{ 
                            duration: 2,
                            repeat: Infinity,
                          }}
                        >
                          <div className="w-full h-full relative">
                            <div className="absolute w-3 h-[1px] bg-gradient-to-r from-rose-400 to-transparent -left-1 top-1/2" />
                            <div className="absolute w-[1px] h-3 bg-gradient-to-b from-rose-400 to-transparent left-1/2 -top-1" />
                          </div>
                        </motion.div>
                      </>
                    )}
                  </AnimatePresence>
                </motion.div>

                {/* Label with gradient text for active state */}
                <span 
                  className={`relative z-10 text-xs font-bold transition-all duration-300 leading-tight drop-shadow-[0_1px_2px_rgba(0,0,0,0.1)] ${
                    isActive 
                      ? 'bg-gradient-to-r from-rose-600 via-pink-600 to-rose-600 bg-clip-text text-transparent drop-shadow-[0_2px_4px_rgba(244,63,94,0.3)]' 
                      : 'text-gray-600'
                  }`}
                >
                  {label}
                </span>

                {/* Hover ripple effect */}
                {!isActive && (
                  <motion.div
                    className="absolute inset-0 rounded-[20px]"
                    style={{ backgroundColor: 'rgba(254, 205, 211, 0)' }}
                    whileHover={{
                      backgroundColor: 'rgba(254, 205, 211, 0.3)',
                    }}
                    transition={{ duration: 0.3 }}
                  />
                )}
              </motion.button>
            );
          })}
        </div>

        {/* Bottom decorative shine */}
        <motion.div
          className="absolute bottom-0 left-0 right-0 h-20 bg-gradient-to-t from-rose-50/30 to-transparent pointer-events-none rounded-b-[28px]"
          animate={{
            opacity: [0.3, 0.5, 0.3],
          }}
          transition={{
            duration: 3,
            repeat: Infinity,
            ease: "easeInOut"
          }}
        />
      </div>
    </div>
  );
}