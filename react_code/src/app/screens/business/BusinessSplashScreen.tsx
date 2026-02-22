import { useNavigate } from 'react-router';
import { Store, Users, TrendingUp, Heart, ArrowLeft } from 'lucide-react';
import RomanticCard from '../../components/RomanticCard';
import RomanticButton from '../../components/RomanticButton';
import { motion } from 'motion/react';

export default function BusinessSplashScreen() {
  const navigate = useNavigate();

  const benefits = [
    { icon: Users, title: 'Reach Caring Customers', description: 'Connect with people who value thoughtfulness and meaningful moments - not impulse buying.' },
    { icon: TrendingUp, title: 'Be Present at the Right Moment', description: 'Your offerings appear when care matters most: birthdays, anniversaries, milestones, and everyday gestures.' },
    { icon: Heart, title: 'Grow with Intention', description: 'Get discovered by local individuals, couples, and families who are actively looking to express care.' },
    { icon: Store, title: 'Build Trust Through Relevance', description: 'Partner with a platform built on quality, context, and respect - not ads or aggressive promotion.' },
    { icon: Users, title: 'Simple & Respectful Visibility', description: 'Your business is shared as a thoughtful option, allowing customers to reach out naturally and directly' },
  ];

  return (
    <div className="min-h-screen px-6 py-12 pb-24 max-w-md mx-auto">
      {/* Back Button */}
      <button
        onClick={() => navigate(-1)}
        className="flex items-center gap-2 px-3 py-2 mb-6 rounded-xl text-purple-600 hover:text-purple-700 hover:bg-purple-50 transition-all"
      >
        <ArrowLeft className="w-5 h-5" />
        <span className="font-medium">Back</span>
      </button>

      <motion.div
        className="text-center mb-12"
        initial={{ opacity: 0, y: -20 }}
        animate={{ opacity: 1, y: 0 }}
      >
        <div className="inline-flex items-center justify-center w-16 h-16 rounded-full bg-gradient-to-br from-purple-400 to-indigo-400 mb-4 shadow-lg">
          <Store className="w-8 h-8 text-white" />
        </div>
        <h1 className="text-3xl mb-3 bg-gradient-to-r from-purple-600 to-indigo-600 bg-clip-text text-transparent">
          Cherish AI for Business
        </h1>
        <p className="text-gray-600 leading-relaxed">
          Help people express their love through your products and services
        </p>
      </motion.div>

      <div className="space-y-4 mb-12">
        {benefits.map((benefit, index) => (
          <motion.div
            key={index}
            initial={{ opacity: 0, x: -20 }}
            animate={{ opacity: 1, x: 0 }}
            transition={{ delay: index * 0.1 + 0.2 }}
          >
            <RomanticCard>
              <div className="flex items-start gap-4">
                <div className="w-12 h-12 rounded-full bg-gradient-to-br from-purple-100 to-indigo-100 flex items-center justify-center flex-shrink-0">
                  <benefit.icon className="w-6 h-6 text-purple-600" />
                </div>
                <div>
                  <h3 className="text-gray-800 mb-1">{benefit.title}</h3>
                  <p className="text-gray-600 text-sm">{benefit.description}</p>
                </div>
              </div>
            </RomanticCard>
          </motion.div>
        ))}
      </div>

      <div className="space-y-3">
        <RomanticButton fullWidth onClick={() => navigate('/business/register')}>
          Join for Partnership
        </RomanticButton>
        <p className="text-center text-gray-500 text-sm">
          Already a partner?{' '}
          <button className="text-purple-500 hover:text-purple-600" onClick={() => navigate('/business/dashboard')}>
            Sign in
          </button>
        </p>
      </div>
    </div>
  );
}