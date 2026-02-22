import { useState } from 'react';
import { useNavigate } from 'react-router';
import { ArrowLeft, Crown, HelpCircle, AlertCircle, X, Sparkles, Pause, ChevronDown, Check } from 'lucide-react';
import { motion, AnimatePresence } from 'motion/react';
import RomanticCard from '@/app/components/RomanticCard';
import chooseHigherTierImg from 'figma:asset/d8b2eae59d55ff7ad602be170430ffb448ffc77c.png';

export default function ManageSubscriptionScreen() {
  const navigate = useNavigate();
  const [currentPlan] = useState('plus'); // Mock current subscription - in real app, get from context/API
  const [showUnsubscribeModal, setShowUnsubscribeModal] = useState(false);
  const [showUpgradeOptions, setShowUpgradeOptions] = useState(false);
  const [showChoosePlanSection, setShowChoosePlanSection] = useState(false);
  const [unsubscribeStep, setUnsubscribeStep] = useState<'options' | 'reasons' | 'confirm'>('options');
  const [selectedReason, setSelectedReason] = useState<string>('');
  const [feedback, setFeedback] = useState<string>('');

  const planNames = {
    essential: 'Cherish Essential',
    plus: 'Cherish Plus',
    unlimited: 'Cherish Unlimited',
  };

  const allPlans = [
    {
      id: 'essential',
      name: 'Cherish Essential',
      price: '$8',
      period: '/month',
      description: 'Perfect for getting started',
      features: [
        'Up to 3 loved ones',
        'Basic gift suggestions',
        'Event reminders',
        'Monthly message ideas',
      ],
      gradient: 'from-rose-400 to-pink-400',
      bgGradient: 'from-rose-50 to-pink-50',
      borderColor: 'border-rose-300',
    },
    {
      id: 'plus',
      name: 'Cherish Plus',
      price: '$15',
      period: '/month',
      description: 'Most popular choice',
      features: [
        'Up to 6 loved ones',
        'Advanced AI gift ideas',
        'Unlimited event tracking',
        'Daily personalized messages',
        'Local business recommendations',
        'Priority support',
      ],
      gradient: 'from-purple-400 to-pink-400',
      bgGradient: 'from-purple-50 to-pink-50',
      borderColor: 'border-purple-300',
      popular: true,
    },
    {
      id: 'unlimited',
      name: 'Cherish Unlimited',
      price: '$25',
      period: '/month',
      description: 'For relationship experts',
      features: [
        'Unlimited loved ones',
        'Premium AI insights',
        'Unlimited everything',
        'Exclusive relationship tips',
        'Advanced analytics',
        'White-glove support',
        'Early access to new features',
      ],
      gradient: 'from-indigo-400 to-purple-400',
      bgGradient: 'from-indigo-50 to-purple-50',
      borderColor: 'border-indigo-300',
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
    navigate('/individual/home');
  };

  const handleCloseModal = () => {
    setShowUnsubscribeModal(false);
    setUnsubscribeStep('options');
    setSelectedReason('');
    setFeedback('');
  };

  const handleUpgrade = () => {
    // Toggle the Choose Your Plan section
    setShowChoosePlanSection(!showChoosePlanSection);
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
                {planNames[currentPlan as keyof typeof planNames]}
              </h2>
            </div>
          </div>

          {/* Upgrade Button */}
          <button
            onClick={handleUpgrade}
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
                  <p className="text-gray-600 text-sm">Select the perfect plan for your relationship journey</p>
                </div>

                {allPlans.map((plan, index) => (
                  <motion.div
                    key={plan.id}
                    initial={{ opacity: 0, y: 20 }}
                    animate={{ opacity: 1, y: 0 }}
                    transition={{ delay: index * 0.1 }}
                  >
                    <RomanticCard className={`relative overflow-hidden bg-gradient-to-br ${plan.bgGradient} border-2 ${plan.borderColor} ${currentPlan === plan.id ? 'ring-4 ring-purple-300 ring-offset-2' : ''}`}>
                      {/* Popular Badge */}
                      {plan.popular && (
                        <div className="absolute top-4 right-4 bg-gradient-to-r from-purple-500 to-pink-500 text-white text-xs font-bold px-3 py-1 rounded-full shadow-lg">
                          Most Popular
                        </div>
                      )}

                      {/* Current Plan Badge */}
                      {currentPlan === plan.id && (
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
                        {currentPlan === plan.id ? (
                          <button
                            disabled
                            className="w-full py-3 px-6 rounded-2xl bg-gray-100 text-gray-500 font-semibold cursor-not-allowed"
                          >
                            Your Current Plan
                          </button>
                        ) : currentPlan === 'plus' && plan.id === 'essential' ? (
                          <button
                            onClick={() => {
                              console.log('Downgrading to', plan.id);
                            }}
                            className="w-full py-3 px-6 rounded-2xl bg-gradient-to-r from-gray-500 to-gray-600 text-white font-semibold shadow-lg hover:shadow-xl hover:scale-[1.02] active:scale-[0.98] transition-all"
                          >
                            Downgrade to {plan.name}
                          </button>
                        ) : currentPlan === 'unlimited' && (plan.id === 'essential' || plan.id === 'plus') ? (
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
                              navigate('/individual/checkout', { state: { selectedPlan: plan.id } });
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
      </div>

      {/* Unsubscribe Confirmation Modal - Multi-Step */}
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
                      We'd love to help! Here are some options that might work better for you:
                    </p>
                  </div>

                  <div className="space-y-3 mb-6">
                    {/* Pause Option */}
                    {currentPlan !== 'essential' && (
                      <button
                        onClick={handlePauseSubscription}
                        className="w-full p-4 rounded-2xl bg-gradient-to-br from-blue-50 to-indigo-50 border-2 border-blue-200 hover:border-blue-400 transition-all text-left group"
                      >
                        <div className="flex items-start gap-3">
                          <div className="w-10 h-10 rounded-full bg-blue-500 flex items-center justify-center flex-shrink-0">
                            <Pause className="w-5 h-5 text-white" />
                          </div>
                          <div className="flex-1">
                            <h4 className="font-bold text-gray-800 mb-1">Pause my subscription</h4>
                            <p className="text-sm text-gray-600">Take a break for up to 3 months, keep your data safe</p>
                          </div>
                        </div>
                      </button>
                    )}

                    {/* Downgrade Option */}
                    {currentPlan !== 'essential' && (
                      <button
                        onClick={handleDowngrade}
                        className="w-full p-4 rounded-2xl bg-gradient-to-br from-purple-50 to-pink-50 border-2 border-purple-200 hover:border-purple-400 transition-all text-left group"
                      >
                        <div className="flex items-start gap-3">
                          <div className="w-10 h-10 rounded-full bg-purple-500 flex items-center justify-center flex-shrink-0">
                            <ChevronDown className="w-5 h-5 text-white" />
                          </div>
                          <div className="flex-1">
                            <h4 className="font-bold text-gray-800 mb-1">Switch to a lower plan</h4>
                            <p className="text-sm text-gray-600">Save money while keeping essential features</p>
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
                  </div>

                  <div className="text-center">
                    <button
                      onClick={handleCloseModal}
                      className="text-sm text-gray-500 hover:text-gray-700 font-medium transition-colors"
                    >
                      Keep my subscription
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
                    <h3 className="text-2xl font-bold text-gray-800 mb-2">Help us improve</h3>
                    <p className="text-gray-600 leading-relaxed">
                      We're sorry to see you go. Please let us know why you're canceling so we can improve Cherish AI for everyone.
                    </p>
                  </div>

                  <div className="space-y-2 mb-6">
                    {cancellationReasons.map((reason) => (
                      <button
                        key={reason.id}
                        onClick={() => setSelectedReason(reason.id)}
                        className={`w-full p-4 rounded-2xl border-2 transition-all text-left ${
                          selectedReason === reason.id
                            ? 'bg-gradient-to-br from-purple-50 to-pink-50 border-purple-400'
                            : 'bg-white border-gray-200 hover:border-gray-300'
                        }`}
                      >
                        <div className="flex items-center gap-3">
                          <span className="text-2xl">{reason.icon}</span>
                          <span className={`font-medium ${selectedReason === reason.id ? 'text-purple-700' : 'text-gray-700'}`}>
                            {reason.label}
                          </span>
                          {selectedReason === reason.id && (
                            <Check className="w-5 h-5 text-purple-600 ml-auto" />
                          )}
                        </div>
                      </button>
                    ))}
                  </div>

                  <div className="mb-6">
                    <label className="block text-sm font-medium text-gray-700 mb-2">
                      Additional feedback (optional)
                    </label>
                    <textarea
                      value={feedback}
                      onChange={(e) => setFeedback(e.target.value)}
                      placeholder="Tell us more about your experience..."
                      className="w-full px-4 py-3 rounded-2xl border-2 border-gray-200 focus:border-purple-400 focus:outline-none resize-none"
                      rows={4}
                    />
                  </div>

                  <div className="space-y-3">
                    <button
                      onClick={handleContinueToConfirm}
                      disabled={!selectedReason}
                      className={`w-full py-3 px-6 rounded-2xl font-semibold transition-all ${
                        selectedReason
                          ? 'bg-gradient-to-r from-rose-500 to-pink-500 text-white shadow-lg hover:shadow-xl'
                          : 'bg-gray-100 text-gray-400 cursor-not-allowed'
                      }`}
                    >
                      Continue
                    </button>
                    <button
                      onClick={handleCloseModal}
                      className="w-full py-3 px-6 rounded-2xl bg-gray-100 text-gray-700 font-medium hover:bg-gray-200 transition-all"
                    >
                      Go Back
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
                    <h3 className="text-2xl font-bold text-gray-800 mb-2">Final Confirmation</h3>
                    <p className="text-gray-600 leading-relaxed">
                      Are you absolutely sure? You'll lose access to all premium features at the end of your billing period.
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
                      onClick={handleFinalCancel}
                      className="w-full py-3 px-6 rounded-2xl bg-gradient-to-r from-red-500 to-rose-500 text-white font-semibold shadow-lg hover:shadow-xl transition-all"
                    >
                      Yes, Cancel My Subscription
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

      {/* Upgrade Options Modal */}
      <AnimatePresence>
        {showUpgradeOptions && (
          <motion.div
            initial={{ opacity: 0 }}
            animate={{ opacity: 1 }}
            exit={{ opacity: 0 }}
            className="fixed inset-0 bg-black/50 backdrop-blur-sm z-50 flex items-center justify-center p-6"
            onClick={() => setShowUpgradeOptions(false)}
          >
            <motion.div
              initial={{ scale: 0.9, opacity: 0 }}
              animate={{ scale: 1, opacity: 1 }}
              exit={{ scale: 0.9, opacity: 0 }}
              onClick={(e) => e.stopPropagation()}
              className="bg-white rounded-3xl p-8 max-w-md w-full shadow-2xl"
            >
              <div className="text-center mb-6">
                <div className="inline-flex items-center justify-center w-16 h-16 rounded-full bg-gradient-to-br from-purple-400 to-pink-400 mb-4">
                  <Crown className="w-8 h-8 text-white" />
                </div>
                <h3 className="text-2xl font-bold text-gray-800 mb-2">Upgrade Your Plan</h3>
                <p className="text-gray-600 leading-relaxed">
                  Choose a higher tier to unlock more features and relationship insights.
                </p>
              </div>

              {/* Upgrade Options */}
              <div className="space-y-3 mb-6">
                {currentPlan === 'essential' && (
                  <>
                    <button
                      onClick={() => {
                        setShowUpgradeOptions(false);
                        // Navigate to checkout with selected plan
                      }}
                      className="w-full p-4 rounded-2xl bg-gradient-to-br from-purple-50 to-pink-50 border-2 border-purple-200 hover:border-purple-400 transition-all text-left group"
                    >
                      <div className="flex items-center justify-between">
                        <div>
                          <h4 className="font-bold text-gray-800 mb-1">Cherish Plus</h4>
                          <p className="text-sm text-gray-600">Up to 6 loved ones</p>
                        </div>
                        <div className="text-right">
                          <p className="text-2xl font-bold text-purple-600">$15</p>
                          <p className="text-xs text-gray-500">/month</p>
                        </div>
                      </div>
                    </button>
                    <button
                      onClick={() => {
                        setShowUpgradeOptions(false);
                        // Navigate to checkout with selected plan
                      }}
                      className="w-full p-4 rounded-2xl bg-gradient-to-br from-indigo-50 to-purple-50 border-2 border-indigo-200 hover:border-indigo-400 transition-all text-left group"
                    >
                      <div className="flex items-center justify-between">
                        <div>
                          <h4 className="font-bold text-gray-800 mb-1">Cherish Unlimited</h4>
                          <p className="text-sm text-gray-600">Unlimited loved ones</p>
                        </div>
                        <div className="text-right">
                          <p className="text-2xl font-bold text-indigo-600">$25</p>
                          <p className="text-xs text-gray-500">/month</p>
                        </div>
                      </div>
                    </button>
                  </>
                )}
                {currentPlan === 'plus' && (
                  <button
                    onClick={() => {
                      setShowUpgradeOptions(false);
                      // Navigate to checkout with selected plan
                    }}
                    className="w-full p-4 rounded-2xl bg-gradient-to-br from-indigo-50 to-purple-50 border-2 border-indigo-200 hover:border-indigo-400 transition-all text-left group"
                  >
                    <div className="flex items-center justify-between">
                      <div>
                        <h4 className="font-bold text-gray-800 mb-1">Cherish Unlimited</h4>
                        <p className="text-sm text-gray-600">Unlimited loved ones</p>
                      </div>
                      <div className="text-right">
                        <p className="text-2xl font-bold text-indigo-600">$25</p>
                        <p className="text-xs text-gray-500">/month</p>
                      </div>
                    </div>
                  </button>
                )}
                {currentPlan === 'unlimited' && (
                  <div className="text-center py-4">
                    <p className="text-gray-600">You're already on the highest tier! 🎉</p>
                  </div>
                )}
              </div>

              <button
                onClick={() => setShowUpgradeOptions(false)}
                className="w-full py-3 px-6 rounded-2xl bg-gray-100 text-gray-700 font-medium hover:bg-gray-200 transition-all"
              >
                Cancel
              </button>
            </motion.div>
          </motion.div>
        )}
      </AnimatePresence>
    </div>
  );
}