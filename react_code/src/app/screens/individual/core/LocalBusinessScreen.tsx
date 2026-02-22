import { useState } from 'react';
import { useNavigate } from 'react-router';
import { ArrowLeft, MapPin, Star, Store, Search, Phone, Mail, ExternalLink, Compass, ChevronDown, Check, Globe, Navigation, MessageCircle, X } from 'lucide-react';
import { motion, AnimatePresence } from 'motion/react';
import { ImageWithFallback } from '@/app/components/figma/ImageWithFallback';
import BottomNav from '@/app/components/BottomNav';
import { useApp } from '@/app/context/AppContext';
import discoverButtonImage from 'figma:asset/f3a599157b94dbaa22d4df07a6e5ff73c4494e48.png';
import whatsappIcon from 'figma:asset/bcec9e8c1009aabd0a6aa8c9756b7ac760d20b79.png';
import instagramIcon from 'figma:asset/d0f8caa05d569c2ed16ac0d05e749b5f1bed81ac.png';
import telegramIcon from 'figma:asset/fae96de532be20d303dc036129d2277974395b4f.png';
import facebookIcon from 'figma:asset/cc2007467cda7c7222349053d65f4942af04bada.png';
import tiktokIcon from 'figma:asset/dac74f85ccf69143e439bee8dafc1b04e0d8bb8d.png';

interface Business {
  id: string;
  name: string;
  category: string;
  description: string;
  country: string;
  city: string;
  rating: number;
  reviewCount: number;
  logo: string;
  phone?: string;
  email?: string;
  website?: string;
  address?: string;
  specialties: string[];
  socialMedia?: {
    instagram?: string;
    facebook?: string;
    whatsapp?: string;
    telegram?: string;
    tiktok?: string;
  };
}

// Mock data - in real app, this would come from API filtered by user's location
const mockBusinesses: Business[] = [
  {
    id: '1',
    name: 'Romantic Gestures Co.',
    category: 'Gift Planning',
    description: 'Specializing in romantic surprise planning and custom gift experiences for couples.',
    country: 'United States',
    city: 'New York',
    rating: 4.8,
    reviewCount: 127,
    logo: '',
    phone: '+1 (555) 123-4567',
    email: 'info@romanticgestures.com',
    website: 'www.romanticgestures.com',
    address: '123 Main Street, New York, NY 10001',
    specialties: ['Anniversary Planning', 'Surprise Dates', 'Custom Gifts'],
    socialMedia: {
      instagram: '@romanticgestures',
      facebook: 'RomanticGesturesCo',
      whatsapp: '+1-555-123-4567',
    },
  },
  {
    id: '2',
    name: 'Eternal Flowers Studio',
    category: 'Flowers & Arrangements',
    description: 'Premium flower arrangements and preserved flowers that last forever.',
    country: 'United States',
    city: 'Los Angeles',
    rating: 4.9,
    reviewCount: 203,
    logo: '',
    phone: '+1 (555) 234-5678',
    email: 'hello@eternalflowers.com',
    website: 'www.eternalflowers.com',
    address: '456 Sunset Blvd, Los Angeles, CA 90028',
    specialties: ['Preserved Roses', 'Luxury Bouquets', 'Same-Day Delivery'],
    socialMedia: {
      instagram: '@eternalflowers',
      tiktok: '@eternalflowersstudio',
    },
  },
  {
    id: '3',
    name: 'Memory Lane Photography',
    category: 'Photography',
    description: 'Capturing your most cherished moments with artistic photography.',
    country: 'United States',
    city: 'Chicago',
    rating: 4.7,
    reviewCount: 89,
    logo: '',
    phone: '+1 (555) 789-0123',
    email: 'book@memorylane.com',
    website: 'www.memorylanephoto.com',
    address: '789 Michigan Ave, Chicago, IL 60611',
    specialties: ['Couple Shoots', 'Engagement Photos', 'Anniversary Sessions'],
    socialMedia: {
      instagram: '@memorylanephoto',
      facebook: 'MemoryLanePhoto',
    },
  },
  {
    id: '4',
    name: 'Sweet Sentiments Bakery',
    category: 'Bakery & Desserts',
    description: 'Custom cakes and desserts for every special occasion.',
    country: 'United States',
    city: 'San Francisco',
    rating: 4.6,
    reviewCount: 156,
    logo: '',
    phone: '+1 (555) 456-7890',
    email: 'orders@sweetsentiments.com',
    website: 'www.sweetsentiments.com',
    address: '321 Market St, San Francisco, CA 94102',
    specialties: ['Custom Cakes', 'Dessert Tables', 'Personalized Treats'],
    socialMedia: {
      instagram: '@sweetsentimentsbakery',
      whatsapp: '+1-555-456-7890',
    },
  },
  {
    id: '5',
    name: 'Heartfelt Jewelry',
    category: 'Jewelry & Accessories',
    description: 'Handcrafted jewelry with personalization options for that special someone.',
    country: 'United States',
    city: 'Boston',
    rating: 4.9,
    reviewCount: 241,
    logo: '',
    phone: '+1 (555) 567-8901',
    email: 'custom@heartfeltjewelry.com',
    website: 'www.heartfeltjewelry.com',
    address: '654 Boylston St, Boston, MA 02116',
    specialties: ['Custom Engraving', 'Couple Jewelry', 'Birthstone Pieces'],
    socialMedia: {
      instagram: '@heartfeltjewelry',
      facebook: 'HeartfeltJewelry',
      telegram: '@heartfeltjewels',
    },
  },
  {
    id: '6',
    name: 'Love Notes Stationery',
    category: 'Cards & Stationery',
    description: 'Beautiful handmade cards and stationery for expressing your feelings.',
    country: 'United States',
    city: 'Seattle',
    rating: 4.5,
    reviewCount: 78,
    logo: '',
    phone: '+1 (555) 678-9012',
    email: 'shop@lovenotes.com',
    website: 'www.lovenotesstationery.com',
    address: '987 Pike Place, Seattle, WA 98101',
    specialties: ['Custom Cards', 'Love Letters', 'Gift Wrapping'],
    socialMedia: {
      instagram: '@lovenotesstationary',
    },
  },
];

