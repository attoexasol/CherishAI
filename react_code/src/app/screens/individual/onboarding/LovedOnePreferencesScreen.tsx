import { useState } from 'react';
import { useNavigate, useLocation } from 'react-router-dom';
import { ArrowLeft, Plus, X, Sparkles, Heart, Calendar, Gift } from 'lucide-react';
import BackButton from '@/app/components/BackButton';

interface Hobby {
  id: number;
  name: string;
  category: string;
}

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

export default function LovedOnePreferencesScreen() {
  const navigate = useNavigate();
  const location = useLocation();
  const [selectedHobbies, setSelectedHobbies] = useState<{ [category: string]: string[] }>({});
  const [customHobby, setCustomHobby] = useState('');
  const [showCustomHobbyInput, setShowCustomHobbyInput] = useState(false);
  
  // Special Occasions State
  const [occasions, setOccasions] = useState<Array<{ id: string; name: string; date: string }>>([]);
  const [showAddOccasion, setShowAddOccasion] = useState(false);
  const [occasionName, setOccasionName] = useState('');
  const [occasionDate, setOccasionDate] = useState('');

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

  const handleAddCustomHobby = () => {
    if (customHobby.trim()) {
      const customCategory = 'custom';
      const currentCustom = selectedHobbies[customCategory] || [];
      if (currentCustom.length < 2) {
        setSelectedHobbies({
          ...selectedHobbies,
          [customCategory]: [...currentCustom, customHobby],
        });
        setCustomHobby('');
        setShowCustomHobbyInput(false);
      }
    }
  };

  const handleRemoveCustomHobby = (hobby: string) => {
    const customCategory = 'custom';
    const currentCustom = selectedHobbies[customCategory] || [];
    setSelectedHobbies({
      ...selectedHobbies,
      [customCategory]: currentCustom.filter(h => h !== hobby),
    });
  };

  const handleAddOccasion = () => {
    if (occasionName.trim() && occasionDate) {
      const newOccasion = {
        id: Date.now().toString(),
        name: occasionName,
        date: occasionDate,
      };
      setOccasions([...occasions, newOccasion]);
      setOccasionName('');
      setOccasionDate('');
      setShowAddOccasion(false);
    }
  };

  const handleRemoveOccasion = (id: string) => {
    setOccasions(occasions.filter((occasion) => occasion.id !== id));
  };

  const handleContinue = () => {
    // Check if we're coming from the edit screen
    const state = location.state as { from?: string; lovedOneId?: string } | null;
    
    if (state?.from === 'edit' && state?.lovedOneId) {
      // Save changes and navigate back to edit screen
      // In a real app, you would save to AppContext or API here
      console.log('Saving hobbies for loved one:', state.lovedOneId, selectedHobbies);
      navigate(`/individual/edit-loved-one/${state.lovedOneId}`);
    } else {
      // Continue with onboarding flow
      navigate('/individual/dislikes');
    }
  };

  return (
    <div className="min-h-screen bg-gradient-to-br from-rose-50 via-pink-50 to-purple-50 pt-20 pb-32 relative">
      {/* Back Button */}
      <BackButton to="/individual/secondary-goals-context" />
      
      {/* Header */}
      <div className="sticky top-0 z-20 bg-gradient-to-br from-rose-50/95 via-pink-50/95 to-purple-50/95 backdrop-blur-xl border-b border-pink-100/50">
        <div className="max-w-2xl mx-auto px-6 py-4">
          <div className="flex items-center justify-end">
            <div className="flex gap-1.5">
              <div className="h-1.5 w-8 rounded-full bg-gradient-to-r from-rose-400 to-pink-400"></div>
              <div className="h-1.5 w-8 rounded-full bg-gradient-to-r from-rose-400 to-pink-400"></div>
              <div className="h-1.5 w-8 rounded-full bg-gradient-to-r from-rose-400 to-pink-400"></div>
            </div>
          </div>
        </div>
      </div>

      {/* Main Content */}
      <div className="max-w-2xl mx-auto px-6 pt-2">
        {/* Title Section */}
        <div className="mb-8 text-center">
          <div className="inline-flex items-center gap-2 px-4 py-2 rounded-full bg-gradient-to-r from-pink-100 to-purple-100 mb-4">
            <Heart className="w-4 h-4 text-purple-600" />
            <span className="text-sm font-medium text-purple-700">Optional</span>
          </div>
          <h1 className="text-2xl text-gray-800 mb-3 text-center">
            Tell Cherish more about your loved one
          </h1>
          <p className="text-base text-gray-500 italic mb-2">
            *For a more personalized experience, let's Cherish AI get to know more*
          </p>
          <p className="text-sm text-gray-400">
            All fields are optional — share what you know
          </p>
        </div>

        {/* Special Occasions Section */}
        <div className="mb-8">
          <div className="mb-4">
            <div className="flex items-center gap-3 mb-2">
              <div className="p-2.5 rounded-xl bg-gradient-to-br from-purple-100 to-pink-100 shadow-sm">
                <Calendar className="w-5 h-5 text-purple-600" />
              </div>
              <h2 className="text-xl font-semibold text-gray-800">SPECIAL OCCASIONS (Final step)</h2>
            </div>
            <p className="text-sm text-gray-600 leading-relaxed">
              Share important dates to help Cherish AI plan meaningful moments
            </p>
          </div>

          {/* Add Occasion Button */}
          {!showAddOccasion ? (
            <button
              onClick={() => setShowAddOccasion(true)}
              className="w-full py-4 px-5 rounded-2xl border-2 border-dashed border-rose-300 hover:border-rose-400 bg-rose-50/50 hover:bg-rose-50 text-rose-600 font-medium transition-all flex items-center justify-center gap-2 shadow-sm"
            >
              <Plus className="w-5 h-5" />
              Add Special Occasion
            </button>
          ) : (
            <div className="bg-white rounded-2xl p-5 border border-pink-200/50 shadow-sm">
              <h3 className="font-semibold text-gray-800 mb-4">Add Special Occasion</h3>
              <div className="space-y-4">
                <input
                  type="text"
                  value={occasionName}
                  onChange={(e) => setOccasionName(e.target.value)}
                  placeholder="e.g., Birthday, Anniversary, Wedding"
                  className="w-full px-4 py-3 rounded-xl border border-pink-200 focus:border-pink-400 focus:ring-2 focus:ring-pink-200 outline-none transition-all text-gray-800 bg-white"
                />
                <input
                  type="date"
                  value={occasionDate}
                  onChange={(e) => setOccasionDate(e.target.value)}
                  className="w-full px-4 py-3 rounded-xl border border-pink-200 focus:border-pink-400 focus:ring-2 focus:ring-pink-200 outline-none transition-all text-gray-800 bg-white"
                />
                <div className="flex gap-2">
                  <button
                    onClick={handleAddOccasion}
                    disabled={!occasionName.trim() || !occasionDate}
                    className="flex-1 py-2.5 px-4 rounded-xl bg-gradient-to-r from-rose-500 via-pink-500 to-purple-500 text-white font-medium disabled:opacity-50 disabled:cursor-not-allowed hover:shadow-lg shadow-pink-300/50 hover:shadow-pink-300/60 transition-all"
                  >
                    Add Occasion
                  </button>
                  <button
                    onClick={() => {
                      setShowAddOccasion(false);
                      setOccasionName('');
                      setOccasionDate('');
                    }}
                    className="px-5 py-2.5 rounded-xl border border-pink-200 bg-white text-gray-600 hover:bg-pink-50 transition-all font-medium"
                  >
                    Cancel
                  </button>
                </div>
              </div>
            </div>
          )}

          {/* Display Occasions */}
          {occasions.length > 0 && (
            <div className="bg-white rounded-2xl p-5 border border-pink-200/30 shadow-sm space-y-4">
              {occasions.map((occasion) => (
                <div
                  key={occasion.id}
                  className="flex items-center justify-between gap-2 px-4 py-2 rounded-full bg-white text-gray-700 shadow-sm border border-pink-200/30"
                >
                  <span className="text-sm font-medium">{occasion.name}</span>
                  <span className="text-sm font-medium">{occasion.date}</span>
                  <button
                    onClick={() => handleRemoveOccasion(occasion.id)}
                    className="p-0.5 rounded-full hover:bg-pink-100 text-gray-600 hover:text-rose-600 transition-colors"
                  >
                    <X className="w-3.5 h-3.5" />
                  </button>
                </div>
              ))}
            </div>
          )}
        </div>

        {/* Hobbies Section */}
        <div className="mb-8">
          <div className="mb-4">
            <div className="flex items-center gap-3 mb-2">
              <div className="p-2.5 rounded-xl bg-gradient-to-br from-purple-100 to-pink-100 shadow-sm">
                <Sparkles className="w-5 h-5 text-purple-600" />
              </div>
              <h2 className="text-xl font-semibold text-gray-800">HOBBIES & INTERESTS (max 1 per category)</h2>
            </div>
            <p className="text-sm text-gray-600 leading-relaxed">
              Share what your loved one enjoys and feels drawn to, so Cherish AI can personalize care in ways that truly resonate
            </p>
          </div>

          {/* Custom Hobbies Display */}
          {selectedHobbies['custom'] && selectedHobbies['custom'].length > 0 && (
            <div className="mb-4">
              <p className="text-sm font-medium text-gray-600 mb-2">Custom Hobbies</p>
              <div className="flex flex-wrap gap-2">
                {selectedHobbies['custom'].map((hobby) => (
                  <div
                    key={hobby}
                    className="inline-flex items-center gap-2 px-4 py-2 rounded-full bg-white text-gray-700 shadow-sm border border-pink-200/30"
                  >
                    <span className="text-sm font-medium">{hobby}</span>
                    <button
                      onClick={() => handleRemoveCustomHobby(hobby)}
                      className="p-0.5 rounded-full hover:bg-pink-100 text-gray-600 hover:text-rose-600 transition-colors"
                    >
                      <X className="w-3.5 h-3.5" />
                    </button>
                  </div>
                ))}
              </div>
            </div>
          )}

          {/* Hobby Categories */}
          <div className="space-y-6">
            {hobbyCategories.map((category, index) => {
              const categoryHobbies = selectedHobbies[category.id] || [];
              const isMaxReached = categoryHobbies.length >= 1;

              return (
                <div
                  key={category.id}
                  style={{
                    animation: `fadeSlideIn 0.5s ease-out ${index * 0.1}s both`,
                  }}
                >
                  <div className={`${category.bgColor} rounded-2xl p-5 border border-pink-200/30 shadow-sm`}>
                    <h3 className="font-semibold text-gray-800 mb-3">{category.name}</h3>
                    <div className="flex flex-wrap gap-2">
                      {category.hobbies.map((hobby) => {
                        const isSelected = categoryHobbies.includes(hobby);
                        const isDisabled = !isSelected && isMaxReached;

                        return (
                          <button
                            key={hobby}
                            onClick={() => handleHobbyToggle(category.id, hobby)}
                            disabled={isDisabled}
                            className={`
                              px-4 py-2 rounded-full text-sm font-medium transition-all
                              ${
                                isSelected
                                  ? 'text-white shadow-md scale-105'
                                  : isDisabled
                                  ? 'bg-white/50 text-gray-400 cursor-not-allowed'
                                  : 'bg-white text-gray-700 hover:bg-white/80 hover:shadow-sm'
                              }
                            `}
                            style={{
                              background: isSelected ? 'linear-gradient(135deg, #E91E63, #F06292)' : undefined,
                              border: isSelected ? '2px solid #E91E63' : undefined,
                              boxShadow: isSelected ? '0px 8px 24px rgba(233, 30, 99, 0.35)' : undefined,
                            }}
                          >
                            {hobby}
                          </button>
                        );
                      })}
                    </div>
                    {categoryHobbies.length > 0 && (
                      <p className="text-xs text-gray-500 mt-3">
                        {categoryHobbies.length} of 1 selected
                      </p>
                    )}
                  </div>
                </div>
              );
            })}
          </div>

          {/* Add Custom Hobby */}
          <div className="mt-6">
            {!showCustomHobbyInput ? (
              <button
                onClick={() => setShowCustomHobbyInput(true)}
                disabled={(selectedHobbies['custom'] || []).length >= 2}
                className={`w-full py-4 px-5 rounded-2xl border border-pink-200/50 font-medium transition-all flex items-center justify-center gap-2 shadow-sm ${
                  (selectedHobbies['custom'] || []).length >= 2
                    ? 'bg-gray-100 text-gray-400 cursor-not-allowed'
                    : 'bg-white text-gray-700 hover:shadow-md hover:border-pink-300/60'
                }`}
              >
                <Plus className="w-5 h-5" />
                Add Custom Hobby {(selectedHobbies['custom'] || []).length >= 2 ? '(Max 2 reached)' : ''}
              </button>
            ) : (
              <div className="bg-white rounded-2xl p-5 border border-pink-200/50 shadow-sm">
                <h3 className="font-semibold text-gray-800 mb-4">Add Custom Hobby</h3>
                <div className="space-y-4">
                  <input
                    type="text"
                    value={customHobby}
                    onChange={(e) => setCustomHobby(e.target.value)}
                    placeholder="e.g., Stargazing, Collecting vinyl, Urban gardening"
                    className="w-full px-4 py-3 rounded-xl border border-pink-200 focus:border-pink-400 focus:ring-2 focus:ring-pink-200 outline-none transition-all text-gray-800 bg-white"
                  />
                  <div className="flex gap-2">
                    <button
                      onClick={handleAddCustomHobby}
                      disabled={!customHobby.trim()}
                      className="flex-1 py-2.5 px-4 rounded-xl bg-gradient-to-r from-rose-500 via-pink-500 to-purple-500 text-white font-medium disabled:opacity-50 disabled:cursor-not-allowed hover:shadow-lg shadow-pink-300/50 hover:shadow-pink-300/60 transition-all"
                    >
                      Add Hobby
                    </button>
                    <button
                      onClick={() => {
                        setShowCustomHobbyInput(false);
                        setCustomHobby('');
                      }}
                      className="px-5 py-2.5 rounded-xl border border-pink-200 bg-white text-gray-600 hover:bg-pink-50 transition-all font-medium"
                    >
                      Cancel
                    </button>
                  </div>
                </div>
              </div>
            )}
          </div>
        </div>
      </div>

      {/* Continue Button */}
      <div className="fixed bottom-0 left-0 right-0 bg-gradient-to-t from-white via-white to-transparent pt-6 pb-6 px-6">
        <div className="max-w-2xl mx-auto">
          <button
            onClick={handleContinue}
            className="w-full py-4 px-6 rounded-2xl bg-gradient-to-r from-rose-500 via-pink-500 to-purple-500 text-white font-semibold text-lg shadow-lg shadow-pink-300/50 hover:shadow-xl hover:scale-[1.02] active:scale-[0.98] transition-all"
          >
            Continue
          </button>
        </div>
      </div>

      {/* Animations */}
      <style>{`
        @keyframes fadeSlideIn {
          from {
            opacity: 0;
            transform: translateY(20px);
          }
          to {
            opacity: 1;
            transform: translateY(0);
          }
        }
      `}</style>
    </div>
  );
}