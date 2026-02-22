import { useState } from 'react';
import { useNavigate } from 'react-router-dom';
import { Check, X, ArrowLeft, Sparkles, Heart, Crown, AlertCircle } from 'lucide-react';
import { motion, AnimatePresence } from 'motion/react';

interface Plan {
  id: string;
  name: string;
  price: number;
  period: string;
  tagline: string;
  recommended?: boolean;
  gradient: string;
  icon: any;
  included: Array<{ text: string; description?: string }>;
  notIncluded?: string[];
  bestFor: string;
}

export default function SubscriptionScreen() {
  const navigate = useNavigate();
  const [selectedPlan, setSelectedPlan] = useState('plus');
  const [currentPlan] = useState('plus'); // Mock current subscription - in real app, get from context/API
  const [showUnsubscribeModal, setShowUnsubscribeModal] = useState(false);

  const plans: Plan[] = [
    {
      id: 'essential',
      name: 'Cherish Essential',
      price: 9,
      period: 'month',
      tagline: 'For one relationship',
      gradient: 'from-pink-400 to-rose-400',
      icon: Heart,
      included: [
        { text: 'You add one loved one/relationship' },
        { 
          text: 'Daily personalized messages & inspirations', 
          description: 'Thoughtful words and ideas you can send directly, or naturally mention in conversation, to show care in a personal and intentional way'
        },
        { 
          text: 'Special-date reminders', 
          description: 'Never miss birthdays, anniversaries, milestones, or meaningful moments'
        },
        { 
          text: 'Gift & experience suggestions for special occasion', 
          description: 'Carefully selected ideas aligned with the relationship, preferences, and moment'
        },
        { text: 'Up to 3 custom important dates' },
        { text: 'Relationship-goal–based personalization' },
        { text: 'Edit goals and preferences anytime' },
      ],
      bestFor: 'One meaningful relationship - romantic, family, friendship, or professional',
    },
    {
      id: 'plus',
      name: 'Cherish Plus',
      price: 16,
      period: 'month',
      tagline: '',
      recommended: true,
      gradient: 'from-purple-400 to-pink-400',
      icon: Sparkles,
      included: [
        { text: 'Includes everything in Cherish Essential, plus:' },
        { text: 'Up to 6 loved ones' },
        { text: 'Unlimited important dates' },
        { 
          text: 'Push notification', 
          description: 'Gentle reminders and inspirations at the right moments.'
        },
        { text: 'Independent goals and preferences per loved one' },
      ],
      bestFor: 'Partners, families, close friends, or users balancing multiple relationships.',
    },
    {
      id: 'unlimited',
      name: 'Cherish Unlimited',
      price: 26,
      period: 'month',
      tagline: '',
      gradient: 'from-indigo-400 to-purple-400',
      icon: Crown,
      included: [
        { text: 'Includes everything in Cherish Plus, plus:' },
        { text: 'Unlimited loved ones' },
        { text: 'Deeper long-term personalization across all relationships' },
        { text: 'Relationship insights over time' },
        { text: 'Early access to new features' },
      ],
      bestFor: 'Large families, highly social users, or anyone who wants Cherish AI fully integrated into daily life.',
    },
  ];

  const handleContinue = () => {
    const plan = plans.find(p => p.id === selectedPlan);
    navigate('/individual/checkout', { 
      state: { 
        plan: {
          id: plan?.id,
          name: plan?.name,
          price: plan?.price,
          period: plan?.period,
          tagline: plan?.tagline,
        }
      } 
    });
  };

  const handleBack = () => {
    navigate(-1);
  };

  const handleUnsubscribe = () => {
    // In real app: call API to cancel subscription
    console.log('Unsubscribing...');
    setShowUnsubscribeModal(false);
    // Navigate to confirmation or home
    navigate('/individual/home');
  };

  return (
    <div className="min-h-screen bg-gradient-to-br from-rose-50 via-pink-50 to-purple-50 pb-32">
      {/* Header */}
      <div className="sticky top-0 z-20 bg-gradient-to-br from-rose-50/95 via-pink-50/95 to-purple-50/95 backdrop-blur-xl border-b border-pink-100/50">
        <div className="max-w-4xl mx-auto px-6 py-4">
          <div className="flex items-center justify-between">
            <button
              onClick={handleBack}
              className="flex items-center gap-2 text-rose-600 hover:text-rose-700 transition-colors"
            >
              <ArrowLeft className="w-5 h-5" />
              <span className="font-medium">Back</span>
            </button>
          </div>
        </div>
      </div>

      {/* Main Content */}
      <div className="max-w-4xl mx-auto px-6 pt-8">
        {/* Title Section */}
        <div className="mb-10 text-center">
          <div className="inline-flex items-center justify-center w-16 h-16 rounded-2xl bg-gradient-to-br from-rose-400 to-purple-400 mb-5 shadow-lg">
            <Heart className="w-8 h-8 text-white" />
          </div>
          <h1 className="text-4xl font-bold bg-gradient-to-r from-rose-600 via-pink-600 to-purple-600 bg-clip-text text-transparent mb-3">
            Choose your plan
          </h1>
          <p className="text-lg text-gray-600">
            Let Cherish AI handle the effort, so your care feels personal, natural, and thoughtful.
          </p>
        </div>

        {/* Current Subscription Status */}
        {currentPlan && (
          <motion.div
            initial={{ opacity: 0, y: -20 }}
            animate={{ opacity: 1, y: 0 }}
            className="mb-8 bg-gradient-to-br from-purple-50 to-pink-50 rounded-3xl p-6 border-2 border-purple-200/50 shadow-lg"
          >
            <div className="flex items-start justify-between mb-4">
              <div>
                <div className="flex items-center gap-2 mb-2">
                  <div className="w-2 h-2 bg-green-500 rounded-full animate-pulse"></div>
                  <span className="text-xs font-semibold text-purple-600 uppercase tracking-wide">Active Subscription</span>
                </div>
                <h3 className="text-xl font-bold text-gray-800">
                  {plans.find(p => p.id === currentPlan)?.name}
                </h3>
                <p className="text-sm text-gray-600 mt-1">
                  ${plans.find(p => p.id === currentPlan)?.price}/month • Renews Feb 20, 2026
                </p>
              </div>
              <div className="flex flex-col gap-2">
                <button
                  onClick={() => selectedPlan !== currentPlan && handleContinue()}
                  disabled={selectedPlan === currentPlan}
                  className={`px-4 py-2 rounded-full text-sm font-medium transition-all ${
                    selectedPlan === currentPlan
                      ? 'bg-gray-100 text-gray-400 cursor-not-allowed'
                      : 'bg-gradient-to-r from-purple-500 to-pink-500 text-white hover:shadow-lg'
                  }`}
                >
                  {selectedPlan === currentPlan ? 'Current Plan' : 'Change Plan'}
                </button>
              </div>
            </div>
            
            <div className="h-px bg-gradient-to-r from-transparent via-purple-200 to-transparent my-4"></div>
            
            <button
              onClick={() => setShowUnsubscribeModal(true)}
              className="text-sm text-gray-500 hover:text-red-500 transition-colors font-bold"
            >
              Cancel subscription
            </button>
          </motion.div>
        )}

        {/* Plans Grid */}
        <div className="grid md:grid-cols-3 gap-6 mb-8">
          {plans.map((plan, index) => {
            const Icon = plan.icon;
            const isSelected = selectedPlan === plan.id;

            return (
              <div
                key={plan.id}
                className="relative"
                style={{
                  animation: `fadeSlideIn 0.6s ease-out ${index * 0.15}s both`,
                }}
              >
                {/* Recommended Badge */}
                {plan.recommended && (
                  <div className="absolute -top-4 left-1/2 transform -translate-x-1/2 z-10">
                    <div className="bg-gradient-to-r from-purple-500 to-pink-500 text-white px-4 py-1.5 rounded-full text-xs font-semibold shadow-lg flex items-center gap-1.5">
                      <Sparkles className="w-3.5 h-3.5" />
                      Recommended
                    </div>
                  </div>
                )}

                {/* Plan Card */}
                <button
                  onClick={() => setSelectedPlan(plan.id)}
                  className={`
                    w-full text-left rounded-3xl p-6 transition-all duration-300 relative overflow-hidden
                    ${
                      isSelected
                        ? 'bg-white shadow-2xl shadow-pink-300/50 scale-[1.02] border-2 border-pink-300'
                        : 'bg-white/80 backdrop-blur border border-pink-200/50 hover:border-pink-300 hover:shadow-lg'
                    }
                  `}
                >
                  {/* Selection Indicator */}
                  {isSelected && (
                    <div className="absolute top-4 right-4">
                      <div className={`w-7 h-7 rounded-full bg-gradient-to-r ${plan.gradient} flex items-center justify-center shadow-md`}>
                        <Check className="w-4 h-4 text-white" strokeWidth={3} />
                      </div>
                    </div>
                  )}

                  {/* Plan Header */}
                  <div className="mb-5">
                    <div className={`inline-flex p-2.5 rounded-xl bg-gradient-to-br ${plan.gradient} bg-opacity-10 mb-3`}>
                      <Icon className={`w-6 h-6 bg-gradient-to-r ${plan.gradient} bg-clip-text text-transparent`} strokeWidth={2} />
                    </div>
                    <h3 className="text-xl font-bold text-gray-800 mb-1">{plan.name}</h3>
                    <p className="text-sm text-gray-500 mb-3">{plan.tagline}</p>
                    <div className="flex items-baseline gap-1">
                      <span className="text-4xl font-bold bg-gradient-to-r from-rose-600 to-purple-600 bg-clip-text text-transparent">
                        ${plan.price}
                      </span>
                      <span className="text-gray-500 text-base">/ {plan.period}</span>
                    </div>
                  </div>

                  {/* Divider */}
                  <div className="h-px bg-gradient-to-r from-transparent via-pink-200 to-transparent mb-5" />

                  {/* Included Features */}
                  <div className="mb-5">
                    <p className="text-xs font-semibold text-gray-700 uppercase tracking-wide mb-3">
                      Includes:
                    </p>
                    <ul className="space-y-2.5">
                      {plan.included.map((feature, i) => (
                        <li key={i} className="flex items-start gap-2.5">
                          <div className={`mt-0.5 flex-shrink-0 w-5 h-5 rounded-full bg-gradient-to-br ${plan.gradient} bg-opacity-10 flex items-center justify-center`}>
                            <Check className={`w-3 h-3 bg-gradient-to-r ${plan.gradient} bg-clip-text text-transparent`} strokeWidth={3} />
                          </div>
                          <div className="leading-snug">
                            <div className="text-sm text-gray-700">{feature.text}</div>
                            {feature.description && (
                              <div className="text-xs text-gray-500 mt-0.5">({feature.description})</div>
                            )}
                          </div>
                        </li>
                      ))}
                    </ul>
                  </div>

                  {/* Not Included Features */}
                  {plan.notIncluded && plan.notIncluded.length > 0 && (
                    <div className="mb-5">
                      <p className="text-xs font-semibold text-gray-700 uppercase tracking-wide mb-3">
                        Not included:
                      </p>
                      <ul className="space-y-2.5">
                        {plan.notIncluded.map((feature, i) => (
                          <li key={i} className="flex items-start gap-2.5 text-sm text-gray-400">
                            <div className="mt-0.5 flex-shrink-0 w-5 h-5 rounded-full bg-gray-100 flex items-center justify-center">
                              <X className="w-3 h-3 text-gray-400" strokeWidth={2} />
                            </div>
                            <span className="leading-snug">{feature}</span>
                          </li>
                        ))}
                      </ul>
                    </div>
                  )}

                  {/* Divider */}
                  <div className="h-px bg-gradient-to-r from-transparent via-pink-200 to-transparent mb-4" />

                  {/* Best For */}
                  <div>
                    <p className="text-xs font-semibold text-gray-700 uppercase tracking-wide mb-2">
                      Best for:
                    </p>
                    <p className="text-sm text-gray-600 leading-relaxed italic">
                      {plan.bestFor}
                    </p>
                  </div>
                </button>
              </div>
            );
          })}
        </div>

        {/* Plan Comparison Note */}
        <div className="mb-8 text-center">
          <p className="text-sm text-gray-500">
            All plans include our core relationship-building features and can be cancelled anytime
          </p>
        </div>
      </div>

      {/* Fixed Bottom CTA */}
      <div className="fixed bottom-0 left-0 right-0 bg-gradient-to-t from-white via-white to-transparent pt-6 pb-6 px-6 border-t border-pink-100/50">
        <div className="max-w-4xl mx-auto">
          <button
            onClick={handleContinue}
            className="w-full py-4 px-6 rounded-2xl bg-gradient-to-r from-rose-500 via-pink-500 to-purple-500 text-white font-semibold text-lg shadow-lg shadow-pink-300/50 hover:shadow-xl hover:scale-[1.02] active:scale-[0.98] transition-all"
          >
            {selectedPlan === 'essential' && 'Start with Essential — $9/month'}
            {selectedPlan === 'plus' && 'Start with Plus — $16/month'}
            {selectedPlan === 'unlimited' && 'Start with Unlimited — $26/month'}
          </button>
        </div>
      </div>

      {/* Unsubscribe Confirmation Modal */}
      <AnimatePresence>
        {showUnsubscribeModal && (
          <motion.div
            initial={{ opacity: 0 }}
            animate={{ opacity: 1 }}
            exit={{ opacity: 0 }}
            className="fixed inset-0 bg-black/50 backdrop-blur-sm z-50 flex items-center justify-center p-6"
            onClick={() => setShowUnsubscribeModal(false)}
          >
            <motion.div
              initial={{ scale: 0.9, opacity: 0 }}
              animate={{ scale: 1, opacity: 1 }}
              exit={{ scale: 0.9, opacity: 0 }}
              onClick={(e) => e.stopPropagation()}
              className="bg-white rounded-3xl p-8 max-w-md w-full shadow-2xl"
            >
              <div className="text-center mb-6">
                <div className="inline-flex items-center justify-center w-16 h-16 rounded-full bg-red-100 mb-4">
                  <AlertCircle className="w-8 h-8 text-red-500" />
                </div>
                <h3 className="text-2xl font-bold text-gray-800 mb-2">Cancel Subscription?</h3>
                <p className="text-gray-600 leading-relaxed">
                  We're sad to see you go. If you cancel now, you'll lose access to all premium features at the end of your billing period.
                </p>
              </div>

              <div className="bg-gradient-to-br from-rose-50 to-pink-50 rounded-2xl p-4 mb-6 border border-rose-200/50">
                <h4 className="font-semibold text-gray-800 mb-2">You'll lose access to:</h4>
                <ul className="space-y-2">
                  <li className="flex items-start gap-2 text-sm text-gray-600">
                    <X className="w-4 h-4 text-rose-500 flex-shrink-0 mt-0.5" />
                    <span>Daily personalized messages & inspiration</span>
                  </li>
                  <li className="flex items-start gap-2 text-sm text-gray-600">
                    <X className="w-4 h-4 text-rose-500 flex-shrink-0 mt-0.5" />
                    <span>Gift & experience suggestions</span>
                  </li>
                  <li className="flex items-start gap-2 text-sm text-gray-600">
                    <X className="w-4 h-4 text-rose-500 flex-shrink-0 mt-0.5" />
                    <span>Multiple loved ones & unlimited dates</span>
                  </li>
                  <li className="flex items-start gap-2 text-sm text-gray-600">
                    <X className="w-4 h-4 text-rose-500 flex-shrink-0 mt-0.5" />
                    <span>AI-powered relationship insights</span>
                  </li>
                </ul>
              </div>

              <div className="space-y-3">
                <button
                  onClick={() => setShowUnsubscribeModal(false)}
                  className="w-full py-3 px-6 rounded-2xl bg-gradient-to-r from-rose-500 via-pink-500 to-purple-500 text-white font-semibold shadow-lg shadow-pink-300/50 hover:shadow-xl transition-all"
                >
                  Keep My Subscription
                </button>
                <button
                  onClick={handleUnsubscribe}
                  className="w-full py-3 px-6 rounded-2xl bg-gray-100 text-gray-700 font-medium hover:bg-gray-200 transition-all"
                >
                  Cancel Anyway
                </button>
              </div>
            </motion.div>
          </motion.div>
        )}
      </AnimatePresence>

      {/* Animations */}
      <style>{`
        @keyframes fadeSlideIn {
          from {
            opacity: 0;
            transform: translateY(30px);
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