import { motion, AnimatePresence } from 'motion/react';
import { X, Mail, CheckCircle2 } from 'lucide-react';
import { useState } from 'react';
import { ImageWithFallback } from './figma/ImageWithFallback';

interface OAuthModalProps {
  isOpen: boolean;
  onClose: () => void;
  provider: 'google' | 'facebook' | 'apple' | null;
  onLogin: (email: string) => void;
}

// Mock accounts for demonstration
const mockAccounts = {
  google: [
    { email: 'john.doe@gmail.com', name: 'John Doe', avatar: 'https://images.unsplash.com/photo-1472099645785-5658abf4ff4e?w=100&h=100&fit=crop' },
    { email: 'sarah.smith@gmail.com', name: 'Sarah Smith', avatar: 'https://images.unsplash.com/photo-1438761681033-6461ffad8d80?w=100&h=100&fit=crop' },
    { email: 'newuser@gmail.com', name: 'New User', avatar: null },
  ],
  facebook: [
    { email: 'john.doe@facebook.com', name: 'John Doe', avatar: 'https://images.unsplash.com/photo-1472099645785-5658abf4ff4e?w=100&h=100&fit=crop' },
    { email: 'sarah.smith@facebook.com', name: 'Sarah Smith', avatar: 'https://images.unsplash.com/photo-1438761681033-6461ffad8d80?w=100&h=100&fit=crop' },
  ],
  apple: [
    { email: 'john.doe@icloud.com', name: 'John Doe', avatar: 'https://images.unsplash.com/photo-1472099645785-5658abf4ff4e?w=100&h=100&fit=crop' },
    { email: 'newuser@icloud.com', name: 'New User', avatar: null },
  ],
};

