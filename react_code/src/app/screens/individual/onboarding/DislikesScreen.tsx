import { useState } from 'react';
import { useNavigate, useLocation } from 'react-router-dom';
import { ArrowLeft, ShieldOff, Plus, X } from 'lucide-react';

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

export default function DislikesScreen() {
  const navigate = useNavigate();
  const location = useLocation();
  const [selectedDislikes, setSelectedDislikes] = useState<{ [category: string]: string[] }>({});
  const [customDislikes, setCustomDislikes] = useState<string[]>([]);
  const [customDislike, setCustomDislike] = useState('');
  const [showCustomDislikeInput, setShowCustomDislikeInput] = useState(false);

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

  const handleAddCustomDislike = () => {
    if (customDislike.trim() && customDislikes.length < 2) {
      setCustomDislikes([...customDislikes, customDislike]);
      setCustomDislike('');
      setShowCustomDislikeInput(false);
    }
  };

  const handleRemoveCustomDislike = (dislike: string) => {
    setCustomDislikes(customDislikes.filter(d => d !== dislike));
  };

  const handleContinue = () => {
    // Check if we're coming from the edit screen
    const state = location.state as { from?: string; lovedOneId?: string } | null;
    
    if (state?.from === 'edit' && state?.lovedOneId) {
      // Save changes and navigate back to edit screen
      // In a real app, you would save to AppContext or API here
      console.log('Saving dislikes for loved one:', state.lovedOneId, { selectedDislikes, customDislikes });
      navigate(`/individual/edit-loved-one/${state.lovedOneId}`);
    } else {
      // Continue with onboarding flow
      navigate('/individual/personal-note');
    }
  };

  const handleBack = () => {
    navigate(-1);
  };

  const getTotalSelected = () => {
    const categoryCount = Object.values(selectedDislikes).reduce(
      (sum, arr) => sum + arr.length,
      0
    );
    return categoryCount + customDislikes.length;
  };

  return (
    <div className="min-h-screen bg-gradient-to-br from-red-50 via-orange-50 to-pink-50 pb-32">
      {/* Header */}
      <div className="sticky top-0 z-20 bg-gradient-to-br from-red-50/95 via-orange-50/95 to-pink-50/95 backdrop-blur-xl border-b border-red-100/50">
        <div className="max-w-2xl mx-auto px-6 py-4">
          <div className="flex items-center justify-between">
            <button
              onClick={handleBack}
              className="flex items-center gap-2 text-red-600 hover:text-red-700 transition-colors"
            >
              <ArrowLeft className="w-5 h-5" />
              <span className="font-medium">Back</span>
            </button>
            <div className="flex gap-1.5">
              <div className="h-1.5 w-8 rounded-full bg-gradient-to-r from-rose-400 to-pink-400"></div>
              <div className="h-1.5 w-8 rounded-full bg-gradient-to-r from-rose-400 to-pink-400"></div>
              <div className="h-1.5 w-8 rounded-full bg-gradient-to-r from-rose-400 to-pink-400"></div>
            </div>
          </div>
        </div>
      </div>

      {/* Main Content */}
      <div className="max-w-2xl mx-auto px-6 pt-8">
        {/* Title Section */}
        <div className="mb-8 text-center">
          <div className="inline-flex items-center gap-2 px-4 py-2 rounded-full bg-gradient-to-r from-red-100 to-orange-100 mb-4">
            <ShieldOff className="w-4 h-4 text-red-600" />
            <span className="text-sm font-medium text-red-700">Final Step</span>
          </div>
          <h1 className="text-3xl font-bold bg-gradient-to-r from-red-600 via-orange-600 to-pink-600 bg-clip-text text-transparent mb-3">
            DISLIKES
          </h1>
          <p className="text-base text-gray-600 leading-relaxed mb-2">
            Every person is different. Sharing what your loved one dislikes helps Cherish AI care in ways that feel right to them
          </p>
          <p className="text-sm" style={{ color: '#A855F7' }}>
            Optional
          </p>
        </div>

        {/* Selection Counter */}
        {getTotalSelected() > 0 && (
          <div className="mb-6 text-center">
            <div className="inline-flex items-center gap-2 px-5 py-2.5 rounded-2xl bg-white/80 backdrop-blur border border-red-200/50 shadow-sm">
              <ShieldOff className="w-4 h-4 text-red-500" />
              <span className="text-sm font-medium text-gray-700">
                {getTotalSelected()} {getTotalSelected() === 1 ? 'dislike' : 'dislikes'} selected
              </span>
            </div>
          </div>
        )}

        {/* Custom Dislikes Display */}
        {customDislikes.length > 0 && (
          <div className="mb-6">
            <p className="text-sm font-medium text-gray-600 mb-3">Custom Dislikes</p>
            <div className="flex flex-wrap gap-2">
              {customDislikes.map((dislike) => (
                <div
                  key={dislike}
                  className="inline-flex items-center gap-2 px-4 py-2 rounded-full bg-white text-gray-700 shadow-sm border border-red-200/30"
                >
                  <span className="text-sm font-medium">{dislike}</span>
                  <button
                    onClick={() => handleRemoveCustomDislike(dislike)}
                    className="p-0.5 rounded-full hover:bg-red-100 text-gray-600 hover:text-red-600 transition-colors"
                  >
                    <X className="w-3.5 h-3.5" />
                  </button>
                </div>
              ))}
            </div>
          </div>
        )}

        {/* Dislike Categories */}
        <div className="space-y-6 mb-6">
          {dislikeCategories.map((category, index) => {
            const categoryDislikes = selectedDislikes[category.id] || [];
            const isMaxReached = categoryDislikes.length >= 1;

            return (
              <div
                key={category.id}
                style={{
                  animation: `fadeSlideIn 0.5s ease-out ${index * 0.1}s both`,
                }}
              >
                <div className={`${category.bgColor} rounded-2xl p-5 border border-red-200/30 shadow-sm`}>
                  <h3 className="font-semibold text-gray-800 mb-3">{category.name}</h3>
                  <div className="flex flex-wrap gap-2">
                    {category.dislikes.map((dislike) => {
                      const isSelected = categoryDislikes.includes(dislike);
                      const isDisabled = !isSelected && isMaxReached;

                      return (
                        <button
                          key={dislike}
                          onClick={() => handleDislikeToggle(category.id, dislike)}
                          disabled={isDisabled}
                          className={`
                            px-4 py-2 rounded-full text-sm font-medium transition-all
                            ${
                              isSelected
                                ? `bg-gradient-to-r ${category.gradient} text-white shadow-md scale-105`
                                : isDisabled
                                ? 'bg-white/50 text-gray-400 cursor-not-allowed'
                                : 'bg-white text-gray-700 hover:shadow-sm'
                            }
                          `}
                          style={{
                            boxShadow: isSelected ? '0px 8px 24px rgba(220, 38, 38, 0.4), 0px 0px 20px rgba(239, 68, 68, 0.3)' : undefined,
                          }}
                          onMouseEnter={(e) => {
                            if (!isSelected && !isDisabled) {
                              e.currentTarget.style.background = 'linear-gradient(135deg, #E91E63, #F06292)';
                              e.currentTarget.style.color = '#FFFFFF';
                              e.currentTarget.style.boxShadow = '0px 8px 24px rgba(233, 30, 99, 0.4), 0px 0px 20px rgba(233, 30, 99, 0.3)';
                            }
                          }}
                          onMouseLeave={(e) => {
                            if (!isSelected && !isDisabled) {
                              e.currentTarget.style.background = '#FFFFFF';
                              e.currentTarget.style.color = '#374151';
                              e.currentTarget.style.boxShadow = '';
                            }
                          }}
                        >
                          {dislike}
                        </button>
                      );
                    })}
                  </div>
                  {categoryDislikes.length > 0 && (
                    <p className="text-xs text-gray-500 mt-3">
                      {categoryDislikes.length} of 1 selected
                    </p>
                  )}
                </div>
              </div>
            );
          })}
        </div>

        {/* Add Custom Dislike */}
        <div className="mb-8">
          {!showCustomDislikeInput ? (
            <button
              onClick={() => setShowCustomDislikeInput(true)}
              disabled={customDislikes.length >= 2}
              className={`w-full py-4 px-5 rounded-2xl border border-red-200/50 font-medium transition-all flex items-center justify-center gap-2 shadow-sm ${
                customDislikes.length >= 2
                  ? 'bg-gray-100 text-gray-400 cursor-not-allowed'
                  : 'bg-white text-gray-700 hover:shadow-md hover:border-red-300/60'
              }`}
            >
              <Plus className="w-5 h-5" />
              Add Custom Dislike {customDislikes.length >= 2 ? '(Max 2 reached)' : ''}
            </button>
          ) : (
            <div className="bg-white rounded-2xl p-5 border border-red-200/50 shadow-sm">
              <h3 className="font-semibold text-gray-800 mb-4">Add Custom Dislike</h3>
              <div className="space-y-4">
                <input
                  type="text"
                  value={customDislike}
                  onChange={(e) => setCustomDislike(e.target.value)}
                  placeholder="e.g., Strong perfumes, Horror movies, Late-night plans"
                  className="w-full px-4 py-3 rounded-xl border border-pink-200 focus:border-pink-400 focus:ring-2 focus:ring-pink-200 outline-none transition-all text-gray-800 bg-white"
                />
                <div className="flex gap-2">
                  <button
                    onClick={handleAddCustomDislike}
                    disabled={!customDislike.trim()}
                    className="flex-1 py-2.5 px-4 rounded-xl bg-gradient-to-r from-rose-500 via-pink-500 to-purple-500 text-white font-medium disabled:opacity-50 disabled:cursor-not-allowed hover:shadow-lg shadow-pink-300/50 hover:shadow-pink-300/60 transition-all"
                  >
                    Add Dislike
                  </button>
                  <button
                    onClick={() => {
                      setShowCustomDislikeInput(false);
                      setCustomDislike('');
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

      {/* Continue Button */}
      <div className="fixed bottom-0 left-0 right-0 bg-gradient-to-t from-white via-white to-transparent pt-6 pb-6 px-6">
        <div className="max-w-2xl mx-auto">
          <button
            onClick={handleContinue}
            className="w-full py-4 px-6 rounded-2xl bg-gradient-to-r from-rose-500 via-pink-500 to-purple-500 text-white font-semibold text-lg shadow-lg shadow-pink-300/50 hover:shadow-xl hover:scale-[1.02] active:scale-[0.98] transition-all"
          >
            Continue
          </button>
          <p className="text-center text-sm text-gray-500 mt-3">
            You can skip or update these preferences later
          </p>
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