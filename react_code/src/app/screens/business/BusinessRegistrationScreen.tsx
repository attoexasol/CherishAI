import { useState } from 'react';
import { useNavigate } from 'react-router';
import { ArrowLeft, Plus, X, Store, MapPin, Upload, MessageCircle, Lock, Truck, MapPinned, Monitor, Edit2, Trash2, Clock, DollarSign, Camera } from 'lucide-react';
import { motion, AnimatePresence } from 'motion/react';
import { useBusiness } from '@/app/contexts/BusinessContext';
import RomanticInput from '@/app/components/RomanticInput';
import RomanticButton from '@/app/components/RomanticButton';
import RomanticCard from '@/app/components/RomanticCard';
import whatsappIcon from 'figma:asset/bcec9e8c1009aabd0a6aa8c9756b7ac760d20b79.png';
import instagramIcon from 'figma:asset/d0f8caa05d569c2ed16ac0d05e749b5f1bed81ac.png';
import telegramIcon from 'figma:asset/fae96de532be20d303dc036129d2277974395b4f.png';
import facebookIcon from 'figma:asset/cc2007467cda7c7222349053d65f4942af04bada.png';
import redditIcon from 'figma:asset/304e161b73873014c33d9d8b3536f8a95d4690a1.png';
import snapchatIcon from 'figma:asset/05d31970f7d942a30da189743cd2e11233d02133.png';
import tiktokIcon from 'figma:asset/dac74f85ccf69143e439bee8dafc1b04e0d8bb8d.png';

interface Site {
  id: string;
  locationName: string;
  country: string;
  city: string;
  postalCode: string;
  region: string;
  streetAddress: string;
  contactPerson: string;
  email?: string;
  tel?: string;
  category: string;
  description: string;
  priceRange: number;
  hours: string;
  deliveryType: string[];
  businessImage?: string;
}

// Helper function to check if user can add more locations based on subscription
const canAddLocation = (totalLocations: number): boolean => {
  // Free: 1 location
  // Plus: 7 locations
  // For now, assume Free tier (1 location max)
  return totalLocations < 1; // Will be dynamic based on subscription
};

const CATEGORIES = [
  { value: 'gifts', label: 'Gifts & Personalized Items', icon: '🎁' },
  { value: 'food', label: 'Food & Dining Experiences', icon: '🍽️' },
  { value: 'wellness', label: 'Wellness & Self-Care Services', icon: '💆' },
  { value: 'entertainment', label: 'Entertainment & Leisure', icon: '🎭' },
  { value: 'fashion', label: 'Fashion & Style', icon: '👗' },
  { value: 'home', label: 'Home & Lifestyle', icon: '🏠' },
  { value: 'travel', label: 'Travel & Getaways', icon: '✈️' },
  { value: 'memories', label: 'Memories & Creative Services', icon: '📸' },
  { value: 'family', label: 'Family & Children Services', icon: '👨‍👩‍👧' },
  { value: 'learning', label: 'Learning & Personal Growth', icon: '📚' },
];

// Common countries
const COUNTRIES = [
  'United States',
  'Canada',
  'United Kingdom',
  'Australia',
  'Germany',
  'France',
  'Italy',
  'Spain',
  'Japan',
  'China',
  'India',
  'Brazil',
  'Mexico',
  'South Africa',
  'Egypt',
  'Nigeria',
  'United Arab Emirates',
  'Singapore',
  'Malaysia',
  'New Zealand',
  'Netherlands',
  'Belgium',
  'Switzerland',
  'Sweden',
  'Norway',
  'Denmark',
  'Finland',
  'Ireland',
  'Portugal',
  'Greece',
  'Poland',
  'Czech Republic',
  'Austria',
  'Hungary',
  'Romania',
  'South Korea',
  'Thailand',
  'Vietnam',
  'Philippines',
  'Indonesia',
  'Pakistan',
  'Bangladesh',
  'Turkey',
  'Saudi Arabia',
  'Israel',
  'Argentina',
  'Chile',
  'Colombia',
  'Peru',
  'Venezuela',
].sort();

