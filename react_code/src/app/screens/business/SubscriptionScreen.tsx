import { useState } from 'react';
import { useNavigate } from 'react-router';
import { Check, Sparkles, ArrowLeft, MapPin, Package, TrendingUp, BarChart3, Star, Zap, Crown, ChevronRight, Heart, Award, Target, Users } from 'lucide-react';
import RomanticCard from '../../components/RomanticCard';
import RomanticButton from '../../components/RomanticButton';
import { useSubscription } from '../../contexts/SubscriptionContext';
import { motion, AnimatePresence } from 'motion/react';

interface PricingPlan {
  id: 'basic' | 'plus';
  name: string;
  subtitle: string;
  price: number;
  period: string;
  description: string;
  gradient: string;
  emoji: string;
  includes: {
    title: string;
    items: string[];
  };
  analytics: {
    title: string;
    items: string[];
  };
  isPopular?: boolean;
}

const PLANS: PricingPlan[] = [
  {
    id: 'basic',
    name: 'Business Partner -',
    subtitle: 'Basic',
    price: 10,
    period: 'month',
    description: 'For single-location businesses looking to be discovered locally',
    gradient: 'from-blue-100 via-indigo-50 to-purple-50',
    emoji: '✨',
    includes: {
      title: 'What\'s included:',
      items: [
        '1 business location',
        'Up to 15 products or services listed',
        'Business profile with website and social links viewed',
        'Your products & services proposed to the right users at the right moment of need',
      ],
    },
    analytics: {
      title: 'Analytics:',
      items: [
        'Business site views',
        'Impressions and interactions',
      ],
    },
  },
  {
    id: 'plus',
    name: 'Business Partner',
    subtitle: 'Plus',
    price: 19,
    period: 'month',
    description: 'For growing businesses with multiple locations and a broader presence',
    gradient: 'from-purple-100 via-pink-100 to-rose-100',
    emoji: '👑',
    isPopular: true,
    includes: {
      title: 'What\'s included:',
      items: [
        'Up to 7 business locations',
        'Up to 130 products or services listed',
        'Business profiles with website and social links',
        'Expanded visibility across multiple neighborhoods or cities',
        'Your business is suggested more broadly when care matters most',
      ],
    },
    analytics: {
      title: '',
      items: [],
    },
  },
];

