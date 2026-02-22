import { useState } from 'react';
import { useNavigate } from 'react-router';
import { Heart, Mail, Lock, AlertCircle, Loader2, ArrowLeft } from 'lucide-react';
import RomanticCard from '../../components/RomanticCard';
import RomanticButton from '../../components/RomanticButton';
import RomanticInput from '../../components/RomanticInput';
import OAuthModal from '../../components/OAuthModal';
import { motion, AnimatePresence } from 'motion/react';
import { ImageWithFallback } from '../../components/figma/ImageWithFallback';
import { useApp } from '../../context/AppContext';
import cherishLogo from 'figma:asset/1ba0763b2c65c413d13ec69a501bf3eb00e15b25.png';

export default function AuthScreen() {
  const navigate = useNavigate();
  const { login, signUp, oauthLogin } = useApp();
  
  const [authMode, setAuthMode] = useState<'signup' | 'login'>('signup');
  const [email, setEmail] = useState('');
  const [password, setPassword] = useState('');
  const [isLoading, setIsLoading] = useState(false);
  const [error, setError] = useState('');
  
  // OAuth Modal State
  const [showOAuthModal, setShowOAuthModal] = useState(false);
  const [oauthProvider, setOauthProvider] = useState<'google' | 'facebook' | 'apple' | null>(null);

  const handleEmailAuth = async (e: React.FormEvent) => {
    e.preventDefault();
    setError('');
    setIsLoading(true);

    try {
      let user;
      if (authMode === 'signup') {
        user = await signUp(email, password);
      } else {
        user = await login(email, password);
      }

      console.log('Auth completed, user:', user); // Debug log

      // Always go to user type selection page after login/signup
      console.log('Navigating to user-type');
      navigate('/user-type');
    } catch (err: any) {
      setError(err.message);
    } finally {
      setIsLoading(false);
    }
  };

  const handleOAuth = async (provider: string) => {
    setError('');
    setIsLoading(true);

    try {
      const user = await oauthLogin(provider);

      console.log('OAuth completed, user:', user); // Debug log

      // Always go to user type selection page after OAuth login
      console.log('Navigating to user-type (OAuth)');
      navigate('/user-type');
    } catch (err: any) {
      setError(err.message);
    } finally {
      setIsLoading(false);
    }
  };

  return (
    <div className="h-screen w-full relative overflow-hidden flex flex-col">
      {/* Romantic Background Image with Overlay */}
      <div className="absolute inset-0 z-0">
        <ImageWithFallback
          src="https://images.unsplash.com/photo-1658851866325-49fb8b7fbcb2?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w3Nzg4Nzd8MHwxfHNlYXJjaHwxfHxyb21hbnRpYyUyMHN1bnNldCUyMGNvdXBsZXxlbnwxfHx8fDE3NjgyMDA1MDN8MA&ixlib=rb-4.1.0&q=80&w=1080"
          alt="Romantic background"
          className="w-full h-full object-cover"
        />
        <div className="absolute inset-0 bg-gradient-to-b from-rose-50/95 via-white/90 to-white/95 backdrop-blur-sm" />
      </div>

      {/* Back Button - Fixed at Top Left */}
      <motion.div
        className="fixed top-8 left-8 z-50"
        initial={{ opacity: 0, scale: 0.8 }}
        animate={{ opacity: 1, scale: 1 }}
        transition={{ duration: 0.8, delay: 0.5 }}
      >
        <motion.button
          onClick={() => navigate('/')}
          className="w-14 h-14 flex items-center justify-center rounded-full shadow-xl"
          style={{
            background: 'linear-gradient(135deg, rgba(255, 255, 255, 0.95) 0%, rgba(255, 241, 247, 0.9) 100%)',
            backdropFilter: 'blur(20px)',
            boxShadow: '0 8px 24px rgba(236, 72, 153, 0.25)',
            border: '1px solid rgba(251, 207, 232, 0.4)',
          }}
          whileHover={{ 
            scale: 1.1, 
            boxShadow: '0 12px 32px rgba(236, 72, 153, 0.35)' 
          }}
          whileTap={{ scale: 0.95 }}
          transition={{ duration: 0.2 }}
        >
          <ArrowLeft className="w-8 h-8 text-purple-500" />
        </motion.button>
      </motion.div>

      <div className="relative z-10 h-full flex flex-col px-6 py-4 max-w-md mx-auto w-full overflow-y-auto">
        {/* Logo Section - Reduced height */}
        <motion.div
          className="flex flex-col items-center justify-center pt-4 pb-4"
          initial={{ opacity: 0, y: -20 }}
          animate={{ opacity: 1, y: 0 }}
        >
          <motion.div
            className="inline-flex items-center justify-center w-32 h-32 mb-2"
            animate={{
              scale: [1, 1.05, 1],
            }}
            transition={{
              duration: 3,
              repeat: Infinity,
              ease: "easeInOut"
            }}
          >
            <div className="relative w-full h-full">
              {/* Soft Glow Behind Logo */}
              <div className="absolute inset-0 bg-gradient-to-br from-rose-300/20 to-purple-300/20 rounded-full blur-2xl scale-110" />
              
              <ImageWithFallback
                src={cherishLogo}
                alt="Cherish AI Logo"
                className="w-full h-full object-contain relative z-10 drop-shadow-2xl"
              />
            </div>
          </motion.div>
          <h1 className="text-2xl mb-1 text-rose-600 font-bold">
            Welcome to Cherish AI
          </h1>
          <p className="text-rose-500 text-base">your personal love assistant 💕</p>
        </motion.div>

        {/* Form Section - Flexible spacing */}
        <div className="flex-1 flex flex-col justify-start pb-4">
          {/* Tab Switcher for Login/Sign Up */}
          <motion.div
            className="flex gap-2 mb-4 bg-rose-50/50 p-1.5 rounded-2xl border border-rose-100"
            initial={{ opacity: 0 }}
            animate={{ opacity: 1 }}
            transition={{ delay: 0.1 }}
          >
            <button
              type="button"
              onClick={() => {
                setAuthMode('signup');
                setError('');
              }}
              className={`flex-1 py-2.5 px-4 rounded-xl font-semibold text-sm transition-all ${
                authMode === 'signup'
                  ? 'bg-gradient-to-r from-rose-500 via-pink-500 to-purple-500 text-white shadow-lg'
                  : 'text-gray-600 hover:text-rose-600'
              }`}
            >
              Sign Up
            </button>
            <button
              type="button"
              onClick={() => {
                setAuthMode('login');
                setError('');
              }}
              className={`flex-1 py-2.5 px-4 rounded-xl font-semibold text-sm transition-all ${
                authMode === 'login'
                  ? 'bg-gradient-to-r from-rose-500 via-pink-500 to-purple-500 text-white shadow-lg'
                  : 'text-gray-600 hover:text-rose-600'
              }`}
            >
              Login
            </button>
          </motion.div>

          {/* Error Message */}
          <AnimatePresence>
            {error && (
              <motion.div
                className="mb-4 p-3 rounded-2xl bg-red-50 border border-red-200 flex items-start gap-2"
                initial={{ opacity: 0, y: -10 }}
                animate={{ opacity: 1, y: 0 }}
                exit={{ opacity: 0, y: -10 }}
              >
                <AlertCircle className="w-5 h-5 text-red-600 flex-shrink-0 mt-0.5" />
                <p className="text-sm text-red-700">{error}</p>
              </motion.div>
            )}
          </AnimatePresence>

          {/* OAuth Buttons */}
          <motion.div
            className="space-y-2.5 mb-4"
            initial={{ opacity: 0 }}
            animate={{ opacity: 1 }}
            transition={{ delay: 0.2 }}
          >
            <button
              onClick={() => {
                setOauthProvider('google');
                setShowOAuthModal(true);
              }}
              disabled={isLoading}
              className="w-full"
            >
              <RomanticCard>
                <div className="flex items-center justify-center gap-3 py-2">
                  {isLoading ? (
                    <Loader2 className="w-5 h-5 animate-spin text-gray-600" />
                  ) : (
                    <>
                      <svg className="w-5 h-5" viewBox="0 0 24 24">
                        <path
                          fill="#4285F4"
                          d="M22.56 12.25c0-.78-.07-1.53-.2-2.25H12v4.26h5.92c-.26 1.37-1.04 2.53-2.21 3.31v2.77h3.57c2.08-1.92 3.28-4.74 3.28-8.09z"
                        />
                        <path
                          fill="#34A853"
                          d="M12 23c2.97 0 5.46-.98 7.28-2.66l-3.57-2.77c-.98.66-2.23 1.06-3.71 1.06-2.86 0-5.29-1.93-6.16-4.53H2.18v2.84C3.99 20.53 7.7 23 12 23z"
                        />
                        <path
                          fill="#FBBC05"
                          d="M5.84 14.09c-.22-.66-.35-1.36-.35-2.09s.13-1.43.35-2.09V7.07H2.18C1.43 8.55 1 10.22 1 12s.43 3.45 1.18 4.93l2.85-2.22.81-.62z"
                        />
                        <path
                          fill="#EA4335"
                          d="M12 5.38c1.62 0 3.06.56 4.21 1.64l3.15-3.15C17.45 2.09 14.97 1 12 1 7.7 1 3.99 3.47 2.18 7.07l3.66 2.84c.87-2.6 3.3-4.53 6.16-4.53z"
                        />
                      </svg>
                      <span className="text-gray-700">Continue with Google</span>
                    </>
                  )}
                </div>
              </RomanticCard>
            </button>

            <button
              onClick={() => {
                setOauthProvider('facebook');
                setShowOAuthModal(true);
              }}
              disabled={isLoading}
              className="w-full"
            >
              <RomanticCard>
                <div className="flex items-center justify-center gap-3 py-2">
                  <svg className="w-5 h-5" fill="#1877F2" viewBox="0 0 24 24">
                    <path d="M24 12.073c0-6.627-5.373-12-12-12s-12 5.373-12 12c0 5.99 4.388 10.954 10.125 11.854v-8.385H7.078v-3.47h3.047V9.43c0-3.007 1.792-4.669 4.533-4.669 1.312 0 2.686.235 2.686.235v2.953H15.83c-1.491 0-1.956.925-1.956 1.874v2.25h3.328l-.532 3.47h-2.796v8.385C19.612 23.027 24 18.062 24 12.073z" />
                  </svg>
                  <span className="text-gray-700">Continue with Facebook</span>
                </div>
              </RomanticCard>
            </button>

            <button
              onClick={() => {
                setOauthProvider('apple');
                setShowOAuthModal(true);
              }}
              disabled={isLoading}
              className="w-full"
            >
              <RomanticCard>
                <div className="flex items-center justify-center gap-3 py-2">
                  <svg className="w-5 h-5" viewBox="0 0 24 24">
                    <path d="M12 2C6.48 2 2 6.48 2 12s4.48 10 10 10 10-4.48 10-10S17.52 2 12 2zm-2 15l-5-5 1.41-1.41L10 14.17l7.59-7.59L19 8l-9 9z" />
                  </svg>
                  <span className="text-gray-700">Continue with Apple</span>
                </div>
              </RomanticCard>
            </button>
          </motion.div>

          {/* Divider */}
          <div className="flex items-center gap-4 mb-4">
            <div className="flex-1 h-px bg-rose-100"></div>
            <span className="text-rose-300 text-sm">or {authMode === 'signup' ? 'sign up' : 'login'} with email</span>
            <div className="flex-1 h-px bg-rose-100"></div>
          </div>

          {/* Email/Password Form */}
          <motion.form
            className="space-y-3"
            initial={{ opacity: 0 }}
            animate={{ opacity: 1 }}
            transition={{ delay: 0.4 }}
            onSubmit={handleEmailAuth}
          >
            <RomanticInput
              type="email"
              placeholder="Enter your email"
              value={email}
              onChange={(e) => setEmail(e.target.value)}
              required
              disabled={isLoading}
            />
            <RomanticInput
              type="password"
              placeholder={authMode === 'signup' ? 'Create a password' : 'Enter your password'}
              value={password}
              onChange={(e) => setPassword(e.target.value)}
              required
              disabled={isLoading}
            />
            <RomanticButton fullWidth type="submit" disabled={isLoading}>
              {isLoading ? (
                <div className="flex items-center justify-center gap-2">
                  <Loader2 className="w-5 h-5 animate-spin" />
                  <span>{authMode === 'signup' ? 'Creating account...' : 'Logging in...'}</span>
                </div>
              ) : (
                authMode === 'signup' ? 'Create Account' : 'Login'
              )}
            </RomanticButton>
          </motion.form>
        </div>

        {/* Privacy Note Section - Fixed height (12vh) */}
        <motion.div 
          className="flex items-center justify-center pt-4 pb-6"
          initial={{ opacity: 0 }}
          animate={{ opacity: 1 }}
          transition={{ delay: 0.6 }}
        >
          <p className="text-center text-gray-500 text-xs leading-relaxed px-2">
            By continuing, you agree to our Terms of Service and Privacy Policy. Your data is
            encrypted and secure. We never share your personal information.
          </p>
        </motion.div>
      </div>

      {/* OAuth Modal */}
      <OAuthModal
        isOpen={showOAuthModal}
        onClose={() => setShowOAuthModal(false)}
        onLogin={handleOAuth}
        provider={oauthProvider}
      />
    </div>
  );
}