export default function BusinessRegistrationScreen() {
  const navigate = useNavigate();
  const { business, setBusiness } = useBusiness();
  const [formData, setFormData] = useState({
    businessName: business.businessName || '',
    category: business.category || '',
    contactPersonName: business.contactPersonName || '',
    email: business.email || '',
    // Business Location 1
    country: business.country || '',
    city: business.city || '',
    postalCode: business.postalCode || '',
    stateRegion: business.stateRegion || '',
    streetAddress: business.streetAddress || '',
    tel: business.tel || '',
    website: business.website || '',
    description: business.description || '',
    priceRange: business.priceRange || 2, // 1-4 scale
    hours: business.hours || '',
    deliveryType: business.deliveryType || [],
    businessImage: business.businessImage || '',
    // Social Media
    facebook: business.facebook || '',
    instagram: business.instagram || '',
    tiktok: business.tiktok || '',
    whatsapp: business.whatsapp || '',
    telegram: business.telegram || '',
    reddit: business.reddit || '',
    snapchat: business.snapchat || '',
  });

  const [imagePreview, setImagePreview] = useState<string>(business.businessImage || '');
  const [siteImagePreview, setSiteImagePreview] = useState<string>('');
  const [sites, setSites] = useState<Site[]>(business.sites || []);
  const [showSiteModal, setShowSiteModal] = useState(false);
  const [showSitesList, setShowSitesList] = useState(false);
  const [editingSite, setEditingSite] = useState<Site | null>(null);
  const [siteFormData, setSiteFormData] = useState({
    locationName: '',
    country: '',
    city: '',
    postalCode: '',
    region: '',
    streetAddress: '',
    contactPerson: '',
    email: '',
    tel: '',
    category: '',
    description: '',
    priceRange: 2,
    hours: '',
    deliveryType: [] as string[],
    businessImage: '',
  });

  const handleSubmit = (e: React.FormEvent) => {
    e.preventDefault();
    setBusiness({
      ...business,
      businessName: formData.businessName,
      category: formData.category,
      contactPersonName: formData.contactPersonName,
      email: formData.email,
      // Business Location 1
      country: formData.country,
      city: formData.city,
      postalCode: formData.postalCode,
      stateRegion: formData.stateRegion,
      streetAddress: formData.streetAddress,
      tel: formData.tel,
      website: formData.website,
      description: formData.description,
      priceRange: formData.priceRange,
      hours: formData.hours,
      deliveryType: formData.deliveryType,
      businessImage: formData.businessImage,
      // Social Media
      facebook: formData.facebook,
      instagram: formData.instagram,
      tiktok: formData.tiktok,
      whatsapp: formData.whatsapp,
      telegram: formData.telegram,
      reddit: formData.reddit,
      snapchat: formData.snapchat,
      sites: sites,
    });
    navigate('/business/products');
  };

  const handleAddSite = () => {
    if (siteFormData.locationName.trim()) {
      const newSite: Site = {
        id: Date.now().toString(),
        locationName: siteFormData.locationName,
        country: siteFormData.country,
        city: siteFormData.city,
        postalCode: siteFormData.postalCode,
        region: siteFormData.region,
        streetAddress: siteFormData.streetAddress,
        contactPerson: siteFormData.contactPerson,
        email: siteFormData.email,
        tel: siteFormData.tel,
        category: siteFormData.category,
        description: siteFormData.description,
        priceRange: siteFormData.priceRange,
        hours: siteFormData.hours,
        deliveryType: siteFormData.deliveryType,
        businessImage: siteFormData.businessImage,
      };
      setSites([...sites, newSite]);
      setSiteFormData({
        locationName: '',
        country: '',
        city: '',
        postalCode: '',
        region: '',
        streetAddress: '',
        contactPerson: '',
        email: '',
        tel: '',
        category: '',
        description: '',
        priceRange: 2,
        hours: '',
        deliveryType: [] as string[],
        businessImage: '',
      });
      setSiteImagePreview('');
      setShowSiteModal(false);
    }
  };

  const handleUpdateSite = () => {
    if (editingSite && siteFormData.locationName.trim()) {
      setSites(sites.map(site => 
        site.id === editingSite.id 
          ? { ...site, ...siteFormData }
          : site
      ));
      setEditingSite(null);
      setSiteFormData({
        locationName: '',
        country: '',
        city: '',
        postalCode: '',
        region: '',
        streetAddress: '',
        contactPerson: '',
        email: '',
        tel: '',
        category: '',
        description: '',
        priceRange: 2,
        hours: '',
        deliveryType: [] as string[],
        businessImage: '',
      });
      setSiteImagePreview('');
      setShowSiteModal(false);
    }
  };

  const handleEditSite = (site: Site) => {
    setEditingSite(site);
    setSiteFormData({
      locationName: site.locationName,
      country: site.country,
      city: site.city,
      postalCode: site.postalCode,
      region: site.region,
      streetAddress: site.streetAddress,
      contactPerson: site.contactPerson,
      email: site.email,
      tel: site.tel,
      category: site.category,
      description: site.description,
      priceRange: site.priceRange,
      hours: site.hours,
      deliveryType: site.deliveryType,
      businessImage: site.businessImage,
    });
    setSiteImagePreview(site.businessImage || '');
    setShowSiteModal(true);
    setShowSitesList(false);
  };

  const handleDeleteSite = (siteId: string) => {
    setSites(sites.filter(site => site.id !== siteId));
  };

  const openAddSiteModal = () => {
    setEditingSite(null);
    setSiteFormData({
      locationName: '',
      country: '',
      city: '',
      postalCode: '',
      region: '',
      streetAddress: '',
      contactPerson: '',
      email: '',
      tel: '',
      category: '',
      description: '',
      priceRange: 2,
      hours: '',
      deliveryType: [] as string[],
      businessImage: '',
    });
    setSiteImagePreview('');
    setShowSiteModal(true);
  };

  const isAtLocationLimit = () => {
    const totalLocations = 1 + sites.length;
    return !canAddLocation(totalLocations);
  };

  const toggleDeliveryType = (type: string) => {
    const currentTypes = Array.isArray(formData.deliveryType) ? formData.deliveryType : [];
    if (currentTypes.includes(type)) {
      setFormData({ ...formData, deliveryType: currentTypes.filter(t => t !== type) });
    } else {
      setFormData({ ...formData, deliveryType: [...currentTypes, type] });
    }
  };

  const toggleSiteDeliveryType = (type: string) => {
    const currentTypes = Array.isArray(siteFormData.deliveryType) ? siteFormData.deliveryType : [];
    if (currentTypes.includes(type)) {
      setSiteFormData({ ...siteFormData, deliveryType: currentTypes.filter(t => t !== type) });
    } else {
      setSiteFormData({ ...siteFormData, deliveryType: [...currentTypes, type] });
    }
  };

  const handleImageChange = (e: React.ChangeEvent<HTMLInputElement>) => {
    const file = e.target.files?.[0];
    if (file) {
      // Check file size (5MB limit)
      if (file.size > 5 * 1024 * 1024) {
        alert('File size must be less than 5MB');
        return;
      }
      
      // Check file type
      if (!file.type.startsWith('image/')) {
        alert('Please upload an image file');
        return;
      }
      
      const reader = new FileReader();
      reader.onloadend = () => {
        setImagePreview(reader.result as string);
        setFormData({ ...formData, businessImage: reader.result as string });
      };
      reader.readAsDataURL(file);
    }
  };

  const handleSiteImageChange = (e: React.ChangeEvent<HTMLInputElement>) => {
    const file = e.target.files?.[0];
    if (file) {
      // Check file size (5MB limit)
      if (file.size > 5 * 1024 * 1024) {
        alert('File size must be less than 5MB');
        return;
      }
      
      // Check file type
      if (!file.type.startsWith('image/')) {
        alert('Please upload an image file');
        return;
      }
      
      const reader = new FileReader();
      reader.onloadend = () => {
        setSiteImagePreview(reader.result as string);
        setSiteFormData({ ...siteFormData, businessImage: reader.result as string });
      };
      reader.readAsDataURL(file);
    }
  };

  return (
    <div className="min-h-screen px-6 py-12 pb-24 max-w-md mx-auto">
      {/* Back Button */}
      <motion.button
        onClick={() => navigate(-1)}
        className="mb-6 w-10 h-10 rounded-full bg-white/80 backdrop-blur-sm shadow-md flex items-center justify-center hover:bg-white transition-colors"
        initial={{ opacity: 0, x: -20 }}
        animate={{ opacity: 1, x: 0 }}
        whileHover={{ scale: 1.05 }}
        whileTap={{ scale: 0.95 }}
      >
        <ArrowLeft className="w-5 h-5 text-purple-600" />
      </motion.button>

      <motion.div
        className="mb-8"
        initial={{ opacity: 0, y: -20 }}
        animate={{ opacity: 1, y: 0 }}
      >
        <div className="inline-flex items-center justify-center w-14 h-14 rounded-full bg-gradient-to-br from-purple-400 to-indigo-400 mb-4 shadow-lg">
          <Store className="w-7 h-7 text-white" />
        </div>
        <h1 className="text-3xl text-gray-800 mb-2">Business Information</h1>
        <p className="text-purple-500">Tell Cherish AI about your business</p>
      </motion.div>

      <form onSubmit={handleSubmit} className="space-y-5">
        {/* Business Name */}
        <RomanticInput
          label="Business Name *"
          placeholder="Your Business Name"
          value={formData.businessName}
          onChange={(e) => setFormData({...formData, businessName: e.target.value})}
          required
        />

        {/* Product or Services Category */}
        <div>
          <label className="block text-purple-700 mb-2 text-sm">
            Product or Services Category *
          </label>
          <select
            className="w-full px-6 py-4 bg-white/60 backdrop-blur-sm border-2 border-purple-100 rounded-[16px] 
              focus:outline-none focus:border-purple-300 focus:bg-white/80 transition-all text-gray-700 appearance-none cursor-pointer"
            style={{
              backgroundImage: `url("data:image/svg+xml,%3Csvg xmlns='http://www.w3.org/2000/svg' width='12' height='12' viewBox='0 0 12 12'%3E%3Cpath fill='%239333ea' d='M6 9L1 4h10z'/%3E%3C/svg%3E")`,
              backgroundRepeat: 'no-repeat',
              backgroundPosition: 'right 1.5rem center',
              backgroundSize: '12px'
            }}
            value={formData.category}
            onChange={(e) => setFormData({...formData, category: e.target.value})}
            required
          >
            <option value="">Select a category</option>
            {CATEGORIES.map((cat) => (
              <option key={cat.value} value={cat.value}>
                {cat.label}
              </option>
            ))}
          </select>
        </div>

        {/* Contact Person Name */}
        <RomanticInput
          label="Contact Person Name *"
          placeholder="Full name of primary contact"
          value={formData.contactPersonName}
          onChange={(e) => setFormData({...formData, contactPersonName: e.target.value})}
          required
        />

        {/* Email */}
        <RomanticInput
          label="Email *"
          type="email"
          placeholder="e.g., contact@yourbusiness.com"
          value={formData.email}
          onChange={(e) => setFormData({...formData, email: e.target.value})}
          required
        />

        {/* Business Location 1 Header */}
        <div className="pt-4">
          <h3 className="text-purple-700 font-medium text-sm mb-2 flex items-center gap-2">
            <MapPin className="w-4 h-4" />
            Location 1 Name *
          </h3>
          <RomanticInput
            value={formData.locationName}
            onChange={(e) => setFormData({ ...formData, locationName: e.target.value })}
            placeholder="e.g., Downtown Branch, Main Store, etc."
          />
        </div>

        {/* Country */}
        <div>
          <label className="block text-purple-700 mb-2 text-sm">Country *</label>
          <select
            className="w-full px-6 py-4 bg-white/60 backdrop-blur-sm border-2 border-purple-100 rounded-[16px] 
              focus:outline-none focus:border-purple-300 focus:bg-white/80 transition-all text-gray-700 appearance-none cursor-pointer"
            style={{
              backgroundImage: `url("data:image/svg+xml,%3Csvg xmlns='http://www.w3.org/2000/svg' width='12' height='12' viewBox='0 0 12 12'%3E%3Cpath fill='%239333ea' d='M6 9L1 4h10z'/%3E%3C/svg%3E")`,
              backgroundRepeat: 'no-repeat',
              backgroundPosition: 'right 1.5rem center',
              backgroundSize: '12px'
            }}
            value={formData.country}
            onChange={(e) => setFormData({...formData, country: e.target.value})}
            required
          >
            <option value="">Select a country</option>
            {COUNTRIES.map((country) => (
              <option key={country} value={country}>
                {country}
              </option>
            ))}
          </select>
        </div>

        {/* City */}
        <RomanticInput
          label="City *"
          placeholder="e.g., New York"
          value={formData.city}
          onChange={(e) => setFormData({...formData, city: e.target.value})}
          required
        />

        {/* Postal Code */}
        <RomanticInput
          label="Postal Code *"
          placeholder="e.g., 10001"
          value={formData.postalCode}
          onChange={(e) => setFormData({...formData, postalCode: e.target.value})}
          required
        />

        {/* State/Region (optional) */}
        <RomanticInput
          label="State/Region"
          placeholder="e.g., New York (Optional)"
          value={formData.stateRegion}
          onChange={(e) => setFormData({...formData, stateRegion: e.target.value})}
        />

        {/* Street Address (optional) */}
        <RomanticInput
          label="Street Address"
          placeholder="e.g., 123 Main Street (Optional)"
          value={formData.streetAddress}
          onChange={(e) => setFormData({...formData, streetAddress: e.target.value})}
        />

        {/* Tel (optional) */}
        <RomanticInput
          label="Tel"
          type="tel"
          placeholder="e.g., +1 (555) 123-4567 (Optional)"
          value={formData.tel}
          onChange={(e) => setFormData({...formData, tel: e.target.value})}
        />

        {/* Website */}
        <RomanticInput
          label="Website"
          type="url"
          placeholder="https://yourbusiness.com (Optional)"
          value={formData.website}
          onChange={(e) => setFormData({...formData, website: e.target.value})}
        />

        {/* Business Description */}
        <div>
          <label className="block text-purple-700 mb-2 text-sm">Business Description *</label>
          <p className="text-xs text-purple-500 mb-2">Briefly describe what you offer. This helps customers understand you at a glance.</p>
          <textarea
            className="w-full px-6 py-4 bg-white/60 backdrop-blur-sm border-2 border-purple-100 rounded-[16px] 
              focus:outline-none focus:border-purple-300 focus:bg-white/80 transition-all placeholder-purple-300 
              text-gray-700 min-h-[100px]"
            placeholder="What makes your business special..."
            value={formData.description}
            onChange={(e) => setFormData({...formData, description: e.target.value})}
            required
          />
        </div>

        {/* Price Range - SLIDE BAR */}
        <div>
          <label className="block text-purple-700 mb-2 text-sm font-medium">Price Range *</label>
          <p className="text-xs text-purple-500 mb-4">This helps Cherish match your offerings to customers' expectations and budgets.</p>
          
          <div className="px-2">
            <input
              type="range"
              min="1"
              max="4"
              value={formData.priceRange}
              onChange={(e) => setFormData({...formData, priceRange: parseInt(e.target.value)})}
              className="w-full h-2 bg-gradient-to-r from-emerald-200 via-indigo-200 to-rose-200 rounded-full appearance-none cursor-pointer slider"
              style={{
                backgroundImage: `linear-gradient(to right, 
                  #10b981 0%, 
                  #10b981 ${((formData.priceRange - 1) / 3) * 100}%, 
                  #e5e7eb ${((formData.priceRange - 1) / 3) * 100}%, 
                  #e5e7eb 100%)`
              }}
            />
            
            {/* Labels */}
            <div className="flex justify-between mt-3 text-xs">
              <span className={`${formData.priceRange === 1 ? 'text-emerald-600 font-semibold' : 'text-gray-400'}`}>
                $ Budget
              </span>
              <span className={`${formData.priceRange === 2 ? 'text-indigo-600 font-semibold' : 'text-gray-400'}`}>
                $$ Moderate
              </span>
              <span className={`${formData.priceRange === 3 ? 'text-purple-600 font-semibold' : 'text-gray-400'}`}>
                $$$ Upscale
              </span>
              <span className={`${formData.priceRange === 4 ? 'text-rose-600 font-semibold' : 'text-gray-400'}`}>
                $$$$ Luxury
              </span>
            </div>

            {/* Current Selection Display */}
            <div className="mt-4 p-3 rounded-[12px] bg-gradient-to-br from-purple-50/50 to-indigo-50/50 border border-purple-100">
              <p className="text-sm text-purple-700 text-center font-medium">
                {formData.priceRange === 1 && '💰 Budget Friendly ($0 - $50)'}
                {formData.priceRange === 2 && '✨ Moderate ($50 - $200)'}
                {formData.priceRange === 3 && '💎 Upscale ($200 - $500)'}
                {formData.priceRange === 4 && '👑 Luxury ($500+)'}
              </p>
            </div>
          </div>
        </div>

        {/* Operating Hours */}
        <div>
          <label className="block text-purple-700 mb-2 text-sm">Operating Hours</label>
          <p className="text-xs text-purple-500 mb-2">Lets customers know when they can visit, contact, or book your services.</p>
          <RomanticInput
            placeholder="e.g., Mon–Fri · 9:00 AM – 6:00 PM"
            value={formData.hours}
            onChange={(e) => setFormData({...formData, hours: e.target.value})}
          />
        </div>

        {/* Delivery Type */}
        <div>
          <label className="block text-purple-700 mb-2 text-sm font-medium">Delivery Type *</label>
          <p className="text-xs text-purple-500 mb-3">Tell customers how your services or products can be accessed.</p>
          
          <div className="space-y-2">
            <button
              type="button"
              onClick={() => toggleDeliveryType('delivery')}
              className={`w-full flex items-center gap-3 p-4 rounded-[16px] border-2 transition-all ${
                Array.isArray(formData.deliveryType) && formData.deliveryType.includes('delivery')
                  ? 'bg-gradient-to-br from-purple-50 to-indigo-50 border-purple-300 shadow-sm'
                  : 'bg-white/60 border-purple-100 hover:border-purple-200'
              }`}
            >
              <Truck className="w-5 h-5 text-purple-500" />
              <div className="flex-1 text-left">
                <p className={`text-sm font-medium ${
                  Array.isArray(formData.deliveryType) && formData.deliveryType.includes('delivery')
                    ? 'text-purple-700'
                    : 'text-gray-700'
                }`}>
                  Delivery
                </p>
                <p className="text-xs text-gray-500">Items can be delivered to the customer</p>
              </div>
              {Array.isArray(formData.deliveryType) && formData.deliveryType.includes('delivery') && (
                <div className="w-5 h-5 rounded-full bg-purple-500 flex items-center justify-center">
                  <svg className="w-3 h-3 text-white" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                    <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={3} d="M5 13l4 4L19 7" />
                  </svg>
                </div>
              )}
            </button>

            <button
              type="button"
              onClick={() => toggleDeliveryType('on-site')}
              className={`w-full flex items-center gap-3 p-4 rounded-[16px] border-2 transition-all ${
                Array.isArray(formData.deliveryType) && formData.deliveryType.includes('on-site')
                  ? 'bg-gradient-to-br from-purple-50 to-indigo-50 border-purple-300 shadow-sm'
                  : 'bg-white/60 border-purple-100 hover:border-purple-200'
              }`}
            >
              <MapPinned className="w-5 h-5 text-purple-500" />
              <div className="flex-1 text-left">
                <p className={`text-sm font-medium ${
                  Array.isArray(formData.deliveryType) && formData.deliveryType.includes('on-site')
                    ? 'text-purple-700'
                    : 'text-gray-700'
                }`}>
                  On-site
                </p>
                <p className="text-xs text-gray-500">Services or experiences take place at your location</p>
              </div>
              {Array.isArray(formData.deliveryType) && formData.deliveryType.includes('on-site') && (
                <div className="w-5 h-5 rounded-full bg-purple-500 flex items-center justify-center">
                  <svg className="w-3 h-3 text-white" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                    <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={3} d="M5 13l4 4L19 7" />
                  </svg>
                </div>
              )}
            </button>

            <button
              type="button"
              onClick={() => toggleDeliveryType('digital')}
              className={`w-full flex items-center gap-3 p-4 rounded-[16px] border-2 transition-all ${
                Array.isArray(formData.deliveryType) && formData.deliveryType.includes('digital')
                  ? 'bg-gradient-to-br from-purple-50 to-indigo-50 border-purple-300 shadow-sm'
                  : 'bg-white/60 border-purple-100 hover:border-purple-200'
              }`}
            >
              <Monitor className="w-5 h-5 text-purple-500" />
              <div className="flex-1 text-left">
                <p className={`text-sm font-medium ${
                  Array.isArray(formData.deliveryType) && formData.deliveryType.includes('digital')
                    ? 'text-purple-700'
                    : 'text-gray-700'
                }`}>
                  Digital
                </p>
                <p className="text-xs text-gray-500">Online or digital services available</p>
              </div>
              {Array.isArray(formData.deliveryType) && formData.deliveryType.includes('digital') && (
                <div className="w-5 h-5 rounded-full bg-purple-500 flex items-center justify-center">
                  <svg className="w-3 h-3 text-white" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                    <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={3} d="M5 13l4 4L19 7" />
                  </svg>
                </div>
              )}
            </button>
          </div>
        </div>

        {/* Upload Business Profile Photo */}
        <div>
          <label className="block text-purple-700 mb-1 text-sm font-medium">Business Logo/Photo</label>
          <p className="text-xs text-purple-500 mb-2">Upload a logo or photo to represent your business</p>
          
          <div className="relative">
            <input
              type="file"
              id="business-image"
              accept="image/*"
              onChange={handleImageChange}
              className="hidden"
            />
            <label
              htmlFor="business-image"
              className="block cursor-pointer"
            >
              {imagePreview ? (
                <div className="relative group">
                  <img
                    src={imagePreview}
                    alt="Business preview"
                    className="w-full h-32 object-cover rounded-[16px] border-2 border-purple-200"
                  />
                  <div className="absolute inset-0 bg-black/40 opacity-0 group-hover:opacity-100 transition-opacity rounded-[16px] flex items-center justify-center">
                    <div className="text-white text-center">
                      <Upload className="w-6 h-6 mx-auto mb-1" />
                      <p className="text-xs font-medium">Change Photo</p>
                    </div>
                  </div>
                </div>
              ) : (
                <RomanticCard className="border-2 border-dashed border-purple-200 hover:border-purple-300 hover:bg-purple-50/30 transition-all">
                  <div className="flex flex-col items-center py-4 text-center">
                    <div className="w-12 h-12 rounded-full bg-gradient-to-br from-purple-100 to-indigo-100 flex items-center justify-center mb-2">
                      <Upload className="w-6 h-6 text-purple-400" />
                    </div>
                    <p className="text-purple-600 font-medium mb-0.5 text-sm">Click to upload photo</p>
                    <p className="text-gray-400 text-xs">PNG, JPG up to 5MB</p>
                  </div>
                </RomanticCard>
              )}
            </label>
          </div>
        </div>

        {/* Social Media Section - MOVED TO BOTTOM */}
        <RomanticCard className="bg-gradient-to-br from-purple-50/40 to-pink-50/40 border-purple-100">
          <div className="flex items-center gap-2 mb-4">
            <MessageCircle className="w-5 h-5 text-purple-500" />
            <label className="text-purple-700 font-medium text-sm">Social Media & Messaging</label>
          </div>
          
          <div className="space-y-3">
            {/* WhatsApp */}
            <div className="flex items-center gap-3">
              <div className="w-10 h-10 rounded-full bg-white flex items-center justify-center flex-shrink-0">
                <img src={whatsappIcon} alt="WhatsApp" className="w-8 h-8" />
              </div>
              <input
                type="text"
                placeholder="WhatsApp"
                value={formData.whatsapp}
                onChange={(e) => setFormData({...formData, whatsapp: e.target.value})}
                className="flex-1 px-4 py-2.5 bg-white/80 backdrop-blur-sm border-2 border-purple-100 rounded-[12px] focus:outline-none focus:border-purple-300 focus:bg-white transition-all placeholder-purple-300 text-gray-700 text-sm"
              />
            </div>

            {/* Telegram */}
            <div className="flex items-center gap-3">
              <div className="w-10 h-10 rounded-full bg-white flex items-center justify-center flex-shrink-0">
                <img src={telegramIcon} alt="Telegram" className="w-8 h-8" />
              </div>
              <input
                type="text"
                placeholder="Telegram"
                value={formData.telegram}
                onChange={(e) => setFormData({...formData, telegram: e.target.value})}
                className="flex-1 px-4 py-2.5 bg-white/80 backdrop-blur-sm border-2 border-purple-100 rounded-[12px] focus:outline-none focus:border-purple-300 focus:bg-white transition-all placeholder-purple-300 text-gray-700 text-sm"
              />
            </div>

            {/* Instagram */}
            <div className="flex items-center gap-3">
              <div className="w-10 h-10 rounded-full bg-white flex items-center justify-center flex-shrink-0">
                <img src={instagramIcon} alt="Instagram" className="w-8 h-8" />
              </div>
              <input
                type="text"
                placeholder="Instagram"
                value={formData.instagram}
                onChange={(e) => setFormData({...formData, instagram: e.target.value})}
                className="flex-1 px-4 py-2.5 bg-white/80 backdrop-blur-sm border-2 border-purple-100 rounded-[12px] focus:outline-none focus:border-purple-300 focus:bg-white transition-all placeholder-purple-300 text-gray-700 text-sm"
              />
            </div>

            {/* Facebook */}
            <div className="flex items-center gap-3">
              <div className="w-10 h-10 rounded-full bg-white flex items-center justify-center flex-shrink-0">
                <img src={facebookIcon} alt="Facebook" className="w-8 h-8" />
              </div>
              <input
                type="text"
                placeholder="Facebook"
                value={formData.facebook}
                onChange={(e) => setFormData({...formData, facebook: e.target.value})}
                className="flex-1 px-4 py-2.5 bg-white/80 backdrop-blur-sm border-2 border-purple-100 rounded-[12px] focus:outline-none focus:border-purple-300 focus:bg-white transition-all placeholder-purple-300 text-gray-700 text-sm"
              />
            </div>

            {/* Reddit */}
            <div className="flex items-center gap-3">
              <div className="w-10 h-10 rounded-full bg-white flex items-center justify-center flex-shrink-0">
                <img src={redditIcon} alt="Reddit" className="w-8 h-8" />
              </div>
              <input
                type="text"
                placeholder="Reddit"
                value={formData.reddit}
                onChange={(e) => setFormData({...formData, reddit: e.target.value})}
                className="flex-1 px-4 py-2.5 bg-white/80 backdrop-blur-sm border-2 border-purple-100 rounded-[12px] focus:outline-none focus:border-purple-300 focus:bg-white transition-all placeholder-purple-300 text-gray-700 text-sm"
              />
            </div>

            {/* Snapchat */}
            <div className="flex items-center gap-3">
              <div className="w-10 h-10 rounded-full bg-white flex items-center justify-center flex-shrink-0">
                <img src={snapchatIcon} alt="Snapchat" className="w-8 h-8" />
              </div>
              <input
                type="text"
                placeholder="Snapchat"
                value={formData.snapchat}
                onChange={(e) => setFormData({...formData, snapchat: e.target.value})}
                className="flex-1 px-4 py-2.5 bg-white/80 backdrop-blur-sm border-2 border-purple-100 rounded-[12px] focus:outline-none focus:border-purple-300 focus:bg-white transition-all placeholder-purple-300 text-gray-700 text-sm"
              />
            </div>

            {/* TikTok */}
            <div className="flex items-center gap-3">
              <div className="w-10 h-10 rounded-full bg-white flex items-center justify-center flex-shrink-0">
                <img src={tiktokIcon} alt="TikTok" className="w-8 h-8" />
              </div>
              <input
                type="text"
                placeholder="TikTok"
                value={formData.tiktok}
                onChange={(e) => setFormData({...formData, tiktok: e.target.value})}
                className="flex-1 px-4 py-2.5 bg-white/80 backdrop-blur-sm border-2 border-purple-100 rounded-[12px] focus:outline-none focus:border-purple-300 focus:bg-white transition-all placeholder-purple-300 text-gray-700 text-sm"
              />
            </div>
          </div>
        </RomanticCard>

        <div className="pt-6">
          <RomanticButton fullWidth type="submit">
            Continue
          </RomanticButton>
        </div>

        {/* Multi-Site Actions */}
        <div className="space-y-2">
          <button
            type="button"
            onClick={openAddSiteModal}
            className="w-full flex items-center justify-center gap-2 py-3 px-4 rounded-[12px] border-2 border-purple-100 bg-white/40 hover:bg-purple-50/50 text-purple-600 transition-all text-sm cursor-pointer"
          >
            <Plus className="w-4 h-4" />
            <span>Add another business location</span>
          </button>

          {sites.length > 0 && (
            <motion.button
              type="button"
              onClick={() => setShowSitesList(true)}
              className="w-full flex items-center justify-center gap-2 py-3 px-4 rounded-[12px] border-2 border-purple-200 bg-gradient-to-r from-purple-50 to-indigo-50 hover:from-purple-100 hover:to-indigo-100 text-purple-700 transition-all text-sm"
              initial={{ opacity: 0, y: -10 }}
              animate={{ opacity: 1, y: 0 }}
            >
              <MapPin className="w-4 h-4" />
              <span>View sites ({sites.length})</span>
            </motion.button>
          )}
        </div>

        {/* Upgrade Prompt */}
        <div className="mt-6 p-4 rounded-[16px] bg-gradient-to-br from-purple-50 to-indigo-50 border border-purple-100">
          <p className="text-sm text-purple-700 text-center mb-3">
            Upgrade to Plus to add up to 7 locations
          </p>
          <button
            type="button"
            onClick={() => navigate('/business/subscription')}
            className="w-full py-3 px-4 bg-gradient-to-r from-purple-400 to-indigo-400 text-white rounded-[12px] text-sm font-medium hover:shadow-lg transition-all"
          >
            View Plans
          </button>
        </div>
      </form>

      {/* Add/Edit Site Modal */}
      <AnimatePresence>
        {showSiteModal && (
          <motion.div
            className="fixed inset-0 bg-black/50 backdrop-blur-sm flex items-center justify-center z-50 px-6"
            initial={{ opacity: 0 }}
            animate={{ opacity: 1 }}
            exit={{ opacity: 0 }}
            onClick={() => {
              setShowSiteModal(false);
              setEditingSite(null);
              setSiteImagePreview('');
              setSiteFormData({
                locationName: '',
                country: '',
                city: '',
                postalCode: '',
                region: '',
                streetAddress: '',
                contactPerson: '',
                email: '',
                tel: '',
                category: '',
                description: '',
                priceRange: 2,
                hours: '',
                deliveryType: [] as string[],
                businessImage: '',
              });
            }}
          >
            <motion.div
              className="bg-white rounded-[20px] shadow-2xl max-w-md w-full max-h-[85vh] overflow-hidden flex flex-col"
              initial={{ scale: 0.9, y: 20 }}
              animate={{ scale: 1, y: 0 }}
              exit={{ scale: 0.9, y: 20 }}
              onClick={(e) => e.stopPropagation()}
            >
              {/* Header */}
              <div className="bg-gradient-to-br from-purple-400 to-indigo-400 px-6 py-6 rounded-t-[20px]">
                <div className="flex items-center justify-between">
                  <div>
                    <h2 className="text-xl text-white mb-1">
                      {editingSite ? 'Edit Business Location' : 'Add Business Location'}
                    </h2>
                    <p className="text-white/80 text-sm">
                      {editingSite ? 'Update location details' : 'Add a new business location'}
                    </p>
                  </div>
                  <button
                    onClick={() => {
                      setShowSiteModal(false);
                      setEditingSite(null);
                      setSiteImagePreview('');
                      setSiteFormData({
                        locationName: '',
                        country: '',
                        city: '',
                        postalCode: '',
                        region: '',
                        streetAddress: '',
                        contactPerson: '',
                        email: '',
                        tel: '',
                        category: '',
                        description: '',
                        priceRange: 2,
                        hours: '',
                        deliveryType: [] as string[],
                        businessImage: '',
                      });
                    }}
                    className="w-8 h-8 rounded-full bg-white/20 backdrop-blur-sm flex items-center justify-center hover:bg-white/30 transition-colors"
                  >
                    <span className="text-white text-xl">×</span>
                  </button>
                </div>
              </div>

              {/* Form Content */}
              <div className="p-6 space-y-5 overflow-y-auto">
                <RomanticInput
                  label="Location Name *"
                  placeholder="e.g., Main Office, Branch 1"
                  value={siteFormData.locationName}
                  onChange={(e) => setSiteFormData({ ...siteFormData, locationName: e.target.value })}
                  required
                />

                <RomanticInput
                  label="Country *"
                  placeholder="e.g., United States"
                  value={siteFormData.country}
                  onChange={(e) => setSiteFormData({ ...siteFormData, country: e.target.value })}
                  required
                />

                <RomanticInput
                  label="City *"
                  placeholder="e.g., New York"
                  value={siteFormData.city}
                  onChange={(e) => setSiteFormData({ ...siteFormData, city: e.target.value })}
                  required
                />

                <RomanticInput
                  label="Postal Code *"
                  placeholder="e.g., 10001"
                  value={siteFormData.postalCode}
                  onChange={(e) => setSiteFormData({ ...siteFormData, postalCode: e.target.value })}
                  required
                />

                <RomanticInput
                  label="State/Region"
                  placeholder="e.g., New York (Optional)"
                  value={siteFormData.region}
                  onChange={(e) => setSiteFormData({ ...siteFormData, region: e.target.value })}
                />

                <RomanticInput
                  label="Street Address"
                  placeholder="e.g., 123 Main Street (Optional)"
                  value={siteFormData.streetAddress}
                  onChange={(e) => setSiteFormData({ ...siteFormData, streetAddress: e.target.value })}
                />

                <RomanticInput
                  label="Contact Person *"
                  placeholder="Full name of primary contact"
                  value={siteFormData.contactPerson}
                  onChange={(e) => setSiteFormData({ ...siteFormData, contactPerson: e.target.value })}
                  required
                />

                <RomanticInput
                  label="Email"
                  type="email"
                  placeholder="e.g., contact@yourbusiness.com"
                  value={siteFormData.email}
                  onChange={(e) => setSiteFormData({ ...siteFormData, email: e.target.value })}
                />

                <RomanticInput
                  label="Tel"
                  type="tel"
                  placeholder="(555) 123-4567"
                  value={siteFormData.tel}
                  onChange={(e) => setSiteFormData({ ...siteFormData, tel: e.target.value })}
                />

                <div>
                  <label className="block text-purple-700 mb-2 text-sm">
                    Product or Services Category *
                  </label>
                  <select
                    className="w-full px-6 py-4 bg-white/60 backdrop-blur-sm border-2 border-purple-100 rounded-[16px] 
                      focus:outline-none focus:border-purple-300 focus:bg-white/80 transition-all text-gray-700 appearance-none cursor-pointer"
                    style={{
                      backgroundImage: `url("data:image/svg+xml,%3Csvg xmlns='http://www.w3.org/2000/svg' width='12' height='12' viewBox='0 0 12 12'%3E%3Cpath fill='%239333ea' d='M6 9L1 4h10z'/%3E%3C/svg%3E")`,
                      backgroundRepeat: 'no-repeat',
                      backgroundPosition: 'right 1.5rem center',
                      backgroundSize: '12px'
                    }}
                    value={siteFormData.category}
                    onChange={(e) => setSiteFormData({ ...siteFormData, category: e.target.value })}
                    required
                  >
                    <option value="">Select a category</option>
                    {CATEGORIES.map((cat) => (
                      <option key={cat.value} value={cat.value}>
                        {cat.label}
                      </option>
                    ))}
                  </select>
                </div>

                <div>
                  <label className="block text-purple-700 mb-2 text-sm">Description</label>
                  <textarea
                    className="w-full px-6 py-4 bg-white/60 backdrop-blur-sm border-2 border-purple-100 rounded-[16px] 
                      focus:outline-none focus:border-purple-300 focus:bg-white/80 transition-all placeholder-purple-300 
                      text-gray-700 min-h-[80px]"
                    placeholder="What makes this location special..."
                    value={siteFormData.description}
                    onChange={(e) => setSiteFormData({ ...siteFormData, description: e.target.value })}
                  />
                </div>

                <div>
                  <label className="block text-purple-700 mb-2 text-sm font-medium">Price Range *</label>
                  <p className="text-xs text-purple-500 mb-4">This helps Cherish match your offerings to customers' expectations and budgets.</p>
                  
                  <div className="px-2">
                    <input
                      type="range"
                      min="1"
                      max="4"
                      value={siteFormData.priceRange}
                      onChange={(e) => setSiteFormData({...siteFormData, priceRange: parseInt(e.target.value)})}
                      className="w-full h-2 bg-gradient-to-r from-emerald-200 via-indigo-200 to-rose-200 rounded-full appearance-none cursor-pointer slider"
                      style={{
                        backgroundImage: `linear-gradient(to right, 
                          #10b981 0%, 
                          #10b981 ${((siteFormData.priceRange - 1) / 3) * 100}%, 
                          #e5e7eb ${((siteFormData.priceRange - 1) / 3) * 100}%, 
                          #e5e7eb 100%)`
                      }}
                    />
                    
                    {/* Labels */}
                    <div className="flex justify-between mt-3 text-xs">
                      <span className={`${siteFormData.priceRange === 1 ? 'text-emerald-600 font-semibold' : 'text-gray-400'}`}>
                        $ Budget
                      </span>
                      <span className={`${siteFormData.priceRange === 2 ? 'text-indigo-600 font-semibold' : 'text-gray-400'}`}>
                        $$ Moderate
                      </span>
                      <span className={`${siteFormData.priceRange === 3 ? 'text-purple-600 font-semibold' : 'text-gray-400'}`}>
                        $$$ Upscale
                      </span>
                      <span className={`${siteFormData.priceRange === 4 ? 'text-rose-600 font-semibold' : 'text-gray-400'}`}>
                        $$$$ Luxury
                      </span>
                    </div>

                    {/* Current Selection Display */}
                    <div className="mt-4 p-3 rounded-[12px] bg-gradient-to-br from-purple-50/50 to-indigo-50/50 border border-purple-100">
                      <p className="text-sm text-purple-700 text-center font-medium">
                        {siteFormData.priceRange === 1 && '💰 Budget Friendly ($0 - $50)'}
                        {siteFormData.priceRange === 2 && '✨ Moderate ($50 - $200)'}
                        {siteFormData.priceRange === 3 && '💎 Upscale ($200 - $500)'}
                        {siteFormData.priceRange === 4 && '👑 Luxury ($500+)'}
                      </p>
                    </div>
                  </div>
                </div>

                <div>
                  <label className="block text-purple-700 mb-2 text-sm">Operating Hours</label>
                  <p className="text-xs text-purple-500 mb-2">Lets customers know when they can visit, contact, or book your services.</p>
                  <RomanticInput
                    placeholder="e.g., Mon–Fri · 9:00 AM – 6:00 PM"
                    value={siteFormData.hours}
                    onChange={(e) => setSiteFormData({...siteFormData, hours: e.target.value})}
                  />
                </div>

                <div>
                  <label className="block text-purple-700 mb-2 text-sm font-medium">Delivery Type *</label>
                  <p className="text-xs text-purple-500 mb-3">Tell customers how your services or products can be accessed.</p>
                  
                  <div className="space-y-2">
                    <button
                      type="button"
                      onClick={() => toggleSiteDeliveryType('delivery')}
                      className={`w-full flex items-center gap-3 p-4 rounded-[16px] border-2 transition-all ${
                        Array.isArray(siteFormData.deliveryType) && siteFormData.deliveryType.includes('delivery')
                          ? 'bg-gradient-to-br from-purple-50 to-indigo-50 border-purple-300 shadow-sm'
                          : 'bg-white/60 border-purple-100 hover:border-purple-200'
                      }`}
                    >
                      <Truck className="w-5 h-5 text-purple-500" />
                      <div className="flex-1 text-left">
                        <p className={`text-sm font-medium ${
                          Array.isArray(siteFormData.deliveryType) && siteFormData.deliveryType.includes('delivery')
                            ? 'text-purple-700'
                            : 'text-gray-700'
                        }`}>
                          Delivery
                        </p>
                        <p className="text-xs text-gray-500">Items can be delivered to the customer</p>
                      </div>
                      {Array.isArray(siteFormData.deliveryType) && siteFormData.deliveryType.includes('delivery') && (
                        <div className="w-5 h-5 rounded-full bg-purple-500 flex items-center justify-center">
                          <svg className="w-3 h-3 text-white" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                            <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={3} d="M5 13l4 4L19 7" />
                          </svg>
                        </div>
                      )}
                    </button>

                    <button
                      type="button"
                      onClick={() => toggleSiteDeliveryType('on-site')}
                      className={`w-full flex items-center gap-3 p-4 rounded-[16px] border-2 transition-all ${
                        Array.isArray(siteFormData.deliveryType) && siteFormData.deliveryType.includes('on-site')
                          ? 'bg-gradient-to-br from-purple-50 to-indigo-50 border-purple-300 shadow-sm'
                          : 'bg-white/60 border-purple-100 hover:border-purple-200'
                      }`}
                    >
                      <MapPinned className="w-5 h-5 text-purple-500" />
                      <div className="flex-1 text-left">
                        <p className={`text-sm font-medium ${
                          Array.isArray(siteFormData.deliveryType) && siteFormData.deliveryType.includes('on-site')
                            ? 'text-purple-700'
                            : 'text-gray-700'
                        }`}>
                          On-site
                        </p>
                        <p className="text-xs text-gray-500">Services or experiences take place at your location</p>
                      </div>
                      {Array.isArray(siteFormData.deliveryType) && siteFormData.deliveryType.includes('on-site') && (
                        <div className="w-5 h-5 rounded-full bg-purple-500 flex items-center justify-center">
                          <svg className="w-3 h-3 text-white" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                            <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={3} d="M5 13l4 4L19 7" />
                          </svg>
                        </div>
                      )}
                    </button>

                    <button
                      type="button"
                      onClick={() => toggleSiteDeliveryType('digital')}
                      className={`w-full flex items-center gap-3 p-4 rounded-[16px] border-2 transition-all ${
                        Array.isArray(siteFormData.deliveryType) && siteFormData.deliveryType.includes('digital')
                          ? 'bg-gradient-to-br from-purple-50 to-indigo-50 border-purple-300 shadow-sm'
                          : 'bg-white/60 border-purple-100 hover:border-purple-200'
                      }`}
                    >
                      <Monitor className="w-5 h-5 text-purple-500" />
                      <div className="flex-1 text-left">
                        <p className={`text-sm font-medium ${
                          Array.isArray(siteFormData.deliveryType) && siteFormData.deliveryType.includes('digital')
                            ? 'text-purple-700'
                            : 'text-gray-700'
                        }`}>
                          Digital
                        </p>
                        <p className="text-xs text-gray-500">Online or digital services available</p>
                      </div>
                      {Array.isArray(siteFormData.deliveryType) && siteFormData.deliveryType.includes('digital') && (
                        <div className="w-5 h-5 rounded-full bg-purple-500 flex items-center justify-center">
                          <svg className="w-3 h-3 text-white" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                            <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={3} d="M5 13l4 4L19 7" />
                          </svg>
                        </div>
                      )}
                    </button>
                  </div>
                </div>

                <div>
                  <label className="block text-purple-700 mb-2 text-sm font-medium">Business Logo/Photo</label>
                  <p className="text-xs text-purple-500 mb-3">Upload a logo or photo to represent your business</p>
                  
                  <div className="relative">
                    <input
                      type="file"
                      id="site-business-image"
                      accept="image/*"
                      onChange={handleSiteImageChange}
                      className="hidden"
                    />
                    <label
                      htmlFor="site-business-image"
                      className="block cursor-pointer"
                    >
                      {siteImagePreview ? (
                        <div className="relative group">
                          <img
                            src={siteImagePreview}
                            alt="Business preview"
                            className="w-full h-48 object-cover rounded-[16px] border-2 border-purple-200"
                          />
                          <div className="absolute inset-0 bg-black/40 opacity-0 group-hover:opacity-100 transition-opacity rounded-[16px] flex items-center justify-center">
                            <div className="text-white text-center">
                              <Upload className="w-8 h-8 mx-auto mb-2" />
                              <p className="text-sm font-medium">Change Photo</p>
                            </div>
                          </div>
                        </div>
                      ) : (
                        <RomanticCard className="border-2 border-dashed border-purple-200 hover:border-purple-300 hover:bg-purple-50/30 transition-all">
                          <div className="flex flex-col items-center py-6 text-center">
                            <div className="w-16 h-16 rounded-full bg-gradient-to-br from-purple-100 to-indigo-100 flex items-center justify-center mb-3">
                              <Upload className="w-8 h-8 text-purple-400" />
                            </div>
                            <p className="text-purple-600 font-medium mb-1">Click to upload photo</p>
                            <p className="text-gray-400 text-xs">PNG, JPG up to 5MB</p>
                          </div>
                        </RomanticCard>
                      )}
                    </label>
                  </div>
                </div>

                <RomanticButton
                  fullWidth
                  type="button"
                  onClick={editingSite ? handleUpdateSite : handleAddSite}
                  disabled={!siteFormData.locationName.trim()}
                >
                  {editingSite ? 'Update Location' : 'Add Location'}
                </RomanticButton>
              </div>
            </motion.div>
          </motion.div>
        )}
      </AnimatePresence>

      {/* Sites List Modal */}
      <AnimatePresence>
        {showSitesList && (
          <motion.div
            className="fixed inset-0 bg-black/50 backdrop-blur-sm flex items-center justify-center z-50 px-6"
            initial={{ opacity: 0 }}
            animate={{ opacity: 1 }}
            exit={{ opacity: 0 }}
            onClick={() => setShowSitesList(false)}
          >
            <motion.div
              className="bg-white rounded-[20px] shadow-2xl max-w-md w-full max-h-[80vh] overflow-hidden"
              initial={{ scale: 0.9, y: 20 }}
              animate={{ scale: 1, y: 0 }}
              exit={{ scale: 0.9, y: 20 }}
              onClick={(e) => e.stopPropagation()}
            >
              <div className="bg-gradient-to-br from-purple-400 to-indigo-400 px-6 py-6">
                <div className="flex items-center justify-between">
                  <div>
                    <h2 className="text-xl text-white mb-1">Your Locations</h2>
                    <p className="text-white/80 text-sm">{sites.length} location{sites.length !== 1 ? 's' : ''}</p>
                  </div>
                  <button
                    onClick={() => setShowSitesList(false)}
                    className="w-8 h-8 rounded-full bg-white/20 backdrop-blur-sm flex items-center justify-center hover:bg-white/30 transition-colors"
                  >
                    <span className="text-white text-xl">×</span>
                  </button>
                </div>
              </div>

              <div className="p-6 overflow-y-auto max-h-[calc(80vh-180px)]">
                <div className="space-y-3">
                  {sites.map((site, index) => (
                    <motion.div
                      key={site.id}
                      initial={{ opacity: 0, y: 10 }}
                      animate={{ opacity: 1, y: 0 }}
                      transition={{ delay: index * 0.1 }}
                    >
                      <RomanticCard>
                        <div className="flex items-start justify-between gap-3">
                          <div className="flex-1">
                            <div className="flex items-center gap-2 mb-2">
                              <MapPin className="w-4 h-4 text-purple-400 flex-shrink-0" />
                              <p className="text-gray-800">{site.address}</p>
                            </div>
                            {site.phone && (
                              <p className="text-gray-600 text-sm mb-1 pl-6">{site.phone}</p>
                            )}
                            {site.description && (
                              <p className="text-gray-500 text-sm pl-6">{site.description}</p>
                            )}
                          </div>
                          <div className="flex gap-1">
                            <button
                              type="button"
                              onClick={() => handleEditSite(site)}
                              className="p-2 rounded-full hover:bg-purple-50 transition-all"
                            >
                              <Edit2 className="w-4 h-4 text-purple-500" />
                            </button>
                            <button
                              type="button"
                              onClick={() => handleDeleteSite(site.id)}
                              className="p-2 rounded-full hover:bg-red-50 transition-all"
                            >
                              <Trash2 className="w-4 h-4 text-red-400" />
                            </button>
                          </div>
                        </div>
                      </RomanticCard>
                    </motion.div>
                  ))}
                </div>
              </div>

              <div className="px-6 pb-6 pt-2 border-t border-gray-100">
                <button
                  type="button"
                  onClick={openAddSiteModal}
                  className="w-full flex items-center justify-center gap-2 py-3 px-4 rounded-[12px] border-2 border-purple-100 bg-white hover:bg-purple-50/50 text-purple-600 transition-all text-sm"
                >
                  <Plus className="w-4 h-4" />
                  <span>Add another business location</span>
                </button>
              </div>
            </motion.div>
          </motion.div>
        )}
      </AnimatePresence>

      {/* CSS for slider */}
      <style dangerouslySetInnerHTML={{ __html: `
        input[type="range"].slider::-webkit-slider-thumb {
          appearance: none;
          width: 24px;
          height: 24px;
          border-radius: 50%;
          background: linear-gradient(135deg, #a855f7, #ec4899);
          cursor: pointer;
          box-shadow: 0 4px 12px rgba(168, 85, 247, 0.4);
          border: 3px solid white;
        }
        
        input[type="range"].slider::-moz-range-thumb {
          width: 24px;
          height: 24px;
          border-radius: 50%;
          background: linear-gradient(135deg, #a855f7, #ec4899);
          cursor: pointer;
          box-shadow: 0 4px 12px rgba(168, 85, 247, 0.4);
          border: 3px solid white;
        }
      `}} />
    </div>
  );
}