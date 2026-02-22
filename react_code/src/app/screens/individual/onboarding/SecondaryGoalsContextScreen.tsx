import { useState } from 'react';
import { useNavigate } from 'react-router-dom';
import { Clock, Heart, HeartHandshake, Sparkles, MessageCircle, ArrowLeft } from 'lucide-react';
import RomanticButton from '../../../components/RomanticButton';
import { motion } from 'motion/react';
import BackButton from '@/app/components/BackButton';

export default function SecondaryGoalsContextScreen() {
  const navigate = useNavigate();
  const [selectedGoals, setSelectedGoals] = useState<string[]>([]);

  const goalCategories = [
    {
      id: 'life-presence',
      icon: Clock,
      emoji: '🕰',
      title: 'Life & Presence',
      goals: [
        { id: 'balance-busy-life', text: 'Balance love with a busy life' },
        { id: 'be-present', text: 'Be more present and intentional' },
        { id: 'reconnect', text: 'Reconnect after distance or absence' },
      ],
    },
    {
      id: 'growth-longevity',
      icon: Heart,
      emoji: '💎',
      title: 'Growth & Longevity',
      goals: [
        { id: 'grow-emotionally', text: 'Grow together emotionally' },
        { id: 'long-term-future', text: 'Build a long-term future together' },
        { id: 'family-bonds', text: 'Strengthen family bonds' },
      ],
    },
    {
      id: 'healing-repair',
      icon: HeartHandshake,
      emoji: '🕊',
      title: 'Healing & Repair',
      goals: [
        { id: 'heal-difficult', text: 'Heal after a difficult period' },
        { id: 'restore-closeness', text: 'Restore closeness after conflict' },
      ],
    },
    {
      id: 'moments-meaning',
      icon: Sparkles,
      emoji: '✨',
      title: 'Moments & Meaning',
      goals: [
        { id: 'celebrate-everyday', text: 'Celebrate everyday moments' },
        { id: 'important-milestone', text: 'Prepare for an important milestone' },
        { id: 'joyful-surprises', text: 'Create joyful surprises' },
      ],
    },
    {
      id: 'emotional-expression',
      icon: MessageCircle,
      emoji: '💗',
      title: 'Emotional Expression',
      goals: [
        { id: 'feel-understood', text: 'Make them feel deeply understood' },
        { id: 'lightness-playfulness', text: 'Bring more lightness and playfulness' },
      ],
    },
  ];

  const handleGoalToggle = (goalId: string) => {
    if (selectedGoals.includes(goalId)) {
      setSelectedGoals(selectedGoals.filter((id) => id !== goalId));
    } else {
      if (selectedGoals.length < 3) {
        setSelectedGoals([...selectedGoals, goalId]);
      }
    }
  };

  const handleContinue = () => {
    // Navigate to next screen - Loved One Preferences
    navigate('/individual/loved-one-preferences');
  };

  const handleSkip = () => {
    // Skip and continue to next step
    navigate('/individual/loved-one-preferences');
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
          onClick={() => navigate('/individual/your-relationship-goals')}
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
      
      <div className="relative z-10 px-6 py-24 max-w-4xl mx-auto">
        {/* Header Section */}
        <motion.div
          className="text-center mb-12"
          initial={{ opacity: 0, y: -20 }}
          animate={{ opacity: 1, y: 0 }}
          transition={{ duration: 0.6 }}
        >
          <h1 className="text-3xl md:text-4xl text-purple-800 mb-3 leading-tight">
            Secondary Relationship Goals (Optional)
          </h1>
          <p className="text-rose-500 text-lg mb-2">
            Choose up to 3 goals to deepen your connection 💕
          </p>
          <p className="text-purple-600 text-sm">
            What context or intention should shape how your PRIMARY relationship goal is expressed?
          </p>
          
          {/* Selection Counter Badge */}
          <motion.div
            className="inline-flex items-center gap-2 mt-4 px-5 py-2.5 rounded-full"
            style={{
              background: 'linear-gradient(135deg, rgba(255, 255, 255, 0.9) 0%, rgba(255, 241, 247, 0.85) 100%)',
              backdropFilter: 'blur(20px)',
              boxShadow: '0 4px 16px rgba(236, 72, 153, 0.15)',
              border: '2px solid rgba(251, 113, 133, 0.3)',
            }}
            initial={{ scale: 0 }}
            animate={{ scale: 1 }}
            transition={{ delay: 0.3, type: "spring" }}
          >
            <Heart className="w-4 h-4 text-rose-500" />
            <span className="text-purple-700 font-medium text-sm">
              Selected: {selectedGoals.length}/3
            </span>
          </motion.div>
        </motion.div>

        {/* Goal Categories */}
        <div className="space-y-8 mb-12">
          {goalCategories.map((category, categoryIndex) => (
            <motion.div
              key={category.id}
              initial={{ opacity: 0, y: 20 }}
              animate={{ opacity: 1, y: 0 }}
              transition={{ delay: categoryIndex * 0.1, duration: 0.5 }}
            >
              {/* Category Header with Premium Design */}
              <div className="flex items-center gap-3 mb-4 px-2">
                <div className="flex items-center justify-center w-10 h-10 rounded-full bg-gradient-to-br from-rose-100 to-pink-100 shadow-md">
                  <span className="text-xl">{category.emoji}</span>
                </div>
                <h2 className="text-xl font-semibold text-purple-800">
                  {category.title}
                </h2>
              </div>

              {/* Goals in this category - Premium Glass Cards */}
              <div className="space-y-3">
                {category.goals.map((goal) => {
                  const isSelected = selectedGoals.includes(goal.id);
                  const isDisabled = !isSelected && selectedGoals.length >= 3;

                  return (
                    <motion.div
                      key={goal.id}
                      className="relative"
                      whileHover={!isDisabled ? { scale: 1.02, y: -2 } : {}}
                      whileTap={!isDisabled ? { scale: 0.98 } : {}}
                    >
                      {/* Outer Glow Effect */}
                      <div className={`absolute inset-0 rounded-[20px] transition-all duration-500 ${
                        isSelected
                          ? 'bg-gradient-to-br from-rose-400/30 via-pink-400/30 to-purple-400/30 blur-lg scale-105'
                          : 'bg-gradient-to-br from-rose-300/10 to-pink-300/10 blur-md scale-100 opacity-0 group-hover:opacity-100'
                      }`} />
                      
                      <button
                        onClick={() => !isDisabled && handleGoalToggle(goal.id)}
                        disabled={isDisabled}
                        className={`relative w-full text-left px-6 py-5 rounded-[20px] transition-all duration-300 group ${
                          isDisabled ? 'cursor-not-allowed opacity-50' : 'cursor-pointer'
                        }`}
                        style={{
                          background: isSelected
                            ? 'linear-gradient(135deg, rgba(255, 255, 255, 0.95) 0%, rgba(255, 241, 247, 0.9) 100%)'
                            : 'rgba(255, 255, 255, 0.75)',
                          backdropFilter: 'blur(20px)',
                          border: isSelected 
                            ? '2.5px solid rgba(251, 113, 133, 0.6)' 
                            : '2px solid rgba(251, 113, 133, 0.25)',
                          boxShadow: isSelected
                            ? '0 8px 24px rgba(236, 72, 153, 0.2), inset 0 1px 2px rgba(255, 255, 255, 0.9)'
                            : '0 4px 12px rgba(236, 72, 153, 0.08), inset 0 1px 1px rgba(255, 255, 255, 0.8)',
                        }}
                      >
                        {/* Subtle Inner Gradient Overlay */}
                        <div className={`absolute inset-0 rounded-[18px] transition-opacity duration-300 ${
                          isSelected
                            ? 'bg-gradient-to-br from-rose-50/50 via-pink-50/40 to-transparent opacity-100'
                            : 'bg-gradient-to-br from-rose-50/20 via-pink-50/10 to-transparent opacity-0 group-hover:opacity-100'
                        }`} />

                        <div className="relative flex items-center justify-between">
                          <div className="flex items-start gap-4 flex-1">
                            <div className="flex items-center justify-center mt-0.5">
                              {isSelected ? (
                                <motion.div
                                  initial={{ scale: 0 }}
                                  animate={{ scale: 1 }}
                                  className="w-6 h-6 rounded-full bg-gradient-to-br from-rose-400 via-pink-500 to-purple-500 flex items-center justify-center shadow-lg"
                                  style={{
                                    boxShadow: '0 4px 12px rgba(236, 72, 153, 0.3)'
                                  }}
                                >
                                  <svg
                                    className="w-3.5 h-3.5 text-white"
                                    fill="none"
                                    strokeLinecap="round"
                                    strokeLinejoin="round"
                                    strokeWidth="3"
                                    viewBox="0 0 24 24"
                                    stroke="currentColor"
                                  >
                                    <path d="M5 13l4 4L19 7" />
                                  </svg>
                                </motion.div>
                              ) : (
                                <div
                                  className="w-6 h-6 rounded-full border-[2.5px] transition-all"
                                  style={{ 
                                    borderColor: isDisabled ? 'rgba(251, 113, 133, 0.3)' : 'rgba(251, 113, 133, 0.5)',
                                    boxShadow: isDisabled ? 'none' : '0 2px 8px rgba(236, 72, 153, 0.1)'
                                  }}
                                />
                              )}
                            </div>
                            <p
                              className={`leading-relaxed text-base flex-1 transition-all ${
                                isSelected ? 'text-purple-800 font-medium' : 'text-gray-700 font-normal'
                              }`}
                            >
                              {goal.text}
                            </p>
                          </div>
                        </div>
                      </button>
                    </motion.div>
                  );
                })}
              </div>
            </motion.div>
          ))}
        </div>

        {/* Action Buttons */}
        <motion.div
          className="flex flex-col gap-4 mt-12 max-w-md mx-auto"
          initial={{ opacity: 0, y: 20 }}
          animate={{ opacity: 1, y: 0 }}
          transition={{ delay: 0.6, duration: 0.5 }}
        >
          <RomanticButton
            onClick={handleContinue}
            disabled={selectedGoals.length === 0}
            fullWidth
          >
            {selectedGoals.length > 0 ? 'Continue' : 'Select at least 1 goal'}
          </RomanticButton>

          <button
            onClick={handleSkip}
            className="text-center py-3 text-rose-500 hover:text-rose-600 transition-colors font-medium"
          >
            Skip for now
          </button>
        </motion.div>
      </div>
    </div>
  );
}