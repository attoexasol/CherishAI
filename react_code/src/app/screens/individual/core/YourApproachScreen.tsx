import { useNavigate, useParams } from 'react-router-dom';
import { ArrowLeft, Compass, Heart } from 'lucide-react';
import { motion } from 'motion/react';
import RomanticCard from '../../../components/RomanticCard';

export default function YourApproachScreen() {
  const navigate = useNavigate();
  const { name } = useParams<{ name: string }>();

  // Mock data - this would come from AI/API based on relationship analysis
  const approachGuidance = {
    Sarah: {
      relationshipType: 'partner',
      primaryGoal: 'Deepen emotional connection',
      guidance: `Based on your relationship dynamics with Sarah, we recommend a thoughtful, emotionally open approach. Sarah values genuine communication and appreciates when you share your feelings openly. Focus on creating intimate moments through meaningful conversations and small gestures that show you're thinking of her throughout the day. She responds well to affirmation and quality time, so prioritize being present and engaged when you're together. Remember, consistency in showing care matters more than grand gestures.`
    },
    Mom: {
      relationshipType: 'mother',
      primaryGoal: 'Show appreciation and strengthen family bond',
      guidance: `Your approach with your mom should emphasize gratitude and recognition of her ongoing support. She values hearing about your life and being included in your decisions. Regular check-ins, even brief ones, mean more to her than occasional lengthy conversations. Share both your successes and challenges with her—it makes her feel trusted and needed. Express appreciation for specific things she's done, both recently and in the past. She cherishes traditions and memories, so referencing shared experiences will deepen your connection.`
    },
    Jake: {
      relationshipType: 'friend',
      primaryGoal: 'Maintain strong friendship through life changes',
      guidance: `With Jake, authenticity and shared experiences are key. Your friendship thrives on mutual support and shared humor. Don't let time between interactions create distance—even a quick meme or inside joke keeps the connection strong. Be proactive about making plans, as he appreciates when you take the initiative. Balance lighthearted fun with deeper conversations when appropriate. Show up for important moments in his life, and don't hesitate to be vulnerable when you need support—true friendship is reciprocal.`
    }
  };

  const currentApproach = approachGuidance[name as keyof typeof approachGuidance] || {
    relationshipType: 'partner',
    primaryGoal: 'Deepen relationship',
    guidance: `We're still learning about your relationship dynamics. Keep engaging with CherishAI, and we'll provide personalized guidance tailored to your unique connection. The more you interact and share, the better we can support you in nurturing this important relationship.`
  };

  return (
    <div className="min-h-screen bg-gradient-to-br from-pink-50 via-purple-50 to-rose-50">
      {/* Header with Back Button */}
      <div className="sticky top-0 z-20 bg-gradient-to-br from-pink-50/95 via-purple-50/95 to-rose-50/95 backdrop-blur-xl border-b border-purple-100/50">
        <div className="max-w-md mx-auto px-5 py-4">
          <div className="flex items-center justify-between">
            <motion.button
              onClick={() => navigate(-1)}
              className="p-2.5 rounded-xl bg-gradient-to-br from-purple-500 to-pink-500 border border-purple-400 hover:shadow-lg transition-all shadow-md"
              whileHover={{ scale: 1.05 }}
              whileTap={{ scale: 0.95 }}
            >
              <ArrowLeft className="w-5 h-5 text-white" />
            </motion.button>
            <h1 className="text-lg font-semibold text-gray-800">
              Your approach with sarah
            </h1>
            <div className="w-10 h-10"></div> {/* Spacer for centering */}
          </div>
        </div>
      </div>

      {/* Main Content */}
      <div className="max-w-md mx-auto px-5 py-8">
        {/* Icon Card */}
        <motion.div
          className="flex justify-center mb-6"
          initial={{ opacity: 0, scale: 0.8 }}
          animate={{ opacity: 1, scale: 1 }}
          transition={{ delay: 0.1 }}
        >
          <div className="w-20 h-20 rounded-3xl bg-gradient-to-br from-purple-400 via-pink-400 to-rose-400 flex items-center justify-center shadow-2xl">
            <Compass className="w-10 h-10 text-white" />
          </div>
        </motion.div>

        {/* Main Guidance Card */}
        <motion.div
          initial={{ opacity: 0, y: 20 }}
          animate={{ opacity: 1, y: 0 }}
          transition={{ delay: 0.2 }}
        >
          <RomanticCard className="bg-white border-2 border-pink-200 shadow-xl mb-4">
            {/* Optional decorative icon */}
            <div className="flex justify-center mb-4">
              <div className="w-12 h-12 rounded-2xl bg-gradient-to-br from-pink-100 to-purple-100 flex items-center justify-center">
                <Heart className="w-6 h-6 text-pink-500" />
              </div>
            </div>

            {/* Title */}
            <h2 className="text-xl font-bold text-gray-800 mb-6 text-center">
              Your approach with Sarah
            </h2>

            {/* Guidance Text */}
            <div className="bg-gradient-to-br from-purple-50/50 to-pink-50/50 rounded-2xl p-6 mb-4 border border-purple-100/50">
              <p className="text-gray-700 leading-relaxed text-base">
                {currentApproach.guidance}
              </p>
            </div>

            {/* Relationship Context Tags */}
            <div className="flex flex-col gap-2 items-center">
              <div className="px-4 py-2 rounded-full bg-gradient-to-r from-purple-100 to-pink-100 border border-purple-200">
                <span className="text-xs font-medium text-purple-700">
                  {currentApproach.relationshipType}
                </span>
              </div>
              <div className="px-4 py-2 rounded-full bg-gradient-to-r from-rose-100 to-pink-100 border border-rose-200">
                <span className="text-xs font-medium text-rose-700">
                  Primary goal: {currentApproach.primaryGoal}
                </span>
              </div>
            </div>
          </RomanticCard>
        </motion.div>
      </div>
    </div>
  );
}