import { useNavigate, useParams } from 'react-router-dom';
import { ArrowLeft, Edit, Calendar, Heart, Gift, Phone, Target, Check, Crown, ArrowRight } from 'lucide-react';
import RomanticCard from '../../../components/RomanticCard';
import RomanticButton from '../../../components/RomanticButton';
import BottomNav from '../../../components/BottomNav';
import { motion } from 'motion/react';
import { useState } from 'react';
import chooseHigherTierImg from 'figma:asset/d8b2eae59d55ff7ad602be170430ffb448ffc77c.png';

export default function LovedOneDetailsScreen() {
  const navigate = useNavigate();
  const { id } = useParams();

  // Mock social media data
  const socialMediaHandles = {
    phone: '+1 234 567 8900',
  };

  // Relationship Goals State
  const [primaryGoal, setPrimaryGoal] = useState<string>('deepen');
  const [secondaryGoals, setSecondaryGoals] = useState<string[]>(['be-present', 'grow-emotionally', 'celebrate-everyday']);

  // Primary Goal Options
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

  // Secondary Goal Options
  const secondaryGoalOptions = [
    { id: 'balance-busy-life', text: 'Balance love with a busy life', category: 'Life & Presence' },
    { id: 'be-present', text: 'Be more present and intentional', category: 'Life & Presence' },
    { id: 'reconnect', text: 'Reconnect after distance or absence', category: 'Life & Presence' },
    { id: 'grow-emotionally', text: 'Grow together emotionally', category: 'Growth & Longevity' },
    { id: 'long-term-future', text: 'Build a long-term future together', category: 'Growth & Longevity' },
    { id: 'family-bonds', text: 'Strengthen family bonds', category: 'Growth & Longevity' },
    { id: 'heal-difficult', text: 'Heal after a difficult period', category: 'Healing & Repair' },
    { id: 'restore-closeness', text: 'Restore closeness after conflict', category: 'Healing & Repair' },
    { id: 'celebrate-everyday', text: 'Celebrate everyday moments', category: 'Moments & Meaning' },
    { id: 'important-milestone', text: 'Prepare for an important milestone', category: 'Moments & Meaning' },
    { id: 'joyful-surprises', text: 'Create joyful surprises', category: 'Moments & Meaning' },
    { id: 'feel-understood', text: 'Make them feel deeply understood', category: 'Emotional Expression' },
    { id: 'lightness-playfulness', text: 'Bring more lightness and playfulness', category: 'Emotional Expression' },
  ];

  const handleSecondaryGoalToggle = (goalId: string) => {
    if (secondaryGoals.includes(goalId)) {
      setSecondaryGoals(secondaryGoals.filter((id) => id !== goalId));
    } else {
      if (secondaryGoals.length < 3) {
        setSecondaryGoals([...secondaryGoals, goalId]);
      }
    }
  };

  return (
    <div className="min-h-screen pb-24">
      <div className="bg-gradient-to-br from-rose-400 to-pink-400 px-6 pt-12 pb-8">
        <button onClick={() => navigate(-1)} className="text-white mb-4">
          <ArrowLeft className="w-6 h-6" />
        </button>
        <div className="flex items-center gap-4">
          <div className="w-20 h-20 rounded-full bg-white/20 backdrop-blur-sm flex items-center justify-center text-4xl">
            💑
          </div>
          <div className="flex-1 text-white">
            <h1 className="text-2xl mb-1">Sarah</h1>
            <p className="text-white/80">Partner</p>
          </div>
          <button 
            onClick={() => navigate(`/individual/edit-loved-one/${id}`)}
            className="w-10 h-10 rounded-full bg-white/20 flex items-center justify-center hover:bg-white/30 transition-colors"
          >
            <Edit className="w-5 h-5 text-white" />
          </button>
        </div>
      </div>

      <div className="px-6 py-6 space-y-4">
        <RomanticCard>
          <h3 className="text-gray-700 mb-3 flex items-center gap-2">
            <Calendar className="w-5 h-5 text-rose-400" />
            Important Dates
          </h3>
          <div className="space-y-2 text-sm">
            <div className="flex justify-between">
              <span className="text-gray-500">Birthday</span>
              <span className="text-gray-800">January 15</span>
            </div>
            <div className="flex justify-between">
              <span className="text-gray-500">Anniversary</span>
              <span className="text-gray-800">March 20</span>
            </div>
          </div>
        </RomanticCard>

        <RomanticCard>
          <h3 className="text-gray-700 mb-3 flex items-center gap-2">
            <Phone className="w-5 h-5 text-rose-400" />
            Contact Information
          </h3>
          <div className="space-y-3">
            {/* Phone Number (Optional) */}
            {socialMediaHandles.phone && (
              <div className="flex items-center gap-3">
                <div className="w-10 h-10 rounded-full bg-gray-100 flex items-center justify-center flex-shrink-0">
                  <Phone className="w-4 h-4 text-gray-600" />
                </div>
                <div className="flex-1">
                  <p className="text-xs text-gray-500">Phone</p>
                  <p className="text-sm text-gray-800">{socialMediaHandles.phone}</p>
                </div>
              </div>
            )}
          </div>
        </RomanticCard>

        {/* Relationship Goals Section */}
        <RomanticCard>
          <h3 className="text-gray-700 mb-4 flex items-center gap-2">
            <Target className="w-5 h-5 text-rose-400" />
            Relationship Goals
          </h3>

          <div className="space-y-4">
            {/* Primary Goal */}
            <div>
              <label className="block text-xs font-medium text-gray-600 mb-2">
                💕 Primary Goal
              </label>
              <select
                value={primaryGoal}
                onChange={(e) => setPrimaryGoal(e.target.value)}
                className="w-full px-4 py-3 rounded-xl border-2 border-pink-200 focus:border-pink-400 focus:ring-2 focus:ring-pink-200 outline-none transition-all text-gray-800 bg-white text-sm"
              >
                <option value="">Select your primary goal</option>
                {primaryGoalOptions.map((goal) => (
                  <option key={goal.id} value={goal.id}>
                    {goal.icon} {goal.title}
                  </option>
                ))}
              </select>
              {primaryGoal && (
                <p className="mt-2 text-xs text-gray-600 leading-relaxed">
                  {primaryGoalOptions.find((g) => g.id === primaryGoal)?.description}
                </p>
              )}
            </div>

            {/* Secondary Goals */}
            <div>
              <div className="flex items-center justify-between mb-2">
                <label className="block text-xs font-medium text-gray-600">
                  ✨ Secondary Goals
                </label>
                <span className="text-xs px-2 py-0.5 rounded-full bg-purple-100 text-purple-700 font-medium">
                  {secondaryGoals.length}/3
                </span>
              </div>
              <div className="space-y-2 max-h-64 overflow-y-auto">
                {secondaryGoalOptions.map((goal) => {
                  const isSelected = secondaryGoals.includes(goal.id);
                  const isDisabled = !isSelected && secondaryGoals.length >= 3;
                  
                  return (
                    <button
                      key={goal.id}
                      type="button"
                      onClick={() => handleSecondaryGoalToggle(goal.id)}
                      disabled={isDisabled}
                      className={`w-full text-left px-3 py-2.5 rounded-xl border-2 transition-all ${
                        isSelected
                          ? 'bg-gradient-to-r from-rose-50 to-pink-50 border-rose-400 shadow-sm'
                          : isDisabled
                          ? 'bg-gray-50 border-gray-200 cursor-not-allowed opacity-50'
                          : 'bg-white border-pink-200 hover:border-pink-300 hover:bg-pink-50/50'
                      }`}
                    >
                      <div className="flex items-center gap-2">
                        <div
                          className={`w-4 h-4 rounded border-2 flex items-center justify-center flex-shrink-0 ${
                            isSelected
                              ? 'bg-rose-500 border-rose-500'
                              : 'bg-white border-pink-300'
                          }`}
                        >
                          {isSelected && <Check className="w-3 h-3 text-white" />}
                        </div>
                        <div className="flex-1">
                          <p className={`text-xs font-medium ${isSelected ? 'text-rose-700' : 'text-gray-800'}`}>
                            {goal.text}
                          </p>
                          <p className="text-[10px] text-gray-500 mt-0.5">{goal.category}</p>
                        </div>
                      </div>
                    </button>
                  );
                })}
              </div>
            </div>
          </div>
        </RomanticCard>

        <RomanticCard>
          <h3 className="text-gray-700 mb-3 flex items-center gap-2">
            <Heart className="w-5 h-5 text-rose-400" />
            What They Love
          </h3>
          <div className="flex flex-wrap gap-2">
            {['Coffee', 'Reading', 'Travel', 'Music'].map(item => (
              <span key={item} className="px-3 py-1 bg-rose-50 text-rose-600 rounded-full text-sm">
                {item}
              </span>
            ))}
          </div>
        </RomanticCard>

        <RomanticButton fullWidth onClick={() => navigate(`/individual/gift-ideas/${id}`, { state: { from: 'loved-one-details' } })}>
          <div className="flex items-center justify-center gap-2">
            <Gift className="w-5 h-5" />
            View Gift Ideas
          </div>
        </RomanticButton>

        {/* Subscription Upgrade Section */}
        <motion.div
          initial={{ opacity: 0, y: 20 }}
          animate={{ opacity: 1, y: 0 }}
          transition={{ delay: 0.2 }}
        >
          <RomanticCard className="relative overflow-hidden bg-gradient-to-br from-purple-50 via-pink-50 to-rose-50 border-2 border-purple-200">
            {/* Decorative elements */}
            <div className="absolute top-0 right-0 w-32 h-32 bg-gradient-to-br from-purple-200/30 to-pink-200/30 rounded-full blur-3xl"></div>
            <div className="absolute bottom-0 left-0 w-24 h-24 bg-gradient-to-br from-rose-200/30 to-purple-200/30 rounded-full blur-2xl"></div>
            
            <div className="relative z-10">
              <div className="flex items-start gap-3 mb-4">
                <div className="w-12 h-12 rounded-full bg-gradient-to-br from-purple-400 to-pink-400 flex items-center justify-center flex-shrink-0 shadow-lg">
                  <Crown className="w-6 h-6 text-white" />
                </div>
                <div className="flex-1">
                  <h3 className="text-gray-800 font-medium mb-1 flex items-center gap-2">
                    Unlock Premium Features
                  </h3>
                  <p className="text-sm text-gray-600 leading-relaxed">
                    Access personalized AI insights, unlimited loved ones, advanced gift recommendations, and more.
                  </p>
                </div>
              </div>

              {/* Image from Figma */}
              <div className="mb-4 flex justify-center">
                <img 
                  src={chooseHigherTierImg} 
                  alt="Choose a higher tier" 
                  className="h-6 object-contain"
                />
              </div>

              <button
                onClick={() => navigate('/individual/subscription')}
                className="w-full py-3 px-4 bg-gradient-to-r from-purple-500 via-pink-500 to-rose-500 text-white rounded-[16px] font-medium hover:shadow-xl hover:scale-[1.02] transition-all flex items-center justify-center gap-2 group"
              >
                <span>View Subscription Plans</span>
                <ArrowRight className="w-5 h-5 group-hover:translate-x-1 transition-transform" />
              </button>
            </div>
          </RomanticCard>
        </motion.div>
      </div>

      <BottomNav />
    </div>
  );
}