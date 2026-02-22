import { useState } from 'react';
import { useNavigate, useParams } from 'react-router';
import { ArrowLeft, MapPin, Star, Phone, Globe, Navigation, Heart, Clock, DollarSign, MessageCircle, X, Compass } from 'lucide-react';
import { motion, AnimatePresence } from 'motion/react';
import BottomNav from '../../../components/BottomNav';
import whatsappIcon from 'figma:asset/bcec9e8c1009aabd0a6aa8c9756b7ac760d20b79.png';
import instagramIcon from 'figma:asset/d0f8caa05d569c2ed16ac0d05e749b5f1bed81ac.png';
import telegramIcon from 'figma:asset/fae96de532be20d303dc036129d2277974395b4f.png';
import facebookIcon from 'figma:asset/cc2007467cda7c7222349053d65f4942af04bada.png';
import tiktokIcon from 'figma:asset/dac74f85ccf69143e439bee8dafc1b04e0d8bb8d.png';

export default function BusinessSuggestionsScreen() {
  const navigate = useNavigate();
  const { id } = useParams();
  
  // Map gift IDs to gift types
  const giftTypes: { [key: string]: string } = {
    '1': 'Personalized Photo Album',
    '2': 'Artisan Coffee Subscription',
    '3': 'Weekend Spa Getaway',
  };

  const [giftType] = useState(giftTypes[id || '1'] || 'Gift');
  const [savedBusinesses, setSavedBusinesses] = useState<number[]>([]);
  const [showSocialMedia, setShowSocialMedia] = useState<number | null>(null);

  // Different businesses based on gift type
  const getBusinesses = () => {
    if (id === '1') {
      return [
        {
          id: 1,
          name: 'Memory Lane Photo Studio',
          type: 'Custom Photo Albums',
          address: '123 Main Street, Downtown',
          distance: '0.5 mi',
          rating: 4.9,
          reviews: 234,
          price: '$$',
          phone: '(555) 123-4567',
          hours: 'Open until 7:00 PM',
          website: 'memorylanephoto.com',
          specialty: 'Premium leather albums with custom embossing',
          emoji: '📸',
          image: 'https://images.unsplash.com/photo-1556745753-b2904692b3cd?w=400',
          socialMedia: {
            instagram: '@memorylanephoto',
            facebook: 'MemoryLanePhoto',
            whatsapp: '+1-555-123-4567',
            telegram: '@memorylanestudio',
            tiktok: '@memorylanephoto'
          }
        },
        {
          id: 2,
          name: 'Artisan Album Co.',
          type: 'Handcrafted Photo Books',
          address: '456 Oak Avenue, Midtown',
          distance: '1.2 mi',
          rating: 4.8,
          reviews: 187,
          price: '$$$',
          phone: '(555) 234-5678',
          hours: 'Open until 6:00 PM',
          website: 'artisanalbum.com',
          specialty: 'Eco-friendly materials with personalization',
          emoji: '🎨',
          image: 'https://images.unsplash.com/photo-1542744173-8e7e53415bb0?w=400',
          socialMedia: {
            instagram: '@artisanalbum',
            facebook: 'ArtisanAlbumCo',
            whatsapp: '+1-555-234-5678',
            telegram: '@artisanalbum',
            tiktok: '@artisanalbum'
          }
        },
        {
          id: 3,
          name: 'Cherished Moments',
          type: 'Photo Gifts & Albums',
          address: '789 Pine Road, Eastside',
          distance: '2.1 mi',
          rating: 4.7,
          reviews: 156,
          price: '$$',
          phone: '(555) 345-6789',
          hours: 'Open until 8:00 PM',
          website: 'cherishedmoments.com',
          specialty: 'Same-day printing and binding services',
          emoji: '💝',
          image: 'https://images.unsplash.com/photo-1554224311-beee4ece2270?w=400',
          socialMedia: {
            instagram: '@cherishedmoments',
            facebook: 'CherishedMoments',
            whatsapp: '+1-555-345-6789',
            telegram: '@cherishedmoments',
            tiktok: '@cherishedmoments'
          }
        },
      ];
    } else if (id === '2') {
      return [
        {
          id: 1,
          name: 'Bean & Brew Subscriptions',
          type: 'Specialty Coffee',
          address: '321 Coffee Lane, Downtown',
          distance: '0.3 mi',
          rating: 5.0,
          reviews: 412,
          price: '$$',
          phone: '(555) 456-7890',
          hours: 'Open until 9:00 PM',
          website: 'beanandbrew.com',
          specialty: 'Curated monthly coffee subscriptions',
          emoji: '☕',
          image: 'https://images.unsplash.com/photo-1495474472287-4d71bcdd2085?w=400',
          socialMedia: {
            instagram: '@beanandbrew',
            facebook: 'BeanAndBrew',
            whatsapp: '+1-555-456-7890',
            telegram: '@beanandbrew',
            tiktok: '@beanandbrew'
          }
        },
        {
          id: 2,
          name: 'The Roastery Club',
          type: 'Artisan Coffee Roasters',
          address: '654 Espresso Street, Westside',
          distance: '0.8 mi',
          rating: 4.9,
          reviews: 328,
          price: '$$$',
          phone: '(555) 567-8901',
          hours: 'Open until 7:00 PM',
          website: 'roasteryclub.com',
          specialty: 'Single-origin beans, subscription boxes',
          emoji: '🌱',
          image: 'https://images.unsplash.com/photo-1447933601403-0c6688de566e?w=400',
          socialMedia: {
            instagram: '@roasteryclub',
            facebook: 'RoasteryClub',
            whatsapp: '+1-555-567-8901',
            telegram: '@roasteryclub',
            tiktok: '@roasteryclub'
          }
        },
        {
          id: 3,
          name: 'Coffee Connoisseur',
          type: 'Premium Coffee Shop',
          address: '987 Brew Boulevard, Northside',
          distance: '1.5 mi',
          rating: 4.8,
          reviews: 289,
          price: '$$',
          phone: '(555) 678-9012',
          hours: 'Open until 6:30 PM',
          website: 'coffeeconnoisseur.com',
          specialty: 'Gift subscriptions with personalized notes',
          emoji: '🎁',
          image: 'https://images.unsplash.com/photo-1511920170033-f8396924c348?w=400',
          socialMedia: {
            instagram: '@coffeeconnoisseur',
            facebook: 'CoffeeConnoisseur',
            whatsapp: '+1-555-678-9012',
            telegram: '@coffeeconnoisseur',
            tiktok: '@coffeeconnoisseur'
          }
        },
      ];
    } else {
      return [
        {
          id: 1,
          name: 'Serenity Spa Resort',
          type: 'Luxury Spa & Wellness',
          address: '111 Tranquil Way, Resort Area',
          distance: '12 mi',
          rating: 5.0,
          reviews: 567,
          price: '$$$$',
          phone: '(555) 789-0123',
          hours: 'Open 24 hours',
          website: 'serenityspa.com',
          specialty: 'Weekend packages with couples massage',
          emoji: '🧖‍♀️',
          image: 'https://images.unsplash.com/photo-1540555700478-4be289fbecef?w=400',
          socialMedia: {
            instagram: '@serenityspa',
            facebook: 'SerenitySpaResort',
            whatsapp: '+1-555-789-0123',
            telegram: '@serenityspa',
            tiktok: '@serenityspa'
          }
        },
        {
          id: 2,
          name: 'Blissful Retreat',
          type: 'Day Spa & Resort',
          address: '222 Harmony Lane, Countryside',
          distance: '15 mi',
          rating: 4.9,
          reviews: 423,
          price: '$$$',
          phone: '(555) 890-1234',
          hours: '8:00 AM - 10:00 PM',
          website: 'blissfulretreat.com',
          specialty: 'All-inclusive spa weekend getaways',
          emoji: '🌸',
          image: 'https://images.unsplash.com/photo-1544161515-4ab6ce6db874?w=400',
          socialMedia: {
            instagram: '@blissfulretreat',
            facebook: 'BlissfulRetreat',
            whatsapp: '+1-555-890-1234',
            telegram: '@blissfulretreat',
            tiktok: '@blissfulretreat'
          }
        },
        {
          id: 3,
          name: 'Rejuvenate Wellness Spa',
          type: 'Holistic Spa Center',
          address: '333 Zen Circle, Mountain View',
          distance: '18 mi',
          rating: 4.8,
          reviews: 391,
          price: '$$$',
          phone: '(555) 901-2345',
          hours: '9:00 AM - 9:00 PM',
          website: 'rejuvenatespa.com',
          specialty: 'Customized spa packages with yoga',
          emoji: '✨',
          image: 'https://images.unsplash.com/photo-1596178060810-0a5c7b20a01a?w=400',
          socialMedia: {
            instagram: '@rejuvenatespa',
            facebook: 'RejuvenateWellnessSpa',
            whatsapp: '+1-555-901-2345',
            telegram: '@rejuvenatespa',
            tiktok: '@rejuvenatespa'
          }
        },
      ];
    }
  };

  const businesses = getBusinesses();

  const handleBack = () => {
    navigate(-1);
  };

  const handleSaveBusiness = (businessId: number) => {
    if (savedBusinesses.includes(businessId)) {
      setSavedBusinesses(savedBusinesses.filter(id => id !== businessId));
    } else {
      setSavedBusinesses([...savedBusinesses, businessId]);
    }
  };

  const handleCall = (phone: string) => {
    window.location.href = `tel:${phone}`;
  };

  const handleWebsite = (website: string) => {
    window.open(`https://${website}`, '_blank');
  };

  const handleDirections = (address: string) => {
    window.open(`https://maps.google.com/?q=${encodeURIComponent(address)}`, '_blank');
  };

  const handleSocialMedia = (businessId: number) => {
    if (showSocialMedia === businessId) {
      setShowSocialMedia(null);
    } else {
      setShowSocialMedia(businessId);
    }
  };

  return (
    <div className="min-h-screen bg-gradient-to-br from-rose-50 via-pink-50 to-purple-50 pb-24">
      {/* Header */}
      <div className="sticky top-0 z-20 bg-gradient-to-br from-rose-50/95 via-pink-50/95 to-purple-50/95 backdrop-blur-xl border-b border-pink-100/50">
        <div className="max-w-4xl mx-auto px-6 py-4">
          <div className="flex items-start justify-between mb-3">
            <button
              onClick={handleBack}
              className="flex items-center gap-2 text-rose-600 hover:text-rose-700 transition-colors"
            >
              <ArrowLeft className="w-5 h-5" />
              <span className="font-medium">Back to Gift Ideas</span>
            </button>
            
            {/* Discover Button - Shows ALL businesses in user's country */}
            <button
              onClick={() => navigate('/individual/local-businesses')}
              className="flex items-center gap-2 px-4 py-2 rounded-xl bg-gradient-to-r from-rose-500 to-pink-500 hover:from-rose-600 hover:to-pink-600 text-white font-semibold shadow-lg hover:shadow-xl transition-all hover:scale-[1.03]"
            >
              <Compass className="w-5 h-5" />
              <span>Discover</span>
            </button>
          </div>
          <div>
            <h1 className="text-2xl font-bold text-gray-800 mb-1">Local Businesses</h1>
            <p className="text-sm text-gray-600">
              Offering <span className="font-semibold text-rose-600">{giftType}</span>
            </p>
          </div>
        </div>
      </div>

      {/* Businesses List */}
      <div className="max-w-4xl mx-auto px-6 pt-6">
        <div className="mb-6">
          <p className="text-sm text-gray-600 text-center">
            Found <span className="font-bold text-gray-800">{businesses.length} trusted businesses</span> near you
          </p>
        </div>

        <div className="space-y-5">
          {businesses.map((business, index) => (
            <motion.div
              key={business.id}
              className="bg-white/80 backdrop-blur border-2 border-pink-200/50 rounded-3xl overflow-hidden shadow-lg hover:shadow-xl transition-all"
              initial={{ opacity: 0, y: 20 }}
              animate={{ opacity: 1, y: 0 }}
              transition={{ delay: index * 0.1 }}
            >
              {/* Business Header */}
              <div className="bg-gradient-to-br from-rose-100 to-pink-100 p-6">
                <div className="flex items-start justify-between mb-4">
                  <div className="flex items-start gap-4 flex-1">
                    {business.image ? (
                      <img
                        src={business.image}
                        alt={business.name}
                        className="w-16 h-16 rounded-2xl object-cover shadow-lg flex-shrink-0 ring-2 ring-rose-200"
                      />
                    ) : (
                      <div className="w-16 h-16 rounded-2xl bg-gradient-to-br from-rose-400 to-purple-400 flex items-center justify-center text-3xl shadow-lg flex-shrink-0">
                        {business.emoji}
                      </div>
                    )}
                    <div className="flex-1">
                      <h3 className="text-xl font-bold text-gray-800 mb-1">
                        {business.name}
                      </h3>
                      <p className="text-sm text-gray-600 mb-2">{business.type}</p>
                      <div className="flex items-center gap-4 flex-wrap">
                        <div className="flex items-center gap-1">
                          <Star className="w-4 h-4 fill-amber-400 text-amber-400" />
                          <span className="text-sm font-bold text-gray-800">{business.rating}</span>
                          <span className="text-xs text-gray-500">({business.reviews})</span>
                        </div>
                        <div className="flex items-center gap-1 text-gray-600">
                          <MapPin className="w-4 h-4" />
                          <span className="text-sm font-medium">{business.distance}</span>
                        </div>
                        <div className="flex items-center gap-1 px-2.5 py-1 rounded-lg bg-white/60">
                          <DollarSign className="w-4 h-4 text-green-600" />
                          <div className="flex items-center gap-0.5">
                            {[1, 2, 3, 4].map((level) => (
                              <DollarSign
                                key={level}
                                className={`w-3.5 h-3.5 ${
                                  level <= business.price.length
                                    ? 'text-green-600 fill-green-600'
                                    : 'text-gray-300'
                                }`}
                              />
                            ))}
                          </div>
                        </div>
                      </div>
                    </div>
                  </div>
                  <button
                    onClick={() => handleSaveBusiness(business.id)}
                    className={`p-3 rounded-xl transition-all ${
                      savedBusinesses.includes(business.id)
                        ? 'bg-gradient-to-br from-rose-500 to-pink-500'
                        : 'bg-white/60'
                    }`}
                  >
                    <Heart
                      className={`w-5 h-5 ${
                        savedBusinesses.includes(business.id)
                          ? 'fill-white text-white'
                          : 'text-rose-500'
                      }`}
                    />
                  </button>
                </div>

                {/* Specialty */}
                <div className="bg-white/60 backdrop-blur rounded-2xl p-3">
                  <p className="text-sm text-gray-700">
                    <span className="font-semibold">Specialty:</span> {business.specialty}
                  </p>
                </div>
              </div>

              {/* Business Details */}
              <div className="p-6">
                {/* Info Grid */}
                <div className="grid grid-cols-1 gap-3 mb-5">
                  <div className="flex items-start gap-3 p-3 rounded-xl bg-gradient-to-r from-rose-50 to-pink-50">
                    <MapPin className="w-5 h-5 text-rose-600 flex-shrink-0 mt-0.5" />
                    <div>
                      <p className="text-xs font-semibold text-gray-600 uppercase mb-1">Address</p>
                      <p className="text-sm font-medium text-gray-800">{business.address}</p>
                    </div>
                  </div>

                  <div className="flex items-center gap-3 p-3 rounded-xl bg-gradient-to-r from-purple-50 to-pink-50">
                    <Clock className="w-5 h-5 text-purple-600 flex-shrink-0" />
                    <div>
                      <p className="text-xs font-semibold text-gray-600 uppercase mb-1">Hours</p>
                      <p className="text-sm font-medium text-gray-800">{business.hours}</p>
                    </div>
                  </div>
                </div>

                {/* Action Buttons */}
                <div className="grid grid-cols-4 gap-2">
                  <button
                    onClick={() => handleCall(business.phone)}
                    className="py-3 px-2 rounded-2xl bg-gradient-to-r from-green-500 to-emerald-500 text-white font-semibold shadow-lg hover:shadow-xl hover:scale-[1.03] transition-all flex flex-col items-center justify-center gap-1.5"
                  >
                    <Phone className="w-5 h-5" />
                    <span className="text-xs">Tel</span>
                  </button>

                  <button
                    onClick={() => handleWebsite(business.website)}
                    className="py-3 px-2 rounded-2xl bg-gradient-to-r from-blue-500 to-cyan-500 text-white font-semibold shadow-lg hover:shadow-xl hover:scale-[1.03] transition-all flex flex-col items-center justify-center gap-1.5"
                  >
                    <Globe className="w-5 h-5" />
                    <span className="text-xs">Website</span>
                  </button>

                  <button
                    onClick={() => handleDirections(business.address)}
                    className="py-3 px-2 rounded-2xl bg-gradient-to-r from-rose-500 via-pink-500 to-purple-500 text-white font-semibold shadow-lg hover:shadow-xl hover:scale-[1.03] transition-all flex flex-col items-center justify-center gap-1.5"
                  >
                    <Navigation className="w-5 h-5" />
                    <span className="text-xs">Location</span>
                  </button>

                  <button
                    onClick={() => handleSocialMedia(business.id)}
                    className="py-3 px-2 rounded-2xl bg-gradient-to-r from-purple-500 to-indigo-500 text-white font-semibold shadow-lg hover:shadow-xl hover:scale-[1.03] transition-all flex flex-col items-center justify-center gap-1.5"
                  >
                    <MessageCircle className="w-5 h-5" />
                    <span className="text-xs">Social</span>
                  </button>
                </div>

                {/* Social Media Links - Expanded */}
                <AnimatePresence>
                  {showSocialMedia === business.id && (
                    <motion.div
                      className="mt-5 p-5 bg-gradient-to-br from-purple-50/80 to-pink-50/80 rounded-2xl border-2 border-purple-200/50"
                      initial={{ opacity: 0, height: 0 }}
                      animate={{ opacity: 1, height: 'auto' }}
                      exit={{ opacity: 0, height: 0 }}
                      transition={{ duration: 0.3 }}
                    >
                      <div className="flex items-center justify-between mb-4">
                        <div className="flex items-center gap-2">
                          <MessageCircle className="w-5 h-5 text-purple-600" />
                          <h4 className="font-semibold text-gray-800">Connect with us</h4>
                        </div>
                        <button
                          onClick={() => setShowSocialMedia(null)}
                          className="p-1.5 rounded-full hover:bg-white/60 transition-colors"
                        >
                          <X className="w-4 h-4 text-gray-600" />
                        </button>
                      </div>
                      <div className="grid grid-cols-2 gap-3">
                        {business.socialMedia.instagram && (
                          <a
                            href={`https://www.instagram.com/${business.socialMedia.instagram.replace('@', '')}`}
                            target="_blank"
                            rel="noopener noreferrer"
                            className="flex items-center gap-3 p-3 bg-white/80 backdrop-blur rounded-xl hover:bg-white transition-all hover:shadow-md"
                          >
                            <img src={instagramIcon} alt="Instagram" className="w-8 h-8" />
                            <div className="flex-1 min-w-0">
                              <p className="text-xs font-semibold text-gray-600 uppercase">Instagram</p>
                              <p className="text-sm font-medium text-gray-800 truncate">{business.socialMedia.instagram}</p>
                            </div>
                          </a>
                        )}
                        {business.socialMedia.facebook && (
                          <a
                            href={`https://www.facebook.com/${business.socialMedia.facebook}`}
                            target="_blank"
                            rel="noopener noreferrer"
                            className="flex items-center gap-3 p-3 bg-white/80 backdrop-blur rounded-xl hover:bg-white transition-all hover:shadow-md"
                          >
                            <img src={facebookIcon} alt="Facebook" className="w-8 h-8" />
                            <div className="flex-1 min-w-0">
                              <p className="text-xs font-semibold text-gray-600 uppercase">Facebook</p>
                              <p className="text-sm font-medium text-gray-800 truncate">{business.socialMedia.facebook}</p>
                            </div>
                          </a>
                        )}
                        {business.socialMedia.whatsapp && (
                          <a
                            href={`https://wa.me/${business.socialMedia.whatsapp.replace(/[^0-9]/g, '')}`}
                            target="_blank"
                            rel="noopener noreferrer"
                            className="flex items-center gap-3 p-3 bg-white/80 backdrop-blur rounded-xl hover:bg-white transition-all hover:shadow-md"
                          >
                            <img src={whatsappIcon} alt="WhatsApp" className="w-8 h-8" />
                            <div className="flex-1 min-w-0">
                              <p className="text-xs font-semibold text-gray-600 uppercase">WhatsApp</p>
                              <p className="text-sm font-medium text-gray-800 truncate">{business.socialMedia.whatsapp}</p>
                            </div>
                          </a>
                        )}
                        {business.socialMedia.telegram && (
                          <a
                            href={`https://t.me/${business.socialMedia.telegram.replace('@', '')}`}
                            target="_blank"
                            rel="noopener noreferrer"
                            className="flex items-center gap-3 p-3 bg-white/80 backdrop-blur rounded-xl hover:bg-white transition-all hover:shadow-md"
                          >
                            <img src={telegramIcon} alt="Telegram" className="w-8 h-8" />
                            <div className="flex-1 min-w-0">
                              <p className="text-xs font-semibold text-gray-600 uppercase">Telegram</p>
                              <p className="text-sm font-medium text-gray-800 truncate">{business.socialMedia.telegram}</p>
                            </div>
                          </a>
                        )}
                        {business.socialMedia.tiktok && (
                          <a
                            href={`https://www.tiktok.com/${business.socialMedia.tiktok}`}
                            target="_blank"
                            rel="noopener noreferrer"
                            className="flex items-center gap-3 p-3 bg-white/80 backdrop-blur rounded-xl hover:bg-white transition-all hover:shadow-md"
                          >
                            <img src={tiktokIcon} alt="TikTok" className="w-8 h-8" />
                            <div className="flex-1 min-w-0">
                              <p className="text-xs font-semibold text-gray-600 uppercase">TikTok</p>
                              <p className="text-sm font-medium text-gray-800 truncate">{business.socialMedia.tiktok}</p>
                            </div>
                          </a>
                        )}
                      </div>
                    </motion.div>
                  )}
                </AnimatePresence>
              </div>
            </motion.div>
          ))}
        </div>

        {/* Footer Info */}
        <motion.div
          className="mt-8 bg-gradient-to-br from-purple-50 to-pink-50 border border-purple-200/50 rounded-3xl p-6 text-center"
          initial={{ opacity: 0 }}
          animate={{ opacity: 1 }}
          transition={{ delay: 0.5 }}
        >
          <p className="text-sm text-gray-600">
            💡 <span className="font-semibold text-gray-800">Tip:</span> Call ahead to check availability and place your order
          </p>
        </motion.div>
      </div>

      <BottomNav />
    </div>
  );
}