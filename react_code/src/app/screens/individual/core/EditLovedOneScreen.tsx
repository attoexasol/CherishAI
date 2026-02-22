import { useState, useEffect } from 'react';
import { useNavigate, useParams } from 'react-router';
import { ArrowLeft, Save, Camera, Calendar, Phone, Heart, Sparkles, ShieldOff, X, Target, Check, Plus } from 'lucide-react';
import { motion } from 'motion/react';
import { ImageWithFallback } from '@/app/components/figma/ImageWithFallback';

// Mock data - in real app, this would come from AppContext/API
const mockLovedOneData = {
  id: '1',
  name: 'Sarah',
  relationship: 'Partner (dating / committed, not married)',
  photo: '',
  birthday: '1990-01-15',
  anniversary: '2022-03-20',
  phone: '+1 234 567 8900',
  notes: 'Loves surprises and thoughtful gestures',
  primaryGoal: 'deepen',
  secondaryGoals: ['be-present', 'grow-emotionally', 'celebrate-everyday'],
  customDates: [],
  // List-based fields (not directly editable, only via list selection)
  hobbies: ['Art & Illustration', 'Photography', 'Travel'],
  preferences: {
    'Love Language': ['Quality Time', 'Acts of Service'],
    'Gift Preferences': ['Personalized Items', 'Experience-based'],
  },
  dislikes: ['Generic gifts', 'Crowded places'],
};

// Hobby Categories
const hobbyCategories = [
  {
    id: 'creative-expressive',
    name: 'Creative & Expressive',
    gradient: 'from-purple-400 to-pink-400',
    bgColor: 'bg-purple-50',
    hobbies: [
      'Art & Illustration',
      'Photography',
      'Writing & Journaling',
      'Music (Listening)',
      'Playing Music',
      'DIY & Crafts',
      'Design & Aesthetics',
    ],
  },
  {
    id: 'food-lifestyle',
    name: 'Food & Lifestyle',
    gradient: 'from-orange-400 to-rose-400',
    bgColor: 'bg-orange-50',
    hobbies: [
      'Cooking',
      'Baking',
      'Coffee & Cafés',
      'Wine & Cocktails',
      'Dining Out',
      'Food Experiences',
    ],
  },
  {
    id: 'experiences-exploration',
    name: 'Experiences & Exploration',
    gradient: 'from-teal-400 to-cyan-400',
    bgColor: 'bg-teal-50',
    hobbies: [
      'Travel',
      'Road Trips',
      'Nature & Outdoors',
      'Hiking',
      'Camping',
      'Cultural Experiences',
    ],
  },
  {
    id: 'wellness-mindfulness',
    name: 'Wellness & Mindfulness',
    gradient: 'from-green-400 to-emerald-400',
    bgColor: 'bg-green-50',
    hobbies: [
      'Fitness & Gym',
      'Yoga & Pilates',
      'Meditation & Mindfulness',
      'Mental Wellness',
      'Self-Care & Relaxation',
    ],
  },
  {
    id: 'fun-entertainment',
    name: 'Fun & Entertainment',
    gradient: 'from-violet-400 to-purple-400',
    bgColor: 'bg-violet-50',
    hobbies: [
      'Movies & TV',
      'Gaming',
      'Board Games',
      'Live Events & Concerts',
      'Socializing & Nightlife',
    ],
  },
  {
    id: 'ambition-productivity',
    name: 'Ambition & Productivity',
    gradient: 'from-indigo-400 to-blue-400',
    bgColor: 'bg-indigo-50',
    hobbies: [
      'Career Growth',
      'Entrepreneurship',
      'Productivity & Planning',
      'Finance & Investing',
    ],
  },
  {
    id: 'relationships-family',
    name: 'Relationships & Family',
    gradient: 'from-rose-400 to-pink-400',
    bgColor: 'bg-rose-50',
    hobbies: [
      'Family Time',
      'Parenting',
      'Kids Activities',
      'Pets & Animals',
    ],
  },
  {
    id: 'tech-modern',
    name: 'Tech & Modern Life',
    gradient: 'from-slate-400 to-zinc-400',
    bgColor: 'bg-slate-50',
    hobbies: [
      'Technology & Gadgets',
      'AI & Innovation',
      'Digital Creation',
    ],
  },
];

