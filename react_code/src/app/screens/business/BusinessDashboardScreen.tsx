import { useNavigate } from 'react-router';
import { TrendingUp, Eye, MousePointer, ExternalLink, User, Crown, Sparkles, ArrowRight, Settings, ArrowLeft } from 'lucide-react';
import RomanticCard from '../../components/RomanticCard';
import RomanticButton from '../../components/RomanticButton';
import { ImageWithFallback } from '../../components/figma/ImageWithFallback';
import { motion } from 'motion/react';
import { useSubscription } from '../../contexts/SubscriptionContext';
import { useBusiness } from '../../contexts/BusinessContext';
import AccountSettingsModal from '../../components/AccountSettingsModal';
import { useState, useEffect } from 'react';

export default function BusinessDashboardScreen() {
  const navigate = useNavigate();
  const { tier } = useSubscription();
  const { business } = useBusiness();
  const [showAccountSettings, setShowAccountSettings] = useState(false);
  const [businessData, setBusinessData] = useState({
    businessName: 'Bloom & Co Florist',
    contactPersonName: 'Sarah Johnson',
    profilePhoto: 'https://images.unsplash.com/photo-1490750967868-88aa4486c946?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&q=80&w=400',
  });

  // Load business data from localStorage on mount
  useEffect(() => {
    const existingUsersJson = localStorage.getItem('cherish_users');
    if (existingUsersJson) {
      const existingUsers = JSON.parse(existingUsersJson);
      const businessUser = existingUsers.find((u: any) => u.userType === 'business');
      
      if (businessUser) {
        setBusinessData({
          businessName: businessUser.businessName || business.businessName || 'Your Business',
          contactPersonName: businessUser.contactPersonName || business.contactPersonName || 'Business Owner',
          profilePhoto: businessUser.profilePhoto || 'https://images.unsplash.com/photo-1490750967868-88aa4486c946?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&q=80&w=400',
        });
      }
    }
  }, [business]);

  // Load products from localStorage
  const [registeredProducts, setRegisteredProducts] = useState<any[]>([]);

  useEffect(() => {
    const getCurrentUserEmail = () => {
      const currentUserJson = localStorage.getItem('cherish_current_user');
      if (currentUserJson) {
        const currentUser = JSON.parse(currentUserJson);
        return currentUser.email;
      }
      return null;
    };

    const userEmail = getCurrentUserEmail();
    if (userEmail) {
      const productsKey = `cherish_products_${userEmail}`;
      const savedProducts = localStorage.getItem(productsKey);
      if (savedProducts) {
        const parsedProducts = JSON.parse(savedProducts);
        setRegisteredProducts(parsedProducts);
      }
    }
  }, []);

  // Analytics stats - removed conversion rate and revenue (app is not transactional)
  const stats = [
    { label: 'Business Profile Views', value: '1,247', icon: Eye, trend: '+12%', color: 'purple' },
    { label: 'Interactions with Products', value: '89', icon: MousePointer, trend: '+8%', color: 'blue' },
    { label: 'Clicks on Website Link', value: '45', icon: ExternalLink, trend: '+5%', color: 'indigo' },
  ];

  return (
    <div className="min-h-screen pb-24 bg-gradient-to-b from-purple-50/30 to-white">
      {/* Header with Profile Button */}
      <div className="bg-gradient-to-br from-purple-400 via-purple-500 to-indigo-500 px-6 pt-12 pb-20 rounded-b-[30px] relative overflow-hidden">
        {/* Decorative elements */}
        <div className="absolute top-0 right-0 w-40 h-40 bg-white/10 rounded-full blur-3xl"></div>
        <div className="absolute bottom-0 left-0 w-32 h-32 bg-white/10 rounded-full blur-2xl"></div>
        
        <div className="relative z-10">
          {/* Back Button Row */}
          <motion.button
            onClick={() => navigate('/business/register')}
            className="w-10 h-10 rounded-full bg-white shadow-lg hover:shadow-xl transition-all mb-6 flex items-center justify-center"
            initial={{ opacity: 0, x: -20 }}
            animate={{ opacity: 1, x: 0 }}
            whileHover={{ scale: 1.05 }}
            whileTap={{ scale: 0.95 }}
          >
            <ArrowLeft className="w-5 h-5 text-purple-600" />
          </motion.button>

          <div className="flex items-center justify-between mb-8">
            <div className="flex items-center gap-3 flex-1">
              {/* Business Profile Photo */}
              <div className="w-16 h-16 rounded-full bg-white overflow-hidden flex-shrink-0 shadow-lg border-2 border-white/50">
                <ImageWithFallback
                  src={businessData.profilePhoto}
                  alt="Business Profile"
                  className="w-full h-full object-cover"
                />
              </div>
              
              <div className="flex-1">
                <div className="flex items-center gap-2 mb-2">
                  <h1 className="text-white text-2xl">{businessData.businessName}</h1>
                  <div className={`flex items-center gap-1 px-2 py-1 rounded-full ${
                    tier === 'plus' ? 'bg-amber-400/20' : 'bg-purple-400/20'
                  }`}>
                    <Crown className={`w-3 h-3 ${tier === 'plus' ? 'text-amber-300' : 'text-purple-300'}`} />
                    <span className={`text-xs ${tier === 'plus' ? 'text-amber-100' : 'text-purple-100'}`}>
                      {tier === 'plus' ? 'Plus' : 'Basic'}
                    </span>
                  </div>
                </div>
                <p className="text-white/90 text-sm mb-1">{businessData.contactPersonName}</p>
                <p className="text-white/70 text-xs">Partner since Jan 2024</p>
              </div>
            </div>
            <button
              onClick={() => setShowAccountSettings(true)}
              className="w-12 h-12 rounded-full bg-white/20 backdrop-blur-sm flex items-center justify-center hover:bg-white/30 transition-colors border-2 border-white/30"
            >
              <Settings className="w-6 h-6 text-white" />
            </button>
          </div>

          {/* Quick Stats in Header */}
          <div className="grid grid-cols-3 gap-3">
            <div className="bg-white/10 backdrop-blur-md rounded-2xl p-3 border border-white/20">
              <p className="text-white/70 text-xs mb-1">Views</p>
              <p className="text-white text-lg">1.2k</p>
            </div>
            <div className="bg-white/10 backdrop-blur-md rounded-2xl p-3 border border-white/20">
              <p className="text-white/70 text-xs mb-1">Interactions</p>
              <p className="text-white text-lg">89</p>
            </div>
            <div className="bg-white/10 backdrop-blur-md rounded-2xl p-3 border border-white/20">
              <p className="text-white/70 text-xs mb-1">Website</p>
              <p className="text-white text-lg">45</p>
            </div>
          </div>
        </div>
      </div>

      <div className="px-6 -mt-10 space-y-6 pb-6">
        {/* Detailed Stats Grid - 3 items */}
        <div className="grid grid-cols-1 gap-3">
          {stats.map((stat, index) => (
            <motion.div
              key={index}
              initial={{ opacity: 0, y: 20 }}
              animate={{ opacity: 1, y: 0 }}
              transition={{ delay: index * 0.1 }}
            >
              <RomanticCard className="relative overflow-hidden">
                <div className="absolute top-0 right-0 w-20 h-20 bg-purple-50 rounded-full -mr-10 -mt-10"></div>
                <div className="relative">
                  <div className="flex items-center justify-between mb-3">
                    <div className={`w-10 h-10 rounded-full flex items-center justify-center ${
                      stat.color === 'purple' ? 'bg-purple-100' :
                      stat.color === 'blue' ? 'bg-blue-100' :
                      stat.color === 'indigo' ? 'bg-indigo-100' :
                      stat.color === 'green' ? 'bg-green-100' :
                      'bg-amber-100'
                    }`}>
                      <stat.icon className={`w-5 h-5 ${
                        stat.color === 'purple' ? 'text-purple-600' :
                        stat.color === 'blue' ? 'text-blue-600' :
                        stat.color === 'indigo' ? 'text-indigo-600' :
                        stat.color === 'green' ? 'text-green-600' :
                        'text-amber-600'
                      }`} />
                    </div>
                    <span className="text-green-600 text-xs flex items-center gap-1">
                      <TrendingUp className="w-3 h-3" />
                      {stat.trend}
                    </span>
                  </div>
                  <p className="text-gray-500 text-xs mb-1">{stat.label}</p>
                  <p className="text-gray-800 text-2xl">{stat.value}</p>
                </div>
              </RomanticCard>
            </motion.div>
          ))}
        </div>

        {/* Products Section with Images */}
        <div>
          <div className="flex items-center justify-between mb-4">
            <div>
              <h2 className="text-xl text-gray-800 flex items-center gap-2">
                Your Products
                <Sparkles className="w-5 h-5 text-purple-400" />
              </h2>
              <p className="text-gray-500 text-xs mt-1">
                {registeredProducts.length === 0 
                  ? 'No products yet' 
                  : `${registeredProducts.length} active listing${registeredProducts.length !== 1 ? 's' : ''}`
                }
              </p>
            </div>
            <button
              onClick={() => navigate('/business/products')}
              className="text-purple-500 text-sm hover:text-purple-600 flex items-center gap-1"
            >
              Manage
              <ArrowRight className="w-4 h-4" />
            </button>
          </div>
          
          {registeredProducts.length === 0 ? (
            <RomanticCard className="text-center py-8">
              <div className="w-16 h-16 rounded-full bg-purple-50 flex items-center justify-center mx-auto mb-4">
                <Sparkles className="w-8 h-8 text-purple-300" />
              </div>
              <h3 className="text-gray-700 mb-2">No Products Yet</h3>
              <p className="text-gray-500 text-sm mb-4">Add your first product or service to get started</p>
              <button
                onClick={() => navigate('/business/products')}
                className="px-6 py-2 rounded-full bg-gradient-to-r from-purple-400 to-indigo-400 text-white text-sm font-medium hover:shadow-lg transition-all"
              >
                Add Product
              </button>
            </RomanticCard>
          ) : (
            <div className="space-y-3">
              {registeredProducts.map((product, index) => (
                <motion.div
                  key={product.id}
                  initial={{ opacity: 0, x: -20 }}
                  animate={{ opacity: 1, x: 0 }}
                  transition={{ delay: 0.5 + index * 0.1 }}
                >
                  <RomanticCard className="hover:shadow-lg transition-shadow cursor-pointer">
                    <div className="flex items-center gap-4">
                      {product.images && product.images.length > 0 ? (
                        <div className="relative flex-shrink-0">
                          <div className="w-20 h-20 rounded-2xl overflow-hidden">
                            <ImageWithFallback
                              src={product.images[0]}
                              alt={product.name}
                              className="w-full h-full object-cover"
                            />
                          </div>
                          <div className="absolute -top-1 -right-1 w-6 h-6 bg-purple-500 rounded-full flex items-center justify-center text-white text-xs">
                            {index + 1}
                          </div>
                        </div>
                      ) : (
                        <div className="relative flex-shrink-0">
                          <div className="w-20 h-20 rounded-2xl overflow-hidden bg-gradient-to-br from-purple-100 to-pink-100 flex items-center justify-center">
                            <Sparkles className="w-8 h-8 text-purple-300" />
                          </div>
                          <div className="absolute -top-1 -right-1 w-6 h-6 bg-purple-500 rounded-full flex items-center justify-center text-white text-xs">
                            {index + 1}
                          </div>
                        </div>
                      )}
                      
                      <div className="flex-1 min-w-0">
                        <h3 className="text-gray-800 mb-1 truncate">{product.name}</h3>
                        <p className="text-purple-600 text-sm mb-2">${product.priceMin} - ${product.priceMax}</p>
                        <div className="flex items-center gap-3 text-xs">
                          <span className="text-gray-500 flex items-center gap-1">
                            <Eye className="w-3 h-3" />
                            {Math.floor(Math.random() * 300) + 50}
                          </span>
                          <span className="text-gray-500 flex items-center gap-1">
                            <MousePointer className="w-3 h-3" />
                            {Math.floor(Math.random() * 30) + 5}
                          </span>
                        </div>
                      </div>

                      <div className="flex-shrink-0">
                        <div className="w-16 h-16 rounded-xl bg-gradient-to-br from-purple-100 to-pink-100 flex flex-col items-center justify-center">
                          <p className="text-xs text-gray-600 mb-0.5">Rate</p>
                          <p className="text-sm text-purple-600">{(Math.random() * 15 + 5).toFixed(1)}%</p>
                        </div>
                      </div>
                    </div>
                  </RomanticCard>
                </motion.div>
              ))}
            </div>
          )}
        </div>

        {/* Upgrade Card */}
        {tier === 'basic' && (
          <RomanticCard gradient className="relative overflow-hidden">
            <div className="absolute top-0 right-0 w-32 h-32 bg-amber-200/30 rounded-full blur-2xl"></div>
            <div className="relative flex items-start gap-4">
              <div className="w-14 h-14 rounded-2xl bg-gradient-to-br from-amber-400 to-orange-400 flex items-center justify-center flex-shrink-0 shadow-lg">
                <Crown className="w-7 h-7 text-white" />
              </div>
              <div className="flex-1">
                <h3 className="text-gray-800 mb-1 flex items-center gap-2">
                  Upgrade to Plus
                  <Sparkles className="w-4 h-4 text-amber-500" />
                </h3>
                <p className="text-gray-600 text-sm mb-1">
                  Get up to 7 business locations & up to 130 product listed
                </p>
                <p className="text-gray-500 text-xs mb-4">
                  (For 1 business location: up to 15 products)
                </p>
                <RomanticButton 
                  onClick={() => navigate('/business/subscription')}
                >
                  View Plans
                </RomanticButton>
              </div>
            </div>
          </RomanticCard>
        )}
        
        {/* Manage Subscription - For Plus Tier */}
        {tier === 'plus' && (
          <RomanticCard className="relative overflow-hidden">
            <div className="flex items-center justify-between">
              <div>
                <h3 className="text-gray-800 mb-1">Subscription</h3>
                <p className="text-gray-600 text-sm">Business Partner Plus • $19/month</p>
              </div>
              <button
                onClick={() => navigate('/business/subscription')}
                className="px-4 py-2 rounded-[12px] bg-purple-50 text-purple-600 hover:bg-purple-100 transition-colors text-sm font-medium"
              >
                Manage
              </button>
            </div>
          </RomanticCard>
        )}
      </div>

      {/* Account Settings Modal */}
      <AccountSettingsModal
        isOpen={showAccountSettings}
        onClose={() => setShowAccountSettings(false)}
        userType="business"
      />
    </div>
  );
}