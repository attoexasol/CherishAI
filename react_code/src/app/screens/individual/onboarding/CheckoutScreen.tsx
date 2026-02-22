import { useState } from 'react';
import { useNavigate, useLocation } from 'react-router-dom';
import { ArrowLeft, CreditCard, Lock, Calendar, User, Mail, CheckCircle, Shield, Sparkles, Smartphone } from 'lucide-react';
import RomanticInput from '../../../components/RomanticInput';

interface Plan {
  id: string;
  name: string;
  price: number;
  period: string;
  tagline: string;
}

export default function CheckoutScreen() {
  const navigate = useNavigate();
  const location = useLocation();
  const selectedPlan = location.state?.plan as Plan || {
    id: 'plus',
    name: 'Cherish Plus',
    price: 15,
    period: 'month',
    tagline: 'For caring across relationships',
  };

  const [formData, setFormData] = useState({
    email: '',
    fullName: '',
    expiryDate: '',
  });

  const [isProcessing, setIsProcessing] = useState(false);
  const [paymentMethod, setPaymentMethod] = useState<'card' | 'google' | 'apple'>('card');

  const handleInputChange = (field: string, value: string) => {
    // Format expiry date
    if (field === 'expiryDate') {
      value = value.replace(/\D/g, '').replace(/(\d{2})(\d{0,2})/, '$1/$2');
    }
    
    setFormData({ ...formData, [field]: value });
  };

  const handleSubmit = async (e?: React.FormEvent) => {
    if (e) e.preventDefault();
    setIsProcessing(true);
    
    // Simulate payment processing
    await new Promise(resolve => setTimeout(resolve, 2000));
    
    // Mark onboarding as completed and save subscription info in localStorage
    const existingUsersJson = localStorage.getItem('cherish_users');
    if (existingUsersJson) {
      const existingUsers = JSON.parse(existingUsersJson);
      const userIndex = existingUsers.findIndex((u: any) => u.userType === 'individual');
      
      if (userIndex !== -1) {
        existingUsers[userIndex].onboardingCompleted = true;
        existingUsers[userIndex].subscription = {
          plan: selectedPlan.id,
          planName: selectedPlan.name,
          price: selectedPlan.price,
          period: selectedPlan.period,
          status: 'active',
          startDate: new Date().toISOString(),
          paymentMethod: paymentMethod,
        };
        localStorage.setItem('cherish_users', JSON.stringify(existingUsers));
      }
    }
    
    // Also save subscription separately for easy access
    localStorage.setItem('cherish_subscription', JSON.stringify({
      plan: selectedPlan.id,
      planName: selectedPlan.name,
      price: selectedPlan.price,
      period: selectedPlan.period,
      status: 'active',
      startDate: new Date().toISOString(),
      paymentMethod: paymentMethod,
    }));
    
    setIsProcessing(false);
    navigate('/individual/home');
  };

  const handleBack = () => {
    navigate(-1);
  };

  const trialEndDate = new Date();
  trialEndDate.setDate(trialEndDate.getDate() + 7);
  const formattedTrialDate = trialEndDate.toLocaleDateString('en-US', { month: 'long', day: 'numeric', year: 'numeric' });

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
              <span className="font-medium">Back to Plans</span>
            </button>
            <div className="flex items-center gap-2 px-4 py-2 rounded-full bg-gradient-to-r from-green-100 to-emerald-100">
              <Lock className="w-4 h-4 text-green-600" />
              <span className="text-sm font-medium text-green-700">Secure Checkout</span>
            </div>
          </div>
        </div>
      </div>

      {/* Main Content */}
      <div className="max-w-4xl mx-auto px-6 pt-8">
        {/* Title Section */}
        <div className="mb-8 text-center">
          <div className="inline-flex items-center justify-center w-16 h-16 rounded-2xl bg-gradient-to-br from-rose-400 to-purple-400 mb-5 shadow-lg">
            <CheckCircle className="w-8 h-8 text-white" />
          </div>
          <h1 className="text-4xl font-bold bg-gradient-to-r from-rose-600 via-pink-600 to-purple-600 bg-clip-text text-transparent mb-3">
            Complete Your Order
          </h1>
          <p className="text-lg text-gray-600">
            Start caring more intentionally today
          </p>
        </div>

        <div className="grid lg:grid-cols-3 gap-8">
          {/* Payment Form - Left Side (2 columns) */}
          <div className="lg:col-span-2">
            <form id="checkout-form" onSubmit={handleSubmit} className="space-y-6">
              {/* Contact Information */}
              <div className="bg-white/80 backdrop-blur border border-pink-200/50 rounded-3xl p-6 shadow-lg">
                <div className="flex items-center gap-3 mb-5">
                  <div className="w-10 h-10 rounded-xl bg-gradient-to-br from-rose-400 to-pink-400 flex items-center justify-center">
                    <Mail className="w-5 h-5 text-white" />
                  </div>
                  <h2 className="text-xl font-bold text-gray-800">Contact Information</h2>
                </div>
                
                <div className="space-y-4">
                  <RomanticInput
                    type="email"
                    placeholder="Email address"
                    value={formData.email}
                    onChange={(e) => handleInputChange('email', e.target.value)}
                    required
                  />
                  <RomanticInput
                    type="text"
                    placeholder="Full name"
                    value={formData.fullName}
                    onChange={(e) => handleInputChange('fullName', e.target.value)}
                    required
                  />
                </div>
              </div>

              {/* Payment Method Selection */}
              <div className="bg-white/80 backdrop-blur border border-pink-200/50 rounded-3xl p-6 shadow-lg">
                <h3 className="text-lg font-bold text-gray-800 mb-4">Select Payment Method</h3>
                
                <div className="grid grid-cols-1 sm:grid-cols-3 gap-3">
                  {/* Credit Card */}
                  <button
                    type="button"
                    onClick={() => setPaymentMethod('card')}
                    className={`p-4 rounded-2xl border-2 transition-all ${
                      paymentMethod === 'card'
                        ? 'border-pink-400 bg-gradient-to-br from-pink-50 to-rose-50 shadow-md'
                        : 'border-pink-200/50 bg-white hover:border-pink-300 hover:shadow-sm'
                    }`}
                  >
                    <div className="flex flex-col items-center gap-2">
                      <CreditCard className={`w-8 h-8 ${paymentMethod === 'card' ? 'text-pink-600' : 'text-gray-600'}`} />
                      <span className={`text-sm font-medium ${paymentMethod === 'card' ? 'text-pink-700' : 'text-gray-700'}`}>
                        Credit Card
                      </span>
                      {paymentMethod === 'card' && (
                        <div className="w-2 h-2 rounded-full bg-pink-500 mt-1"></div>
                      )}
                    </div>
                  </button>

                  {/* Google Pay */}
                  <button
                    type="button"
                    onClick={() => setPaymentMethod('google')}
                    className={`p-4 rounded-2xl border-2 transition-all ${
                      paymentMethod === 'google'
                        ? 'border-pink-400 bg-gradient-to-br from-pink-50 to-rose-50 shadow-md'
                        : 'border-pink-200/50 bg-white hover:border-pink-300 hover:shadow-sm'
                    }`}
                  >
                    <div className="flex flex-col items-center gap-2">
                      <div className={`w-10 h-10 rounded-full flex items-center justify-center shadow-lg border-2 ${paymentMethod === 'google' ? 'bg-gradient-to-br from-rose-400 to-pink-400 border-pink-400' : 'bg-white border-gray-300'}`}>
                        <span className={`text-lg font-bold ${paymentMethod === 'google' ? 'text-white' : 'text-gray-600'}`}>G</span>
                      </div>
                      <span className={`text-sm font-medium ${paymentMethod === 'google' ? 'text-pink-700' : 'text-gray-700'}`}>
                        Google Pay
                      </span>
                      {paymentMethod === 'google' && (
                        <div className="w-2 h-2 rounded-full bg-pink-500 mt-1"></div>
                      )}
                    </div>
                  </button>

                  {/* Apple Pay */}
                  <button
                    type="button"
                    onClick={() => setPaymentMethod('apple')}
                    className={`p-4 rounded-2xl border-2 transition-all ${
                      paymentMethod === 'apple'
                        ? 'border-pink-400 bg-gradient-to-br from-pink-50 to-rose-50 shadow-md'
                        : 'border-pink-200/50 bg-white hover:border-pink-300 hover:shadow-sm'
                    }`}
                  >
                    <div className="flex flex-col items-center gap-2">
                      <svg className={`w-8 h-8 ${paymentMethod === 'apple' ? 'text-pink-700' : 'text-gray-600'}`} fill="currentColor" viewBox="0 0 24 24">
                        <path d="M17.05 20.28c-.98.95-2.05.8-3.08.35-1.09-.46-2.09-.48-3.24 0-1.44.62-2.2.44-3.06-.35C2.79 15.25 3.51 7.59 9.05 7.31c1.35.07 2.29.74 3.08.8 1.18-.24 2.31-.93 3.57-.84 1.51.12 2.65.72 3.4 1.8-3.12 1.87-2.38 5.98.48 7.13-.57 1.5-1.31 2.99-2.54 4.09l.01-.01zM12.03 7.25c-.15-2.23 1.66-4.07 3.74-4.25.29 2.58-2.34 4.5-3.74 4.25z"/>
                      </svg>
                      <span className={`text-sm font-medium ${paymentMethod === 'apple' ? 'text-pink-700' : 'text-gray-700'}`}>
                        Apple Pay
                      </span>
                      {paymentMethod === 'apple' && (
                        <div className="w-2 h-2 rounded-full bg-pink-500 mt-1"></div>
                      )}
                    </div>
                  </button>
                </div>
              </div>

              {/* Google Pay Information */}
              {paymentMethod === 'google' && (
                <div className="bg-white/80 backdrop-blur border border-pink-200/50 rounded-3xl p-8 shadow-lg text-center">
                  <div className="flex flex-col items-center gap-4">
                    <div className="w-20 h-20 rounded-full bg-gradient-to-br from-blue-500 to-green-500 flex items-center justify-center shadow-lg">
                      <span className="text-white text-3xl font-bold">G</span>
                    </div>
                    <h3 className="text-2xl font-bold text-gray-800">Pay with Google Pay</h3>
                    <p className="text-gray-600 max-w-sm">
                      Complete your purchase securely using your Google Pay account
                    </p>
                    
                    <div className="flex items-start gap-3 p-4 rounded-2xl bg-gradient-to-r from-green-50 to-emerald-50 border border-green-200/50 mt-4 w-full">
                      <Shield className="w-5 h-5 text-green-600 flex-shrink-0 mt-0.5" />
                      <div className="text-left">
                        <p className="text-sm font-medium text-green-800 mb-1">
                          Secure Google Pay checkout
                        </p>
                        <p className="text-xs text-green-600">
                          Your payment information is protected by Google's security
                        </p>
                      </div>
                    </div>
                  </div>
                </div>
              )}

              {/* Apple Pay Information */}
              {paymentMethod === 'apple' && (
                <div className="bg-white/80 backdrop-blur border border-pink-200/50 rounded-3xl p-8 shadow-lg text-center">
                  <div className="flex flex-col items-center gap-4">
                    <div className="w-20 h-20 rounded-full bg-gray-900 flex items-center justify-center shadow-lg">
                      <svg className="w-12 h-12 text-white" fill="currentColor" viewBox="0 0 24 24">
                        <path d="M17.05 20.28c-.98.95-2.05.8-3.08.35-1.09-.46-2.09-.48-3.24 0-1.44.62-2.2.44-3.06-.35C2.79 15.25 3.51 7.59 9.05 7.31c1.35.07 2.29.74 3.08.8 1.18-.24 2.31-.93 3.57-.84 1.51.12 2.65.72 3.4 1.8-3.12 1.87-2.38 5.98.48 7.13-.57 1.5-1.31 2.99-2.54 4.09l.01-.01zM12.03 7.25c-.15-2.23 1.66-4.07 3.74-4.25.29 2.58-2.34 4.5-3.74 4.25z"/>
                      </svg>
                    </div>
                    <h3 className="text-2xl font-bold text-gray-800">Pay with Apple Pay</h3>
                    <p className="text-gray-600 max-w-sm">
                      Complete your purchase securely using your Apple Pay account
                    </p>
                    
                    <div className="flex items-start gap-3 p-4 rounded-2xl bg-gradient-to-r from-green-50 to-emerald-50 border border-green-200/50 mt-4 w-full">
                      <Shield className="w-5 h-5 text-green-600 flex-shrink-0 mt-0.5" />
                      <div className="text-left">
                        <p className="text-sm font-medium text-green-800 mb-1">
                          Secure Apple Pay checkout
                        </p>
                        <p className="text-xs text-green-600">
                          Your payment information is protected by Apple's security
                        </p>
                      </div>
                    </div>
                  </div>
                </div>
              )}

              {/* Card Details Form */}
              {paymentMethod === 'card' && (
                <div className="bg-white/80 backdrop-blur border border-pink-200/50 rounded-3xl p-6 shadow-lg">
                  <div className="flex items-center gap-3 mb-5">
                    <div className="w-10 h-10 rounded-xl bg-gradient-to-br from-purple-400 to-pink-400 flex items-center justify-center">
                      <CreditCard className="w-5 h-5 text-white" />
                    </div>
                    <h2 className="text-xl font-bold text-gray-800">Card Information</h2>
                  </div>
                  
                  {/* Card Brand Icons */}
                  <div className="mb-6">
                    <p className="text-sm text-gray-600 mb-3">Accepted Cards</p>
                    <div className="flex items-center gap-3">
                      {/* Visa */}
                      <div className="w-12 h-8 bg-white rounded border border-gray-200 flex items-center justify-center shadow-sm">
                        <svg className="h-4" viewBox="0 0 48 16" fill="none">
                          <path d="M18.5 0.5L15.5 15.5H11.5L14.5 0.5H18.5Z" fill="#00579F"/>
                          <path d="M31 1C30 0.5 28.5 0 26.5 0C22.5 0 19.5 2 19.5 5C19.5 7.5 22 9 24 10C26 11 26.5 11.5 26.5 12.5C26.5 13.5 25.5 14 24 14C22 14 21 13.5 19.5 13L19 12.5L18.5 15.5C19.5 16 21.5 16.5 23.5 16.5C28 16.5 30.5 14.5 30.5 11C30.5 9 29 7.5 26 6C24.5 5 23.5 4.5 23.5 3.5C23.5 2.5 24.5 2 26 2C27.5 2 28.5 2.5 29.5 3L30 3.5L30.5 0.5L31 1Z" fill="#00579F"/>
                          <path d="M38 0.5L35 0.5C34 0.5 33.5 1 33 2L27.5 15.5H32L33 13H38.5L39 15.5H43L39.5 0.5H38ZM34.5 9.5L36.5 4.5L37.5 9.5H34.5Z" fill="#00579F"/>
                          <path d="M11 0.5L6.5 11L6 8.5C5.5 6.5 3.5 4 1 2.5L5 15.5H9.5L16 0.5H11Z" fill="#00579F"/>
                        </svg>
                      </div>
                      {/* Mastercard */}
                      <div className="w-12 h-8 bg-white rounded border border-gray-200 flex items-center justify-center shadow-sm">
                        <svg className="h-5" viewBox="0 0 24 16" fill="none">
                          <circle cx="8" cy="8" r="7" fill="#EB001B"/>
                          <circle cx="16" cy="8" r="7" fill="#F79E1B"/>
                          <path d="M12 3C13.5 4.5 14.5 6.5 14.5 8.5C14.5 10.5 13.5 12.5 12 14C10.5 12.5 9.5 10.5 9.5 8.5C9.5 6.5 10.5 4.5 12 3Z" fill="#FF5F00"/>
                        </svg>
                      </div>
                      {/* Amex */}
                      <div className="w-12 h-8 bg-white rounded border border-gray-200 flex items-center justify-center shadow-sm">
                        <svg className="h-4" viewBox="0 0 32 16" fill="none">
                          <rect width="32" height="16" rx="2" fill="#006FCF"/>
                          <text x="50%" y="11" fontSize="8" fontWeight="bold" fill="white" textAnchor="middle">AMEX</text>
                        </svg>
                      </div>
                      {/* Discover */}
                      <div className="w-12 h-8 bg-white rounded border border-gray-200 flex items-center justify-center shadow-sm">
                        <svg className="h-4" viewBox="0 0 32 16" fill="none">
                          <rect width="32" height="16" rx="2" fill="#FF6000"/>
                          <circle cx="24" cy="8" r="6" fill="#FFA500"/>
                        </svg>
                      </div>
                    </div>
                  </div>

                  <div className="flex items-start gap-3 p-4 rounded-2xl bg-gradient-to-r from-green-50 to-emerald-50 border border-green-200/50 mt-5">
                    <Lock className="w-5 h-5 text-green-600 flex-shrink-0 mt-0.5" />
                    <div className="text-left">
                      <p className="text-sm font-medium text-green-800 mb-1">
                        Your payment is secure
                      </p>
                      <p className="text-xs text-green-600">
                        All transactions are encrypted and PCI-compliant
                      </p>
                    </div>
                  </div>
                </div>
              )}
            </form>
          </div>

          {/* Order Summary - Right Side (1 column) */}
          <div className="lg:col-span-1">
            <div className="sticky top-24">
              {/* Selected Plan Card */}
              <div className="bg-white/80 backdrop-blur border border-pink-200/50 rounded-3xl p-6 shadow-lg mb-6">
                <h3 className="text-lg font-bold text-gray-800 mb-4">Order Summary</h3>
                
                {/* Plan Details */}
                <div className="flex items-start gap-4 p-4 rounded-2xl bg-gradient-to-br from-rose-50 to-pink-50 border border-pink-200/30 mb-5">
                  <div className="w-12 h-12 rounded-xl bg-gradient-to-br from-purple-400 to-pink-400 flex items-center justify-center flex-shrink-0">
                    <Sparkles className="w-6 h-6 text-white" />
                  </div>
                  <div className="flex-1">
                    <h4 className="font-bold text-gray-800 mb-1">{selectedPlan.name}</h4>
                    <p className="text-sm text-gray-600 mb-2">{selectedPlan.tagline}</p>
                    <div className="flex items-baseline gap-1">
                      <span className="text-2xl font-bold bg-gradient-to-r from-rose-600 to-purple-600 bg-clip-text text-transparent">
                        ${selectedPlan.price}
                      </span>
                      <span className="text-gray-500 text-sm">/ {selectedPlan.period}</span>
                    </div>
                  </div>
                </div>

                {/* Divider */}
                <div className="h-px bg-gradient-to-r from-transparent via-pink-200 to-transparent mb-5" />

                {/* Price Breakdown */}
                <div className="space-y-3 mb-5">
                  <div className="flex justify-between items-center text-gray-700">
                    <span className="text-sm">Monthly Subscription</span>
                    <span className="font-medium">${selectedPlan.price}/month</span>
                  </div>
                </div>

                {/* Divider */}
                <div className="h-px bg-gradient-to-r from-transparent via-pink-200 to-transparent mb-5" />

                {/* Total */}
                <div className="flex justify-between items-center mb-5">
                  <span className="text-lg font-bold text-gray-800">Due Today</span>
                  <span className="text-3xl font-bold bg-gradient-to-r from-rose-600 to-purple-600 bg-clip-text text-transparent">
                    ${selectedPlan.price}
                  </span>
                </div>

                {/* Billing Info */}
                <div className="p-4 rounded-2xl bg-gradient-to-r from-purple-50 to-pink-50 border border-purple-200/30">
                  <p className="text-xs text-gray-600">
                    You'll be billed ${selectedPlan.price} monthly. Cancel anytime from your account settings.
                  </p>
                </div>
              </div>

              {/* Submit Button - Desktop Only */}
              {paymentMethod === 'card' && (
                <button
                  type="submit"
                  form="checkout-form"
                  disabled={isProcessing}
                  className="hidden lg:block w-full py-4 px-6 rounded-2xl bg-gradient-to-r from-rose-500 via-pink-500 to-purple-500 text-white font-semibold text-lg shadow-lg shadow-pink-300/50 hover:shadow-xl hover:scale-[1.02] active:scale-[0.98] transition-all disabled:opacity-50 disabled:cursor-not-allowed"
                >
                  {isProcessing ? (
                    <span className="flex items-center justify-center gap-2">
                      <div className="w-5 h-5 border-2 border-white/30 border-t-white rounded-full animate-spin" />
                      Processing...
                    </span>
                  ) : (
                    `Complete Purchase`
                  )}
                </button>
              )}

              {/* Google Pay Button - Desktop */}
              {paymentMethod === 'google' && (
                <button
                  type="button"
                  onClick={() => handleSubmit()}
                  disabled={isProcessing || !formData.email || !formData.fullName}
                  className="hidden lg:block w-full py-4 px-6 rounded-2xl bg-gradient-to-r from-blue-500 to-green-500 text-white font-semibold text-lg shadow-lg hover:shadow-xl hover:scale-[1.02] active:scale-[0.98] transition-all disabled:opacity-50 disabled:cursor-not-allowed"
                >
                  {isProcessing ? (
                    <span className="flex items-center justify-center gap-2">
                      <div className="w-5 h-5 border-2 border-white/30 border-t-white rounded-full animate-spin" />
                      Processing...
                    </span>
                  ) : (
                    <span className="flex items-center justify-center gap-2">
                      <span className="text-2xl font-bold">G</span>
                      Pay ${selectedPlan.price}
                    </span>
                  )}
                </button>
              )}

              {/* Apple Pay Button - Desktop */}
              {paymentMethod === 'apple' && (
                <button
                  type="button"
                  onClick={() => handleSubmit()}
                  disabled={isProcessing || !formData.email || !formData.fullName}
                  className="hidden lg:block w-full py-4 px-6 rounded-2xl bg-gray-900 text-white font-semibold text-lg shadow-lg hover:shadow-xl hover:bg-gray-800 hover:scale-[1.02] active:scale-[0.98] transition-all disabled:opacity-50 disabled:cursor-not-allowed"
                >
                  {isProcessing ? (
                    <span className="flex items-center justify-center gap-2">
                      <div className="w-5 h-5 border-2 border-white/30 border-t-white rounded-full animate-spin" />
                      Processing...
                    </span>
                  ) : (
                    <span className="flex items-center justify-center gap-2">
                      <svg className="w-6 h-6" fill="currentColor" viewBox="0 0 24 24">
                        <path d="M17.05 20.28c-.98.95-2.05.8-3.08.35-1.09-.46-2.09-.48-3.24 0-1.44.62-2.2.44-3.06-.35C2.79 15.25 3.51 7.59 9.05 7.31c1.35.07 2.29.74 3.08.8 1.18-.24 2.31-.93 3.57-.84 1.51.12 2.65.72 3.4 1.8-3.12 1.87-2.38 5.98.48 7.13-.57 1.5-1.31 2.99-2.54 4.09l.01-.01zM12.03 7.25c-.15-2.23 1.66-4.07 3.74-4.25.29 2.58-2.34 4.5-3.74 4.25z"/>
                      </svg>
                      Pay ${selectedPlan.price}
                    </span>
                  )}
                </button>
              )}

              {/* Submit Button - Mobile Only */}
              {paymentMethod === 'card' && (
                <button
                  type="submit"
                  form="checkout-form"
                  disabled={isProcessing}
                  className="lg:hidden w-full py-4 px-6 rounded-2xl bg-gradient-to-r from-rose-500 via-pink-500 to-purple-500 text-white font-semibold text-lg shadow-lg shadow-pink-300/50 hover:shadow-xl hover:scale-[1.02] active:scale-[0.98] transition-all disabled:opacity-50 disabled:cursor-not-allowed mt-6"
                >
                  {isProcessing ? (
                    <span className="flex items-center justify-center gap-2">
                      <div className="w-5 h-5 border-2 border-white/30 border-t-white rounded-full animate-spin" />
                      Processing...
                    </span>
                  ) : (
                    `Complete Purchase`
                  )}
                </button>
              )}

              {/* Google Pay Button - Mobile */}
              {paymentMethod === 'google' && (
                <button
                  type="button"
                  onClick={() => handleSubmit()}
                  disabled={isProcessing || !formData.email || !formData.fullName}
                  className="lg:hidden w-full py-4 px-6 rounded-2xl bg-gradient-to-r from-blue-500 to-green-500 text-white font-semibold text-lg shadow-lg hover:shadow-xl hover:scale-[1.02] active:scale-[0.98] transition-all disabled:opacity-50 disabled:cursor-not-allowed mt-6"
                >
                  {isProcessing ? (
                    <span className="flex items-center justify-center gap-2">
                      <div className="w-5 h-5 border-2 border-white/30 border-t-white rounded-full animate-spin" />
                      Processing...
                    </span>
                  ) : (
                    <span className="flex items-center justify-center gap-2">
                      <span className="text-2xl font-bold">G</span>
                      Pay ${selectedPlan.price}
                    </span>
                  )}
                </button>
              )}

              {/* Apple Pay Button - Mobile */}
              {paymentMethod === 'apple' && (
                <button
                  type="button"
                  onClick={() => handleSubmit()}
                  disabled={isProcessing || !formData.email || !formData.fullName}
                  className="lg:hidden w-full py-4 px-6 rounded-2xl bg-gray-900 text-white font-semibold text-lg shadow-lg hover:shadow-xl hover:bg-gray-800 hover:scale-[1.02] active:scale-[0.98] transition-all disabled:opacity-50 disabled:cursor-not-allowed mt-6"
                >
                  {isProcessing ? (
                    <span className="flex items-center justify-center gap-2">
                      <div className="w-5 h-5 border-2 border-white/30 border-t-white rounded-full animate-spin" />
                      Processing...
                    </span>
                  ) : (
                    <span className="flex items-center justify-center gap-2">
                      <svg className="w-6 h-6" fill="currentColor" viewBox="0 0 24 24">
                        <path d="M17.05 20.28c-.98.95-2.05.8-3.08.35-1.09-.46-2.09-.48-3.24 0-1.44.62-2.2.44-3.06-.35C2.79 15.25 3.51 7.59 9.05 7.31c1.35.07 2.29.74 3.08.8 1.18-.24 2.31-.93 3.57-.84 1.51.12 2.65.72 3.4 1.8-3.12 1.87-2.38 5.98.48 7.13-.57 1.5-1.31 2.99-2.54 4.09l.01-.01zM12.03 7.25c-.15-2.23 1.66-4.07 3.74-4.25.29 2.58-2.34 4.5-3.74 4.25z"/>
                      </svg>
                      Pay ${selectedPlan.price}
                    </span>
                  )}
                </button>
              )}

              {/* Trust Indicators */}
              <div className="mt-6 space-y-3">
                <div className="flex items-center gap-2 text-gray-600">
                  <CheckCircle className="w-4 h-4 text-green-600" />
                  <span className="text-xs">No commitment • Cancel anytime</span>
                </div>
                <div className="flex items-center gap-2 text-gray-600">
                  <CheckCircle className="w-4 h-4 text-green-600" />
                  <span className="text-xs">Secure 256-bit SSL encryption</span>
                </div>
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>
  );
}