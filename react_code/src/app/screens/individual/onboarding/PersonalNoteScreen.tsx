import { useState } from 'react';
import { useNavigate } from 'react-router-dom';
import { Heart, ArrowRight, Sparkles, ChevronDown, ArrowLeft, Star } from 'lucide-react';
import { motion, AnimatePresence } from 'motion/react';

export default function PersonalNoteScreen() {
  const navigate = useNavigate();
  const [personalNote, setPersonalNote] = useState('');
  const [currentPlaceholder, setCurrentPlaceholder] = useState(0);
  const [showExamples, setShowExamples] = useState(false);
  const [showError, setShowError] = useState(false);

  const placeholders = [
    "Susan is someone I often see at the bus station. I'm developing feelings and want to be kind, subtle, and respectful.",
    "We've been together for years, but life has been busy and I want to reconnect gently.",
    "She's my mother. I don't say it often, but I want her to feel appreciated."
  ];

  const examples = [
    "John is my coworker. I'm developing romantic feelings and want to be subtle and respectful.",
    "We've been together for years, but life has been busy and I want to reconnect gently.",
    "She's my mother. I don't say it often, but I want her to feel appreciated.",
    "We're close friends who live far apart. I want to stay emotionally present.",
    "She's my partner and we're expecting a child. I want to be more supportive and present."
  ];

  const handleExampleClick = (example: string) => {
    setPersonalNote(example);
    setShowExamples(false);
  };

  const handleContinue = () => {
    // Save personal note to localStorage or context
    if (personalNote.trim()) {
      const existingNote = localStorage.getItem('cherish_personal_note');
      localStorage.setItem('cherish_personal_note', personalNote);
      navigate('/individual/subscription');
    }
  };

  const handleSkip = () => {
    navigate('/individual/subscription');
  };

  const handleBack = () => {
    navigate(-1);
  };

  const characterCount = personalNote.length;
  const maxCharacters = 300;
  const isButtonDisabled = !personalNote.trim();

  return (
    <div className="min-h-screen bg-gradient-to-br from-rose-50 via-pink-50 to-purple-50 flex flex-col">
      {/* Header */}
      <motion.div 
        className="pt-8 pb-6 px-6"
        initial={{ opacity: 0, y: -20 }}
        animate={{ opacity: 1, y: 0 }}
        transition={{ duration: 0.6 }}
      >
        {/* Back Button */}
        <div className="mb-4">
          <button
            onClick={handleBack}
            className="flex items-center gap-2 text-rose-600 hover:text-rose-700 transition-colors"
          >
            <ArrowLeft className="w-5 h-5" />
            <span className="font-medium">Back</span>
          </button>
        </div>

        <div className="flex items-center justify-between mb-2">
          <div className="flex items-center gap-2">
            <div className="w-10 h-10 rounded-full bg-gradient-to-br from-rose-400 to-pink-500 flex items-center justify-center shadow-lg">
              <Heart className="w-5 h-5 text-white fill-white" />
            </div>
            <h1 className="text-2xl font-bold bg-gradient-to-r from-rose-600 to-pink-600 bg-clip-text text-transparent">
              Cherish AI
            </h1>
          </div>
          <button
            onClick={handleSkip}
            className="text-sm font-medium text-gray-500 hover:text-rose-600 transition-colors"
          >
            Skip
          </button>
        </div>
        
        {/* Progress bar */}
        <div className="w-full bg-rose-100 h-2 rounded-full overflow-hidden">
          <motion.div 
            className="h-full bg-gradient-to-r from-rose-500 to-pink-500"
            initial={{ width: '71%' }}
            animate={{ width: '86%' }}
            transition={{ duration: 0.8, ease: 'easeOut' }}
          />
        </div>
        <p className="text-xs text-gray-500 mt-2 text-right">Step 6 of 7</p>
      </motion.div>

      {/* Content */}
      <div className="flex-1 px-6 pb-32 overflow-y-auto">
        <motion.div
          initial={{ opacity: 0, y: 20 }}
          animate={{ opacity: 1, y: 0 }}
          transition={{ duration: 0.6, delay: 0.2 }}
        >
          {/* Icon */}
          <div className="flex justify-center mb-6">
            <div className="w-20 h-20 rounded-full bg-gradient-to-br from-purple-100 to-pink-100 flex items-center justify-center">
              <Sparkles className="w-10 h-10 text-purple-500" />
            </div>
          </div>

          {/* Title */}
          <h2 className="text-2xl font-bold text-center mb-3 text-gray-800">
            Add a Personal Note
          </h2>
          
          <p className="text-center text-gray-600 mb-8 px-4">
            Help Cherish AI understand your relationship better for more personalized messages
          </p>

          {/* Personal Note Input */}
          <div className="bg-white rounded-3xl p-6 shadow-lg border border-rose-100 mb-6">
            <label className="block mb-3">
              <div className="flex items-center gap-2 mb-2">
                <span className="text-sm font-semibold text-gray-700">
                  👉 Personal note <span className="text-rose-500">*</span>
                </span>
              </div>
              
              <textarea
                value={personalNote}
                onChange={(e) => {
                  if (e.target.value.length <= maxCharacters) {
                    setPersonalNote(e.target.value);
                    setShowError(false); // Clear error when user starts typing
                  }
                }}
                placeholder={placeholders[currentPlaceholder]}
                className={`w-full px-4 py-3 border-2 rounded-2xl focus:outline-none transition-all resize-none text-gray-700 ${
                  showError 
                    ? 'border-red-500 focus:border-red-500' 
                    : 'border-rose-200 focus:border-rose-400'
                }`}
                rows={6}
                maxLength={maxCharacters}
                required
              />
              
              {/* Error Message */}
              <AnimatePresence>
                {showError && (
                  <motion.div
                    initial={{ opacity: 0, y: -10 }}
                    animate={{ opacity: 1, y: 0 }}
                    exit={{ opacity: 0, y: -10 }}
                    transition={{ duration: 0.2 }}
                    className="mt-2 flex items-center gap-2 text-red-600 text-sm font-medium"
                  >
                    <svg className="w-4 h-4" fill="currentColor" viewBox="0 0 20 20">
                      <path fillRule="evenodd" d="M18 10a8 8 0 11-16 0 8 8 0 0116 0zm-7 4a1 1 0 11-2 0 1 1 0 012 0zm-1-9a1 1 0 00-1 1v4a1 1 0 102 0V6a1 1 0 00-1-1z" clipRule="evenodd" />
                    </svg>
                    Please add a personal note to continue
                  </motion.div>
                )}
              </AnimatePresence>

              {/* Character Counter */}
              <div className="flex justify-end mt-2">
                <span className={`text-xs font-medium ${
                  characterCount > maxCharacters - 20 
                    ? 'text-rose-600' 
                    : 'text-gray-500'
                }`}>
                  {characterCount}/{maxCharacters}
                </span>
              </div>
            </label>

            {/* Helper Text */}
            <div className="mt-4 p-4 bg-purple-50 rounded-xl border border-purple-100">
              <p className="text-sm text-gray-600 leading-relaxed">
                Share anything that helps Cherish AI understand this relationship better. A few sentences are enough.
              </p>
            </div>

            {/* Example Toggle */}
            <button
              onClick={() => setShowExamples(!showExamples)}
              className="mt-4 text-sm text-rose-600 hover:text-rose-700 font-medium flex items-center gap-1 transition-colors"
            >
              <Sparkles className="w-3 h-3" />
              See more examples
              <ChevronDown className={`w-3 h-3 transition-transform ${showExamples ? 'rotate-180' : ''}`} />
            </button>

            {/* Examples Dropdown */}
            <AnimatePresence>
              {showExamples && (
                <motion.div
                  initial={{ opacity: 0, height: 0 }}
                  animate={{ opacity: 1, height: 'auto' }}
                  exit={{ opacity: 0, height: 0 }}
                  transition={{ duration: 0.3 }}
                  className="overflow-hidden"
                >
                  <div className="mt-3 space-y-2">
                    {examples.map((example, index) => (
                      <motion.button
                        key={index}
                        onClick={() => handleExampleClick(example)}
                        className="w-full text-left p-3 bg-gradient-to-r from-rose-50 to-pink-50 hover:from-rose-100 hover:to-pink-100 rounded-xl border border-rose-200 hover:border-rose-300 transition-all text-xs text-gray-700 leading-relaxed hover:shadow-md"
                        initial={{ opacity: 0, x: -10 }}
                        animate={{ opacity: 1, x: 0 }}
                        transition={{ delay: index * 0.05 }}
                        whileHover={{ scale: 1.02 }}
                        whileTap={{ scale: 0.98 }}
                      >
                        {example}
                      </motion.button>
                    ))}
                  </div>
                </motion.div>
              )}
            </AnimatePresence>
          </div>

          {/* Why this helps - REMOVED */}
        </motion.div>
      </div>

      {/* Bottom Action Button */}
      <motion.div 
        className="fixed bottom-0 left-0 right-0 p-6 bg-gradient-to-t from-white via-white to-transparent"
        initial={{ opacity: 0, y: 20 }}
        animate={{ opacity: 1, y: 0 }}
        transition={{ duration: 0.6, delay: 0.3 }}
      >
        <button
          onClick={handleContinue}
          disabled={isButtonDisabled}
          className={`w-full py-4 px-6 rounded-2xl font-semibold text-lg shadow-xl transition-all flex items-center justify-center gap-2 ${
            isButtonDisabled
              ? 'bg-gray-300 text-gray-500 cursor-not-allowed opacity-60'
              : 'bg-gradient-to-r from-rose-500 via-pink-500 to-purple-500 text-white hover:shadow-2xl hover:scale-[1.02]'
          }`}
        >
          Continue
          <ArrowRight className="w-5 h-5" />
        </button>
      </motion.div>
    </div>
  );
}