// Dislike Categories
const dislikeCategories = [
  {
    id: 'gift-material',
    name: 'Gift & Material Preferences',
    gradient: 'from-red-400 to-rose-400',
    bgColor: 'bg-red-50',
    dislikes: [
      'Generic gifts',
      'Expensive gifts',
      'Cheap-looking items',
      'Practical gifts',
      'Overly romantic gestures',
      'Flashy or showy items',
    ],
  },
  {
    id: 'food-lifestyle',
    name: 'Food & Lifestyle',
    gradient: 'from-orange-400 to-amber-400',
    bgColor: 'bg-orange-50',
    dislikes: [
      'Sweets & desserts',
      'Alcohol',
      'Coffee',
      'Spicy food',
      'Dining out',
    ],
  },
  {
    id: 'experiences-social',
    name: 'Experiences & Social Preferences',
    gradient: 'from-purple-400 to-pink-400',
    bgColor: 'bg-purple-50',
    dislikes: [
      'Crowded places',
      'Surprises',
      'Public displays of affection',
      'Loud environments',
      'Late-night activities',
    ],
  },
  {
    id: 'wellness-personality',
    name: 'Wellness & Personality',
    gradient: 'from-indigo-400 to-violet-400',
    bgColor: 'bg-indigo-50',
    dislikes: [
      'High-intensity activities',
      'Structured schedules',
      'Technology-heavy experiences',
      'Minimal planning',
    ],
  },
];

