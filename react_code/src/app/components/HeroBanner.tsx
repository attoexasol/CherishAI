import { Heart } from 'lucide-react';
import { motion } from 'motion/react';

export default function HeroBanner() {
  return (
    <div 
      className="w-full flex items-center justify-center py-12 px-6"
      style={{
        background: 'linear-gradient(135deg, #FFE6EF 0%, #FAD1E4 100%)',
        position: 'relative',
      }}
    >
      {/* Subtle texture overlay */}
      <div 
        className="absolute inset-0 opacity-30"
        style={{
          backgroundImage: `url("data:image/svg+xml,%3Csvg width='60' height='60' viewBox='0 0 60 60' xmlns='http://www.w3.org/2000/svg'%3E%3Cg fill='%23FFB6D0' fill-opacity='0.15' fill-rule='evenodd'%3E%3Ccircle cx='30' cy='30' r='1'/%3E%3Ccircle cx='15' cy='45' r='1'/%3E%3Ccircle cx='45' cy='15' r='1'/%3E%3C/g%3E%3C/svg%3E")`,
          mixBlendMode: 'overlay',
        }}
      />
      
      {/* Noise grain overlay */}
      <div 
        className="absolute inset-0 opacity-20"
        style={{
          backgroundImage: `url("data:image/svg+xml,%3Csvg viewBox='0 0 200 200' xmlns='http://www.w3.org/2000/svg'%3E%3Cfilter id='noiseFilter'%3E%3CfeTurbulence type='fractalNoise' baseFrequency='0.9' numOctaves='4' stitchTiles='stitch'/%3E%3C/filter%3E%3Crect width='100%25' height='100%25' filter='url(%23noiseFilter)' opacity='0.3'/%3E%3C/svg%3E")`,
          mixBlendMode: 'soft-light',
        }}
      />

      <div className="w-full max-w-[1200px] relative z-10 space-y-6">
        {/* Main Card */}
        <motion.div
          className="rounded-[30px] p-10"
          style={{
            background: 'rgba(255, 255, 255, 0.6)',
            backdropFilter: 'blur(10px)',
            boxShadow: '0px 8px 20px rgba(255, 150, 180, 0.25)',
          }}
          initial={{ opacity: 0, y: 20 }}
          animate={{ opacity: 1, y: 0 }}
          transition={{ duration: 0.6 }}
        >
          <div className="grid grid-cols-1 md:grid-cols-3 gap-8 items-center">
            {/* LEFT COLUMN - Text Block */}
            <div className="space-y-4">
              <h1 
                className="font-semibold leading-tight"
                style={{
                  fontFamily: "'Poppins', 'Rounded Mplus 1c', sans-serif",
                  fontSize: '22px',
                  color: '#7A3E55',
                  lineHeight: '1.4',
                }}
              >
                Most relationship apps today still ask more from you
              </h1>
              
              <div className="space-y-3">
                {['Time', 'Efforts', 'Emotional work'].map((item, index) => (
                  <motion.div 
                    key={item}
                    className="flex items-center gap-3"
                    initial={{ opacity: 0, x: -10 }}
                    animate={{ opacity: 1, x: 0 }}
                    transition={{ duration: 0.4, delay: 0.2 + index * 0.1 }}
                  >
                    <Heart 
                      className="w-5 h-5 flex-shrink-0" 
                      fill="#FF8FB3" 
                      stroke="#FF8FB3"
                      style={{ opacity: 0.9 }}
                    />
                    <span 
                      style={{
                        fontFamily: "'Poppins', sans-serif",
                        fontSize: '16px',
                        color: '#B05A78',
                        lineHeight: '1.4',
                      }}
                    >
                      {item}
                    </span>
                  </motion.div>
                ))}
              </div>
            </div>

            {/* CENTER COLUMN - Illustration */}
            <div className="flex flex-col items-center justify-center relative">
              {/* Floral decoration on top */}
              <motion.div 
                className="absolute -top-8 z-10"
                initial={{ scale: 0, rotate: -20 }}
                animate={{ scale: 1, rotate: 0 }}
                transition={{ duration: 0.5, delay: 0.3 }}
              >
                <svg width="80" height="40" viewBox="0 0 80 40" fill="none">
                  {/* Rose */}
                  <circle cx="25" cy="20" r="8" fill="#FFB6D0" opacity="0.8" />
                  <circle cx="25" cy="20" r="5" fill="#FF8FB3" opacity="0.9" />
                  <circle cx="55" cy="20" r="8" fill="#FFB6D0" opacity="0.8" />
                  <circle cx="55" cy="20" r="5" fill="#FF8FB3" opacity="0.9" />
                  <circle cx="40" cy="15" r="9" fill="#FFC9DC" opacity="0.9" />
                  <circle cx="40" cy="15" r="6" fill="#FFB6D0" opacity="1" />
                  {/* Leaves */}
                  <ellipse cx="15" cy="25" rx="6" ry="10" fill="#C8A8D4" opacity="0.6" transform="rotate(-30 15 25)" />
                  <ellipse cx="65" cy="25" rx="6" ry="10" fill="#C8A8D4" opacity="0.6" transform="rotate(30 65 25)" />
                </svg>
              </motion.div>

              {/* Couple Illustration */}
              <motion.div
                className="relative"
                initial={{ scale: 0.8, opacity: 0 }}
                animate={{ scale: 1, opacity: 1 }}
                transition={{ duration: 0.6, delay: 0.2 }}
              >
                <svg width="200" height="220" viewBox="0 0 200 220" fill="none">
                  {/* Floating hearts above */}
                  <motion.g
                    animate={{ y: [0, -5, 0] }}
                    transition={{ duration: 2, repeat: Infinity, ease: "easeInOut" }}
                  >
                    <path d="M50 30 C50 20, 65 20, 65 30 C65 20, 80 20, 80 30 C80 45, 65 55, 65 55 C65 55, 50 45, 50 30 Z" fill="#FF8FB3" opacity="0.7" />
                  </motion.g>
                  <motion.g
                    animate={{ y: [0, -7, 0] }}
                    transition={{ duration: 2.5, repeat: Infinity, ease: "easeInOut", delay: 0.5 }}
                  >
                    <path d="M120 25 C120 18, 130 18, 130 25 C130 18, 140 18, 140 25 C140 36, 130 43, 130 43 C130 43, 120 36, 120 25 Z" fill="#FFB6D0" opacity="0.8" />
                  </motion.g>
                  <motion.g
                    animate={{ y: [0, -6, 0] }}
                    transition={{ duration: 2.2, repeat: Infinity, ease: "easeInOut", delay: 0.8 }}
                  >
                    <path d="M155 35 C155 28, 165 28, 165 35 C165 28, 175 28, 175 35 C175 46, 165 53, 165 53 C165 53, 155 46, 155 35 Z" fill="#FFC9DC" opacity="0.6" />
                  </motion.g>

                  {/* Person 1 (Left - Pink hair) */}
                  <g>
                    {/* Body */}
                    <ellipse cx="70" cy="160" rx="35" ry="45" fill="#FFD4E5" />
                    {/* Head */}
                    <circle cx="70" cy="95" r="28" fill="#FFE6EF" />
                    {/* Hair */}
                    <path d="M 45 90 Q 40 70, 55 65 Q 60 60, 70 62 Q 80 60, 85 65 Q 95 70, 95 85 Q 95 95, 90 95 Q 85 75, 70 75 Q 55 75, 50 95 Q 45 95, 45 90 Z" fill="#FFB6D0" />
                    {/* Face */}
                    <circle cx="63" cy="92" r="3" fill="#7A3E55" />
                    <circle cx="77" cy="92" r="3" fill="#7A3E55" />
                    <path d="M 60 102 Q 70 107, 80 102" stroke="#FF8FB3" strokeWidth="2" fill="none" strokeLinecap="round" />
                    {/* Arm */}
                    <ellipse cx="95" cy="140" rx="12" ry="35" fill="#FFE6EF" transform="rotate(25 95 140)" />
                  </g>

                  {/* Person 2 (Right - Purple hair) */}
                  <g>
                    {/* Body */}
                    <ellipse cx="130" cy="155" rx="38" ry="48" fill="#E6D4F5" />
                    {/* Head */}
                    <circle cx="125" cy="90" r="30" fill="#F5E6FF" />
                    {/* Hair */}
                    <path d="M 95 85 Q 92 65, 105 60 Q 115 55, 125 58 Q 135 55, 145 60 Q 155 65, 155 80 Q 155 92, 150 92 Q 145 72, 125 72 Q 105 72, 100 92 Q 95 92, 95 85 Z" fill="#D4B4E8" />
                    {/* Face */}
                    <circle cx="117" cy="87" r="3" fill="#7A3E55" />
                    <circle cx="133" cy="87" r="3" fill="#7A3E55" />
                    <path d="M 113 97 Q 125 102, 137 97" stroke="#C8A8D4" strokeWidth="2" fill="none" strokeLinecap="round" />
                    {/* Arm */}
                    <ellipse cx="105" cy="135" rx="12" ry="38" fill="#F5E6FF" transform="rotate(-30 105 135)" />
                  </g>

                  {/* Hug effect - overlapping */}
                  <ellipse cx="100" cy="145" rx="25" ry="30" fill="#FFE6EF" opacity="0.6" />
                </svg>
              </motion.div>
            </div>

            {/* RIGHT COLUMN - Brand Area */}
            <div className="text-center md:text-right space-y-3">
              <motion.h2
                className="font-bold"
                style={{
                  fontFamily: "'Dancing Script', 'Brush Script MT', cursive",
                  fontSize: '42px',
                  color: '#B24C75',
                  lineHeight: '1.2',
                }}
                initial={{ opacity: 0, scale: 0.9 }}
                animate={{ opacity: 1, scale: 1 }}
                transition={{ duration: 0.5, delay: 0.4 }}
              >
                CherishAI
              </motion.h2>
              <motion.p
                style={{
                  fontFamily: "'Poppins', sans-serif",
                  fontSize: '18px',
                  color: '#8B4A65',
                  lineHeight: '1.5',
                }}
                initial={{ opacity: 0 }}
                animate={{ opacity: 1 }}
                transition={{ duration: 0.5, delay: 0.6 }}
              >
                is your personal love assistant
              </motion.p>
            </div>
          </div>
        </motion.div>

        {/* Bottom Card Strip */}
        <motion.div
          className="rounded-[30px] py-6 px-10"
          style={{
            background: 'rgba(255, 255, 255, 0.6)',
            backdropFilter: 'blur(10px)',
            boxShadow: '0px 8px 20px rgba(255, 150, 180, 0.25)',
          }}
          initial={{ opacity: 0, y: 20 }}
          animate={{ opacity: 1, y: 0 }}
          transition={{ duration: 0.6, delay: 0.3 }}
        >
          <p
            className="text-center font-medium"
            style={{
              fontFamily: "'Poppins', sans-serif",
              fontSize: '18px',
              color: '#7A3E55',
              lineHeight: '1.5',
            }}
          >
            It thinks for you, makes efforts for you and helps you love and care better.
          </p>
        </motion.div>
      </div>
    </div>
  );
}
