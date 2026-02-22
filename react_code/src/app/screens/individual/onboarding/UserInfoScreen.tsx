import { useState } from 'react';
import { useNavigate } from 'react-router-dom';
import { User, Camera, MapPin, Phone, Sparkles, Heart, ChevronRight } from 'lucide-react';
import RomanticInput from '../../../components/RomanticInput';
import RomanticButton from '../../../components/RomanticButton';
import { useApp } from '../../../context/AppContext';
import { motion, AnimatePresence } from 'motion/react';
import BackButton from '@/app/components/BackButton';

export default function UserInfoScreen() {
  const navigate = useNavigate();
  const { setCurrentUser } = useApp();
  const [formData, setFormData] = useState({
    name: '',
    ageRange: '',
    gender: '',
    country: '',
    city: '',
    postalCode: '',
    stateRegion: '',
    streetAddress: '',
    countryCode: '+1',
    phone: '',
    profilePhoto: '',
  });
  const [photoPreview, setPhotoPreview] = useState<string>('');
  const [currentStep, setCurrentStep] = useState(1);

  const ageRanges = ['18-24', '25-34', '35-44', '45-54', '55-64', '65+'];
  const genders = ['Male', 'Female'];
  
  // Common countries
  const countries = [
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
  
  // Common country codes
  const countryCodes = [
    { code: '+1', country: 'US/CA', name: 'United States/Canada' },
    { code: '+44', country: 'UK', name: 'United Kingdom' },
    { code: '+91', country: 'IN', name: 'India' },
    { code: '+86', country: 'CN', name: 'China' },
    { code: '+81', country: 'JP', name: 'Japan' },
    { code: '+49', country: 'DE', name: 'Germany' },
    { code: '+33', country: 'FR', name: 'France' },
    { code: '+39', country: 'IT', name: 'Italy' },
    { code: '+34', country: 'ES', name: 'Spain' },
    { code: '+61', country: 'AU', name: 'Australia' },
    { code: '+7', country: 'RU', name: 'Russia' },
    { code: '+82', country: 'KR', name: 'South Korea' },
    { code: '+55', country: 'BR', name: 'Brazil' },
    { code: '+52', country: 'MX', name: 'Mexico' },
    { code: '+27', country: 'ZA', name: 'South Africa' },
    { code: '+20', country: 'EG', name: 'Egypt' },
    { code: '+234', country: 'NG', name: 'Nigeria' },
    { code: '+971', country: 'AE', name: 'UAE' },
    { code: '+65', country: 'SG', name: 'Singapore' },
    { code: '+60', country: 'MY', name: 'Malaysia' },
  ];

  const handlePhotoChange = (e: React.ChangeEvent<HTMLInputElement>) => {
    const file = e.target.files?.[0];
    if (file) {
      const reader = new FileReader();
      reader.onloadend = () => {
        setPhotoPreview(reader.result as string);
        setFormData({ ...formData, profilePhoto: reader.result as string });
      };
      reader.readAsDataURL(file);
    }
  };

  const handleContinue = () => {
    // Get existing user data from localStorage and update it with the name
    const existingUsersJson = localStorage.getItem('cherish_users');
    const existingUsers = existingUsersJson ? JSON.parse(existingUsersJson) : [];
    
    // Find the current user (most recently added individual user)
    const userIndex = existingUsers.findIndex((u: any) => u.userType === 'individual');
    
    if (userIndex !== -1) {
      // Update the existing user with the name
      existingUsers[userIndex].name = formData.name;
      existingUsers[userIndex].ageRange = formData.ageRange;
      existingUsers[userIndex].gender = formData.gender;
      existingUsers[userIndex].country = formData.country;
      existingUsers[userIndex].city = formData.city;
      existingUsers[userIndex].postalCode = formData.postalCode;
      existingUsers[userIndex].stateRegion = formData.stateRegion;
      existingUsers[userIndex].streetAddress = formData.streetAddress;
      existingUsers[userIndex].phone = formData.phone;
      existingUsers[userIndex].countryCode = formData.countryCode;
      existingUsers[userIndex].profilePhoto = formData.profilePhoto;
      
      localStorage.setItem('cherish_users', JSON.stringify(existingUsers));
      
      // Update the current user state with the name
      setCurrentUser({
        id: existingUsers[userIndex].id,
        email: existingUsers[userIndex].email,
        name: formData.name,
        userType: 'individual',
        isNewUser: true,
        onboardingCompleted: false,
      });
    }
    
    navigate('/individual/add-loved-one');
  };

  return (
    <div className="min-h-screen px-6 pt-20 pb-24 max-w-lg mx-auto relative">
      {/* Back Button */}
      <BackButton to="/auth" />
      
      {/* Progress Indicator */}
      <motion.div 
        className="mb-8 mt-2"
        initial={{ opacity: 0, y: -20 }}
        animate={{ opacity: 1, y: 0 }}
      >
      </motion.div>

      {/* Header */}
      <motion.div
        className="text-center mb-10"
        initial={{ opacity: 0, y: 20 }}
        animate={{ opacity: 1, y: 0 }}
        transition={{ delay: 0.1 }}
      >
        <div className="inline-flex items-center gap-2 px-4 py-2 bg-gradient-to-r from-rose-50 to-pink-50 rounded-full mb-6 border border-rose-100">
          <Heart className="w-4 h-4 text-rose-500" />
          <span className="text-rose-600 text-sm font-medium">Step 1 of 4</span>
        </div>
        
        <motion.div
          initial={{ scale: 0 }}
          animate={{ scale: 1 }}
          transition={{ delay: 0.2, type: 'spring', stiffness: 200 }}
          className="inline-flex items-center justify-center w-20 h-20 rounded-full bg-gradient-to-br from-rose-400 via-pink-400 to-purple-400 mb-6 shadow-2xl"
        >
          <User className="w-10 h-10 text-white" />
        </motion.div>
        
        <h1 className="text-4xl text-gray-800 mb-3">
          Tell Cherish AI about yourself
        </h1>
        <p className="text-gray-600 text-lg leading-relaxed">
          Personalize your Cherish AI experience
        </p>
      </motion.div>

      <motion.form
        className="space-y-8"
        onSubmit={(e) => {
          e.preventDefault();
          handleContinue();
        }}
        initial={{ opacity: 0 }}
        animate={{ opacity: 1 }}
        transition={{ delay: 0.3 }}
      >
        {/* Profile Photo Upload - Premium Design */}
        <motion.div 
          className="flex flex-col items-center"
          initial={{ opacity: 0, scale: 0.9 }}
          animate={{ opacity: 1, scale: 1 }}
          transition={{ delay: 0.4 }}
        >
          <label className="block text-gray-700 mb-4 text-sm font-semibold text-center">
            Profile Photo <span className="text-gray-400 font-normal">(Optional)</span>
          </label>
          
          <div className="relative group">
            <input
              type="file"
              accept="image/*"
              className="absolute inset-0 w-full h-full opacity-0 cursor-pointer z-10"
              onChange={handlePhotoChange}
              id="profile-photo"
            />
            
            <motion.div 
              className="relative w-36 h-36 rounded-full overflow-hidden shadow-2xl bg-gradient-to-br from-rose-100 via-pink-100 to-purple-100 flex items-center justify-center cursor-pointer"
              whileHover={{ scale: 1.05 }}
              whileTap={{ scale: 0.95 }}
            >
              {/* Decorative Ring */}
              <div className="absolute inset-0 rounded-full border-4 border-white"></div>
              <div className="absolute inset-0 rounded-full ring-4 ring-rose-200 ring-offset-2"></div>
              
              {photoPreview ? (
                <img
                  src={photoPreview}
                  alt="Profile preview"
                  className="w-full h-full object-cover"
                />
              ) : (
                <div className="flex flex-col items-center justify-center text-rose-400 group-hover:text-rose-500 transition-colors">
                  <Camera className="w-12 h-12 mb-2" strokeWidth={1.5} />
                  <span className="text-sm font-medium">Add Photo</span>
                </div>
              )}
            </motion.div>
            
            {/* Edit Badge */}
            <motion.div 
              className="absolute bottom-1 right-1 w-12 h-12 rounded-full bg-gradient-to-br from-rose-400 to-pink-500 flex items-center justify-center shadow-xl border-4 border-white cursor-pointer"
              whileHover={{ scale: 1.1, rotate: 15 }}
              whileTap={{ scale: 0.9 }}
            >
              <Camera className="w-5 h-5 text-white" />
            </motion.div>
          </div>
          
          <p className="text-xs text-gray-500 mt-3 text-center">
            Help us put a face to your beautiful journey
          </p>
        </motion.div>

        {/* Name Input - Premium Card */}
        <motion.div
          initial={{ opacity: 0, y: 20 }}
          animate={{ opacity: 1, y: 0 }}
          transition={{ delay: 0.5 }}
          className="bg-white/80 backdrop-blur-sm rounded-[24px] p-6 shadow-lg border border-purple-50"
        >
          <div className="flex items-center gap-3 mb-4">
            <div className="w-10 h-10 rounded-full bg-gradient-to-br from-rose-100 to-pink-100 flex items-center justify-center">
              <Sparkles className="w-5 h-5 text-rose-500" />
            </div>
            <h3 className="text-gray-800 font-semibold">How should Cherish AI call you? <span className="text-rose-500">*</span></h3>
          </div>
          
          <RomanticInput
            placeholder="Your name or nickname"
            value={formData.name}
            onChange={(e) => setFormData({ ...formData, name: e.target.value })}
            required
          />
          <p className="text-xs text-gray-500 mt-2 ml-1">
            This is how Cherish AI will address you throughout your experience
          </p>
        </motion.div>

        {/* Age Range - Premium Selection */}
        <motion.div
          initial={{ opacity: 0, y: 20 }}
          animate={{ opacity: 1, y: 0 }}
          transition={{ delay: 0.6 }}
          className="bg-white/80 backdrop-blur-sm rounded-[24px] p-6 shadow-lg border border-purple-50"
        >
          <h3 className="text-gray-800 font-semibold mb-4">Age Range *</h3>
          <div className="grid grid-cols-3 gap-3">
            {ageRanges.map((range, index) => (
              <motion.button
                key={range}
                type="button"
                onClick={() => setFormData({ ...formData, ageRange: range })}
                initial={{ opacity: 0, scale: 0.8 }}
                animate={{ opacity: 1, scale: 1 }}
                transition={{ delay: 0.7 + index * 0.05 }}
                whileHover={{ scale: 1.05 }}
                whileTap={{ scale: 0.95 }}
                className={`relative py-4 px-4 rounded-[16px] border-2 transition-all font-semibold overflow-hidden ${
                  formData.ageRange === range
                    ? 'bg-gradient-to-br from-rose-400 to-pink-400 border-rose-400 text-white shadow-lg'
                    : 'bg-white border-gray-200 text-gray-700 hover:border-rose-300 hover:shadow-md'
                }`}
              >
                {/* Shine effect when selected */}
                {formData.ageRange === range && (
                  <motion.div
                    className="absolute inset-0 bg-gradient-to-r from-transparent via-white/30 to-transparent"
                    initial={{ x: '-100%' }}
                    animate={{ x: '100%' }}
                    transition={{ duration: 0.6, delay: 0.2 }}
                  />
                )}
                <span className="relative z-10">{range}</span>
              </motion.button>
            ))}
          </div>
        </motion.div>

        {/* Gender - Premium Selection */}
        <motion.div
          initial={{ opacity: 0, y: 20 }}
          animate={{ opacity: 1, y: 0 }}
          transition={{ delay: 0.7 }}
          className="bg-white/80 backdrop-blur-sm rounded-[24px] p-6 shadow-lg border border-purple-50"
        >
          <h3 className="text-gray-800 font-semibold mb-4">Gender *</h3>
          <div className="grid grid-cols-2 gap-3">
            {genders.map((gender, index) => (
              <motion.button
                key={gender}
                type="button"
                onClick={() => setFormData({ ...formData, gender })}
                initial={{ opacity: 0, scale: 0.8 }}
                animate={{ opacity: 1, scale: 1 }}
                transition={{ delay: 0.8 + index * 0.05 }}
                whileHover={{ scale: 1.05 }}
                whileTap={{ scale: 0.95 }}
                className={`relative py-4 px-4 rounded-[16px] border-2 transition-all font-semibold text-sm overflow-hidden ${
                  formData.gender === gender
                    ? 'bg-gradient-to-br from-rose-400 to-pink-400 border-rose-400 text-white shadow-lg'
                    : 'bg-white border-gray-200 text-gray-700 hover:border-rose-300 hover:shadow-md'
                }`}
              >
                {formData.gender === gender && (
                  <motion.div
                    className="absolute inset-0 bg-gradient-to-r from-transparent via-white/30 to-transparent"
                    initial={{ x: '-100%' }}
                    animate={{ x: '100%' }}
                    transition={{ duration: 0.6, delay: 0.2 }}
                  />
                )}
                <span className="relative z-10">{gender}</span>
              </motion.button>
            ))}
          </div>
        </motion.div>

        {/* Location - Premium Card */}
        <motion.div
          initial={{ opacity: 0, y: 20 }}
          animate={{ opacity: 1, y: 0 }}
          transition={{ delay: 0.9 }}
          className="bg-white/80 backdrop-blur-sm rounded-[24px] p-6 shadow-lg border border-purple-50"
        >
          <div className="flex items-center gap-3 mb-6">
            <div className="w-10 h-10 rounded-full bg-gradient-to-br from-rose-100 to-pink-100 flex items-center justify-center">
              <MapPin className="w-5 h-5 text-rose-500" />
            </div>
            <h3 className="text-gray-800 font-semibold">Your Address</h3>
          </div>
          
          {/* Country */}
          <div className="mb-5">
            <RomanticInput
              mode="select"
              label="Country *"
              options={[
                { value: '', label: 'Select your country' },
                ...countries.map((country) => ({ value: country, label: country }))
              ]}
              value={formData.country}
              onChange={(e) => setFormData({ ...formData, country: e.target.value })}
              required
            />
          </div>

          {/* City and Postal Code - Side by Side */}
          <div className="grid grid-cols-2 gap-4 mb-5">
            <div>
              <label className="block text-gray-700 text-sm font-semibold mb-2">
                City *
              </label>
              <RomanticInput
                placeholder="Your city"
                value={formData.city}
                onChange={(e) => setFormData({ ...formData, city: e.target.value })}
                required
              />
            </div>
            <div>
              <label className="block text-gray-700 text-sm font-semibold mb-2">
                Postal Code *
              </label>
              <RomanticInput
                placeholder="Postal code"
                value={formData.postalCode}
                onChange={(e) => setFormData({ ...formData, postalCode: e.target.value })}
                required
              />
            </div>
          </div>

          {/* State/Region */}
          <div className="mb-5">
            <label className="block text-gray-700 text-sm font-semibold mb-2">
              State / Region <span className="text-gray-400 font-normal">(Optional)</span>
            </label>
            <RomanticInput
              placeholder="State, province, or region"
              value={formData.stateRegion}
              onChange={(e) => setFormData({ ...formData, stateRegion: e.target.value })}
            />
          </div>

          {/* Street Address */}
          <div>
            <label className="block text-gray-700 text-sm font-semibold mb-2">
              Street Address <span className="text-gray-400 font-normal">(Optional)</span>
            </label>
            <RomanticInput
              placeholder="123 Main Street, Apt 4B"
              value={formData.streetAddress}
              onChange={(e) => setFormData({ ...formData, streetAddress: e.target.value })}
            />
          </div>

          <p className="text-xs text-gray-500 mt-4 ml-1">
            Your location helps Cherish AI suggest thoughtful gifts and services nearby.<br />
            No need to share street number or building details
          </p>
        </motion.div>

        {/* Phone Number - Premium Card */}
        <motion.div
          initial={{ opacity: 0, y: 20 }}
          animate={{ opacity: 1, y: 0 }}
          transition={{ delay: 1.0 }}
          className="bg-white/80 backdrop-blur-sm rounded-[24px] p-6 shadow-lg border border-purple-50"
        >
          <div className="flex items-center gap-3 mb-4">
            <div className="w-10 h-10 rounded-full bg-gradient-to-br from-rose-100 to-pink-100 flex items-center justify-center">
              <Phone className="w-5 h-5 text-rose-500" />
            </div>
            <h3 className="text-gray-800 font-semibold">
              Phone Number <span className="text-gray-400 font-normal text-sm">(Optional)</span>
            </h3>
          </div>
          
          <div className="flex gap-3">
            <select
              className="w-36 py-3.5 px-4 rounded-[16px] border-2 border-gray-200 bg-white text-gray-700 font-medium focus:outline-none focus:border-rose-300 focus:ring-4 focus:ring-rose-100 transition-all shadow-sm"
              value={formData.countryCode}
              onChange={(e) => setFormData({ ...formData, countryCode: e.target.value })}
            >
              {countryCodes.map((item) => (
                <option key={item.code} value={item.code}>
                  {item.code} {item.country}
                </option>
              ))}
            </select>
            <div className="flex-1">
              <RomanticInput
                type="tel"
                placeholder="Phone number"
                value={formData.phone}
                onChange={(e) => setFormData({ ...formData, phone: e.target.value })}
              />
            </div>
          </div>
          <p className="text-xs text-gray-500 mt-3 ml-1">
            For important reminders and thoughtful notifications
          </p>
        </motion.div>

        {/* Submit Button */}
        <motion.div 
          className="pt-6"
          initial={{ opacity: 0, y: 20 }}
          animate={{ opacity: 1, y: 0 }}
          transition={{ delay: 1.1 }}
        >
          <motion.button
            type="submit"
            whileHover={{ scale: 1.02 }}
            whileTap={{ scale: 0.98 }}
            className="w-full py-4 rounded-[16px] bg-gradient-to-r from-rose-500 via-pink-500 to-purple-500 text-white font-semibold shadow-lg shadow-pink-300/50 hover:shadow-xl hover:shadow-pink-300/60 transition-all flex items-center justify-center gap-2 group"
          >
            Continue to Next Step
            <ChevronRight className="w-5 h-5 group-hover:translate-x-1 transition-transform" />
          </motion.button>
        </motion.div>
      </motion.form>

      {/* Footer Note */}
      <motion.div
        initial={{ opacity: 0 }}
        animate={{ opacity: 1 }}
        transition={{ delay: 1.2 }}
        className="text-center mt-8"
      >
        <div className="inline-flex items-center gap-2 px-4 py-2 bg-purple-50 rounded-full">
          <div className="w-1.5 h-1.5 rounded-full bg-rose-400"></div>
          <span className="text-purple-600 text-xs font-medium">Required fields</span>
        </div>
      </motion.div>
    </div>
  );
}