export default function EditLovedOneScreen() {
  const navigate = useNavigate();
  const { id } = useParams();
  
  const [formData, setFormData] = useState({
    name: '',
    relationship: '',
    photo: '',
    birthday: '',
    anniversary: '',
    phone: '',
    notes: '',
    personalNote: '',
  });

  const [photoPreview, setPhotoPreview] = useState<string>('');
  const [isSaving, setIsSaving] = useState(false);
  const [activeTab, setActiveTab] = useState<'basic' | 'contact' | 'dates'>('basic');
  const [primaryGoal, setPrimaryGoal] = useState<string>('');
  const [secondaryGoals, setSecondaryGoals] = useState<string[]>([]);
  const [customDates, setCustomDates] = useState<Array<{ id: string; occasion: string; date: string }>>([]);

  // Hobbies, Preferences, and Dislikes state
  const [selectedHobbies, setSelectedHobbies] = useState<{ [category: string]: string[] }>({});
  const [selectedPreferences, setSelectedPreferences] = useState<{ [category: string]: string[] }>({});
  const [selectedDislikes, setSelectedDislikes] = useState<{ [category: string]: string[] }>({});
  const [customDislikes, setCustomDislikes] = useState<string[]>([]);

  // Load loved one data
  useEffect(() => {
    // In real app, fetch from AppContext or API
    setFormData({
      name: mockLovedOneData.name,
      relationship: mockLovedOneData.relationship,
      photo: mockLovedOneData.photo,
      birthday: mockLovedOneData.birthday,
      anniversary: mockLovedOneData.anniversary,
      phone: mockLovedOneData.phone,
      notes: mockLovedOneData.notes,
      personalNote: '',
    });
    
    if (mockLovedOneData.photo) {
      setPhotoPreview(mockLovedOneData.photo);
    }

    setPrimaryGoal(mockLovedOneData.primaryGoal);
    setSecondaryGoals(mockLovedOneData.secondaryGoals);
    setCustomDates(mockLovedOneData.customDates || []);

    // Initialize hobbies, preferences, and dislikes
    setSelectedHobbies({ 'Hobbies & Interests': mockLovedOneData.hobbies });
    setSelectedPreferences(mockLovedOneData.preferences);
    setSelectedDislikes({ 'Dislikes': mockLovedOneData.dislikes });
  }, [id]);

  const handlePhotoChange = (e: React.ChangeEvent<HTMLInputElement>) => {
    const file = e.target.files?.[0];
    if (file) {
      const reader = new FileReader();
      reader.onloadend = () => {
        const result = reader.result as string;
        setPhotoPreview(result);
        setFormData({ ...formData, photo: result });
      };
      reader.readAsDataURL(file);
    }
  };

  const handleSave = async () => {
    setIsSaving(true);
    
    // Simulate API call
    await new Promise(resolve => setTimeout(resolve, 1000));
    
    // In real app: Update AppContext or send to API
    console.log('Saving loved one data:', formData);
    
    setIsSaving(false);
    navigate(`/individual/loved-one-details/${id}`);
  };

  const relationshipOptions = [
    { category: 'Romantic / Intimate', options: ['Partner (dating / committed, not married)', 'Spouse (married partner)', 'Crush / Romantic interest'] },
    { category: 'Family', options: ['Parent', 'Child', 'Sibling', 'Extended family'] },
    { category: 'Social', options: ['Friend', 'Close friend / Best friend'] },
    { category: 'Professional', options: ['Colleague', 'Mentor', 'Mentee'] },
  ];

  // Primary Goal Options
  const primaryGoalOptions = [
    {
      id: 'deepen',
      icon: '💕',
      title: 'Deepen emotional connection',
      description: 'Increase closeness, openness, emotional intimacy',
    },
    {
      id: 'spark',
      icon: '✨',
      title: 'Keep the spark alive',
      description: 'Maintain excitement, playfulness, attraction, novelty',
    },
    {
      id: 'trust',
      icon: '🛡️',
      title: 'Build trust & emotional security',
      description: 'Create safety, reassurance, reliability, stability',
    },
    {
      id: 'communication',
      icon: '💬',
      title: 'Improve communication & understanding',
      description: 'Express better, listen better, feel understood',
    },
    {
      id: 'appreciation',
      icon: '🌸',
      title: 'Show appreciation & care',
      description: 'Express gratitude, recognition, affection',
    },
    {
      id: 'moments',
      icon: '🌟',
      title: 'Create meaningful shared moments',
      description: 'Build memories through experiences and rituals',
    },
    {
      id: 'reignite',
      icon: '🔥',
      title: 'Reignite romance or closeness',
      description: 'Restore warmth, affection, emotional energy',
    },
    {
      id: 'support',
      icon: '🤝',
      title: 'Support and uplift each other',
      description: 'Offer encouragement and emotional presence',
    },
    {
      id: 'romantic',
      icon: '💓',
      title: 'Build romantic interest naturally',
      description: 'Explore attraction with warmth and respect',
    },
  ];

  // Secondary Goal Options
  const secondaryGoalOptions = [
    { id: 'balance-busy-life', text: 'Balance love with a busy life', category: 'Life & Presence' },
    { id: 'be-present', text: 'Be more present and intentional', category: 'Life & Presence' },
    { id: 'reconnect', text: 'Reconnect after distance or absence', category: 'Life & Presence' },
    { id: 'grow-emotionally', text: 'Grow together emotionally', category: 'Growth & Longevity' },
    { id: 'long-term-future', text: 'Build a long-term future together', category: 'Growth & Longevity' },
    { id: 'family-bonds', text: 'Strengthen family bonds', category: 'Growth & Longevity' },
    { id: 'heal-difficult', text: 'Heal after a difficult period', category: 'Healing & Repair' },
    { id: 'restore-closeness', text: 'Restore closeness after conflict', category: 'Healing & Repair' },
    { id: 'celebrate-everyday', text: 'Celebrate everyday moments', category: 'Moments & Meaning' },
    { id: 'important-milestone', text: 'Prepare for an important milestone', category: 'Moments & Meaning' },
    { id: 'joyful-surprises', text: 'Create joyful surprises', category: 'Moments & Meaning' },
    { id: 'feel-understood', text: 'Make them feel deeply understood', category: 'Emotional Expression' },
    { id: 'lightness-playfulness', text: 'Bring more lightness and playfulness', category: 'Emotional Expression' },
  ];

  const handleSecondaryGoalToggle = (goalId: string) => {
    if (secondaryGoals.includes(goalId)) {
      setSecondaryGoals(secondaryGoals.filter((id) => id !== goalId));
    } else {
      if (secondaryGoals.length < 3) {
        setSecondaryGoals([...secondaryGoals, goalId]);
      }
    }
  };

  const handleAddCustomDate = () => {
    const newDate = {
      id: Date.now().toString(),
      occasion: '',
      date: '',
    };
    setCustomDates([...customDates, newDate]);
  };

  const handleRemoveCustomDate = (dateId: string) => {
    setCustomDates(customDates.filter((d) => d.id !== dateId));
  };

  const handleUpdateCustomDate = (dateId: string, field: 'occasion' | 'date', value: string) => {
    setCustomDates(
      customDates.map((d) => (d.id === dateId ? { ...d, [field]: value } : d))
    );
  };

  // Hobby handlers
  const handleHobbyToggle = (categoryId: string, hobby: string) => {
    const categoryHobbies = selectedHobbies[categoryId] || [];
    
    if (categoryHobbies.includes(hobby)) {
      setSelectedHobbies({
        ...selectedHobbies,
        [categoryId]: categoryHobbies.filter(h => h !== hobby),
      });
    } else {
      if (categoryHobbies.length < 1) {
        setSelectedHobbies({
          ...selectedHobbies,
          [categoryId]: [...categoryHobbies, hobby],
        });
      }
    }
  };

  // Dislike handlers
  const handleDislikeToggle = (categoryId: string, dislike: string) => {
    const categoryDislikes = selectedDislikes[categoryId] || [];
    
    if (categoryDislikes.includes(dislike)) {
      setSelectedDislikes({
        ...selectedDislikes,
        [categoryId]: categoryDislikes.filter(d => d !== dislike),
      });
    } else {
      if (categoryDislikes.length < 1) {
        setSelectedDislikes({
          ...selectedDislikes,
          [categoryId]: [...categoryDislikes, dislike],
        });
      }
    }
  };

  const handleAddCustomDislike = (dislike: string) => {
    if (dislike.trim() && customDislikes.length < 2) {
      setCustomDislikes([...customDislikes, dislike.trim()]);
    }
  };

  const handleRemoveCustomDislike = (dislike: string) => {
    setCustomDislikes(customDislikes.filter(d => d !== dislike));
  };

  const getTotalHobbies = () => {
    return Object.values(selectedHobbies).reduce((sum, arr) => sum + arr.length, 0);
  };

  const getTotalDislikes = () => {
    const categoryCount = Object.values(selectedDislikes).reduce(
      (sum, arr) => sum + arr.length,
      0
    );
    return categoryCount + customDislikes.length;
  };

  return (
    <div className="min-h-screen bg-gradient-to-br from-rose-50 via-pink-50 to-purple-50 pb-24">
      {/* Header */}
      <div className="sticky top-0 z-20 bg-gradient-to-br from-rose-50/95 via-pink-50/95 to-purple-50/95 backdrop-blur-xl border-b border-rose-100/50">
        <div className="max-w-2xl mx-auto px-6 py-4">
          <div className="flex items-center justify-between">
            <button
              onClick={() => navigate(-1)}
              className="flex items-center gap-2 text-rose-600 hover:text-rose-700 transition-colors"
            >
              <ArrowLeft className="w-5 h-5" />
              <span className="font-medium">Back</span>
            </button>
            <h1 className="text-lg font-semibold text-gray-800">Edit Profile</h1>
            <button
              onClick={handleSave}
              disabled={isSaving}
              className="flex items-center gap-2 px-4 py-2 rounded-full bg-gradient-to-r from-rose-500 via-pink-500 to-purple-500 text-white font-medium shadow-lg shadow-pink-300/50 hover:shadow-xl disabled:opacity-50 disabled:cursor-not-allowed transition-all"
            >
              {isSaving ? (
                <>
                  <div className="w-4 h-4 border-2 border-white border-t-transparent rounded-full animate-spin" />
                  <span>Saving...</span>
                </>
              ) : (
                <>
                  <Save className="w-4 h-4" />
                  <span>Save</span>
                </>
              )}
            </button>
          </div>
        </div>
      </div>

      <div className="max-w-2xl mx-auto px-6 pt-8">
        {/* Photo Section */}
        <motion.div
          initial={{ opacity: 0, y: 20 }}
          animate={{ opacity: 1, y: 0 }}
          className="mb-8"
        >
          <div className="bg-white/80 backdrop-blur-sm rounded-3xl p-8 border border-rose-200/50 shadow-lg text-center">
            <label className="cursor-pointer group">
              <div className="relative inline-block mb-4">
                {photoPreview ? (
                  <div className="relative w-32 h-32 rounded-full overflow-hidden border-4 border-rose-200 group-hover:border-rose-400 transition-all shadow-xl">
                    <ImageWithFallback
                      src={photoPreview}
                      alt={formData.name}
                      className="w-full h-full object-cover"
                    />
                    <div className="absolute inset-0 bg-black/40 opacity-0 group-hover:opacity-100 transition-opacity flex items-center justify-center">
                      <Camera className="w-8 h-8 text-white" />
                    </div>
                  </div>
                ) : (
                  <div className="w-32 h-32 rounded-full bg-gradient-to-br from-rose-200 to-pink-200 flex items-center justify-center text-6xl border-4 border-rose-200 group-hover:border-rose-400 transition-all shadow-xl">
                    💑
                  </div>
                )}
                <div className="absolute bottom-0 right-0 w-10 h-10 rounded-full bg-gradient-to-br from-rose-500 to-pink-500 flex items-center justify-center shadow-lg group-hover:scale-110 transition-transform">
                  <Camera className="w-5 h-5 text-white" />
                </div>
              </div>
              <input
                type="file"
                accept="image/*"
                onChange={handlePhotoChange}
                className="hidden"
              />
              <p className="text-sm text-gray-600 mt-2">Click to change photo</p>
            </label>
          </div>
        </motion.div>

        {/* Basic Info Section */}
        <motion.div
          initial={{ opacity: 0, y: 20 }}
          animate={{ opacity: 1, y: 0 }}
          className="space-y-4 mb-8"
        >
          <h2 className="text-xl font-semibold text-gray-800 flex items-center gap-2">
            <Heart className="w-5 h-5 text-rose-500" />
            Basic Information
          </h2>
          
          {/* Name */}
          <div className="bg-white/80 backdrop-blur-sm rounded-2xl p-6 border border-rose-200/50 shadow-sm">
            <label className="block text-sm font-medium text-gray-700 mb-2">
              Name <span className="text-rose-500">*</span>
            </label>
            <input
              type="text"
              value={formData.name}
              onChange={(e) => setFormData({ ...formData, name: e.target.value })}
              placeholder="Enter name"
              className="w-full px-4 py-3 rounded-xl border border-pink-200 focus:border-pink-400 focus:ring-2 focus:ring-pink-200 outline-none transition-all text-gray-800 bg-white"
            />
          </div>

          {/* Relationship */}
          <div className="bg-white/80 backdrop-blur-sm rounded-2xl p-6 border border-rose-200/50 shadow-sm">
            <label className="block text-sm font-medium text-gray-700 mb-2">
              Relationship <span className="text-rose-500">*</span>
            </label>
            <select
              value={formData.relationship}
              onChange={(e) => setFormData({ ...formData, relationship: e.target.value })}
              className="w-full px-4 py-3 rounded-xl border border-pink-200 focus:border-pink-400 focus:ring-2 focus:ring-pink-200 outline-none transition-all text-gray-800 bg-white"
            >
              <option value="">Select relationship</option>
              {relationshipOptions.map((category) => (
                <optgroup key={category.category} label={category.category}>
                  {category.options.map((option) => (
                    <option key={option} value={option}>
                      {option}
                    </option>
                  ))}
                </optgroup>
              ))}
            </select>
          </div>

          {/* Notes - Removed per user request */}

          {/* Personal Note for AI */}
          <div className="bg-gradient-to-br from-purple-50 to-pink-50 rounded-2xl p-6 border border-purple-200/50 shadow-sm">
            <div className="flex items-start gap-2 mb-2">
              <Sparkles className="w-5 h-5 text-purple-500 flex-shrink-0 mt-0.5" />
              <div className="flex-1">
                <label className="block text-sm font-medium text-gray-700 mb-1">
                  👉 Personal note (optional)
                </label>
                <p className="text-xs text-gray-600 mb-3">
                  Share anything that helps Cherish AI understand this relationship better. A few sentences are enough.
                </p>
              </div>
            </div>
            <textarea
              value={formData.personalNote}
              onChange={(e) => {
                if (e.target.value.length <= 300) {
                  setFormData({ ...formData, personalNote: e.target.value });
                }
              }}
              placeholder="e.g., Susan is someone I often see at the bus station. I'm developing feelings and want to be kind, subtle, and respectful."
              rows={4}
              maxLength={300}
              className="w-full px-4 py-3 rounded-xl border border-purple-200 focus:border-purple-400 focus:ring-2 focus:ring-purple-200 outline-none transition-all text-gray-800 bg-white resize-none"
            />
            <div className="flex justify-between items-center mt-2">
              <p className="text-xs text-gray-500 italic">
                Used by AI to personalize messages and suggestions
              </p>
              <span className={`text-xs font-medium ${
                formData.personalNote.length > 280 ? 'text-rose-600' : 'text-gray-500'
              }`}>
                {formData.personalNote.length}/300
              </span>
            </div>
          </div>
        </motion.div>

        {/* Important Dates Section */}
        <motion.div
          initial={{ opacity: 0, y: 20 }}
          animate={{ opacity: 1, y: 0 }}
          transition={{ delay: 0.1 }}
          className="space-y-4 mb-8"
        >
          <h2 className="text-xl font-semibold text-gray-800 flex items-center gap-2">
            <Calendar className="w-5 h-5 text-rose-500" />
            Important Dates
          </h2>

          {/* Birthday */}
          <div className="bg-white/80 backdrop-blur-sm rounded-2xl p-6 border border-rose-200/50 shadow-sm">
            <label className="block text-sm font-medium text-gray-700 mb-2">
              🎂 Birthday
            </label>
            <input
              type="date"
              value={formData.birthday}
              onChange={(e) => setFormData({ ...formData, birthday: e.target.value })}
              className="w-full px-4 py-3 rounded-xl border border-pink-200 focus:border-pink-400 focus:ring-2 focus:ring-pink-200 outline-none transition-all text-gray-800 bg-white"
            />
          </div>

          {/* Anniversary */}
          <div className="bg-white/80 backdrop-blur-sm rounded-2xl p-6 border border-rose-200/50 shadow-sm">
            <label className="block text-sm font-medium text-gray-700 mb-2">
              💕 Anniversary
            </label>
            <input
              type="date"
              value={formData.anniversary}
              onChange={(e) => setFormData({ ...formData, anniversary: e.target.value })}
              className="w-full px-4 py-3 rounded-xl border border-pink-200 focus:border-pink-400 focus:ring-2 focus:ring-pink-200 outline-none transition-all text-gray-800 bg-white"
            />
          </div>

          {/* Custom Important Dates */}
          {customDates.map((customDate, index) => (
            <div key={customDate.id} className="bg-white/80 backdrop-blur-sm rounded-2xl p-6 border border-rose-200/50 shadow-sm">
              <div className="flex items-start justify-between mb-4">
                <label className="block text-sm font-medium text-gray-700">
                  ✨ Custom Date {index + 1}
                </label>
                <button
                  onClick={() => handleRemoveCustomDate(customDate.id)}
                  className="p-1 rounded-lg hover:bg-rose-100 transition-colors text-rose-600"
                >
                  <X className="w-5 h-5" />
                </button>
              </div>
              <div className="space-y-3">
                <div>
                  <label className="block text-xs text-gray-600 mb-1">Occasion Name</label>
                  <input
                    type="text"
                    value={customDate.occasion}
                    onChange={(e) => handleUpdateCustomDate(customDate.id, 'occasion', e.target.value)}
                    placeholder="e.g., First Date, Graduation, etc."
                    className="w-full px-4 py-3 rounded-xl border border-pink-200 focus:border-pink-400 focus:ring-2 focus:ring-pink-200 outline-none transition-all text-gray-800 bg-white"
                  />
                </div>
                <div>
                  <label className="block text-xs text-gray-600 mb-1">Date</label>
                  <input
                    type="date"
                    value={customDate.date}
                    onChange={(e) => handleUpdateCustomDate(customDate.id, 'date', e.target.value)}
                    className="w-full px-4 py-3 rounded-xl border border-pink-200 focus:border-pink-400 focus:ring-2 focus:ring-pink-200 outline-none transition-all text-gray-800 bg-white"
                  />
                </div>
              </div>
            </div>
          ))}

          {/* Add Important Date Button */}
          <button
            onClick={handleAddCustomDate}
            className="w-full py-4 px-6 rounded-2xl border-2 border-dashed border-rose-300 hover:border-rose-400 bg-rose-50/50 hover:bg-rose-50 transition-all flex items-center justify-center gap-2 text-rose-600 font-medium"
          >
            <Plus className="w-5 h-5" />
            <span>Add Important Date</span>
          </button>

          <div className="bg-gradient-to-br from-purple-50 to-pink-50 rounded-2xl p-6 border border-purple-200/50">
            <div className="flex gap-3">
              <Calendar className="w-5 h-5 text-purple-500 flex-shrink-0 mt-0.5" />
              <div>
                <h3 className="font-semibold text-gray-800 mb-1">Date Reminders</h3>
                <p className="text-sm text-gray-600 leading-relaxed">
                  Cherish AI will remind you about these special dates in advance, helping you prepare thoughtful celebrations and gifts.
                </p>
              </div>
            </div>
          </div>
        </motion.div>

        {/* Contact & Social Section */}
        <motion.div
          initial={{ opacity: 0, y: 20 }}
          animate={{ opacity: 1, y: 0 }}
          transition={{ delay: 0.15 }}
          className="space-y-4 mb-8"
        >
          <h2 className="text-xl font-semibold text-gray-800 flex items-center gap-2">
            <Phone className="w-5 h-5 text-rose-500" />
            Contact Information
          </h2>

          {/* Phone */}
          <div className="bg-white/80 backdrop-blur-sm rounded-2xl p-6 border border-rose-200/50 shadow-sm">
            <label className="block text-sm font-medium text-gray-700 mb-2">
              📱 Phone Number
            </label>
            <input
              type="tel"
              value={formData.phone}
              onChange={(e) => setFormData({ ...formData, phone: e.target.value })}
              placeholder="+1 234 567 8900"
              className="w-full px-4 py-3 rounded-xl border border-pink-200 focus:border-pink-400 focus:ring-2 focus:ring-pink-200 outline-none transition-all text-gray-800 bg-white"
            />
          </div>
        </motion.div>

        {/* Relationship Goals Section */}
        <motion.div
          initial={{ opacity: 0, y: 20 }}
          animate={{ opacity: 1, y: 0 }}
          transition={{ delay: 0.17 }}
          className="space-y-4 mb-8"
        >
          <h2 className="text-xl font-semibold text-gray-800 flex items-center gap-2">
            <Target className="w-5 h-5 text-rose-500" />
            Relationship Goals
          </h2>

          {/* Primary Goal */}
          <div className="bg-white/80 backdrop-blur-sm rounded-2xl p-6 border border-rose-200/50 shadow-sm">
            <label className="block text-sm font-medium text-gray-700 mb-3">
              💕 Primary Goal <span className="text-gray-500 text-xs">(Choose 1)</span>
            </label>
            <select
              value={primaryGoal}
              onChange={(e) => setPrimaryGoal(e.target.value)}
              className="w-full px-4 py-3 rounded-xl border border-pink-200 focus:border-pink-400 focus:ring-2 focus:ring-pink-200 outline-none transition-all text-gray-800 bg-white"
            >
              <option value="">Select your primary goal</option>
              {primaryGoalOptions.map((goal) => (
                <option key={goal.id} value={goal.id}>
                  {goal.icon} {goal.title}
                </option>
              ))}
            </select>
            {primaryGoal && (
              <p className="mt-2 text-xs text-gray-600">
                {primaryGoalOptions.find((g) => g.id === primaryGoal)?.description}
              </p>
            )}
          </div>

          {/* Secondary Goals */}
          <div className="bg-white/80 backdrop-blur-sm rounded-2xl p-6 border border-rose-200/50 shadow-sm">
            <div className="flex items-start justify-between mb-3">
              <label className="block text-sm font-medium text-gray-700">
                ✨ Secondary Goals <span className="text-gray-500 text-xs">(Choose up to 3)</span>
              </label>
              <span className="text-xs px-2 py-1 rounded-full bg-purple-100 text-purple-700 font-medium">
                {secondaryGoals.length}/3
              </span>
            </div>
            <div className="space-y-2">
              {secondaryGoalOptions.map((goal) => {
                const isSelected = secondaryGoals.includes(goal.id);
                const isDisabled = !isSelected && secondaryGoals.length >= 3;
                
                return (
                  <button
                    key={goal.id}
                    type="button"
                    onClick={() => handleSecondaryGoalToggle(goal.id)}
                    disabled={isDisabled}
                    className={`w-full text-left px-4 py-3 rounded-xl border-2 transition-all ${
                      isSelected
                        ? 'bg-gradient-to-r from-rose-50 to-pink-50 border-rose-400 shadow-md'
                        : isDisabled
                        ? 'bg-gray-50 border-gray-200 cursor-not-allowed opacity-50'
                        : 'bg-white border-pink-200 hover:border-pink-300 hover:bg-pink-50/50'
                    }`}
                  >
                    <div className="flex items-center gap-3">
                      <div
                        className={`w-5 h-5 rounded-md border-2 flex items-center justify-center flex-shrink-0 ${
                          isSelected
                            ? 'bg-rose-500 border-rose-500'
                            : 'bg-white border-pink-300'
                        }`}
                      >
                        {isSelected && <Check className="w-3.5 h-3.5 text-white" />}
                      </div>
                      <div className="flex-1">
                        <p className={`text-sm font-medium ${isSelected ? 'text-rose-700' : 'text-gray-800'}`}>
                          {goal.text}
                        </p>
                        <p className="text-xs text-gray-500 mt-0.5">{goal.category}</p>
                      </div>
                    </div>
                  </button>
                );
              })}
            </div>
          </div>

          <div className="bg-gradient-to-br from-purple-50 to-pink-50 rounded-2xl p-6 border border-purple-200/50">
            <div className="flex gap-3">
              <Target className="w-5 h-5 text-purple-500 flex-shrink-0 mt-0.5" />
              <div>
                <h3 className="font-semibold text-gray-800 mb-1">Personalized Guidance</h3>
                <p className="text-sm text-gray-600 leading-relaxed">
                  These goals help Cherish AI understand what matters most in your relationship, so we can provide tailored suggestions and meaningful gift ideas.
                </p>
              </div>
            </div>
          </div>
        </motion.div>

        {/* List-Based Fields (Read-Only with Edit Links) */}
        <motion.div
          initial={{ opacity: 0, y: 20 }}
          animate={{ opacity: 1, y: 0 }}
          transition={{ delay: 0.2 }}
          className="mt-8 space-y-4"
        >
          <h2 className="text-xl font-semibold text-gray-800 flex items-center gap-2">
            <Sparkles className="w-5 h-5 text-rose-500" />
            Hobbies & Preferences
          </h2>
          
          <p className="text-sm text-gray-600 mb-4">
            Select hobbies, interests, and dislikes directly on this page - all changes save automatically when you click Save
          </p>

          {/* Hobbies & Interests - Inline Editing */}
          <div className="bg-white/80 backdrop-blur-sm rounded-2xl p-6 border border-purple-200/50 shadow-sm">
            <div className="flex items-start justify-between mb-3">
              <label className="block text-sm font-medium text-gray-700">
                🎨 Hobbies & Interests <span className="text-gray-500 text-xs">(Select up to 8 total, 1 per category)</span>
              </label>
              <span className="text-xs px-2 py-1 rounded-full bg-purple-100 text-purple-700 font-medium">
                {getTotalHobbies()}/8
              </span>
            </div>
            
            <div className="space-y-3">
              {hobbyCategories.map((category, index) => {
                const categoryHobbies = selectedHobbies[category.id] || [];
                const isMaxReached = categoryHobbies.length >= 1;
                
                return (
                  <div key={category.id} className={`${category.bgColor} rounded-xl p-4 border border-purple-200/30`}>
                    <h4 className="font-semibold text-gray-800 text-sm mb-2">{category.name}</h4>
                    <div className="flex flex-wrap gap-2">
                      {category.hobbies.map((hobby) => {
                        const isSelected = categoryHobbies.includes(hobby);
                        const isDisabled = !isSelected && isMaxReached;
                        
                        return (
                          <button
                            key={hobby}
                            onClick={() => handleHobbyToggle(category.id, hobby)}
                            disabled={isDisabled}
                            className={`px-3 py-1.5 rounded-full text-sm font-medium transition-all ${
                              isSelected
                                ? `bg-gradient-to-r ${category.gradient} text-white shadow-md`
                                : isDisabled
                                ? 'bg-white/50 text-gray-400 cursor-not-allowed'
                                : 'bg-white text-gray-700 hover:shadow-sm border border-purple-200'
                            }`}
                          >
                            {hobby}
                          </button>
                        );
                      })}
                    </div>
                  </div>
                );
              })}
            </div>
          </div>

          {/* Dislikes - Inline Editing */}
          <div className="bg-white/80 backdrop-blur-sm rounded-2xl p-6 border border-red-200/50 shadow-sm">
            <div className="flex items-start justify-between mb-3">
              <div className="flex items-center gap-2">
                <ShieldOff className="w-5 h-5 text-red-500" />
                <label className="block text-sm font-medium text-gray-700">
                  Dislikes <span className="text-gray-500 text-xs">(Select up to 4 + 2 custom)</span>
                </label>
              </div>
              <span className="text-xs px-2 py-1 rounded-full bg-red-100 text-red-700 font-medium">
                {getTotalDislikes()}/6
              </span>
            </div>
            
            {/* Custom Dislikes Display */}
            {customDislikes.length > 0 && (
              <div className="mb-4">
                <p className="text-xs font-medium text-gray-600 mb-2">Custom Dislikes</p>
                <div className="flex flex-wrap gap-2">
                  {customDislikes.map((dislike) => (
                    <div
                      key={dislike}
                      className="inline-flex items-center gap-2 px-3 py-1.5 rounded-full bg-gradient-to-r from-red-100 to-rose-100 text-gray-700 shadow-sm border border-red-200"
                    >
                      <span className="text-sm font-medium">{dislike}</span>
                      <button
                        onClick={() => handleRemoveCustomDislike(dislike)}
                        className="p-0.5 rounded-full hover:bg-red-200 text-gray-600 hover:text-red-600 transition-colors"
                      >
                        <X className="w-3 h-3" />
                      </button>
                    </div>
                  ))}
                </div>
              </div>
            )}
            
            <div className="space-y-3">
              {dislikeCategories.map((category) => {
                const categoryDislikes = selectedDislikes[category.id] || [];
                const isMaxReached = categoryDislikes.length >= 1;
                
                return (
                  <div key={category.id} className={`${category.bgColor} rounded-xl p-4 border border-red-200/30`}>
                    <h4 className="font-semibold text-gray-800 text-sm mb-2">{category.name}</h4>
                    <div className="flex flex-wrap gap-2">
                      {category.dislikes.map((dislike) => {
                        const isSelected = categoryDislikes.includes(dislike);
                        const isDisabled = !isSelected && isMaxReached;
                        
                        return (
                          <button
                            key={dislike}
                            onClick={() => handleDislikeToggle(category.id, dislike)}
                            disabled={isDisabled}
                            className={`px-3 py-1.5 rounded-full text-sm font-medium transition-all ${
                              isSelected
                                ? `bg-gradient-to-r ${category.gradient} text-white shadow-md`
                                : isDisabled
                                ? 'bg-white/50 text-gray-400 cursor-not-allowed'
                                : 'bg-white text-gray-700 hover:shadow-sm border border-red-200'
                            }`}
                          >
                            {dislike}
                          </button>
                        );
                      })}
                    </div>
                  </div>
                );
              })}
            </div>
            
            {/* Add Custom Dislike Input */}
            {customDislikes.length < 2 && (
              <div className="mt-4 p-3 bg-red-50/50 rounded-xl border border-red-200/50">
                <input
                  type="text"
                  placeholder="Add custom dislike (press Enter)"
                  className="w-full px-3 py-2 rounded-lg border border-red-200 focus:border-red-400 focus:ring-2 focus:ring-red-200 outline-none transition-all text-sm text-gray-800 bg-white"
                  onKeyPress={(e) => {
                    if (e.key === 'Enter') {
                      const value = (e.target as HTMLInputElement).value;
                      if (value.trim()) {
                        handleAddCustomDislike(value);
                        (e.target as HTMLInputElement).value = '';
                      }
                    }
                  }}
                />
                <p className="text-xs text-gray-500 mt-2">Press Enter to add</p>
              </div>
            )}
          </div>
        </motion.div>
      </div>

      {/* Save Button (Fixed at Bottom on Mobile) */}
      <div className="fixed bottom-0 left-0 right-0 bg-gradient-to-t from-white via-white/95 to-transparent pt-6 pb-6 px-6 md:hidden">
        <div className="max-w-2xl mx-auto">
          <button
            onClick={handleSave}
            disabled={isSaving}
            className="w-full py-4 px-6 rounded-2xl bg-gradient-to-r from-rose-500 via-pink-500 to-purple-500 text-white font-semibold text-lg shadow-lg shadow-pink-300/50 hover:shadow-xl hover:scale-[1.02] active:scale-[0.98] transition-all disabled:opacity-50 disabled:cursor-not-allowed"
          >
            {isSaving ? (
              <div className="flex items-center justify-center gap-2">
                <div className="w-5 h-5 border-2 border-white border-t-transparent rounded-full animate-spin" />
                <span>Saving Changes...</span>
              </div>
            ) : (
              'Save Changes'
            )}
          </button>
        </div>
      </div>
    </div>
  );
}