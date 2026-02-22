import { useState, useEffect } from 'react';
import { useNavigate } from 'react-router';
import { User, Mail, Phone, MapPin, Edit2, LogOut, Store, Globe, Clock, DollarSign, ArrowLeft, Settings, Star, Camera, X, Truck, MapPinned, Monitor, MessageCircle, Plus, Trash2, Edit as EditIcon } from 'lucide-react';
import RomanticCard from '../../components/RomanticCard';
import RomanticInput from '../../components/RomanticInput';
import RomanticButton from '../../components/RomanticButton';
import { ImageWithFallback } from '../../components/figma/ImageWithFallback';
import { motion, AnimatePresence } from 'motion/react';
import { useBusiness } from '@/app/contexts/BusinessContext';
import whatsappIcon from 'figma:asset/bcec9e8c1009aabd0a6aa8c9756b7ac760d20b79.png';
import instagramIcon from 'figma:asset/d0f8caa05d569c2ed16ac0d05e749b5f1bed81ac.png';
import telegramIcon from 'figma:asset/fae96de532be20d303dc036129d2277974395b4f.png';
import facebookIcon from 'figma:asset/cc2007467cda7c7222349053d65f4942af04bada.png';
import redditIcon from 'figma:asset/304e161b73873014c33d9d8b3536f8a95d4690a1.png';
import snapchatIcon from 'figma:asset/05d31970f7d942a30da189743cd2e11233d02133.png';
import tiktokIcon from 'figma:asset/dac74f85ccf69143e439bee8dafc1b04e0d8bb8d.png';

const CATEGORIES = [
  { value: 'gifts', label: 'Gifts & Personalized Items' },
  { value: 'food', label: 'Food & Dining Experiences' },
  { value: 'wellness', label: 'Wellness & Self-Care Services' },
  { value: 'entertainment', label: 'Entertainment & Leisure' },
  { value: 'fashion', label: 'Fashion & Style' },
  { value: 'home', label: 'Home & Lifestyle' },
  { value: 'travel', label: 'Travel & Getaways' },
  { value: 'memories', label: 'Memories & Creative Services' },
  { value: 'family', label: 'Family & Children Services' },
  { value: 'learning', label: 'Learning & Personal Growth' },
];

const COUNTRIES = [
  'United States', 'Canada', 'United Kingdom', 'Australia', 'Germany',
  'France', 'Italy', 'Spain', 'Japan', 'China', 'India', 'Brazil',
  'Mexico', 'South Africa', 'Egypt', 'Nigeria', 'United Arab Emirates',
  'Singapore', 'Malaysia', 'New Zealand', 'Netherlands', 'Belgium',
  'Switzerland', 'Sweden', 'Norway', 'Denmark', 'Finland', 'Ireland',
  'Portugal', 'Greece', 'Poland', 'Czech Republic', 'Austria', 'Hungary',
  'Romania', 'South Korea', 'Thailand', 'Vietnam', 'Philippines',
  'Indonesia', 'Pakistan', 'Bangladesh', 'Turkey', 'Saudi Arabia',
  'Israel', 'Argentina', 'Chile', 'Colombia', 'Peru', 'Venezuela',
].sort();

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