export default function OAuthModal({ isOpen, onClose, provider, onLogin }: OAuthModalProps) {
  const [selectedEmail, setSelectedEmail] = useState<string | null>(null);
  const [showNewAccountForm, setShowNewAccountForm] = useState(false);
  const [newAccountEmail, setNewAccountEmail] = useState('');
  const [newAccountPassword, setNewAccountPassword] = useState('');

  if (!provider) return null;

  const accounts = mockAccounts[provider];
  
  const providerConfig = {
    google: {
      color: '#4285F4',
      name: 'Google',
      logo: (
        <svg className="w-6 h-6" viewBox="0 0 24 24">
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
      ),
    },
    facebook: {
      color: '#1877F2',
      name: 'Facebook',
      logo: (
        <svg className="w-6 h-6" fill="#1877F2" viewBox="0 0 24 24">
          <path d="M24 12.073c0-6.627-5.373-12-12-12s-12 5.373-12 12c0 5.99 4.388 10.954 10.125 11.854v-8.385H7.078v-3.47h3.047V9.43c0-3.007 1.792-4.669 4.533-4.669 1.312 0 2.686.235 2.686.235v2.953H15.83c-1.491 0-1.956.925-1.956 1.874v2.25h3.328l-.532 3.47h-2.796v8.385C19.612 23.027 24 18.062 24 12.073z" />
        </svg>
      ),
    },
    apple: {
      color: '#000000',
      name: 'Apple',
      logo: (
        <svg className="w-6 h-6" fill="#000000" viewBox="0 0 24 24">
          <path d="M17.05 20.28c-.98.95-2.05.8-3.08.35-1.09-.46-2.09-.48-3.24 0-1.44.62-2.2.44-3.06-.35C2.79 15.25 3.51 7.59 9.05 7.31c1.35.07 2.29.74 3.08.8 1.18-.24 2.31-.93 3.57-.84 1.51.12 2.65.72 3.4 1.8-3.12 1.87-2.38 5.98.48 7.13-.57 1.5-1.31 2.99-2.54 4.09l.01-.01zM12.03 7.25c-.15-2.23 1.66-4.07 3.74-4.25.29 2.58-2.34 4.5-3.74 4.25z" />
        </svg>
      ),
    },
  };

  const config = providerConfig[provider];

  const handleSelectAccount = (email: string) => {
    setSelectedEmail(email);
    setTimeout(() => {
      onLogin(email);
      onClose();
      setSelectedEmail(null);
    }, 500);
  };

  const handleNewAccountSubmit = () => {
    if (newAccountEmail && newAccountPassword) {
      handleSelectAccount(newAccountEmail);
      setShowNewAccountForm(false);
      setNewAccountEmail('');
      setNewAccountPassword('');
    }
  };

  return (
    <AnimatePresence>
      {isOpen && (
        <>
          {/* Backdrop */}
          <motion.div
            className="fixed inset-0 bg-black/50 backdrop-blur-sm z-50"
            initial={{ opacity: 0 }}
            animate={{ opacity: 1 }}
            exit={{ opacity: 0 }}
            onClick={onClose}
          />

          {/* Modal */}
          <div className="fixed inset-0 z-50 flex items-center justify-center p-4">
            <motion.div
              className="bg-white rounded-3xl shadow-2xl max-w-md w-full overflow-hidden"
              initial={{ opacity: 0, scale: 0.9, y: 20 }}
              animate={{ opacity: 1, scale: 1, y: 0 }}
              exit={{ opacity: 0, scale: 0.9, y: 20 }}
              onClick={(e) => e.stopPropagation()}
            >
              {/* Header */}
              <div className="relative bg-gradient-to-br from-rose-50 to-purple-50 p-6 border-b border-rose-100">
                <button
                  onClick={onClose}
                  className="absolute top-4 right-4 p-2 rounded-full hover:bg-white/60 transition-colors"
                >
                  <X className="w-5 h-5 text-gray-600" />
                </button>

                <div className="flex items-center gap-3 mb-2">
                  {config.logo}
                  <h2 className="text-xl font-semibold text-gray-800">
                    Sign in with {config.name}
                  </h2>
                </div>
                <p className="text-sm text-gray-600">
                  Choose an account to continue to Cherish AI
                </p>
              </div>

              {/* Account List */}
              <div className="p-4 max-h-[400px] overflow-y-auto">
                {accounts.map((account) => (
                  <motion.button
                    key={account.email}
                    onClick={() => handleSelectAccount(account.email)}
                    className="w-full flex items-center gap-4 p-4 rounded-2xl hover:bg-gradient-to-r hover:from-rose-50 hover:to-purple-50 transition-all border-2 border-transparent hover:border-rose-200 mb-3 relative group"
                    whileHover={{ scale: 1.02 }}
                    whileTap={{ scale: 0.98 }}
                  >
                    {/* Avatar */}
                    <div className="w-12 h-12 rounded-full bg-gradient-to-br from-rose-400 to-purple-400 flex items-center justify-center text-white font-semibold overflow-hidden flex-shrink-0">
                      {account.avatar ? (
                        <ImageWithFallback
                          src={account.avatar}
                          alt={account.name}
                          className="w-full h-full object-cover"
                        />
                      ) : (
                        <Mail className="w-6 h-6" />
                      )}
                    </div>

                    {/* Account Info */}
                    <div className="flex-1 text-left">
                      <p className="font-semibold text-gray-800">{account.name}</p>
                      <p className="text-sm text-gray-600">{account.email}</p>
                    </div>

                    {/* Selection Indicator */}
                    <AnimatePresence>
                      {selectedEmail === account.email && (
                        <motion.div
                          initial={{ scale: 0 }}
                          animate={{ scale: 1 }}
                          exit={{ scale: 0 }}
                        >
                          <CheckCircle2 className="w-6 h-6 text-rose-600" />
                        </motion.div>
                      )}
                    </AnimatePresence>

                    {/* Hover Glow */}
                    <div className="absolute inset-0 rounded-2xl bg-gradient-to-r from-rose-400/0 to-purple-400/0 group-hover:from-rose-400/5 group-hover:to-purple-400/5 transition-all pointer-events-none" />
                  </motion.button>
                ))}

                {/* Use Another Account */}
                <button
                  onClick={() => setShowNewAccountForm(true)}
                  className="w-full flex items-center justify-center gap-2 p-4 rounded-2xl border-2 border-dashed border-rose-200 text-rose-600 hover:bg-rose-50 hover:border-rose-300 transition-all"
                >
                  <Mail className="w-5 h-5" />
                  <span className="font-semibold">Use another account</span>
                </button>

                {/* New Account Form */}
                <AnimatePresence>
                  {showNewAccountForm && (
                    <motion.div 
                      className="mt-4 p-6 rounded-2xl space-y-4"
                      style={{
                        background: 'linear-gradient(135deg, rgba(255, 241, 247, 0.8) 0%, rgba(254, 242, 248, 0.8) 100%)',
                        border: '2px solid rgba(251, 113, 133, 0.3)',
                      }}
                      initial={{ opacity: 0, height: 0 }}
                      animate={{ opacity: 1, height: 'auto' }}
                      exit={{ opacity: 0, height: 0 }}
                      transition={{ duration: 0.3 }}
                    >
                      <div className="space-y-3">
                        <div>
                          <label 
                            className="block mb-2 font-medium"
                            style={{ fontSize: '14px', color: '#7A3E55' }}
                          >
                            Email Address
                          </label>
                          <input
                            type="email"
                            value={newAccountEmail}
                            onChange={(e) => setNewAccountEmail(e.target.value)}
                            placeholder={`your.email@${provider === 'google' ? 'gmail.com' : provider === 'facebook' ? 'facebook.com' : 'icloud.com'}`}
                            className="w-full px-4 py-3 rounded-xl border-2 border-rose-200 focus:border-rose-400 focus:outline-none transition-all"
                            style={{
                              fontSize: '15px',
                              color: '#7A3E55',
                            }}
                            autoFocus
                          />
                        </div>
                        
                        <div>
                          <label 
                            className="block mb-2 font-medium"
                            style={{ fontSize: '14px', color: '#7A3E55' }}
                          >
                            Password
                          </label>
                          <input
                            type="password"
                            value={newAccountPassword}
                            onChange={(e) => setNewAccountPassword(e.target.value)}
                            placeholder="Enter your password"
                            className="w-full px-4 py-3 rounded-xl border-2 border-rose-200 focus:border-rose-400 focus:outline-none transition-all"
                            style={{
                              fontSize: '15px',
                              color: '#7A3E55',
                            }}
                            onKeyDown={(e) => {
                              if (e.key === 'Enter') {
                                handleNewAccountSubmit();
                              }
                            }}
                          />
                        </div>
                      </div>

                      <div className="flex gap-3 pt-2">
                        <motion.button
                          onClick={() => {
                            setShowNewAccountForm(false);
                            setNewAccountEmail('');
                            setNewAccountPassword('');
                          }}
                          className="flex-1 px-4 py-3 rounded-xl font-semibold transition-all"
                          style={{
                            background: 'rgba(255, 255, 255, 0.8)',
                            border: '2px solid rgba(251, 113, 133, 0.3)',
                            color: '#7A3E55',
                            fontSize: '15px',
                          }}
                          whileHover={{ scale: 1.02 }}
                          whileTap={{ scale: 0.98 }}
                        >
                          Cancel
                        </motion.button>
                        
                        <motion.button
                          onClick={handleNewAccountSubmit}
                          disabled={!newAccountEmail || !newAccountPassword}
                          className="flex-1 px-4 py-3 rounded-xl font-semibold text-white transition-all disabled:opacity-50 disabled:cursor-not-allowed"
                          style={{
                            background: newAccountEmail && newAccountPassword 
                              ? 'linear-gradient(135deg, #FB7185 0%, #F472B6 100%)' 
                              : '#D1D5DB',
                            fontSize: '15px',
                          }}
                          whileHover={newAccountEmail && newAccountPassword ? { scale: 1.02 } : {}}
                          whileTap={newAccountEmail && newAccountPassword ? { scale: 0.98 } : {}}
                        >
                          Sign In
                        </motion.button>
                      </div>
                    </motion.div>
                  )}
                </AnimatePresence>
              </div>

              {/* Footer */}
              <div className="bg-gray-50 px-6 py-4 text-center">
                <p className="text-xs text-gray-500">
                  To continue, Cherish AI will receive your name, email address, and profile picture
                </p>
              </div>
            </motion.div>
          </div>
        </>
      )}
    </AnimatePresence>
  );
}