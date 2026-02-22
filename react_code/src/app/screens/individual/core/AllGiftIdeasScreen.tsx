import { useState } from 'react';
import { useNavigate } from 'react-router';
import { ArrowLeft, Gift, Calendar, Heart, SlidersHorizontal, ChevronDown, ChevronUp } from 'lucide-react';
import { motion, AnimatePresence } from 'motion/react';
import BottomNav from '../../../components/BottomNav';

// Type for gift idea
interface GiftIdea {
  id: number;
  name: string;
  description: string;
  price: string;
  priceValue: number;
  category: string;
  image: string;
  lovedOneName: string;
  lovedOneId: number;
  occasion: string;
  occasionDate: string;
  dateProposed: string;
  isSaved: boolean;
  tags: string[];
}

export default function AllGiftIdeasScreen() {
  const navigate = useNavigate();
  const [sortBy, setSortBy] = useState<'date' | 'occasion' | 'lovedOne'>('date');
  const [expandedSections, setExpandedSections] = useState<Set<string>>(new Set(['all']));
  const [showFilters, setShowFilters] = useState(false);

  // Mock data - In production, this would come from your database
  const allGiftIdeas: GiftIdea[] = [
    // Sarah's Birthday (January 23, 2026)
    {
      id: 1,
      name: 'Custom Star Map',
      description: 'Beautiful constellation map of your special night',
      price: '$79',
      priceValue: 79,
      category: 'Personalized',
      image: 'space night sky',
      lovedOneName: 'Sarah',
      lovedOneId: 1,
      occasion: 'Birthday',
      occasionDate: 'January 23, 2026',
      dateProposed: 'January 10, 2026',
      isSaved: true,
      tags: ['romantic', 'personalized', 'wall art'],
    },
    {
      id: 2,
      name: 'Spa Day Package',
      description: 'Luxury spa experience with massage and facial',
      price: '$250',
      priceValue: 250,
      category: 'Experience',
      image: 'spa wellness',
      lovedOneName: 'Sarah',
      lovedOneId: 1,
      occasion: 'Birthday',
      occasionDate: 'January 23, 2026',
      dateProposed: 'January 12, 2026',
      isSaved: true,
      tags: ['experience', 'relaxation', 'wellness'],
    },
    {
      id: 3,
      name: 'Designer Handbag',
      description: 'Elegant leather handbag in her favorite color',
      price: '$420',
      priceValue: 420,
      category: 'Luxury',
      image: 'luxury handbag',
      lovedOneName: 'Sarah',
      lovedOneId: 1,
      occasion: 'Birthday',
      occasionDate: 'January 23, 2026',
      dateProposed: 'January 8, 2026',
      isSaved: false,
      tags: ['fashion', 'luxury', 'accessories'],
    },
    // Mom's Mother's Day (May 11, 2026)
    {
      id: 4,
      name: 'Jewelry Box',
      description: 'Handcrafted wooden jewelry organizer',
      price: '$95',
      priceValue: 95,
      category: 'Personalized',
      image: 'jewelry box wood',
      lovedOneName: 'Mom',
      lovedOneId: 2,
      occasion: "Mother's Day",
      occasionDate: 'May 11, 2026',
      dateProposed: 'January 15, 2026',
      isSaved: true,
      tags: ['practical', 'handcrafted', 'storage'],
    },
    {
      id: 5,
      name: 'Garden Tool Set',
      description: 'Premium gardening tools with personalized engraving',
      price: '$145',
      priceValue: 145,
      category: 'Practical',
      image: 'garden tools',
      lovedOneName: 'Mom',
      lovedOneId: 2,
      occasion: "Mother's Day",
      occasionDate: 'May 11, 2026',
      dateProposed: 'January 20, 2026',
      isSaved: false,
      tags: ['hobby', 'outdoor', 'tools'],
    },
    {
      id: 6,
      name: 'Cooking Class Experience',
      description: 'Italian cooking class for two',
      price: '$180',
      priceValue: 180,
      category: 'Experience',
      image: 'cooking class italian',
      lovedOneName: 'Mom',
      lovedOneId: 2,
      occasion: "Mother's Day",
      occasionDate: 'May 11, 2026',
      dateProposed: 'January 18, 2026',
      isSaved: true,
      tags: ['experience', 'food', 'quality time'],
    },
    // Jake's Friendship Anniversary (March 15, 2026)
    {
      id: 7,
      name: 'Gaming Headset',
      description: 'Wireless gaming headset with noise cancellation',
      price: '$199',
      priceValue: 199,
      category: 'Tech',
      image: 'gaming headset',
      lovedOneName: 'Jake',
      lovedOneId: 3,
      occasion: 'Friendship Anniversary',
      occasionDate: 'March 15, 2026',
      dateProposed: 'January 22, 2026',
      isSaved: true,
      tags: ['gaming', 'tech', 'audio'],
    },
    {
      id: 8,
      name: 'Concert Tickets',
      description: 'VIP tickets to his favorite band',
      price: '$320',
      priceValue: 320,
      category: 'Experience',
      image: 'concert music live',
      lovedOneName: 'Jake',
      lovedOneId: 3,
      occasion: 'Friendship Anniversary',
      occasionDate: 'March 15, 2026',
      dateProposed: 'January 14, 2026',
      isSaved: false,
      tags: ['experience', 'music', 'entertainment'],
    },
    // Dad's Father's Day (June 21, 2026)
    {
      id: 9,
      name: 'Smart Watch',
      description: 'Fitness tracker with health monitoring',
      price: '$299',
      priceValue: 299,
      category: 'Tech',
      image: 'smart watch fitness',
      lovedOneName: 'Dad',
      lovedOneId: 4,
      occasion: "Father's Day",
      occasionDate: 'June 21, 2026',
      dateProposed: 'January 25, 2026',
      isSaved: true,
      tags: ['tech', 'fitness', 'health'],
    },
    {
      id: 10,
      name: 'Golf Club Set',
      description: 'Professional grade golf clubs',
      price: '$850',
      priceValue: 850,
      category: 'Sport',
      image: 'golf clubs',
      lovedOneName: 'Dad',
      lovedOneId: 4,
      occasion: "Father's Day",
      occasionDate: 'June 21, 2026',
      dateProposed: 'January 16, 2026',
      isSaved: false,
      tags: ['sport', 'hobby', 'outdoor'],
    },
    {
      id: 11,
      name: 'Whiskey Tasting Set',
      description: 'Premium whiskey collection from around the world',
      price: '$165',
      priceValue: 165,
      category: 'Luxury',
      image: 'whiskey tasting',
      lovedOneName: 'Dad',
      lovedOneId: 4,
      occasion: "Father's Day",
      occasionDate: 'June 21, 2026',
      dateProposed: 'January 24, 2026',
      isSaved: true,
      tags: ['luxury', 'spirits', 'collection'],
    },
  ];

  // Organize gifts based on sort option
  const organizeGifts = () => {
    if (sortBy === 'date') {
      // Group by date proposed (most recent first)
      const sorted = [...allGiftIdeas].sort((a, b) => 
        new Date(b.dateProposed).getTime() - new Date(a.dateProposed).getTime()
      );
      
      const grouped: { [key: string]: GiftIdea[] } = {};
      sorted.forEach(gift => {
        const date = new Date(gift.dateProposed);
        const monthYear = date.toLocaleDateString('en-US', { month: 'long', year: 'numeric' });
        if (!grouped[monthYear]) grouped[monthYear] = [];
        grouped[monthYear].push(gift);
      });
      
      return grouped;
    } else if (sortBy === 'occasion') {
      // Group by occasion (chronologically by occasion date)
      const sorted = [...allGiftIdeas].sort((a, b) => 
        new Date(a.occasionDate).getTime() - new Date(b.occasionDate).getTime()
      );
      
      const grouped: { [key: string]: GiftIdea[] } = {};
      sorted.forEach(gift => {
        const key = `${gift.occasion} - ${gift.occasionDate}`;
        if (!grouped[key]) grouped[key] = [];
        grouped[key].push(gift);
      });
      
      return grouped;
    } else {
      // Group by loved one
      const grouped: { [key: string]: GiftIdea[] } = {};
      allGiftIdeas.forEach(gift => {
        if (!grouped[gift.lovedOneName]) grouped[gift.lovedOneName] = [];
        grouped[gift.lovedOneName].push(gift);
      });
      
      return grouped;
    }
  };

  const organizedGifts = organizeGifts();

  const toggleSection = (section: string) => {
    setExpandedSections(prev => {
      const newSet = new Set(prev);
      if (newSet.has(section)) {
        newSet.delete(section);
      } else {
        newSet.add(section);
      }
      return newSet;
    });
  };

  return (
    <div className="min-h-screen bg-gradient-to-br from-rose-50 via-pink-50 to-purple-50 pb-24">
      {/* Header */}
      <div className="sticky top-0 z-20 bg-gradient-to-br from-rose-50/95 via-pink-50/95 to-purple-50/95 backdrop-blur-xl border-b border-pink-100/50">
        <div className="max-w-4xl mx-auto px-6 py-6">
          {/* Back Button */}
          <motion.button
            onClick={() => navigate(-1)}
            className="mb-4 p-2.5 rounded-xl bg-gradient-to-br from-purple-500 to-pink-500 border border-purple-400 hover:shadow-lg transition-all shadow-md inline-flex items-center justify-center"
            whileHover={{ scale: 1.05 }}
            whileTap={{ scale: 0.95 }}
          >
            <ArrowLeft className="w-5 h-5 text-white" />
          </motion.button>
          
          <h1 className="text-3xl font-bold bg-gradient-to-r from-rose-600 via-pink-600 to-purple-600 bg-clip-text text-transparent mb-2">
            All Gift Ideas
          </h1>
          <p className="text-gray-600">
            Every gift idea you've ever explored, organized just for you
          </p>
        </div>
      </div>

      {/* Stats Bar */}
      <div className="max-w-4xl mx-auto px-6 pt-6">
        <motion.div
          className="bg-white/80 backdrop-blur border border-pink-200/50 rounded-2xl p-5 shadow-lg mb-6"
          initial={{ opacity: 0, y: 20 }}
          animate={{ opacity: 1, y: 0 }}
        >
          <div className="grid grid-cols-3 gap-4 text-center">
            <div>
              <p className="text-2xl font-bold bg-gradient-to-r from-rose-600 to-pink-600 bg-clip-text text-transparent">
                {allGiftIdeas.length}
              </p>
              <p className="text-xs text-gray-600 mt-1">Total Ideas</p>
            </div>
            <div>
              <p className="text-2xl font-bold bg-gradient-to-r from-purple-600 to-pink-600 bg-clip-text text-transparent">
                {allGiftIdeas.filter(g => g.isSaved).length}
              </p>
              <p className="text-xs text-gray-600 mt-1">Saved</p>
            </div>
            <div>
              <p className="text-2xl font-bold bg-gradient-to-r from-pink-600 to-rose-600 bg-clip-text text-transparent">
                {new Set(allGiftIdeas.map(g => g.lovedOneName)).size}
              </p>
              <p className="text-xs text-gray-600 mt-1">Loved Ones</p>
            </div>
          </div>
        </motion.div>

        {/* Sort/Filter Controls */}
        <div className="flex gap-3 mb-6">
          <button
            onClick={() => setShowFilters(!showFilters)}
            className="flex-1 py-3 px-5 rounded-2xl bg-white/80 backdrop-blur border border-pink-200/50 shadow-lg hover:shadow-xl transition-all flex items-center justify-center gap-2 text-gray-800 font-medium"
          >
            <SlidersHorizontal className="w-4 h-4" />
            Sort by
          </button>
        </div>

        {/* Sort Options */}
        <AnimatePresence>
          {showFilters && (
            <motion.div
              initial={{ opacity: 0, height: 0 }}
              animate={{ opacity: 1, height: 'auto' }}
              exit={{ opacity: 0, height: 0 }}
              className="mb-6 overflow-hidden"
            >
              <div className="bg-white/80 backdrop-blur border border-pink-200/50 rounded-2xl p-4 shadow-lg space-y-2">
                {[
                  { value: 'date', label: 'Date Proposed', icon: Calendar },
                  { value: 'occasion', label: 'Occasion', icon: Gift },
                  { value: 'lovedOne', label: 'Loved One', icon: Heart },
                ].map((option) => {
                  const Icon = option.icon;
                  return (
                    <button
                      key={option.value}
                      onClick={() => {
                        setSortBy(option.value as any);
                        setExpandedSections(new Set(['all']));
                      }}
                      className={`w-full py-3 px-4 rounded-xl transition-all flex items-center gap-3 ${
                        sortBy === option.value
                          ? 'bg-gradient-to-r from-rose-500 to-pink-500 text-white shadow-lg'
                          : 'bg-gray-50 text-gray-700 hover:bg-gray-100'
                      }`}
                    >
                      <Icon className="w-4 h-4" />
                      <span className="font-medium">{option.label}</span>
                      {sortBy === option.value && (
                        <div className="ml-auto w-2 h-2 rounded-full bg-white"></div>
                      )}
                    </button>
                  );
                })}
              </div>
            </motion.div>
          )}
        </AnimatePresence>
      </div>

      {/* Organized Gift Ideas */}
      <div className="max-w-4xl mx-auto px-6 pb-6">
        <div className="space-y-6">
          {Object.entries(organizedGifts).map(([sectionName, gifts], sectionIndex) => (
            <motion.div
              key={sectionName}
              initial={{ opacity: 0, y: 20 }}
              animate={{ opacity: 1, y: 0 }}
              transition={{ delay: sectionIndex * 0.1 }}
            >
              {/* Section Header */}
              <button
                onClick={() => toggleSection(sectionName)}
                className="w-full flex items-center justify-between p-5 bg-white/80 backdrop-blur border border-pink-200/50 rounded-2xl shadow-lg hover:shadow-xl transition-all mb-4"
              >
                <div className="flex items-center gap-3">
                  <div className="w-12 h-12 rounded-xl bg-gradient-to-br from-rose-400 to-purple-400 flex items-center justify-center shadow-lg">
                    <Gift className="w-6 h-6 text-white" />
                  </div>
                  <div className="text-left">
                    <h3 className="text-lg font-bold text-gray-800">{sectionName}</h3>
                    <p className="text-sm text-gray-600">{gifts.length} gift ideas</p>
                  </div>
                </div>
                <motion.div
                  animate={{ rotate: expandedSections.has(sectionName) ? 180 : 0 }}
                  transition={{ duration: 0.3 }}
                >
                  <ChevronDown className="w-5 h-5 text-gray-600" />
                </motion.div>
              </button>

              {/* Section Content */}
              <AnimatePresence>
                {expandedSections.has(sectionName) && (
                  <motion.div
                    initial={{ opacity: 0, height: 0 }}
                    animate={{ opacity: 1, height: 'auto' }}
                    exit={{ opacity: 0, height: 0 }}
                    className="space-y-4 overflow-hidden"
                  >
                    {gifts.map((gift, index) => (
                      <motion.div
                        key={gift.id}
                        initial={{ opacity: 0, x: -20 }}
                        animate={{ opacity: 1, x: 0 }}
                        transition={{ delay: index * 0.05 }}
                        className="bg-white/80 backdrop-blur border border-pink-200/50 rounded-2xl overflow-hidden shadow-lg hover:shadow-xl transition-all"
                      >
                        <div className="p-5">
                          <div className="flex gap-4">
                            {/* Gift Info */}
                            <div className="flex-1">
                              <div className="flex items-start justify-between mb-2">
                                <div>
                                  <h4 className="text-lg font-bold text-gray-800">{gift.name}</h4>
                                  <p className="text-sm text-gray-600 mt-1">{gift.description}</p>
                                </div>
                                {gift.isSaved && (
                                  <div className="ml-3 flex-shrink-0">
                                    <div className="w-8 h-8 rounded-full bg-gradient-to-br from-rose-400 to-pink-400 flex items-center justify-center shadow-md">
                                      <Heart className="w-4 h-4 text-white fill-current" />
                                    </div>
                                  </div>
                                )}
                              </div>

                              {/* Meta Info */}
                              <div className="mt-4 space-y-2">
                                <div className="flex flex-wrap gap-2">
                                  <span className="px-3 py-1 rounded-full text-xs font-medium bg-gradient-to-r from-rose-100 to-pink-100 text-rose-700">
                                    {gift.lovedOneName}
                                  </span>
                                  <span className="px-3 py-1 rounded-full text-xs font-medium bg-gradient-to-r from-purple-100 to-pink-100 text-purple-700">
                                    {gift.occasion}
                                  </span>
                                  <span className="px-3 py-1 rounded-full text-xs font-medium bg-gradient-to-r from-pink-100 to-rose-100 text-pink-700">
                                    {gift.category}
                                  </span>
                                </div>
                                <div className="flex items-center justify-between text-xs text-gray-500">
                                  <span>Proposed: {gift.dateProposed}</span>
                                  <span className="font-bold text-rose-600 text-base">{gift.price}</span>
                                </div>
                              </div>
                            </div>
                          </div>
                        </div>
                      </motion.div>
                    ))}
                  </motion.div>
                )}
              </AnimatePresence>
            </motion.div>
          ))}
        </div>
      </div>

      <BottomNav />
    </div>
  );
}