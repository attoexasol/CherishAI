import { useState } from 'react';
import { useNavigate } from 'react-router-dom';
import { Globe, Check, Search } from 'lucide-react';
import { motion } from 'motion/react';

interface Language {
  code: string;
  name: string;
  nativeName: string;
  flag: string;
  region: string;
}

const languages: Language[] = [
  // European Languages
  { code: 'en', name: 'English', nativeName: 'English', flag: '🇬🇧', region: 'Europe' },
  { code: 'es', name: 'Spanish', nativeName: 'Español', flag: '🇪🇸', region: 'Europe' },
  { code: 'fr', name: 'French', nativeName: 'Français', flag: '🇫🇷', region: 'Europe' },
  { code: 'de', name: 'German', nativeName: 'Deutsch', flag: '🇩🇪', region: 'Europe' },
  { code: 'it', name: 'Italian', nativeName: 'Italiano', flag: '🇮🇹', region: 'Europe' },
  { code: 'pt', name: 'Portuguese', nativeName: 'Português', flag: '🇵🇹', region: 'Europe' },
  { code: 'ru', name: 'Russian', nativeName: 'Русский', flag: '🇷🇺', region: 'Europe' },
  { code: 'nl', name: 'Dutch', nativeName: 'Nederlands', flag: '🇳🇱', region: 'Europe' },
  { code: 'pl', name: 'Polish', nativeName: 'Polski', flag: '🇵🇱', region: 'Europe' },
  { code: 'sv', name: 'Swedish', nativeName: 'Svenska', flag: '🇸🇪', region: 'Europe' },
  { code: 'no', name: 'Norwegian', nativeName: 'Norsk', flag: '🇳🇴', region: 'Europe' },
  { code: 'da', name: 'Danish', nativeName: 'Dansk', flag: '🇩🇰', region: 'Europe' },
  { code: 'fi', name: 'Finnish', nativeName: 'Suomi', flag: '🇫🇮', region: 'Europe' },
  { code: 'el', name: 'Greek', nativeName: 'Ελληνικά', flag: '🇬🇷', region: 'Europe' },
  { code: 'cs', name: 'Czech', nativeName: 'Čeština', flag: '🇨🇿', region: 'Europe' },
  { code: 'ro', name: 'Romanian', nativeName: 'Română', flag: '🇷🇴', region: 'Europe' },
  { code: 'hu', name: 'Hungarian', nativeName: 'Magyar', flag: '🇭🇺', region: 'Europe' },
  { code: 'tr', name: 'Turkish', nativeName: 'Türkçe', flag: '🇹🇷', region: 'Europe' },
  { code: 'uk', name: 'Ukrainian', nativeName: 'Українська', flag: '🇺🇦', region: 'Europe' },
  
  // Asian Languages
  { code: 'zh', name: 'Chinese (Simplified)', nativeName: '简体中文', flag: '🇨🇳', region: 'Asia' },
  { code: 'zh-TW', name: 'Chinese (Traditional)', nativeName: '繁體中文', flag: '🇹🇼', region: 'Asia' },
  { code: 'ja', name: 'Japanese', nativeName: '日本語', flag: '🇯🇵', region: 'Asia' },
  { code: 'ko', name: 'Korean', nativeName: '한국어', flag: '🇰🇷', region: 'Asia' },
  { code: 'hi', name: 'Hindi', nativeName: 'हिन्दी', flag: '🇮🇳', region: 'Asia' },
  { code: 'bn', name: 'Bengali', nativeName: 'বাংলা', flag: '🇧🇩', region: 'Asia' },
  { code: 'ur', name: 'Urdu', nativeName: 'اردو', flag: '🇵🇰', region: 'Asia' },
  { code: 'ta', name: 'Tamil', nativeName: 'தமிழ்', flag: '🇮🇳', region: 'Asia' },
  { code: 'te', name: 'Telugu', nativeName: 'తెలుగు', flag: '🇮🇳', region: 'Asia' },
  { code: 'mr', name: 'Marathi', nativeName: 'मराठी', flag: '🇮🇳', region: 'Asia' },
  { code: 'th', name: 'Thai', nativeName: 'ไทย', flag: '🇹🇭', region: 'Asia' },
  { code: 'vi', name: 'Vietnamese', nativeName: 'Tiếng Việt', flag: '🇻🇳', region: 'Asia' },
  { code: 'id', name: 'Indonesian', nativeName: 'Bahasa Indonesia', flag: '🇮🇩', region: 'Asia' },
  { code: 'ms', name: 'Malay', nativeName: 'Bahasa Melayu', flag: '🇲🇾', region: 'Asia' },
  { code: 'fil', name: 'Filipino', nativeName: 'Filipino', flag: '🇵🇭', region: 'Asia' },
  
  // Middle Eastern & African Languages
  { code: 'ar', name: 'Arabic', nativeName: 'العربية', flag: '🇸🇦', region: 'Middle East' },
  { code: 'he', name: 'Hebrew', nativeName: 'עברית', flag: '🇮🇱', region: 'Middle East' },
  { code: 'fa', name: 'Persian', nativeName: 'فارسی', flag: '🇮🇷', region: 'Middle East' },
  { code: 'sw', name: 'Swahili', nativeName: 'Kiswahili', flag: '🇰🇪', region: 'Africa' },
  { code: 'am', name: 'Amharic', nativeName: 'አማርኛ', flag: '🇪🇹', region: 'Africa' },
  { code: 'zu', name: 'Zulu', nativeName: 'isiZulu', flag: '🇿🇦', region: 'Africa' },
  { code: 'af', name: 'Afrikaans', nativeName: 'Afrikaans', flag: '🇿🇦', region: 'Africa' },
  
  // American Languages
  { code: 'en-US', name: 'English (US)', nativeName: 'English (US)', flag: '🇺🇸', region: 'Americas' },
  { code: 'es-MX', name: 'Spanish (Mexico)', nativeName: 'Español (México)', flag: '🇲🇽', region: 'Americas' },
  { code: 'pt-BR', name: 'Portuguese (Brazil)', nativeName: 'Português (Brasil)', flag: '🇧🇷', region: 'Americas' },
  { code: 'fr-CA', name: 'French (Canada)', nativeName: 'Français (Canada)', flag: '🇨🇦', region: 'Americas' },
  
  // Other Languages
  { code: 'en-AU', name: 'English (Australia)', nativeName: 'English (Australia)', flag: '🇦🇺', region: 'Oceania' },
  { code: 'mi', name: 'Maori', nativeName: 'Te Reo Māori', flag: '🇳🇿', region: 'Oceania' },
];

