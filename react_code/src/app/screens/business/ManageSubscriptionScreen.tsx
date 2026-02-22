import { useState } from 'react';
import { useNavigate } from 'react-router';
import { ArrowLeft, Crown, HelpCircle, AlertCircle, X, Sparkles, Pause, ChevronDown, Check } from 'lucide-react';
import { motion, AnimatePresence } from 'motion/react';
import RomanticCard from '@/app/components/RomanticCard';
import { useSubscription } from '@/app/contexts/SubscriptionContext';

export default function ManageSubscriptionScreen() {
  const navigate = useNavigate();
  const { tier } = useSubscription();
  const [showUnsubscribeModal, setShowUnsubscribeModal] = useState(false);
  const [showChoosePlanSection, setShowChoosePlanSection] = useState(false);
  const [unsubscribeStep, setUnsubscribeStep] = useState<'options' | 'reasons' | 'confirm'>('options');
  const [selectedReason, setSelectedReason] = useState<string>('');
  const [feedback, setFeedback] = useState<string>('');

  const planNames = {
    basic: 'Business Partner - Basic',
    plus: 'Business Partner Plus',
  };

  const allPlans = [
    {
      id: 'basic',
      name: 'Business Partner - Basic',
      price: '$10',
      period: '/month',
      description: 'For single-location businesses',
      features: [
        '1 business location',
        'Up to 15 products or services',
        'Business profile with links',
        'Smart user matching',
        'Basic analytics',
      ],
      gradient: 'from-blue-400 to-indigo-400',
      bgGradient: 'from-blue-50 to-indigo-50',
      borderColor: 'border-blue-300',
    },
    {
      id: 'plus',
      name: 'Business Partner Plus',
      price: '$19',
      period: '/month',
      description: 'For growing businesses',
      features: [
        'Up to 7 business locations',
        'Up to 130 products or services',
        'Business profiles with links',
        'Expanded visibility',
        'Priority support',
        'Advanced analytics',
      ],
      gradient: 'from-purple-400 to-pink-400',
      bgGradient: 'from-purple-50 to-pink-50',
      borderColor: 'border-purple-300',
      popular: true,
    },
  ];

  const cancellationReasons = [
    { id: 'too-expensive', label: 'Too expensive', icon: '💰' },
    { id: 'not-using', label: 'Not using it enough', icon: '⏰' },
    { id: 'technical-issues', label: 'Technical issues', icon: '⚙️' },
    { id: 'missing-features', label: 'Missing features I need', icon: '✨' },
    { id: 'found-alternative', label: 'Found a better alternative', icon: '🔄' },
    { id: 'other', label: 'Other reason', icon: '💭' },
  ];

  const handleBack = () => {
    navigate(-1);
  };

  const handlePauseSubscription = () => {
    console.log('Pausing subscription...');
    setShowUnsubscribeModal(false);
  };

  const handleDowngrade = () => {
    console.log('Navigating to downgrade options...');
    setShowUnsubscribeModal(false);
    setShowChoosePlanSection(true);
  };

  const handleContinueToReasons = () => {
    setUnsubscribeStep('reasons');
  };

  const handleContinueToConfirm = () => {
    if (selectedReason) {
      setUnsubscribeStep('confirm');
    }
  };

  const handleFinalCancel = () => {
    console.log('Canceling subscription...', { reason: selectedReason, feedback });
    setShowUnsubscribeModal(false);
    setUnsubscribeStep('options');
    setSelectedReason('');
    setFeedback('');
    navigate('/business/dashboard');
  };

  const handleCloseModal = () => {
    setShowUnsubscribeModal(false);
    setUnsubscribeStep('options');
    setSelectedReason('');
    setFeedback('');
  };

  return (
    <div className="min-h-screen bg-gradient-to-br from-pink-50/30 via-rose-50/30 to-purple-50/30">
      {/* Header */}
      <div className="sticky top-0 z-20 bg-white/80 backdrop-blur-xl border-b border-pink-100/30">
        <div className="max-w-2xl mx-auto px-6 py-4">
          <div className="flex items-center justify-between">
            <button
              onClick={handleBack}
              className="flex items-center justify-center w-10 h-10 rounded-full hover:bg-pink-100 transition-colors"
            >
              <ArrowLeft className="w-5 h-5 text-pink-400" />
            </button>
            <h1 className="text-lg font-semibold text-gray-800">Manage Subscription</h1>
            <button
              className="flex items-center justify-center w-10 h-10 rounded-full hover:bg-pink-100 transition-colors"
            >
              <HelpCircle className="w-5 h-5 text-gray-400" />
            </button>
          </div>
        </div>
      </div>

      {/* Main Content */}
      <div className="max-w-2xl mx-auto px-6 pt-8 pb-24">
        {/* Current Plan Card */}
        <motion.div
          initial={{ opacity: 0, y: 20 }}
          animate={{ opacity: 1, y: 0 }}
          className="bg-white rounded-[24px] p-8 shadow-lg shadow-pink-100/50 border border-pink-100/50"
        >
          {/* Current Plan Info */}
          <div className="flex items-center gap-4 mb-6">
            <div className="w-14 h-14 rounded-full bg-gradient-to-br from-purple-300 to-pink-300 flex items-center justify-center shadow-md">
              <Crown className="w-7 h-7 text-white" />
            </div>
            <div>
              <p className="text-sm text-gray-400 mb-1">Current Plan</p>
              <h2 className="text-xl font-bold text-gray-800">
                {planNames[tier as keyof typeof planNames]}
              </h2>
            </div>
          </div>

          {/* Upgrade Button */}
          <button
            onClick={() => setShowChoosePlanSection(!showChoosePlanSection)}
            className="w-full py-4 px-6 rounded-full bg-gradient-to-r from-pink-400 to-pink-500 text-white font-semibold text-base shadow-md shadow-pink-300/40 hover:shadow-lg hover:scale-[1.02] active:scale-[0.98] transition-all mb-3"
          >
            {showChoosePlanSection ? 'Hide Plans' : 'Upgrade'}
          </button>

          {/* Unsubscribe Link */}
          <button
            onClick={() => setShowUnsubscribeModal(true)}
            className="w-full py-3 text-pink-400 hover:text-pink-500 font-medium transition-colors"
          >
            Unsubscribe
          </button>
        </motion.div>

        {/* Choose Your Plan Section - Expandable */}
        <AnimatePresence>
          {showChoosePlanSection && (
            <motion.div
              initial={{ opacity: 0, height: 0 }}
              animate={{ opacity: 1, height: 'auto' }}
              exit={{ opacity: 0, height: 0 }}
              transition={{ duration: 0.3 }}
              className="overflow-hidden mt-8"
            >
              <div className="space-y-6">
                <div className="text-center mb-6">
                  <h2 className="text-2xl font-bold text-gray-800 mb-2">Choose Your Plan</h2>
                  <p className="text-gray-600 text-sm">Select the perfect plan for your business</p>
                </div>

                {allPlans.map((plan, index) => (
                  <motion.div
                    key={plan.id}
                    initial={{ opacity: 0, y: 20 }}
                    animate={{ opacity: 1, y: 0 }}
                    transition={{ delay: index * 0.1 }}
                  >
                    <RomanticCard className={`relative overflow-hidden bg-gradient-to-br ${plan.bgGradient} border-2 ${plan.borderColor} ${tier === plan.id ? 'ring-4 ring-purple-300 ring-offset-2' : ''}`}>
                      {/* Popular Badge */}
                      {plan.popular && (
                        <div className="absolute top-4 right-4 bg-gradient-to-r from-purple-500 to-pink-500 text-white text-xs font-bold px-3 py-1 rounded-full shadow-lg">
                          Most Popular
                        </div>
                      )}

                      {/* Current Plan Badge */}
                      {tier === plan.id && (
                        <div className="absolute top-4 left-4 bg-green-500 text-white text-xs font-bold px-3 py-1 rounded-full shadow-lg flex items-center gap-1">
                          <Check className="w-3 h-3" />
                          Current Plan
                        </div>
                      )}

                      <div className="pt-6">
                        {/* Plan Header */}
                        <div className="mb-6">
                          <div className="flex items-center gap-3 mb-2">
                            <div className={`w-12 h-12 rounded-full bg-gradient-to-br ${plan.gradient} flex items-center justify-center shadow-lg`}>
                              <Crown className="w-6 h-6 text-white" />
                            </div>
                            <div>
                              <h3 className="text-xl font-bold text-gray-800">{plan.name}</h3>
                              <p className="text-sm text-gray-600">{plan.description}</p>
                            </div>
                          </div>
                        </div>

                        {/* Price */}
                        <div className="mb-6">
                          <div className="flex items-baseline gap-1">
                            <span className="text-4xl font-bold text-gray-800">{plan.price}</span>
                            <span className="text-gray-500 text-base">{plan.period}</span>
                          </div>
                        </div>

                        {/* Features */}
                        <div className="mb-6">
                          <ul className="space-y-3">
                            {plan.features.map((feature, idx) => (
                              <li key={idx} className="flex items-start gap-2">
                                <Check className="w-5 h-5 text-green-500 flex-shrink-0 mt-0.5" />
                                <span className="text-sm text-gray-700">{feature}</span>
                              </li>
                            ))}
                          </ul>
                        </div>

                        {/* Action Button */}
                        {tier === plan.id ? (
                          <button
                            disabled
                            className="w-full py-3 px-6 rounded-2xl bg-gray-100 text-gray-500 font-semibold cursor-not-allowed"
                          >
                            Your Current Plan
                          </button>
                        ) : tier === 'plus' && plan.id === 'basic' ? (
                          <button
                            onClick={() => {
                              console.log('Downgrading to', plan.id);
                            }}
                            className="w-full py-3 px-6 rounded-2xl bg-gradient-to-r from-gray-500 to-gray-600 text-white font-semibold shadow-lg hover:shadow-xl hover:scale-[1.02] active:scale-[0.98] transition-all"
                          >
                            Downgrade to {plan.name}
                          </button>
                        ) : (
                          <button
                            onClick={() => {
                              console.log('Upgrading to', plan.id);
                              navigate('/business/subscription');
                            }}
                            className={`w-full py-3 px-6 rounded-2xl bg-gradient-to-r ${plan.gradient} text-white font-semibold shadow-lg hover:shadow-xl hover:scale-[1.02] active:scale-[0.98] transition-all`}
                          >
                            Upgrade to {plan.name}
                          </button>
                        )}
                      </div>
                    </RomanticCard>
                  </motion.div>
                ))}
              </div>
            </motion.div>
          )}
        </AnimatePresence>

        {/* Info Text */}
        <motion.p
          initial={{ opacity: 0 }}
          animate={{ opacity: 1 }}
          transition={{ delay: 0.2 }}
          className="text-center text-sm text-gray-400 mt-8 leading-relaxed px-4"
        >
          To manage your billing or cancel your subscription, please use the buttons above. You can change or cancel anytime.
        </motion.p>
      </div>

      {/* Unsubscribe Confirmation Modal */}
      <AnimatePresence>
        {showUnsubscribeModal && (
          <motion.div
            initial={{ opacity: 0 }}
            animate={{ opacity: 1 }}
            exit={{ opacity: 0 }}
            className="fixed inset-0 bg-black/50 backdrop-blur-sm z-50 flex items-center justify-center p-6"
            onClick={handleCloseModal}
          >
            <motion.div
              initial={{ scale: 0.9, opacity: 0 }}
              animate={{ scale: 1, opacity: 1 }}
              exit={{ scale: 0.9, opacity: 0 }}
              onClick={(e) => e.stopPropagation()}
              className="bg-white rounded-3xl p-8 max-w-md w-full shadow-2xl max-h-[90vh] overflow-y-auto"
            >
              {unsubscribeStep === 'options' && (
                <>
                  <div className="text-center mb-6">
                    <div className="inline-flex items-center justify-center w-16 h-16 rounded-full bg-purple-100 mb-4">
                      <AlertCircle className="w-8 h-8 text-purple-500" />
                    </div>
                    <h3 className="text-2xl font-bold text-gray-800 mb-2">Before you go...</h3>
                    <p className="text-gray-600 leading-relaxed">
                      We'd love to keep you as a partner. Consider these options:
                    </p>
                  </div>

                  <div className="space-y-3">
                    {/* Pause Subscription Option */}
                    <button
                      onClick={handlePauseSubscription}
                      className="w-full p-4 rounded-2xl bg-gradient-to-br from-blue-50 to-indigo-50 border-2 border-blue-200 hover:border-blue-400 transition-all text-left group"
                    >
                      <div className="flex items-start gap-3">
                        <div className="w-10 h-10 rounded-full bg-blue-500 flex items-center justify-center flex-shrink-0">
                          <Pause className="w-5 h-5 text-white" />
                        </div>
                        <div className="flex-1">
                          <h4 className="font-bold text-gray-800 mb-1">Pause Subscription</h4>
                          <p className="text-sm text-gray-600">Take a break for up to 3 months. Your data stays safe.</p>
                        </div>
                      </div>
                    </button>

                    {/* Downgrade Option */}
                    {tier === 'plus' && (
                      <button
                        onClick={handleDowngrade}
                        className="w-full p-4 rounded-2xl bg-gradient-to-br from-purple-50 to-pink-50 border-2 border-purple-200 hover:border-purple-400 transition-all text-left group"
                      >
                        <div className="flex items-start gap-3">
                          <div className="w-10 h-10 rounded-full bg-purple-500 flex items-center justify-center flex-shrink-0">
                            <ChevronDown className="w-5 h-5 text-white" />
                          </div>
                          <div className="flex-1">
                            <h4 className="font-bold text-gray-800 mb-1">Downgrade Plan</h4>
                            <p className="text-sm text-gray-600">Switch to a more affordable tier instead.</p>
                          </div>
                        </div>
                      </button>
                    )}

                    {/* Cancel Subscription Button */}
                    <button
                      onClick={handleContinueToReasons}
                      className="w-full py-3 px-6 rounded-2xl bg-gray-100 text-gray-700 font-medium hover:bg-gray-200 transition-all"
                    >
                      I still want to cancel
                    </button>

                    {/* Keep Subscription */}
                    <button
                      onClick={handleCloseModal}
                      className="w-full py-3 px-6 rounded-2xl bg-gradient-to-r from-rose-500 via-pink-500 to-purple-500 text-white font-semibold shadow-lg shadow-pink-300/50 hover:shadow-xl transition-all"
                    >
                      Keep My Subscription
                    </button>
                  </div>
                </>
              )}

              {unsubscribeStep === 'reasons' && (
                <>
                  <div className="text-center mb-6">
                    <div className="inline-flex items-center justify-center w-16 h-16 rounded-full bg-rose-100 mb-4">
                      <AlertCircle className="w-8 h-8 text-rose-500" />
                    </div>
                    <h3 className="text-2xl font-bold text-gray-800 mb-2">Why are you leaving?</h3>
                    <p className="text-gray-600 leading-relaxed">
                      Your feedback helps us improve our service
                    </p>
                  </div>

                  <div className="bg-gradient-to-br from-rose-50 to-pink-50 rounded-2xl p-4 mb-6 border border-rose-200/50">
                    <h4 className="font-semibold text-gray-800 mb-2">You'll lose access to:</h4>
                    <ul className="space-y-2">
                      <li className="flex items-start gap-2 text-sm text-gray-600">
                        <X className="w-4 h-4 text-rose-500 flex-shrink-0 mt-0.5" />
                        <span>Smart customer matching</span>
                      </li>
                      <li className="flex items-start gap-2 text-sm text-gray-600">
                        <X className="w-4 h-4 text-rose-500 flex-shrink-0 mt-0.5" />
                        <span>Business profile visibility</span>
                      </li>
                      <li className="flex items-start gap-2 text-sm text-gray-600">
                        <X className="w-4 h-4 text-rose-500 flex-shrink-0 mt-0.5" />
                        <span>Product & service listings</span>
                      </li>
                      <li className="flex items-start gap-2 text-sm text-gray-600">
                        <X className="w-4 h-4 text-rose-500 flex-shrink-0 mt-0.5" />
                        <span>Analytics and insights</span>
                      </li>
                    </ul>
                  </div>

                  <div className="space-y-3 mb-6">
                    {cancellationReasons.map(reason => (
                      <button
                        key={reason.id}
                        onClick={() => setSelectedReason(reason.id)}
                        className={`w-full p-4 rounded-2xl bg-gradient-to-br from-rose-50 to-pink-50 border-2 ${selectedReason === reason.id ? 'border-purple-400 bg-purple-50' : 'border-rose-200'} hover:border-purple-400 transition-all text-left group`}
                      >
                        <div className="flex items-center justify-between">
                          <div className="flex items-center gap-3">
                            <span className="text-2xl">{reason.icon}</span>
                            <h4 className="font-bold text-gray-800">{reason.label}</h4>
                          </div>
                          <div className="text-right">
                            <Check className={`w-5 h-5 ${selectedReason === reason.id ? 'text-purple-600' : 'text-gray-300'}`} />
                          </div>
                        </div>
                      </button>
                    ))}
                  </div>

                  <div className="space-y-3">
                    <button
                      onClick={handleContinueToConfirm}
                      disabled={!selectedReason}
                      className={`w-full py-3 px-6 rounded-2xl font-semibold shadow-lg transition-all ${
                        selectedReason
                          ? 'bg-gradient-to-r from-rose-500 via-pink-500 to-purple-500 text-white shadow-pink-300/50 hover:shadow-xl'
                          : 'bg-gray-100 text-gray-400 cursor-not-allowed'
                      }`}
                    >
                      Continue
                    </button>
                    <button
                      onClick={handleCloseModal}
                      className="w-full py-3 px-6 rounded-2xl bg-white border-2 border-gray-200 text-gray-700 font-medium hover:bg-gray-50 transition-all"
                    >
                      Keep My Subscription
                    </button>
                  </div>
                </>
              )}

              {unsubscribeStep === 'confirm' && (
                <>
                  <div className="text-center mb-6">
                    <div className="inline-flex items-center justify-center w-16 h-16 rounded-full bg-red-100 mb-4">
                      <AlertCircle className="w-8 h-8 text-red-500" />
                    </div>
                    <h3 className="text-2xl font-bold text-gray-800 mb-2">Final Step</h3>
                    <p className="text-gray-600 leading-relaxed">
                      Are you sure you want to cancel? This action will take effect at the end of your billing period.
                    </p>
                  </div>

                  <div className="bg-gradient-to-br from-rose-50 to-pink-50 rounded-2xl p-4 mb-6 border border-rose-200/50">
                    <h4 className="font-semibold text-gray-800 mb-2">You'll lose access to:</h4>
                    <ul className="space-y-2">
                      <li className="flex items-start gap-2 text-sm text-gray-600">
                        <X className="w-4 h-4 text-rose-500 flex-shrink-0 mt-0.5" />
                        <span>Smart customer matching</span>
                      </li>
                      <li className="flex items-start gap-2 text-sm text-gray-600">
                        <X className="w-4 h-4 text-rose-500 flex-shrink-0 mt-0.5" />
                        <span>Business profile visibility</span>
                      </li>
                      <li className="flex items-start gap-2 text-sm text-gray-600">
                        <X className="w-4 h-4 text-rose-500 flex-shrink-0 mt-0.5" />
                        <span>Product & service listings</span>
                      </li>
                      <li className="flex items-start gap-2 text-sm text-gray-600">
                        <X className="w-4 h-4 text-rose-500 flex-shrink-0 mt-0.5" />
                        <span>Analytics and insights</span>
                      </li>
                    </ul>
                  </div>

                  <div className="mb-6">
                    <label className="block text-sm font-medium text-gray-700 mb-2">
                      Any additional feedback? (Optional)
                    </label>
                    <textarea
                      value={feedback}
                      onChange={(e) => setFeedback(e.target.value)}
                      placeholder="Help us understand how we can improve..."
                      rows={4}
                      className="w-full p-4 rounded-2xl bg-white border-2 border-gray-200 focus:border-purple-400 focus:outline-none transition-all resize-none text-gray-700"
                    />
                  </div>

                  <div className="space-y-3">
                    <button
                      onClick={handleFinalCancel}
                      className="w-full py-3 px-6 rounded-2xl bg-gradient-to-r from-gray-500 to-gray-600 text-white font-semibold hover:from-gray-600 hover:to-gray-700 transition-all"
                    >
                      Cancel Subscription
                    </button>
                    <button
                      onClick={handleCloseModal}
                      className="w-full py-3 px-6 rounded-2xl bg-gradient-to-r from-rose-500 via-pink-500 to-purple-500 text-white font-semibold shadow-lg shadow-pink-300/50 hover:shadow-xl transition-all"
                    >
                      Keep My Subscription
                    </button>
                  </div>
                </>
              )}
            </motion.div>
          </motion.div>
        )}
      </AnimatePresence>
    </div>
  );
}