export default function BusinessProfileScreen() {
  const navigate = useNavigate();
  const { business, setBusiness } = useBusiness();
  const [isEditing, setIsEditing] = useState(false);
  const [profilePhoto, setProfilePhoto] = useState('https://images.unsplash.com/photo-1758887261865-a2b89c0f7ac5?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w3Nzg4Nzd8MHwxfHNlYXJjaHwxfHxidXNpbmVzcyUyMG93bmVyJTIwcG9ydHJhaXR8ZW58MXx8fHwxNzY4MTM4MDY5fDA&ixlib=rb-4.1.0&q=80&w=1080&utm_source=figma&utm_medium=referral');
  const [businessImage, setBusinessImage] = useState('');
  const [siteImagePreview, setSiteImagePreview] = useState<string>('');
  
  const [profile, setProfile] = useState({
    businessName: business.businessName || 'Your Business',
    category: business.category || 'gifts',
    contactPersonName: business.contactPersonName || 'Business Owner',
    email: business.email || '',
    tel: business.tel || '',
    country: business.country || '',
    city: business.city || '',
    postalCode: business.postalCode || '',
    stateRegion: business.stateRegion || '',
    streetAddress: business.streetAddress || '',
    website: business.website || '',
    description: business.description || '',
    priceRange: business.priceRange || 2,
    hours: business.hours || '',
    deliveryType: business.deliveryType || [],
    whatsapp: business.whatsapp || '',
    telegram: business.telegram || '',
    instagram: business.instagram || '',
    facebook: business.facebook || '',
    reddit: business.reddit || '',
    snapchat: business.snapchat || '',
    tiktok: business.tiktok || '',
  });

  const [sites, setSites] = useState<Site[]>(business.sites || []);
  const [showSiteModal, setShowSiteModal] = useState(false);
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

  useEffect(() => {
    if (business.businessImage) {
      setBusinessImage(business.businessImage);
    }
  }, [business]);

  const handlePhotoUpload = (e: React.ChangeEvent<HTMLInputElement>) => {
    const file = e.target.files?.[0];
    if (file) {
      const reader = new FileReader();
      reader.onloadend = () => {
        setProfilePhoto(reader.result as string);
      };
      reader.readAsDataURL(file);
    }
  };

  const handleBusinessImageUpload = (e: React.ChangeEvent<HTMLInputElement>) => {
    const file = e.target.files?.[0];
    if (file) {
      if (file.size > 5 * 1024 * 1024) {
        alert('File size must be less than 5MB');
        return;
      }
      const reader = new FileReader();
      reader.onloadend = () => {
        setBusinessImage(reader.result as string);
      };
      reader.readAsDataURL(file);
    }
  };

  const handleSiteImageUpload = (e: React.ChangeEvent<HTMLInputElement>) => {
    const file = e.target.files?.[0];
    if (file) {
      if (file.size > 5 * 1024 * 1024) {
        alert('File size must be less than 5MB');
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

  const toggleDeliveryType = (type: string) => {
    const currentTypes = Array.isArray(profile.deliveryType) ? profile.deliveryType : [];
    if (currentTypes.includes(type)) {
      setProfile({ ...profile, deliveryType: currentTypes.filter(t => t !== type) });
    } else {
      setProfile({ ...profile, deliveryType: [...currentTypes, type] });
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

  const handleSaveChanges = () => {
    setBusiness({
      ...business,
      businessName: profile.businessName,
      category: profile.category,
      contactPersonName: profile.contactPersonName,
      email: profile.email,
      tel: profile.tel,
      country: profile.country,
      city: profile.city,
      postalCode: profile.postalCode,
      stateRegion: profile.stateRegion,
      streetAddress: profile.streetAddress,
      website: profile.website,
      description: profile.description,
      priceRange: profile.priceRange,
      hours: profile.hours,
      deliveryType: profile.deliveryType,
      businessImage: businessImage,
      whatsapp: profile.whatsapp,
      telegram: profile.telegram,
      instagram: profile.instagram,
      facebook: profile.facebook,
      reddit: profile.reddit,
      snapchat: profile.snapchat,
      tiktok: profile.tiktok,
      sites: sites,
    });
    
    setIsEditing(false);
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
      setSiteFormData({ locationName: '', country: '', city: '', postalCode: '', region: '', streetAddress: '', contactPerson: '', email: '', tel: '', category: '', description: '', priceRange: 2, hours: '', deliveryType: [] as string[], businessImage: '' });
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
      setSiteFormData({ locationName: '', country: '', city: '', postalCode: '', region: '', streetAddress: '', contactPerson: '', email: '', tel: '', category: '', description: '', priceRange: 2, hours: '', deliveryType: [] as string[], businessImage: '' });
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
  };

  const handleDeleteSite = (siteId: string) => {
    setSites(sites.filter(site => site.id !== siteId));
  };

  const openAddSiteModal = () => {
    setEditingSite(null);
    setSiteFormData({ locationName: '', country: '', city: '', postalCode: '', region: '', streetAddress: '', contactPerson: '', email: '', tel: '', category: '', description: '', priceRange: 2, hours: '', deliveryType: [] as string[], businessImage: '' });
    setShowSiteModal(true);
  };

  const getCategoryLabel = (value: string) => {
    const category = CATEGORIES.find(cat => cat.value === value);
    return category ? category.label : value;
  };

  const getPriceRangeLabel = (value: number) => {
    switch(value) {
      case 1: return '💰 Budget Friendly ($0 - $50)';
      case 2: return '✨ Moderate ($50 - $200)';
      case 3: return '💎 Upscale ($200 - $500)';
      case 4: return '👑 Luxury ($500+)';
      default: return '✨ Moderate';
    }
  };

  return (
    <div className="min-h-screen bg-gradient-to-b from-purple-50/30 to-white pb-24">
      {/* Header with gradient */}
      <div className="bg-gradient-to-br from-purple-400 via-purple-500 to-indigo-500 px-5 pt-12 pb-16 relative overflow-hidden">
        {/* Decorative elements */}
        <div className="absolute top-0 right-0 w-40 h-40 bg-white/10 rounded-full blur-3xl"></div>
        <div className="absolute bottom-0 left-0 w-32 h-32 bg-white/10 rounded-full blur-2xl"></div>
        
        <div className="relative z-10">
          <div className="flex items-center justify-between mb-8">
            <motion.button
              onClick={() => navigate('/business/dashboard')}
              className="flex items-center gap-2 px-4 py-2.5 rounded-full bg-white shadow-xl hover:shadow-2xl transition-all border-2 border-purple-200 z-50"
              initial={{ opacity: 0, x: -20 }}
              animate={{ opacity: 1, x: 0 }}
              whileHover={{ scale: 1.05 }}
              whileTap={{ scale: 0.95 }}
            >
              <ArrowLeft className="w-5 h-5 text-purple-600" />
              <span className="text-purple-600 font-semibold">Back</span>
            </motion.button>
            <h1 className="text-white font-semibold">{isEditing ? 'Edit Profile' : 'Business Profile'}</h1>
            <motion.button
              onClick={() => isEditing ? setIsEditing(false) : setIsEditing(true)}
              className={`w-10 h-10 rounded-full backdrop-blur-sm flex items-center justify-center transition-all border-2 ${
                isEditing 
                  ? 'bg-white border-white shadow-lg' 
                  : 'bg-white/20 border-white/30 hover:bg-white/30'
              }`}
              whileHover={{ scale: 1.05 }}
              whileTap={{ scale: 0.95 }}
              animate={{
                rotate: isEditing ? 180 : 0,
              }}
              transition={{ duration: 0.3 }}
            >
              {isEditing ? (
                <X className="w-5 h-5 text-purple-600" />
              ) : (
                <Edit2 className="w-5 h-5 text-white" />
              )}
            </motion.button>
          </div>
          
          {/* Profile Photo and Info */}
          <div className="flex flex-col items-center">
            <div className="relative mb-4">
              <div className="w-20 h-20 rounded-2xl overflow-hidden border-3 border-white shadow-lg bg-white">
                <ImageWithFallback
                  src={profilePhoto}
                  alt="Business Owner"
                  className="w-full h-full object-cover"
                />
              </div>
              {/* Camera Upload Button */}
              {isEditing && (
                <label className="absolute -bottom-1.5 -right-1.5 w-7 h-7 bg-purple-600 rounded-lg flex items-center justify-center shadow-md cursor-pointer hover:bg-purple-700 transition-colors">
                  <Camera className="w-3.5 h-3.5 text-white" />
                  <input
                    type="file"
                    accept="image/*"
                    onChange={handlePhotoUpload}
                    className="hidden"
                  />
                </label>
              )}
            </div>
            <h2 className="text-white text-xl font-medium mb-1">{profile.businessName}</h2>
            <p className="text-white/80 text-sm mb-3">{profile.contactPersonName}</p>
            <div className="flex items-center gap-1.5 bg-amber-400/20 px-3 py-1.5 rounded-full">
              <Star className="w-3.5 h-3.5 text-amber-300 fill-amber-300" />
              <span className="text-amber-100 text-xs font-medium">Premium Partner</span>
            </div>
          </div>
        </div>
      </div>

      <div className="px-5 -mt-12 space-y-4">
        {/* Basic Information Card */}
        <RomanticCard gradient>
          <h3 className="text-gray-800 font-medium mb-4 flex items-center gap-2">
            <Store className="w-4.5 h-4.5 text-purple-400" />
            Basic Information
          </h3>

          {!isEditing ? (
            <div className="space-y-4">
              <div className="flex items-start gap-3">
                <div className="flex-1">
                  <p className="text-xs text-gray-500 mb-0.5">Business Name</p>
                  <p className="text-gray-800 text-sm font-medium">{profile.businessName}</p>
                </div>
              </div>

              <div className="flex items-start gap-3">
                <div className="flex-1">
                  <p className="text-xs text-gray-500 mb-0.5">Category</p>
                  <p className="text-gray-800 text-sm">{getCategoryLabel(profile.category)}</p>
                </div>
              </div>

              <div className="flex items-start gap-3">
                <div className="flex-1">
                  <p className="text-xs text-gray-500 mb-0.5">Contact Person</p>
                  <p className="text-gray-800 text-sm">{profile.contactPersonName}</p>
                </div>
              </div>

              <div className="flex items-start gap-3">
                <div className="flex-1">
                  <p className="text-xs text-gray-500 mb-0.5">Description</p>
                  <p className="text-gray-800 text-sm leading-relaxed">{profile.description || 'No description provided'}</p>
                </div>
              </div>
            </div>
          ) : (
            <div className="space-y-3">
              <div>
                <label className="text-xs text-gray-600 mb-1.5 block">Business Name *</label>
                <RomanticInput 
                  value={profile.businessName} 
                  onChange={(e) => setProfile({...profile, businessName: e.target.value})} 
                  placeholder="Enter business name"
                />
              </div>
              
              <div>
                <label className="text-xs text-gray-600 mb-1.5 block">Category *</label>
                <select
                  className="w-full px-4 py-3 bg-white/60 backdrop-blur-sm border-2 border-rose-100 rounded-[16px] 
                    focus:outline-none focus:border-rose-400 transition-all text-gray-700 text-sm"
                  value={profile.category}
                  onChange={(e) => setProfile({...profile, category: e.target.value})}
                >
                  {CATEGORIES.map((cat) => (
                    <option key={cat.value} value={cat.value}>{cat.label}</option>
                  ))}
                </select>
              </div>

              <div>
                <label className="text-xs text-gray-600 mb-1.5 block">Contact Person *</label>
                <RomanticInput 
                  value={profile.contactPersonName} 
                  onChange={(e) => setProfile({...profile, contactPersonName: e.target.value})} 
                  placeholder="Contact person name"
                />
              </div>

              <div>
                <label className="text-xs text-gray-600 mb-1.5 block">Description</label>
                <textarea
                  value={profile.description}
                  onChange={(e) => setProfile({...profile, description: e.target.value})}
                  placeholder="Tell customers about your business..."
                  rows={3}
                  className="w-full px-4 py-3 bg-white/60 backdrop-blur-sm border-2 border-rose-100 rounded-[16px] 
                    focus:outline-none focus:border-rose-400 transition-all text-gray-700 text-sm resize-none"
                />
              </div>
            </div>
          )}
        </RomanticCard>

        {/* Contact Information Card */}
        <RomanticCard>
          <h3 className="text-gray-800 font-medium mb-4 flex items-center gap-2">
            <Mail className="w-4.5 h-4.5 text-purple-400" />
            Contact Information
          </h3>

          {!isEditing ? (
            <div className="space-y-4">
              <div className="flex items-start gap-3">
                <div className="w-10 h-10 rounded-xl bg-purple-50 flex items-center justify-center flex-shrink-0 mt-0.5">
                  <Mail className="w-4.5 h-4.5 text-purple-400" />
                </div>
                <div className="flex-1 pt-1">
                  <p className="text-xs text-gray-500 mb-0.5">Email</p>
                  <p className="text-gray-800 text-sm">{profile.email || 'Not provided'}</p>
                </div>
              </div>

              <div className="flex items-start gap-3">
                <div className="w-10 h-10 rounded-xl bg-indigo-50 flex items-center justify-center flex-shrink-0 mt-0.5">
                  <Phone className="w-4.5 h-4.5 text-indigo-400" />
                </div>
                <div className="flex-1 pt-1">
                  <p className="text-xs text-gray-500 mb-0.5">Phone</p>
                  <p className="text-gray-800 text-sm">{profile.tel || 'Not provided'}</p>
                </div>
              </div>

              <div className="flex items-start gap-3">
                <div className="w-10 h-10 rounded-xl bg-green-50 flex items-center justify-center flex-shrink-0 mt-0.5">
                  <Globe className="w-4.5 h-4.5 text-green-400" />
                </div>
                <div className="flex-1 pt-1">
                  <p className="text-xs text-gray-500 mb-0.5">Website</p>
                  <p className="text-gray-800 text-sm">{profile.website || 'Not provided'}</p>
                </div>
              </div>
            </div>
          ) : (
            <div className="space-y-3">
              <div>
                <label className="text-xs text-gray-600 mb-1.5 block">Email</label>
                <RomanticInput 
                  type="email"
                  value={profile.email} 
                  onChange={(e) => setProfile({...profile, email: e.target.value})} 
                  placeholder="email@example.com"
                />
              </div>
              <div>
                <label className="text-xs text-gray-600 mb-1.5 block">Phone</label>
                <RomanticInput 
                  type="tel"
                  value={profile.tel} 
                  onChange={(e) => setProfile({...profile, tel: e.target.value})} 
                  placeholder="+1 (555) 123-4567"
                />
              </div>
              <div>
                <label className="text-xs text-gray-600 mb-1.5 block">Website</label>
                <RomanticInput 
                  type="url"
                  value={profile.website} 
                  onChange={(e) => setProfile({...profile, website: e.target.value})} 
                  placeholder="https://yourbusiness.com"
                />
              </div>
            </div>
          )}
        </RomanticCard>

        {/* Location Card */}
        <RomanticCard>
          <h3 className="text-gray-800 font-medium mb-4 flex items-center gap-2">
            <MapPin className="w-4.5 h-4.5 text-purple-400" />
            Location
          </h3>

          {!isEditing ? (
            <div className="space-y-4">
              <div className="flex items-start gap-3">
                <div className="flex-1">
                  <p className="text-xs text-gray-500 mb-0.5">Main Address</p>
                  <p className="text-gray-800 text-sm leading-relaxed">
                    {profile.streetAddress && `${profile.streetAddress}, `}
                    {profile.city}{profile.stateRegion && `, ${profile.stateRegion}`}
                    {profile.postalCode && ` ${profile.postalCode}`}
                    {profile.country && `, ${profile.country}`}
                  </p>
                </div>
              </div>

              {sites.length > 0 && (
                <div>
                  <p className="text-xs text-gray-500 mb-2">Additional Locations ({sites.length})</p>
                  <div className="space-y-2">
                    {sites.map((site) => (
                      <div key={site.id} className="p-3 bg-purple-50 rounded-xl">
                        <p className="text-sm text-gray-800 font-medium mb-1">{site.locationName}</p>
                        <p className="text-xs text-gray-600">
                          {site.streetAddress && `${site.streetAddress}, `}
                          {site.city}{site.region && `, ${site.region}`}
                          {site.postalCode && ` ${site.postalCode}`}
                          {site.country && `, ${site.country}`}
                        </p>
                        {site.tel && <p className="text-xs text-gray-600 mt-1">📞 {site.tel}</p>}
                        {site.description && <p className="text-xs text-gray-500 mt-1">{site.description}</p>}
                      </div>
                    ))}
                  </div>
                </div>
              )}
            </div>
          ) : (
            <div className="space-y-3">
              <div>
                <label className="text-xs text-gray-600 mb-1.5 block">Country *</label>
                <select
                  className="w-full px-4 py-3 bg-white/60 backdrop-blur-sm border-2 border-rose-100 rounded-[16px] 
                    focus:outline-none focus:border-rose-400 transition-all text-gray-700 text-sm"
                  value={profile.country}
                  onChange={(e) => setProfile({...profile, country: e.target.value})}
                >
                  <option value="">Select a country</option>
                  {COUNTRIES.map((country) => (
                    <option key={country} value={country}>{country}</option>
                  ))}
                </select>
              </div>

              <div className="grid grid-cols-2 gap-3">
                <div>
                  <label className="text-xs text-gray-600 mb-1.5 block">City *</label>
                  <RomanticInput 
                    value={profile.city} 
                    onChange={(e) => setProfile({...profile, city: e.target.value})} 
                    placeholder="City"
                  />
                </div>
                <div>
                  <label className="text-xs text-gray-600 mb-1.5 block">Postal Code *</label>
                  <RomanticInput 
                    value={profile.postalCode} 
                    onChange={(e) => setProfile({...profile, postalCode: e.target.value})} 
                    placeholder="12345"
                  />
                </div>
              </div>

              <div>
                <label className="text-xs text-gray-600 mb-1.5 block">State/Region</label>
                <RomanticInput 
                  value={profile.stateRegion} 
                  onChange={(e) => setProfile({...profile, stateRegion: e.target.value})} 
                  placeholder="State or region"
                />
              </div>

              <div>
                <label className="text-xs text-gray-600 mb-1.5 block">Street Address</label>
                <RomanticInput 
                  value={profile.streetAddress} 
                  onChange={(e) => setProfile({...profile, streetAddress: e.target.value})} 
                  placeholder="123 Main Street"
                />
              </div>

              {/* Additional Locations Management */}
              <div>
                <label className="text-xs text-gray-600 mb-2 block">Additional Locations</label>
                {sites.length > 0 && (
                  <div className="space-y-2 mb-3">
                    {sites.map((site) => (
                      <div key={site.id} className="flex items-start gap-2 p-3 bg-purple-50 rounded-xl">
                        <div className="flex-1">
                          <p className="text-sm text-gray-800 font-medium">{site.locationName}</p>
                          <p className="text-xs text-gray-600 mt-0.5">
                            {site.city}{site.country && `, ${site.country}`}
                          </p>
                          {site.tel && <p className="text-xs text-gray-600 mt-0.5">📞 {site.tel}</p>}
                        </div>
                        <button
                          onClick={() => handleEditSite(site)}
                          className="p-1.5 hover:bg-purple-100 rounded-lg transition-colors"
                        >
                          <EditIcon className="w-4 h-4 text-purple-500" />
                        </button>
                        <button
                          onClick={() => handleDeleteSite(site.id)}
                          className="p-1.5 hover:bg-red-100 rounded-lg transition-colors"
                        >
                          <Trash2 className="w-4 h-4 text-red-500" />
                        </button>
                      </div>
                    ))}
                  </div>
                )}
                <button
                  onClick={openAddSiteModal}
                  className="w-full flex items-center justify-center gap-2 py-2.5 px-4 rounded-xl border-2 border-purple-200 bg-white hover:bg-purple-50 text-purple-600 transition-all text-sm"
                >
                  <Plus className="w-4 h-4" />
                  <span>Add Location</span>
                </button>
              </div>
            </div>
          )}
        </RomanticCard>

        {/* Business Details Card */}
        <RomanticCard>
          <h3 className="text-gray-800 font-medium mb-4 flex items-center gap-2">
            <Clock className="w-4.5 h-4.5 text-purple-400" />
            Business Details
          </h3>

          {!isEditing ? (
            <div className="space-y-4">
              <div className="flex items-start gap-3">
                <div className="w-10 h-10 rounded-xl bg-amber-50 flex items-center justify-center flex-shrink-0 mt-0.5">
                  <Clock className="w-4.5 h-4.5 text-amber-400" />
                </div>
                <div className="flex-1 pt-1">
                  <p className="text-xs text-gray-500 mb-0.5">Operating Hours</p>
                  <p className="text-gray-800 text-sm">{profile.hours || 'Not specified'}</p>
                </div>
              </div>

              <div className="flex items-start gap-3">
                <div className="w-10 h-10 rounded-xl bg-pink-50 flex items-center justify-center flex-shrink-0 mt-0.5">
                  <DollarSign className="w-4.5 h-4.5 text-pink-400" />
                </div>
                <div className="flex-1 pt-1">
                  <p className="text-xs text-gray-500 mb-0.5">Price Range</p>
                  <p className="text-gray-800 text-sm">{getPriceRangeLabel(profile.priceRange)}</p>
                </div>
              </div>

              <div className="flex items-start gap-3">
                <div className="w-10 h-10 rounded-xl bg-blue-50 flex items-center justify-center flex-shrink-0 mt-0.5">
                  <Truck className="w-4.5 h-4.5 text-blue-400" />
                </div>
                <div className="flex-1 pt-1">
                  <p className="text-xs text-gray-500 mb-0.5">Delivery Type</p>
                  <div className="flex flex-wrap gap-2 mt-1">
                    {Array.isArray(profile.deliveryType) && profile.deliveryType.length > 0 ? (
                      profile.deliveryType.map((type) => (
                        <span key={type} className="px-2 py-1 bg-purple-100 text-purple-700 rounded-lg text-xs">
                          {type === 'delivery' && '🚚 Delivery'}
                          {type === 'on-site' && '📍 On-site'}
                          {type === 'digital' && '💻 Digital'}
                        </span>
                      ))
                    ) : (
                      <span className="text-gray-800 text-sm">Not specified</span>
                    )}
                  </div>
                </div>
              </div>
            </div>
          ) : (
            <div className="space-y-3">
              <div>
                <label className="text-xs text-gray-600 mb-1.5 block">Operating Hours</label>
                <RomanticInput 
                  value={profile.hours} 
                  onChange={(e) => setProfile({...profile, hours: e.target.value})} 
                  placeholder="e.g., Mon–Fri · 9:00 AM – 6:00 PM"
                />
              </div>

              <div>
                <label className="text-xs text-gray-600 mb-2 block">Price Range</label>
                <input
                  type="range"
                  min="1"
                  max="4"
                  value={profile.priceRange}
                  onChange={(e) => setProfile({...profile, priceRange: parseInt(e.target.value)})}
                  className="w-full h-2 bg-gradient-to-r from-emerald-200 to-rose-200 rounded-full appearance-none cursor-pointer"
                />
                <div className="flex justify-between mt-2 text-xs text-gray-500">
                  <span>$ Budget</span>
                  <span>$$ Moderate</span>
                  <span>$$$ Upscale</span>
                  <span>$$$$ Luxury</span>
                </div>
                <p className="text-sm text-purple-700 text-center mt-2 font-medium">
                  {getPriceRangeLabel(profile.priceRange)}
                </p>
              </div>

              <div>
                <label className="text-xs text-gray-600 mb-2 block">Delivery Type</label>
                <div className="space-y-2">
                  <button
                    type="button"
                    onClick={() => toggleDeliveryType('delivery')}
                    className={`w-full flex items-center gap-3 p-3 rounded-xl border-2 transition-all ${
                      Array.isArray(profile.deliveryType) && profile.deliveryType.includes('delivery')
                        ? 'bg-purple-50 border-purple-300'
                        : 'bg-white border-gray-200'
                    }`}
                  >
                    <Truck className="w-4 h-4 text-purple-500" />
                    <span className={`text-sm flex-1 text-left ${
                      Array.isArray(profile.deliveryType) && profile.deliveryType.includes('delivery')
                        ? 'text-purple-700 font-medium'
                        : 'text-gray-700'
                    }`}>Delivery</span>
                  </button>

                  <button
                    type="button"
                    onClick={() => toggleDeliveryType('on-site')}
                    className={`w-full flex items-center gap-3 p-3 rounded-xl border-2 transition-all ${
                      Array.isArray(profile.deliveryType) && profile.deliveryType.includes('on-site')
                        ? 'bg-purple-50 border-purple-300'
                        : 'bg-white border-gray-200'
                    }`}
                  >
                    <MapPinned className="w-4 h-4 text-purple-500" />
                    <span className={`text-sm flex-1 text-left ${
                      Array.isArray(profile.deliveryType) && profile.deliveryType.includes('on-site')
                        ? 'text-purple-700 font-medium'
                        : 'text-gray-700'
                    }`}>On-site</span>
                  </button>

                  <button
                    type="button"
                    onClick={() => toggleDeliveryType('digital')}
                    className={`w-full flex items-center gap-3 p-3 rounded-xl border-2 transition-all ${
                      Array.isArray(profile.deliveryType) && profile.deliveryType.includes('digital')
                        ? 'bg-purple-50 border-purple-300'
                        : 'bg-white border-gray-200'
                    }`}
                  >
                    <Monitor className="w-4 h-4 text-purple-500" />
                    <span className={`text-sm flex-1 text-left ${
                      Array.isArray(profile.deliveryType) && profile.deliveryType.includes('digital')
                        ? 'text-purple-700 font-medium'
                        : 'text-gray-700'
                    }`}>Digital</span>
                  </button>
                </div>
              </div>
            </div>
          )}
        </RomanticCard>

        {/* Business Photo Card */}
        {isEditing && (
          <RomanticCard>
            <h3 className="text-gray-800 font-medium mb-4 flex items-center gap-2">
              <Camera className="w-4.5 h-4.5 text-purple-400" />
              Business Logo/Photo
            </h3>

            <div>
              {businessImage ? (
                <div className="relative">
                  <img
                    src={businessImage}
                    alt="Business"
                    className="w-full h-48 object-cover rounded-xl border-2 border-purple-200"
                  />
                  <label
                    htmlFor="business-image-upload"
                    className="absolute inset-0 bg-black/40 opacity-0 hover:opacity-100 transition-opacity rounded-xl flex items-center justify-center cursor-pointer"
                  >
                    <div className="text-white text-center">
                      <Camera className="w-8 h-8 mx-auto mb-2" />
                      <p className="text-sm font-medium">Change Photo</p>
                    </div>
                  </label>
                </div>
              ) : (
                <label
                  htmlFor="business-image-upload"
                  className="flex flex-col items-center justify-center w-full h-48 border-2 border-dashed border-purple-300 rounded-xl cursor-pointer bg-purple-50/30 hover:bg-purple-50/50 transition-all"
                >
                  <Camera className="w-12 h-12 text-purple-400 mb-3" />
                  <span className="text-gray-600 font-medium text-sm">Click to upload photo</span>
                  <span className="text-xs text-gray-500 mt-1">PNG, JPG up to 5MB</span>
                </label>
              )}
              <input
                type="file"
                id="business-image-upload"
                accept="image/*"
                onChange={handleBusinessImageUpload}
                className="hidden"
              />
            </div>
          </RomanticCard>
        )}

        {/* Social Media Card */}
        <RomanticCard className="bg-gradient-to-br from-purple-50/40 to-pink-50/40">
          <h3 className="text-gray-800 font-medium mb-4 flex items-center gap-2">
            <MessageCircle className="w-4.5 h-4.5 text-purple-400" />
            Social Media & Messaging
          </h3>

          {!isEditing ? (
            <div className="space-y-3">
              {profile.whatsapp && (
                <div className="flex items-center gap-3">
                  <img src={whatsappIcon} alt="WhatsApp" className="w-8 h-8" />
                  <span className="text-sm text-gray-700">{profile.whatsapp}</span>
                </div>
              )}
              {profile.telegram && (
                <div className="flex items-center gap-3">
                  <img src={telegramIcon} alt="Telegram" className="w-8 h-8" />
                  <span className="text-sm text-gray-700">{profile.telegram}</span>
                </div>
              )}
              {profile.instagram && (
                <div className="flex items-center gap-3">
                  <img src={instagramIcon} alt="Instagram" className="w-8 h-8" />
                  <span className="text-sm text-gray-700">{profile.instagram}</span>
                </div>
              )}
              {profile.facebook && (
                <div className="flex items-center gap-3">
                  <img src={facebookIcon} alt="Facebook" className="w-8 h-8" />
                  <span className="text-sm text-gray-700">{profile.facebook}</span>
                </div>
              )}
              {profile.reddit && (
                <div className="flex items-center gap-3">
                  <img src={redditIcon} alt="Reddit" className="w-8 h-8" />
                  <span className="text-sm text-gray-700">{profile.reddit}</span>
                </div>
              )}
              {profile.snapchat && (
                <div className="flex items-center gap-3">
                  <img src={snapchatIcon} alt="Snapchat" className="w-8 h-8" />
                  <span className="text-sm text-gray-700">{profile.snapchat}</span>
                </div>
              )}
              {profile.tiktok && (
                <div className="flex items-center gap-3">
                  <img src={tiktokIcon} alt="TikTok" className="w-8 h-8" />
                  <span className="text-sm text-gray-700">{profile.tiktok}</span>
                </div>
              )}
              {!profile.whatsapp && !profile.telegram && !profile.instagram && 
               !profile.facebook && !profile.reddit && !profile.snapchat && !profile.tiktok && (
                <p className="text-sm text-gray-500 italic">No social media connected</p>
              )}
            </div>
          ) : (
            <div className="space-y-2">
              <div className="flex items-center gap-2">
                <img src={whatsappIcon} alt="WhatsApp" className="w-8 h-8" />
                <RomanticInput
                  value={profile.whatsapp}
                  onChange={(e) => setProfile({...profile, whatsapp: e.target.value})}
                  placeholder="WhatsApp"
                  className="flex-1"
                />
              </div>
              <div className="flex items-center gap-2">
                <img src={telegramIcon} alt="Telegram" className="w-8 h-8" />
                <RomanticInput
                  value={profile.telegram}
                  onChange={(e) => setProfile({...profile, telegram: e.target.value})}
                  placeholder="Telegram"
                  className="flex-1"
                />
              </div>
              <div className="flex items-center gap-2">
                <img src={instagramIcon} alt="Instagram" className="w-8 h-8" />
                <RomanticInput
                  value={profile.instagram}
                  onChange={(e) => setProfile({...profile, instagram: e.target.value})}
                  placeholder="Instagram"
                  className="flex-1"
                />
              </div>
              <div className="flex items-center gap-2">
                <img src={facebookIcon} alt="Facebook" className="w-8 h-8" />
                <RomanticInput
                  value={profile.facebook}
                  onChange={(e) => setProfile({...profile, facebook: e.target.value})}
                  placeholder="Facebook"
                  className="flex-1"
                />
              </div>
              <div className="flex items-center gap-2">
                <img src={redditIcon} alt="Reddit" className="w-8 h-8" />
                <RomanticInput
                  value={profile.reddit}
                  onChange={(e) => setProfile({...profile, reddit: e.target.value})}
                  placeholder="Reddit"
                  className="flex-1"
                />
              </div>
              <div className="flex items-center gap-2">
                <img src={snapchatIcon} alt="Snapchat" className="w-8 h-8" />
                <RomanticInput
                  value={profile.snapchat}
                  onChange={(e) => setProfile({...profile, snapchat: e.target.value})}
                  placeholder="Snapchat"
                  className="flex-1"
                />
              </div>
              <div className="flex items-center gap-2">
                <img src={tiktokIcon} alt="TikTok" className="w-8 h-8" />
                <RomanticInput
                  value={profile.tiktok}
                  onChange={(e) => setProfile({...profile, tiktok: e.target.value})}
                  placeholder="TikTok"
                  className="flex-1"
                />
              </div>
            </div>
          )}
        </RomanticCard>

        {/* Save Button - Only show when editing */}
        {isEditing && (
          <motion.div
            initial={{ opacity: 0, y: 20 }}
            animate={{ opacity: 1, y: 0 }}
            className="sticky bottom-6"
          >
            <RomanticButton fullWidth onClick={handleSaveChanges}>
              💾 Save All Changes
            </RomanticButton>
          </motion.div>
        )}

        {/* Settings & Logout - Only show when NOT editing */}
        {!isEditing && (
          <>
            <RomanticCard>
              <button
                className="w-full flex items-center justify-center gap-2.5 py-3 text-gray-700 hover:bg-purple-50 rounded-xl transition-colors"
              >
                <Settings className="w-4.5 h-4.5" />
                <span className="text-sm font-medium">Account Settings</span>
              </button>
            </RomanticCard>

            <RomanticCard>
              <button
                onClick={() => navigate('/')}
                className="w-full flex items-center justify-center gap-2.5 py-3 text-rose-500 hover:bg-rose-50 rounded-xl transition-colors"
              >
                <LogOut className="w-4.5 h-4.5" />
                <span className="text-sm font-medium">Log Out</span>
              </button>
            </RomanticCard>
          </>
        )}
      </div>

      {/* Add/Edit Site Modal */}
      <AnimatePresence>
        {showSiteModal && (
          <motion.div
            className="fixed inset-0 bg-black/50 backdrop-blur-sm flex items-center justify-center z-50 px-6 py-6 overflow-y-auto"
            initial={{ opacity: 0 }}
            animate={{ opacity: 1 }}
            exit={{ opacity: 0 }}
            onClick={() => {
              setShowSiteModal(false);
              setEditingSite(null);
              setSiteFormData({ locationName: '', country: '', city: '', postalCode: '', region: '', streetAddress: '', contactPerson: '', email: '', tel: '', category: '', description: '', priceRange: 2, hours: '', deliveryType: [] as string[], businessImage: '' });
            }}
          >
            <motion.div
              className="bg-white rounded-[20px] shadow-2xl max-w-md w-full my-auto max-h-[90vh] overflow-y-auto"
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
                      {editingSite ? 'Edit Location' : 'Add Location'}
                    </h2>
                    <p className="text-white/80 text-sm">
                      {editingSite ? 'Update location details' : 'Add a new business location'}
                    </p>
                  </div>
                  <button
                    onClick={() => {
                      setShowSiteModal(false);
                      setEditingSite(null);
                      setSiteFormData({ locationName: '', country: '', city: '', postalCode: '', region: '', streetAddress: '', contactPerson: '', email: '', tel: '', category: '', description: '', priceRange: 2, hours: '', deliveryType: [] as string[], businessImage: '' });
                    }}
                    className="w-8 h-8 rounded-full bg-white/20 backdrop-blur-sm flex items-center justify-center hover:bg-white/30 transition-colors"
                  >
                    <X className="w-5 h-5 text-white" />
                  </button>
                </div>
              </div>

              {/* Form Content */}
              <div className="p-6 space-y-4">
                <div>
                  <label className="text-xs text-gray-600 mb-1.5 block">Location Name *</label>
                  <RomanticInput
                    placeholder="Location Name"
                    value={siteFormData.locationName}
                    onChange={(e) => setSiteFormData({ ...siteFormData, locationName: e.target.value })}
                  />
                </div>

                <div>
                  <label className="text-xs text-gray-600 mb-1.5 block">Country *</label>
                  <select
                    className="w-full px-4 py-3 bg-white/60 backdrop-blur-sm border-2 border-rose-100 rounded-[16px] 
                      focus:outline-none focus:border-rose-400 transition-all text-gray-700 text-sm"
                    value={siteFormData.country}
                    onChange={(e) => setSiteFormData({ ...siteFormData, country: e.target.value })}
                  >
                    <option value="">Select a country</option>
                    {COUNTRIES.map((country) => (
                      <option key={country} value={country}>{country}</option>
                    ))}
                  </select>
                </div>

                <div className="grid grid-cols-2 gap-3">
                  <div>
                    <label className="text-xs text-gray-600 mb-1.5 block">City *</label>
                    <RomanticInput 
                      value={siteFormData.city} 
                      onChange={(e) => setSiteFormData({...siteFormData, city: e.target.value})} 
                      placeholder="City"
                    />
                  </div>
                  <div>
                    <label className="text-xs text-gray-600 mb-1.5 block">Postal Code *</label>
                    <RomanticInput 
                      value={siteFormData.postalCode} 
                      onChange={(e) => setSiteFormData({...siteFormData, postalCode: e.target.value})} 
                      placeholder="12345"
                    />
                  </div>
                </div>

                <div>
                  <label className="text-xs text-gray-600 mb-1.5 block">State/Region</label>
                  <RomanticInput 
                    value={siteFormData.region} 
                    onChange={(e) => setSiteFormData({...siteFormData, region: e.target.value})} 
                    placeholder="State or region"
                  />
                </div>

                <div>
                  <label className="text-xs text-gray-600 mb-1.5 block">Street Address</label>
                  <RomanticInput 
                    value={siteFormData.streetAddress} 
                    onChange={(e) => setSiteFormData({...siteFormData, streetAddress: e.target.value})} 
                    placeholder="123 Main Street"
                  />
                </div>

                <div>
                  <label className="text-xs text-gray-600 mb-1.5 block">Contact Person</label>
                  <RomanticInput 
                    value={siteFormData.contactPerson} 
                    onChange={(e) => setSiteFormData({...siteFormData, contactPerson: e.target.value})} 
                    placeholder="Contact person name"
                  />
                </div>

                <div>
                  <label className="text-xs text-gray-600 mb-1.5 block">Email</label>
                  <RomanticInput 
                    type="email"
                    value={siteFormData.email} 
                    onChange={(e) => setSiteFormData({...siteFormData, email: e.target.value})} 
                    placeholder="email@example.com"
                  />
                </div>

                <div>
                  <label className="text-xs text-gray-600 mb-1.5 block">Phone</label>
                  <RomanticInput 
                    type="tel"
                    value={siteFormData.tel} 
                    onChange={(e) => setSiteFormData({...siteFormData, tel: e.target.value})} 
                    placeholder="+1 (555) 123-4567"
                  />
                </div>

                <div>
                  <label className="text-xs text-gray-600 mb-1.5 block">Category *</label>
                  <select
                    className="w-full px-4 py-3 bg-white/60 backdrop-blur-sm border-2 border-rose-100 rounded-[16px] 
                      focus:outline-none focus:border-rose-400 transition-all text-gray-700 text-sm"
                    value={siteFormData.category}
                    onChange={(e) => setSiteFormData({ ...siteFormData, category: e.target.value })}
                  >
                    {CATEGORIES.map((cat) => (
                      <option key={cat.value} value={cat.value}>{cat.label}</option>
                    ))}
                  </select>
                </div>

                <div>
                  <label className="text-xs text-gray-600 mb-1.5 block">Description</label>
                  <textarea
                    className="w-full px-4 py-3 bg-white/60 backdrop-blur-sm border-2 border-rose-100 rounded-[16px] 
                      focus:outline-none focus:border-rose-400 transition-all text-gray-700 text-sm resize-none"
                    placeholder="Tell customers about your business..."
                    value={siteFormData.description}
                    onChange={(e) => setSiteFormData({ ...siteFormData, description: e.target.value })}
                    rows={3}
                  />
                </div>

                <RomanticButton
                  fullWidth
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
    </div>
  );
}