import { useState } from 'react';
import { useNavigate } from 'react-router-dom';
import { Target } from 'lucide-react';
import RomanticButton from '../../../components/RomanticButton';
import { motion } from 'motion/react';
import BackButton from '@/app/components/BackButton';

export default function YourRelationshipGoalsScreen() {
  const navigate = useNavigate();
  const [primaryGoal, setPrimaryGoal] = useState<string>('');

  const primaryGoalOptions = [
    {
      id: 'deepen',
      icon: '💕',
      title: 'Deepen emotional connection',
      description: 'Increase closeness, openness, emotional intimacy',
    },
    {
      id: 'spark',
      icon: '✨',
      title: 'Keep the spark alive',
      description: 'Maintain excitement, playfulness, attraction, novelty',
    },
    {
      id: 'trust',
      icon: '🛡️',
      title: 'Build trust & emotional security',
      description: 'Create safety, reassurance, reliability, stability',
    },
    {
      id: 'communication',
      icon: '💬',
      title: 'Improve communication & understanding',
      description: 'Express better, listen better, feel understood',
    },
    {
      id: 'appreciation',
      icon: '🌸',
      title: 'Show appreciation & care',
      description: 'Express gratitude, recognition, affection',
    },
    {
      id: 'moments',
      icon: '🌟',
      title: 'Create meaningful shared moments',
      description: 'Build memories through experiences and rituals',
    },
    {
      id: 'reignite',
      icon: '🔥',
      title: 'Reignite romance or closeness',
      description: 'Restore warmth, affection, emotional energy',
    },
    {
      id: 'support',
      icon: '🤝',
      title: 'Support and uplift each other',
      description: 'Offer encouragement and emotional presence',
    },
    {
      id: 'romantic',
      icon: '💓',
      title: 'Build romantic interest naturally',
      description: 'Explore attraction with warmth and respect',
    },
  ];

  const handleContinue = () => {
    if (primaryGoal) {
      // Store goals and navigate directly to Secondary Goals Context
      navigate('/individual/secondary-goals-context');
    }
  };

  return (
    <div
      className="min-h-screen pb-8 relative pt-20"
      style={{
        background: 'linear-gradient(180deg, #FFF5F8 0%, #FCECF1 100%)',
      }}
    >
      {/* Back Button */}
      <BackButton to="/individual/add-loved-one" />
      
      <div className="max-w-md mx-auto px-6 pt-2 pb-8">
        {/* Header */}
        <motion.div
          className="mb-8"
          initial={{ opacity: 0, y: -20 }}
          animate={{ opacity: 1, y: 0 }}
          transition={{ duration: 0.5 }}
        >
          <div
            className="w-10 h-10 rounded-full flex items-center justify-center mb-4"
            style={{
              background: 'linear-gradient(135deg, #E91E63, #C2185B)',
            }}
          >
            <Target className="w-5 h-5 text-white" />
          </div>
          <h1
            className="text-2xl font-semibold mb-2"
            style={{ color: '#4A3B4F', fontFamily: 'Inter, SF Pro, Poppins, sans-serif' }}
          >
            Your relationship goals
          </h1>
          <p className="text-sm leading-relaxed" style={{ color: '#C98FA1' }}>
            Every relationship is different. By choosing your goal, you help Cherish AI understand how you want to care — so suggestions, words, and ideas feel truly personal and aligned with what you're trying to nurture
          </p>
        </motion.div>

        {/* Primary Goal Section */}
        <motion.div
          className="mb-8"
          initial={{ opacity: 0 }}
          animate={{ opacity: 1 }}
          transition={{ delay: 0.2, duration: 0.5 }}
        >
          <p className="text-sm mb-4" style={{ color: '#9C7B8A' }}>
            Primary Goal (choose 1)
          </p>
          <div className="space-y-3">
            {primaryGoalOptions.map((goal, index) => (
              <motion.button
                key={goal.id}
                type="button"
                onClick={() => setPrimaryGoal(goal.id)}
                className="w-full text-left transition-all duration-300"
                initial={{ opacity: 0, y: 20 }}
                animate={{ opacity: 1, y: 0 }}
                transition={{ delay: 0.1 * index, duration: 0.4 }}
                whileTap={{ scale: 0.98 }}
                whileHover={{ scale: 1.02, y: -2 }}
                style={{
                  background: primaryGoal === goal.id 
                    ? 'linear-gradient(135deg, #FFE5EC, #FFF0F5)'
                    : '#FFFFFF',
                  borderRadius: '16px',
                  padding: '16px',
                  boxShadow:
                    primaryGoal === goal.id
                      ? '0px 12px 32px rgba(233, 30, 99, 0.35)'
                      : '0px 8px 20px rgba(246, 166, 193, 0.25)',
                  border: primaryGoal === goal.id
                      ? '3px solid #E91E63'
                      : '2px solid rgba(246, 166, 193, 0.2)',
                  transform: primaryGoal === goal.id ? 'scale(1.02)' : 'scale(1)',
                }}
              >
                <div className="flex items-start gap-3">
                  <div
                    className="w-8 h-8 rounded-full flex items-center justify-center flex-shrink-0"
                    style={{
                      background: primaryGoal === goal.id
                        ? 'linear-gradient(135deg, #E91E63, #F06292)'
                        : 'linear-gradient(135deg, #FFF0F5, #FFE4EC)',
                    }}
                  >
                    <span className="text-lg">{goal.icon}</span>
                  </div>
                  <div className="flex-1">
                    <h3
                      className="text-base font-medium mb-1"
                      style={{ color: primaryGoal === goal.id ? '#C2185B' : '#4A3B4F' }}
                    >
                      {goal.title}
                    </h3>
                    <p className="text-sm leading-relaxed" style={{ color: '#9C7B8A' }}>
                      {goal.description}
                    </p>
                  </div>
                </div>
              </motion.button>
            ))}
          </div>
        </motion.div>

        {/* Save Button */}
        <motion.div
          initial={{ opacity: 0, y: 20 }}
          animate={{ opacity: 1, y: 0 }}
          transition={{ delay: 0.6, duration: 0.5 }}
        >
          <button
            type="button"
            onClick={handleContinue}
            disabled={!primaryGoal}
            className={`
              w-full py-4 px-6 rounded-2xl font-semibold text-lg transition-all duration-300
              ${
                primaryGoal
                  ? 'bg-gradient-to-r from-rose-500 via-pink-500 to-purple-500 text-white shadow-lg shadow-pink-300/50 hover:shadow-xl hover:shadow-pink-300/60 hover:scale-[1.02] active:scale-[0.98]'
                  : 'bg-gray-200 text-gray-400 cursor-not-allowed'
              }
            `}
          >
            Save
          </button>

          <p
            className="text-center mt-4 text-xs"
            style={{ color: '#CFA3B4' }}
          >
            We'll help you achieve these goals together
          </p>
        </motion.div>
      </div>
    </div>
  );
}