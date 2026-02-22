import { motion, AnimatePresence } from 'motion/react';
import { X, CreditCard, User, Trash2, LogOut, ChevronRight, Edit2, MessageCircle } from 'lucide-react';
import { useNavigate } from 'react-router';
import { useApp } from '@/app/context/AppContext';

interface AccountSettingsModalProps {
  isOpen: boolean;
  onClose: () => void;
  userType: 'individual' | 'business';
}

export default function AccountSettingsModal({ isOpen, onClose, userType }: AccountSettingsModalProps) {
  const navigate = useNavigate();
  const { logout } = useApp();

  const handleManageSubscription = () => {
    onClose();
    if (userType === 'business') {
      navigate('/business/manage-subscription');
    } else {
      navigate('/individual/manage-subscription');
    }
  };

  const handleUserProfile = () => {
    onClose();
    if (userType === 'business') {
      navigate('/business/profile');
    } else {
      navigate('/individual/user-profile');
    }
  };

  const handleHelpFeedback = () => {
    onClose();
    navigate('/help-feedback');
  };

  const handleLogout = () => {
    logout();
    navigate('/');
    onClose();
  };

  return (
    <AnimatePresence>
      {isOpen && (
        <motion.div
          className="fixed inset-0 bg-black/50 backdrop-blur-sm flex items-center justify-center z-50 px-6"
          initial={{ opacity: 0 }}
          animate={{ opacity: 1 }}
          exit={{ opacity: 0 }}
          onClick={onClose}
        >
          <motion.div
            className="bg-white rounded-[24px] shadow-2xl max-w-md w-full overflow-hidden"
            initial={{ scale: 0.9, y: 20 }}
            animate={{ scale: 1, y: 0 }}
            exit={{ scale: 0.9, y: 20 }}
            onClick={(e) => e.stopPropagation()}
          >
            {/* Header */}
            <div className="bg-gradient-to-br from-rose-400 via-pink-500 to-purple-500 px-6 py-6 relative overflow-hidden">
              {/* Decorative elements */}
              <div className="absolute top-0 right-0 w-32 h-32 bg-white/10 rounded-full blur-2xl"></div>
              <div className="absolute bottom-0 left-0 w-24 h-24 bg-white/10 rounded-full blur-xl"></div>
              
              <div className="relative flex items-center justify-between">
                <div>
                  <h2 className="text-2xl text-white mb-1">
                    Account Settings
                  </h2>
                  <p className="text-white/80 text-sm">
                    Manage your account preferences
                  </p>
                </div>
                <button
                  onClick={onClose}
                  className="w-10 h-10 rounded-full bg-white/20 backdrop-blur-sm flex items-center justify-center hover:bg-white/30 transition-colors"
                >
                  <X className="w-5 h-5 text-white" />
                </button>
              </div>
            </div>

            {/* Menu Options */}
            <div className="p-6 space-y-3">
              {/* Manage Subscription */}
              <button
                onClick={handleManageSubscription}
                className="w-full flex items-center gap-4 p-4 rounded-[16px] bg-gradient-to-br from-purple-50 to-pink-50 border-2 border-purple-100 hover:border-purple-300 hover:shadow-md transition-all group"
              >
                <div className="w-12 h-12 rounded-full bg-gradient-to-br from-purple-400 to-indigo-400 flex items-center justify-center flex-shrink-0">
                  <CreditCard className="w-6 h-6 text-white" />
                </div>
                <div className="flex-1 text-left">
                  <h3 className="text-gray-800 font-medium mb-1">Manage Subscription</h3>
                  <p className="text-gray-500 text-sm">Change plan</p>
                </div>
                <ChevronRight className="w-5 h-5 text-purple-400 group-hover:translate-x-1 transition-transform" />
              </button>

              {/* User Profile */}
              <button
                onClick={handleUserProfile}
                className="w-full flex items-center gap-4 p-4 rounded-[16px] bg-gradient-to-br from-blue-50 to-cyan-50 border-2 border-blue-100 hover:border-blue-300 hover:shadow-md transition-all group"
              >
                <div className="w-12 h-12 rounded-full bg-gradient-to-br from-blue-400 to-cyan-400 flex items-center justify-center flex-shrink-0">
                  <User className="w-6 h-6 text-white" />
                </div>
                <div className="flex-1 text-left">
                  <h3 className="text-gray-800 font-medium mb-1">User Profile</h3>
                  <p className="text-gray-500 text-sm">Edit info or delete account</p>
                </div>
                <ChevronRight className="w-5 h-5 text-blue-400 group-hover:translate-x-1 transition-transform" />
              </button>

              {/* Help & Feedback */}
              <button
                onClick={handleHelpFeedback}
                className="w-full flex items-center gap-4 p-4 rounded-[16px] bg-gradient-to-br from-green-50 to-emerald-50 border-2 border-green-100 hover:border-green-300 hover:shadow-md transition-all group"
              >
                <div className="w-12 h-12 rounded-full bg-gradient-to-br from-green-400 to-emerald-400 flex items-center justify-center flex-shrink-0">
                  <MessageCircle className="w-6 h-6 text-white" />
                </div>
                <div className="flex-1 text-left">
                  <h3 className="text-gray-800 font-medium mb-1">Help & Feedback</h3>
                  <p className="text-gray-500 text-sm">Share your thoughts with us</p>
                </div>
                <ChevronRight className="w-5 h-5 text-green-400 group-hover:translate-x-1 transition-transform" />
              </button>

              {/* Logout */}
              <button
                onClick={handleLogout}
                className="w-full flex items-center gap-4 p-4 rounded-[16px] bg-gradient-to-br from-gray-50 to-slate-50 border-2 border-gray-200 hover:border-gray-300 hover:shadow-md transition-all group"
              >
                <div className="w-12 h-12 rounded-full bg-gradient-to-br from-gray-400 to-slate-400 flex items-center justify-center flex-shrink-0">
                  <LogOut className="w-6 h-6 text-white" />
                </div>
                <div className="flex-1 text-left">
                  <h3 className="text-gray-800 font-medium mb-1">Logout</h3>
                  <p className="text-gray-500 text-sm">Sign out of your account</p>
                </div>
                <ChevronRight className="w-5 h-5 text-gray-400 group-hover:translate-x-1 transition-transform" />
              </button>
            </div>
          </motion.div>
        </motion.div>
      )}
    </AnimatePresence>
  );
}