export default function LanguageSelectionScreen() {
  const navigate = useNavigate();
  const [selectedLanguage, setSelectedLanguage] = useState<string>('en');
  const [searchQuery, setSearchQuery] = useState('');
  const [selectedRegion, setSelectedRegion] = useState<string>('All');

  const regions = ['All', 'Europe', 'Asia', 'Middle East', 'Africa', 'Americas', 'Oceania'];

  const filteredLanguages = languages.filter(lang => {
    const matchesSearch = 
      lang.name.toLowerCase().includes(searchQuery.toLowerCase()) ||
      lang.nativeName.toLowerCase().includes(searchQuery.toLowerCase());
    const matchesRegion = selectedRegion === 'All' || lang.region === selectedRegion;
    return matchesSearch && matchesRegion;
  });

  const handleContinue = () => {
    // Save selected language to localStorage or context
    localStorage.setItem('selectedLanguage', selectedLanguage);
    navigate('/auth');
  };

  return (
    <div 
      className="min-h-screen pb-32"
      style={{
        background: 'linear-gradient(180deg, #F8EFF3 0%, #F5E8ED 40%, #F9F3F6 100%)',
      }}
    >
      {/* Header */}
      <div className="sticky top-0 z-20 backdrop-blur-xl border-b"
        style={{
          background: 'linear-gradient(135deg, rgba(255, 240, 245, 0.95), rgba(255, 228, 236, 0.95))',
          borderColor: 'rgba(246, 166, 193, 0.2)',
        }}
      >
        <div className="max-w-4xl mx-auto px-6 py-4">
          <div className="flex items-center justify-between">
            <div className="flex items-center gap-3">
              <div 
                className="w-12 h-12 rounded-2xl flex items-center justify-center"
                style={{
                  background: 'linear-gradient(135deg, #E91E63, #9C27B0)',
                  boxShadow: '0px 6px 20px rgba(233, 30, 99, 0.5)',
                }}
              >
                <Globe className="w-6 h-6 text-white" />
              </div>
              <div>
                <h1 
                  className="font-bold"
                  style={{
                    fontSize: '20px',
                    color: '#C2185B',
                  }}
                >
                  Select Language
                </h1>
                <p className="text-sm font-medium" style={{ color: '#6B2C4D' }}>
                  Choose your preferred language
                </p>
              </div>
            </div>
          </div>
        </div>
      </div>

      {/* Main Content */}
      <div className="max-w-4xl mx-auto px-6 pt-8">
        {/* Welcome Section */}
        <motion.div 
          className="text-center mb-8"
          initial={{ opacity: 0, y: 20 }}
          animate={{ opacity: 1, y: 0 }}
          transition={{ duration: 0.5 }}
        >
          <div 
            className="inline-flex items-center justify-center w-20 h-20 rounded-3xl mb-4"
            style={{
              background: 'linear-gradient(135deg, #E91E63, #F06292)',
              boxShadow: '0px 12px 32px rgba(233, 30, 99, 0.4)',
            }}
          >
            <Globe className="w-10 h-10 text-white" />
          </div>
          <h2 
            className="font-bold mb-3"
            style={{
              fontSize: 'clamp(28px, 6vw, 36px)',
              color: '#2D1F35',
            }}
          >
            Welcome to Cherish AI
          </h2>
          <p 
            className="text-lg max-w-2xl mx-auto leading-relaxed"
            style={{ color: '#6B4B5E' }}
          >
            Choose your language to personalize your experience. We support {languages.length}+ languages worldwide.
          </p>
        </motion.div>

        {/* Search Bar */}
        <motion.div 
          className="mb-6"
          initial={{ opacity: 0, y: 20 }}
          animate={{ opacity: 1, y: 0 }}
          transition={{ duration: 0.5, delay: 0.1 }}
        >
          <div className="relative">
            <Search 
              className="absolute left-4 top-1/2 transform -translate-y-1/2 w-5 h-5"
              style={{ color: '#E91E63' }}
            />
            <input
              type="text"
              placeholder="Search languages..."
              value={searchQuery}
              onChange={(e) => setSearchQuery(e.target.value)}
              className="w-full pl-12 pr-4 py-4 rounded-2xl border-2 outline-none transition-all"
              style={{
                background: 'linear-gradient(135deg, #FFFFFF, #FEFBFC)',
                borderColor: searchQuery ? '#E91E63' : 'rgba(246, 166, 193, 0.3)',
                boxShadow: searchQuery ? '0px 8px 24px rgba(233, 30, 99, 0.2)' : '0px 4px 12px rgba(246, 166, 193, 0.15)',
                color: '#2D1F35',
              }}
            />
          </div>
        </motion.div>

        {/* Region Filter */}
        <motion.div 
          className="mb-6 overflow-x-auto"
          initial={{ opacity: 0, y: 20 }}
          animate={{ opacity: 1, y: 0 }}
          transition={{ duration: 0.5, delay: 0.2 }}
        >
          <div className="flex gap-2 pb-2 overflow-x-auto items-center"
            style={{
              scrollbarWidth: 'none',
              msOverflowStyle: 'none',
              WebkitOverflowScrolling: 'touch',
              scrollSnapType: 'x mandatory',
            }}
          >
            {regions.map((region) => (
              <button
                key={region}
                onClick={() => setSelectedRegion(region)}
                className="px-4 py-2 rounded-xl font-medium transition-all whitespace-nowrap flex-shrink-0"
                style={{
                  background: selectedRegion === region
                    ? 'linear-gradient(135deg, #E91E63, #F06292)'
                    : 'linear-gradient(135deg, #FFFFFF, #FFF5F8)',
                  color: selectedRegion === region ? '#FFFFFF' : '#6B4B5E',
                  border: selectedRegion === region ? 'none' : '2px solid rgba(246, 166, 193, 0.2)',
                  boxShadow: selectedRegion === region 
                    ? '0px 4px 12px rgba(233, 30, 99, 0.3)'
                    : '0px 2px 8px rgba(246, 166, 193, 0.1)',
                  scrollSnapAlign: 'start',
                }}
              >
                {region}
              </button>
            ))}
          </div>
        </motion.div>

        {/* Languages Grid */}
        <motion.div 
          className="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-3 gap-4 mb-8"
          initial={{ opacity: 0 }}
          animate={{ opacity: 1 }}
          transition={{ duration: 0.5, delay: 0.3 }}
        >
          {filteredLanguages.map((language, index) => {
            const isSelected = selectedLanguage === language.code;
            
            return (
              <motion.button
                key={language.code}
                onClick={() => setSelectedLanguage(language.code)}
                className="text-left rounded-2xl p-4 transition-all"
                style={{
                  background: isSelected
                    ? 'linear-gradient(135deg, #FFE5EC, #FFF0F5)'
                    : 'linear-gradient(135deg, #FFFFFF, #FEFBFC)',
                  border: isSelected ? '3px solid #E91E63' : '2px solid rgba(246, 166, 193, 0.2)',
                  boxShadow: isSelected
                    ? '0px 12px 32px rgba(233, 30, 99, 0.35)'
                    : '0px 4px 12px rgba(246, 166, 193, 0.15)',
                  transform: isSelected ? 'scale(1.02)' : 'scale(1)',
                }}
                initial={{ opacity: 0, y: 20 }}
                animate={{ opacity: 1, y: 0 }}
                transition={{ duration: 0.3, delay: 0.3 + index * 0.02 }}
                whileHover={{ scale: 1.02, y: -2 }}
                whileTap={{ scale: 0.98 }}
              >
                <div className="flex items-start justify-between gap-3">
                  <div className="flex items-center gap-3 flex-1">
                    <div 
                      className="text-3xl flex items-center justify-center w-12 h-12 rounded-xl"
                      style={{
                        background: isSelected
                          ? 'linear-gradient(135deg, #E91E63, #F06292)'
                          : 'linear-gradient(135deg, #FFF0F5, #FFE4EC)',
                      }}
                    >
                      {language.flag}
                    </div>
                    <div className="flex-1 min-w-0">
                      <p 
                        className="font-semibold mb-1 truncate"
                        style={{ 
                          color: isSelected ? '#C2185B' : '#2D1F35',
                          fontSize: '15px',
                        }}
                      >
                        {language.name}
                      </p>
                      <p 
                        className="text-sm truncate"
                        style={{ color: '#9C7B8A' }}
                      >
                        {language.nativeName}
                      </p>
                    </div>
                  </div>
                  {isSelected && (
                    <motion.div
                      className="w-6 h-6 rounded-full flex items-center justify-center flex-shrink-0"
                      style={{
                        background: 'linear-gradient(135deg, #E91E63, #F06292)',
                      }}
                      initial={{ scale: 0 }}
                      animate={{ scale: 1 }}
                      transition={{ type: "spring", stiffness: 500, damping: 30 }}
                    >
                      <Check className="w-4 h-4 text-white" strokeWidth={3} />
                    </motion.div>
                  )}
                </div>
              </motion.button>
            );
          })}
        </motion.div>

        {/* No Results */}
        {filteredLanguages.length === 0 && (
          <motion.div 
            className="text-center py-12"
            initial={{ opacity: 0 }}
            animate={{ opacity: 1 }}
          >
            <p className="text-lg font-medium" style={{ color: '#9C7B8A' }}>
              No languages found matching "{searchQuery}"
            </p>
          </motion.div>
        )}
      </div>

      {/* Continue Button - Fixed at bottom */}
      <div 
        className="fixed bottom-0 left-0 right-0 px-6 py-6 z-30"
        style={{
          background: 'linear-gradient(to top, #FFFFFF 70%, rgba(255, 255, 255, 0))',
        }}
      >
        <div className="max-w-4xl mx-auto">
          <motion.button
            onClick={handleContinue}
            className="w-full py-4 px-6 rounded-2xl font-semibold text-lg text-white transition-all"
            style={{
              background: 'linear-gradient(135deg, #E91E63, #F06292)',
              boxShadow: '0px 12px 32px rgba(233, 30, 99, 0.4)',
            }}
            whileHover={{ scale: 1.02, boxShadow: '0px 16px 40px rgba(233, 30, 99, 0.5)' }}
            whileTap={{ scale: 0.98 }}
            initial={{ opacity: 0, y: 20 }}
            animate={{ opacity: 1, y: 0 }}
            transition={{ duration: 0.5, delay: 0.5 }}
          >
            Continue with {languages.find(l => l.code === selectedLanguage)?.name || 'English'}
          </motion.button>
          <p className="text-center text-sm mt-3" style={{ color: '#9C7B8A' }}>
            You can change this later in settings
          </p>
        </div>
      </div>

      {/* Animations */}
      <style>{`
        @keyframes fadeSlideIn {
          from {
            opacity: 0;
            transform: translateY(20px);
          }
          to {
            opacity: 1;
            transform: translateY(0);
          }
        }
      `}</style>
    </div>
  );
}