export default function SubscriptionScreen() {
  const navigate = useNavigate();
  const { tier, upgradeTier } = useSubscription();
  const [selectedPlan, setSelectedPlan] = useState<'basic' | 'plus' | null>(null);

  const handleSelectPlan = (planId: 'basic' | 'plus') => {
    setSelectedPlan(planId);
    upgradeTier(planId);
    setTimeout(() => {
      navigate('/business/dashboard');
    }, 1500);
  };

  return (
    <div className="min-h-screen px-6 py-8 pb-24 max-w-5xl mx-auto">
      {/* Back Button */}
      <motion.button
        onClick={() => navigate('/business/dashboard')}
        className="mb-8 flex items-center gap-2 px-4 py-3 rounded-full bg-white shadow-lg hover:shadow-xl transition-all group"
        initial={{ opacity: 0, x: -20 }}
        animate={{ opacity: 1, x: 0 }}
        whileHover={{ scale: 1.05 }}
        whileTap={{ scale: 0.95 }}
      >
        <ArrowLeft className="w-5 h-5 text-purple-600 group-hover:-translate-x-1 transition-transform" />
        <span className="text-purple-600 font-medium text-sm">Back to Dashboard</span>
      </motion.button>

      {/* Header */}
      <motion.div 
        className="text-center mb-12 max-w-2xl mx-auto"
        initial={{ opacity: 0, y: 20 }}
        animate={{ opacity: 1, y: 0 }}
      >
        <div className="inline-flex items-center gap-2 px-5 py-2 bg-gradient-to-r from-purple-50 to-pink-50 rounded-full mb-6 border border-purple-100">
          <Heart className="w-4 h-4 text-purple-500" />
          <span className="text-purple-600 text-sm font-medium">Business Subscriptions</span>
        </div>
        
        <h1 className="text-4xl md:text-5xl text-gray-800 mb-4">
          Choose Your Plan
        </h1>
        
        <p className="text-gray-600 text-lg leading-relaxed">
          Connect with customers who need you most, at the perfect moment
        </p>
      </motion.div>

      {/* Pricing Cards */}
      <div className="grid md:grid-cols-2 gap-6 mb-12">
        {PLANS.map((plan, index) => {
          const isCurrentPlan = tier === plan.id;

          return (
            <motion.div
              key={plan.id}
              initial={{ opacity: 0, y: 40 }}
              animate={{ opacity: 1, y: 0 }}
              transition={{ delay: 0.2 + index * 0.1, duration: 0.5 }}
              className="relative"
            >
              {/* Popular Badge */}
              {plan.isPopular && (
                <motion.div 
                  initial={{ opacity: 0, y: -10 }}
                  animate={{ opacity: 1, y: 0 }}
                  transition={{ delay: 0.5 }}
                  className="absolute -top-4 left-1/2 -translate-x-1/2 z-10"
                >
                  <div className="flex items-center gap-2 px-6 py-2 bg-gradient-to-r from-purple-500 via-pink-500 to-rose-500 rounded-full shadow-lg">
                    <Sparkles className="w-4 h-4 text-white" />
                    <span className="text-white text-sm font-semibold">Most Popular</span>
                  </div>
                </motion.div>
              )}

              {/* Card */}
              <div
                className={`relative rounded-[24px] bg-white shadow-xl overflow-hidden transition-all duration-300 ${
                  plan.isPopular ? 'border-2 border-purple-200 md:scale-105' : 'border border-gray-100'
                } ${
                  selectedPlan === plan.id ? 'ring-4 ring-purple-300 ring-offset-4' : ''
                } hover:shadow-2xl`}
              >
                {/* Gradient Header */}
                <div className={`relative bg-gradient-to-br ${plan.gradient} px-8 py-10`}>
                  {/* Decorative Elements */}
                  <div className="absolute top-0 right-0 w-40 h-40 bg-white/20 rounded-full blur-3xl -translate-y-1/2 translate-x-1/2"></div>
                  <div className="absolute bottom-0 left-0 w-32 h-32 bg-white/20 rounded-full blur-2xl translate-y-1/2 -translate-x-1/2"></div>
                  
                  <div className="relative">
                    {/* Emoji Icon */}
                    <div className="flex justify-center mb-4">
                      <div className="text-5xl">
                        {plan.emoji}
                      </div>
                    </div>

                    {/* Plan Name */}
                    <div className="text-center mb-6">
                      <h2 className="text-gray-700 text-lg mb-1">{plan.name}</h2>
                      <h3 className="text-3xl font-bold text-gray-800">{plan.subtitle}</h3>
                    </div>

                    {/* Price */}
                    <div className="text-center">
                      <div className="flex items-baseline justify-center gap-2 mb-2">
                        <span className="text-5xl font-bold text-gray-800">${plan.price}</span>
                        <span className="text-gray-600">/ {plan.period}</span>
                      </div>
                      <p className="text-gray-600 text-sm mt-4 px-2 leading-relaxed">
                        {plan.description}
                      </p>
                    </div>
                  </div>
                </div>

                {/* Content */}
                <div className="px-8 py-8">
                  {/* Includes Section */}
                  <div className="mb-8">
                    <h4 className="text-gray-800 font-semibold mb-4 text-sm uppercase tracking-wide">
                      {plan.includes.title}
                    </h4>
                    <div className="space-y-3">
                      {plan.includes.items.map((item, idx) => (
                        <motion.div
                          key={idx}
                          initial={{ opacity: 0, x: -20 }}
                          animate={{ opacity: 1, x: 0 }}
                          transition={{ delay: 0.4 + idx * 0.05 }}
                          className="flex items-start gap-3"
                        >
                          <div className="flex-shrink-0 w-5 h-5 rounded-full bg-gradient-to-br from-purple-400 to-pink-400 flex items-center justify-center mt-0.5">
                            <Check className="w-3 h-3 text-white" strokeWidth={3} />
                          </div>
                          <span className="text-gray-700 text-sm leading-relaxed flex-1">{item}</span>
                        </motion.div>
                      ))}
                    </div>
                  </div>

                  {/* Analytics Section */}
                  {plan.analytics.title && plan.analytics.items.length > 0 && (
                    <div className="mb-8 pt-6 border-t border-gray-100">
                      <h4 className="text-gray-800 font-semibold mb-4 text-sm uppercase tracking-wide">
                        {plan.analytics.title}
                      </h4>
                      <div className="space-y-3">
                        {plan.analytics.items.map((item, idx) => (
                          <motion.div
                            key={idx}
                            initial={{ opacity: 0, x: -20 }}
                            animate={{ opacity: 1, x: 0 }}
                            transition={{ delay: 0.6 + idx * 0.05 }}
                            className="flex items-start gap-3"
                          >
                            <div className="flex-shrink-0 w-5 h-5 rounded-full bg-gradient-to-br from-purple-400 to-pink-400 flex items-center justify-center mt-0.5">
                              <Check className="w-3 h-3 text-white" strokeWidth={3} />
                            </div>
                            <span className="text-gray-700 text-sm leading-relaxed flex-1">{item}</span>
                          </motion.div>
                        ))}
                      </div>
                    </div>
                  )}

                  {/* CTA Button */}
                  <AnimatePresence mode="wait">
                    {isCurrentPlan ? (
                      <motion.div
                        key="current"
                        initial={{ opacity: 0 }}
                        animate={{ opacity: 1 }}
                        exit={{ opacity: 0 }}
                      >
                        <button
                          disabled
                          className="w-full py-4 rounded-[16px] bg-gray-100 text-gray-500 font-semibold flex items-center justify-center gap-2"
                        >
                          <Check className="w-5 h-5" />
                          Current Plan
                        </button>
                      </motion.div>
                    ) : selectedPlan === plan.id ? (
                      <motion.div
                        key="processing"
                        initial={{ opacity: 0, scale: 0.95 }}
                        animate={{ opacity: 1, scale: 1 }}
                        exit={{ opacity: 0, scale: 0.95 }}
                        className="w-full py-4 rounded-[16px] bg-gradient-to-r from-rose-500 via-pink-500 to-purple-500 text-white font-semibold flex items-center justify-center gap-2 shadow-lg shadow-pink-300/50"
                      >
                        <motion.div
                          animate={{ rotate: 360 }}
                          transition={{ duration: 1, repeat: Infinity, ease: 'linear' }}
                        >
                          <Sparkles className="w-5 h-5" />
                        </motion.div>
                        Processing...
                      </motion.div>
                    ) : (
                      <motion.button
                        key="select"
                        initial={{ opacity: 0 }}
                        animate={{ opacity: 1 }}
                        exit={{ opacity: 0 }}
                        whileHover={{ scale: 1.02 }}
                        whileTap={{ scale: 0.98 }}
                        onClick={() => handleSelectPlan(plan.id)}
                        className="w-full py-4 rounded-[16px] bg-gradient-to-r from-rose-500 via-pink-500 to-purple-500 text-white font-semibold shadow-lg shadow-pink-300/50 hover:shadow-xl hover:shadow-pink-300/60 transition-all flex items-center justify-center gap-2 group"
                      >
                        {plan.id === 'plus' && tier === 'basic' ? (
                          <>
                            Upgrade to Plus
                            <ChevronRight className="w-5 h-5 group-hover:translate-x-1 transition-transform" />
                          </>
                        ) : plan.id === 'basic' && tier === 'plus' ? (
                          'Switch to Basic'
                        ) : (
                          <>
                            Get Started
                            <ChevronRight className="w-5 h-5 group-hover:translate-x-1 transition-transform" />
                          </>
                        )}
                      </motion.button>
                    )}
                  </AnimatePresence>
                </div>
              </div>
            </motion.div>
          );
        })}
      </div>

      {/* Feature Highlights */}
      <motion.div
        initial={{ opacity: 0, y: 30 }}
        animate={{ opacity: 1, y: 0 }}
        transition={{ delay: 0.6 }}
        className="mb-12"
      >
        <div className="grid md:grid-cols-3 gap-6">
          <div className="text-center p-6 rounded-[20px] bg-white/60 backdrop-blur-sm border border-purple-100">
            <div className="inline-flex items-center justify-center w-14 h-14 rounded-full bg-gradient-to-br from-purple-100 to-pink-100 mb-4">
              <Target className="w-7 h-7 text-purple-600" />
            </div>
            <h3 className="text-gray-800 font-semibold mb-2">Smart Matching</h3>
            <p className="text-gray-600 text-sm">Connect with customers at the perfect moment</p>
          </div>

          <div className="text-center p-6 rounded-[20px] bg-white/60 backdrop-blur-sm border border-purple-100">
            <div className="inline-flex items-center justify-center w-14 h-14 rounded-full bg-gradient-to-br from-purple-100 to-pink-100 mb-4">
              <Users className="w-7 h-7 text-purple-600" />
            </div>
            <h3 className="text-gray-800 font-semibold mb-2">Grow Your Business</h3>
            <p className="text-gray-600 text-sm">Reach more customers who need your services</p>
          </div>

          <div className="text-center p-6 rounded-[20px] bg-white/60 backdrop-blur-sm border border-purple-100">
            <div className="inline-flex items-center justify-center w-14 h-14 rounded-full bg-gradient-to-br from-purple-100 to-pink-100 mb-4">
              <Award className="w-7 h-7 text-purple-600" />
            </div>
            <h3 className="text-gray-800 font-semibold mb-2">Premium Analytics</h3>
            <p className="text-gray-600 text-sm">Track performance and optimize your offerings</p>
          </div>
        </div>
      </motion.div>

      {/* Bottom Info */}
      <motion.div 
        initial={{ opacity: 0 }}
        animate={{ opacity: 1 }}
        transition={{ delay: 0.8 }}
        className="text-center"
      >
        <button
          onClick={() => navigate('/business/dashboard')}
          className="text-purple-600 hover:text-purple-700 text-sm font-medium transition-colors flex items-center gap-2 mx-auto group"
        >
          <ArrowLeft className="w-4 h-4 group-hover:-translate-x-1 transition-transform" />
          Back to Dashboard
        </button>
      </motion.div>
    </div>
  );
}