export default function LocalBusinessScreen() {
  const navigate = useNavigate();
  const { currentUser } = useApp();
  const [searchQuery, setSearchQuery] = useState('');
  const [selectedCategories, setSelectedCategories] = useState<string[]>([]);
  const [isDropdownOpen, setIsDropdownOpen] = useState(false);
  const [showSocialMedia, setShowSocialMedia] = useState<string | null>(null);

  // Filter businesses by user's country
  const userCountry = currentUser?.country || 'United States';
  const businessesInCountry = mockBusinesses.filter((business) => business.country === userCountry);

  // Get unique categories
  const categories = Array.from(new Set(businessesInCountry.map((b) => b.category)));

  // Filter businesses
  const filteredBusinesses = businessesInCountry.filter((business) => {
    const matchesSearch =
      business.name.toLowerCase().includes(searchQuery.toLowerCase()) ||
      business.description.toLowerCase().includes(searchQuery.toLowerCase()) ||
      business.category.toLowerCase().includes(searchQuery.toLowerCase());
    const matchesCategory = selectedCategories.length === 0 || selectedCategories.includes(business.category);
    return matchesSearch && matchesCategory;
  });

  const handleCategoryToggle = (category: string) => {
    if (selectedCategories.includes(category)) {
      setSelectedCategories(selectedCategories.filter(c => c !== category));
    } else {
      setSelectedCategories([...selectedCategories, category]);
    }
  };

  const getDropdownLabel = () => {
    if (selectedCategories.length === 0) {
      return 'All Categories';
    } else if (selectedCategories.length === 1) {
      return selectedCategories[0];
    } else {
      return `${selectedCategories.length} Categories Selected`;
    }
  };

  // Handler functions for action buttons
  const handleCall = (phone: string) => {
    window.location.href = `tel:${phone}`;
  };

  const handleWebsite = (website: string) => {
    window.open(`https://${website}`, '_blank');
  };

  const handleDirections = (address: string) => {
    window.open(`https://maps.google.com/?q=${encodeURIComponent(address)}`, '_blank');
  };

  const handleSocialMedia = (businessId: string) => {
    if (showSocialMedia === businessId) {
      setShowSocialMedia(null);
    } else {
      setShowSocialMedia(businessId);
    }
  };

  return (
    <div className="min-h-screen bg-gradient-to-br from-rose-50 via-pink-50 to-purple-50 pb-28">
      {/* Header with Discover Button */}
      <div className="sticky top-0 z-20 bg-gradient-to-br from-rose-50/95 via-pink-50/95 to-purple-50/95 backdrop-blur-xl border-b border-rose-100/50">
        <div className="max-w-6xl mx-auto px-6 py-4">
          <div className="flex items-center justify-between gap-3 mb-4">
            <div className="flex items-center gap-3 flex-1">
              <button
                onClick={() => navigate(-1)}
                className="flex items-center gap-2 px-3 py-2 rounded-xl text-rose-600 hover:text-rose-700 hover:bg-rose-50 transition-all"
              >
                <ArrowLeft className="w-5 h-5" />
                <span className="font-medium">Back</span>
              </button>
              <div className="flex items-center gap-2">
                <Store className="w-6 h-6 text-rose-500" />
                <h1 className="text-xl font-semibold text-gray-800">Local Businesses</h1>
              </div>
            </div>
            
            {/* Discover Button - Styled like reference image */}
            <button
              className="flex items-center gap-2 px-5 py-2.5 rounded-xl bg-gradient-to-r from-rose-500 to-pink-500 hover:from-rose-600 hover:to-pink-600 text-white font-bold shadow-lg hover:shadow-xl transition-all"
              onClick={() => {
                // Could trigger a refresh or special discovery feature
                window.scrollTo({ top: 0, behavior: 'smooth' });
              }}
            >
              <Compass className="w-5 h-5" />
              <span>Discover</span>
            </button>
          </div>

          {/* Location Badge */}
          <div className="mb-4">
            <div className="inline-flex items-center gap-2 px-4 py-2 rounded-xl bg-gradient-to-r from-rose-100 to-pink-100 border border-rose-200">
              <MapPin className="w-4 h-4 text-rose-600" />
              <span className="text-sm font-semibold text-gray-800">Showing businesses in {userCountry}</span>
            </div>
          </div>

          {/* Search Bar */}
          <div className="relative mb-4">
            <Search className="absolute left-4 top-1/2 transform -translate-y-1/2 w-5 h-5 text-gray-400" />
            <input
              type="text"
              placeholder="Search businesses..."
              value={searchQuery}
              onChange={(e) => setSearchQuery(e.target.value)}
              className="w-full pl-12 pr-4 py-3 rounded-xl border-2 border-rose-200 focus:border-rose-400 focus:outline-none bg-white/80 backdrop-blur text-gray-800 placeholder-gray-400"
            />
          </div>

          {/* Category Filter */}
          <div className="relative">
            <button
              className="flex items-center justify-between gap-2 px-4 py-2 rounded-full font-medium transition-all bg-gradient-to-r from-rose-500 to-pink-500 text-white shadow-lg shadow-pink-300/50 hover:shadow-xl min-w-[200px]"
              onClick={() => setIsDropdownOpen(!isDropdownOpen)}
            >
              <span>{getDropdownLabel()}</span>
              <ChevronDown className={`w-4 h-4 transition-transform ${isDropdownOpen ? 'rotate-180' : ''}`} />
            </button>
            
            {isDropdownOpen && (
              <>
                {/* Backdrop to close dropdown when clicking outside */}
                <div 
                  className="fixed inset-0 z-10" 
                  onClick={() => setIsDropdownOpen(false)}
                />
                
                {/* Dropdown Menu */}
                <div className="absolute left-0 top-full mt-2 w-64 bg-white rounded-2xl border-2 border-rose-200 shadow-xl z-20 overflow-hidden">
                  <div className="p-2 max-h-80 overflow-y-auto">
                    {categories.map((category) => {
                      const isSelected = selectedCategories.includes(category);
                      return (
                        <button
                          key={category}
                          onClick={() => handleCategoryToggle(category)}
                          className="w-full flex items-center gap-3 px-4 py-3 rounded-xl hover:bg-rose-50 transition-all text-left"
                        >
                          <div className={`w-5 h-5 rounded-md border-2 flex items-center justify-center flex-shrink-0 ${
                            isSelected
                              ? 'bg-gradient-to-r from-rose-500 to-pink-500 border-rose-500'
                              : 'bg-white border-pink-300'
                          }`}>
                            {isSelected && <Check className="w-3.5 h-3.5 text-white" />}
                          </div>
                          <span className={`font-medium ${isSelected ? 'text-rose-600' : 'text-gray-700'}`}>
                            {category}
                          </span>
                        </button>
                      );
                    })}
                  </div>
                  
                  {/* Clear All Button */}
                  {selectedCategories.length > 0 && (
                    <div className="border-t border-rose-200 p-2">
                      <button
                        onClick={() => {
                          setSelectedCategories([]);
                          setIsDropdownOpen(false);
                        }}
                        className="w-full px-4 py-2 rounded-xl bg-rose-50 hover:bg-rose-100 text-rose-600 font-medium transition-all"
                      >
                        Clear All
                      </button>
                    </div>
                  )}
                </div>
              </>
            )}
          </div>
        </div>
      </div>

      <div className="max-w-6xl mx-auto px-6 pt-6">
        {/* Results Count */}
        <p className="text-sm text-gray-600 mb-6">
          Found <span className="font-semibold text-rose-600">{filteredBusinesses.length}</span>{' '}
          {filteredBusinesses.length === 1 ? 'business' : 'businesses'}
        </p>

        {/* Business Cards */}
        <div className="space-y-4">
          {filteredBusinesses.map((business, index) => (
            <motion.div
              key={business.id}
              initial={{ opacity: 0, y: 20 }}
              animate={{ opacity: 1, y: 0 }}
              transition={{ delay: index * 0.1 }}
              className="bg-white/80 backdrop-blur-sm rounded-2xl border border-rose-200/50 shadow-lg overflow-hidden hover:shadow-xl transition-all"
            >
              <div className="p-6">
                {/* Header */}
                <div className="flex items-start gap-4 mb-4">
                  {business.logo ? (
                    <div className="w-16 h-16 rounded-xl overflow-hidden border-2 border-rose-200 flex-shrink-0">
                      <ImageWithFallback
                        src={business.logo}
                        alt={business.name}
                        className="w-full h-full object-cover"
                      />
                    </div>
                  ) : (
                    <div className="w-16 h-16 rounded-xl bg-gradient-to-br from-rose-200 to-pink-200 flex items-center justify-center text-2xl flex-shrink-0">
                      🏪
                    </div>
                  )}
                  <div className="flex-1">
                    <h3 className="text-xl font-bold text-gray-800 mb-1">{business.name}</h3>
                    <p className="text-sm text-gray-500 mb-2">
                      <MapPin className="w-3.5 h-3.5 inline mr-1" />
                      {business.city}, {business.country}
                    </p>
                    <div className="flex items-center gap-2 mb-2">
                      <span className="px-3 py-1 rounded-full text-xs font-semibold bg-gradient-to-r from-purple-100 to-pink-100 text-purple-700">
                        {business.category}
                      </span>
                    </div>
                    <div className="flex items-center gap-3 text-sm text-gray-600">
                      <div className="flex items-center gap-1">
                        <MapPin className="w-4 h-4 text-rose-500" />
                        <span>{business.city}</span>
                      </div>
                      <div className="flex items-center gap-1">
                        <Star className="w-4 h-4 text-yellow-500 fill-yellow-500" />
                        <span className="font-semibold">{business.rating}</span>
                        <span className="text-gray-400">({business.reviewCount})</span>
                      </div>
                    </div>
                  </div>
                </div>

                {/* Description */}
                <p className="text-gray-700 mb-4 leading-relaxed">{business.description}</p>

                {/* Specialties */}
                <div className="mb-4">
                  <h4 className="text-sm font-semibold text-gray-700 mb-2">Specialties:</h4>
                  <div className="flex flex-wrap gap-2">
                    {business.specialties.map((specialty, idx) => (
                      <span
                        key={idx}
                        className="px-3 py-1 rounded-lg text-xs font-medium bg-rose-50 text-rose-700 border border-rose-200"
                      >
                        {specialty}
                      </span>
                    ))}
                  </div>
                </div>

                {/* Action Buttons - Matching BusinessSuggestionsScreen Format */}
                <div className="grid grid-cols-4 gap-2">
                  <button
                    onClick={() => business.phone && handleCall(business.phone)}
                    disabled={!business.phone}
                    className={`py-3 px-2 rounded-2xl text-white font-semibold shadow-lg hover:shadow-xl hover:scale-[1.03] transition-all flex flex-col items-center justify-center gap-1.5 ${
                      business.phone
                        ? 'bg-gradient-to-r from-green-500 to-emerald-500 cursor-pointer'
                        : 'bg-gray-300 cursor-not-allowed opacity-50'
                    }`}
                  >
                    <Phone className="w-5 h-5" />
                    <span className="text-xs">Tel</span>
                  </button>

                  <button
                    onClick={() => business.website && handleWebsite(business.website)}
                    disabled={!business.website}
                    className={`py-3 px-2 rounded-2xl text-white font-semibold shadow-lg hover:shadow-xl hover:scale-[1.03] transition-all flex flex-col items-center justify-center gap-1.5 ${
                      business.website
                        ? 'bg-gradient-to-r from-blue-500 to-cyan-500 cursor-pointer'
                        : 'bg-gray-300 cursor-not-allowed opacity-50'
                    }`}
                  >
                    <Globe className="w-5 h-5" />
                    <span className="text-xs">Website</span>
                  </button>

                  <button
                    onClick={() => business.address && handleDirections(business.address)}
                    disabled={!business.address}
                    className={`py-3 px-2 rounded-2xl text-white font-semibold shadow-lg hover:shadow-xl hover:scale-[1.03] transition-all flex flex-col items-center justify-center gap-1.5 ${
                      business.address
                        ? 'bg-gradient-to-r from-rose-500 via-pink-500 to-purple-500 cursor-pointer'
                        : 'bg-gray-300 cursor-not-allowed opacity-50'
                    }`}
                  >
                    <Navigation className="w-5 h-5" />
                    <span className="text-xs">Location</span>
                  </button>

                  <button
                    onClick={() => handleSocialMedia(business.id)}
                    disabled={!business.socialMedia || Object.keys(business.socialMedia).length === 0}
                    className={`py-3 px-2 rounded-2xl text-white font-semibold shadow-lg hover:shadow-xl hover:scale-[1.03] transition-all flex flex-col items-center justify-center gap-1.5 ${
                      business.socialMedia && Object.keys(business.socialMedia).length > 0
                        ? 'bg-gradient-to-r from-purple-500 to-indigo-500 cursor-pointer'
                        : 'bg-gray-300 cursor-not-allowed opacity-50'
                    }`}
                  >
                    <MessageCircle className="w-5 h-5" />
                    <span className="text-xs">Social</span>
                  </button>
                </div>

                {/* Social Media Links - Expanded */}
                <AnimatePresence>
                  {showSocialMedia === business.id && business.socialMedia && (
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
                            href={`https://www.tiktok.com/@${business.socialMedia.tiktok.replace('@', '')}`}
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

        {/* Empty State */}
        {filteredBusinesses.length === 0 && (
          <div className="text-center py-12">
            <div className="w-20 h-20 rounded-full bg-gradient-to-br from-purple-100 to-pink-100 mx-auto mb-4 flex items-center justify-center text-4xl">
              🔍
            </div>
            <p className="text-gray-600 font-medium mb-2">No businesses found</p>
            <p className="text-gray-400 text-sm">
              Try adjusting your search or category filter
            </p>
          </div>
        )}
      </div>

      <BottomNav />
    </div>
  );
}