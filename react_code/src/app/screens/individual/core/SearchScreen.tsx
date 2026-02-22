import { useState } from 'react';
import { useNavigate } from 'react-router-dom';
import { Search, Heart, Gift, Calendar, MessageSquare, X, TrendingUp, Clock, ArrowRight, ArrowLeft } from 'lucide-react';
import RomanticCard from '../../../components/RomanticCard';
import BottomNav from '../../../components/BottomNav';
import { motion, AnimatePresence } from 'motion/react';

export default function SearchScreen() {
  const navigate = useNavigate();
  const [searchQuery, setSearchQuery] = useState('');
  const [searchResults, setSearchResults] = useState<any[]>([]);
  const [isSearching, setIsSearching] = useState(false);

  // Recent searches
  const recentSearches = [
    'Gift ideas for Sarah',
    'Birthday reminders',
    'Anniversary gifts',
    'Romantic messages',
  ];

  // Trending searches
  const trendingSearches = [
    { id: 1, query: 'Valentine\'s Day gifts', icon: '💝', category: 'Gifts' },
    { id: 2, query: 'Birthday planning', icon: '🎂', category: 'Events' },
    { id: 3, query: 'Romantic messages', icon: '💌', category: 'Messages' },
    { id: 4, query: 'Anniversary ideas', icon: '💕', category: 'Events' },
  ];

  // Quick access categories
  const quickCategories = [
    { id: 1, name: 'Loved Ones', icon: Heart, color: 'from-rose-400 to-pink-400', path: '/individual/loved-ones-list' },
    { id: 2, name: 'Gift Ideas', icon: Gift, color: 'from-purple-400 to-indigo-400', path: '/individual/gifts-hub' },
    { id: 3, name: 'Events', icon: Calendar, color: 'from-blue-400 to-cyan-400', path: '/individual/all-upcoming-events' },
    { id: 4, name: 'Old Messages', icon: MessageSquare, color: 'from-pink-400 to-rose-400', path: '/individual/old-messages' },
  ];

  const handleSearch = (query: string) => {
    setSearchQuery(query);
    setIsSearching(true);
    
    // Simulate search (in production, this would call an API)
    setTimeout(() => {
      // Mock search results
      if (query.trim()) {
        setSearchResults([
          { id: 1, type: 'loved-one', name: 'Sarah', subtitle: 'Partner', icon: '💑' },
          { id: 2, type: 'gift', name: 'Personalized Jewelry', subtitle: 'Gift Idea', icon: '💍' },
          { id: 3, type: 'event', name: 'Sarah\'s Birthday', subtitle: 'January 23, 2026', icon: '🎂' },
        ]);
      } else {
        setSearchResults([]);
      }
      setIsSearching(false);
    }, 500);
  };

  const clearSearch = () => {
    setSearchQuery('');
    setSearchResults([]);
  };

  return (
    <div className="min-h-screen bg-gradient-to-b from-purple-50/30 to-white pb-28">
      {/* Header with Search Bar */}
      <div className="bg-gradient-to-br from-purple-400 via-purple-500 to-indigo-500 px-5 pt-12 pb-8 relative overflow-hidden">
        {/* Decorative elements */}
        <div className="absolute top-0 right-0 w-40 h-40 bg-white/10 rounded-full blur-3xl"></div>
        <div className="absolute bottom-0 left-0 w-32 h-32 bg-white/10 rounded-full blur-2xl"></div>
        
        <div className="relative z-10">
          {/* Back Button + Title */}
          <div className="flex items-center gap-3 mb-6">
            <h1 className="text-white text-2xl font-semibold">Search</h1>
          </div>
          
          {/* Search Input */}
          <div className="relative">
            <Search className="absolute left-4 top-1/2 -translate-y-1/2 w-5 h-5 text-purple-400 z-10" />
            <input
              type="text"
              value={searchQuery}
              onChange={(e) => handleSearch(e.target.value)}
              placeholder="Search loved ones, gifts, events..."
              className="w-full h-12 pl-12 pr-12 rounded-2xl bg-white shadow-lg focus:outline-none focus:ring-2 focus:ring-purple-300 transition-all text-gray-800 placeholder-gray-400"
            />
            {searchQuery && (
              <motion.button
                onClick={clearSearch}
                className="absolute right-4 top-1/2 -translate-y-1/2 w-7 h-7 rounded-full bg-gray-100 hover:bg-gray-200 flex items-center justify-center transition-colors"
                initial={{ scale: 0 }}
                animate={{ scale: 1 }}
                whileTap={{ scale: 0.9 }}
              >
                <X className="w-4 h-4 text-gray-600" />
              </motion.button>
            )}
          </div>
        </div>
      </div>

      <div className="px-5 py-6 space-y-6">
        {/* Search Results */}
        <AnimatePresence mode="wait">
          {searchQuery && searchResults.length > 0 ? (
            <motion.div
              key="results"
              initial={{ opacity: 0, y: 20 }}
              animate={{ opacity: 1, y: 0 }}
              exit={{ opacity: 0, y: -20 }}
              className="space-y-3"
            >
              <h3 className="text-gray-700 font-medium text-sm mb-3">Search Results</h3>
              {searchResults.map((result) => (
                <RomanticCard key={result.id} className="hover:shadow-xl transition-shadow cursor-pointer">
                  <div className="flex items-center gap-3">
                    <div className="w-12 h-12 rounded-xl bg-gradient-to-br from-purple-100 to-pink-100 flex items-center justify-center text-2xl flex-shrink-0">
                      {result.icon}
                    </div>
                    <div className="flex-1">
                      <h4 className="text-gray-800 font-medium">{result.name}</h4>
                      <p className="text-gray-500 text-sm">{result.subtitle}</p>
                    </div>
                    <ArrowRight className="w-5 h-5 text-purple-400" />
                  </div>
                </RomanticCard>
              ))}
            </motion.div>
          ) : searchQuery && !isSearching ? (
            <motion.div
              key="no-results"
              initial={{ opacity: 0 }}
              animate={{ opacity: 1 }}
              exit={{ opacity: 0 }}
              className="text-center py-12"
            >
              <div className="w-20 h-20 rounded-full bg-gradient-to-br from-purple-100 to-pink-100 mx-auto mb-4 flex items-center justify-center text-4xl">
                🔍
              </div>
              <p className="text-gray-600 font-medium mb-2">No results found</p>
              <p className="text-gray-400 text-sm">Try searching for loved ones, gifts, or events</p>
            </motion.div>
          ) : !searchQuery ? (
            <motion.div
              key="default"
              initial={{ opacity: 0 }}
              animate={{ opacity: 1 }}
              exit={{ opacity: 0 }}
              className="space-y-6"
            >
              {/* Quick Access Categories */}
              <div>
                <h3 className="text-gray-700 font-medium text-sm mb-3">Quick Access</h3>
                <div className="grid grid-cols-2 gap-3">
                  {quickCategories.map((category) => {
                    const Icon = category.icon;
                    return (
                      <motion.button
                        key={category.id}
                        onClick={() => navigate(category.path)}
                        className={`relative overflow-hidden rounded-2xl p-4 bg-gradient-to-br ${category.color} shadow-lg hover:shadow-xl transition-all`}
                        whileTap={{ scale: 0.95 }}
                        whileHover={{ scale: 1.02 }}
                      >
                        <div className="absolute top-0 right-0 w-20 h-20 bg-white/10 rounded-full blur-2xl"></div>
                        <Icon className="w-6 h-6 text-white mb-2 relative z-10" />
                        <p className="text-white font-medium text-sm relative z-10">{category.name}</p>
                      </motion.button>
                    );
                  })}
                </div>
              </div>

              {/* Trending Searches */}
              <div>
                <h3 className="text-gray-700 font-medium text-sm mb-3 flex items-center gap-2">
                  <TrendingUp className="w-4 h-4 text-purple-400" />
                  Trending
                </h3>
                <div className="space-y-2">
                  {trendingSearches.map((item) => (
                    <motion.button
                      key={item.id}
                      onClick={() => handleSearch(item.query)}
                      className="w-full"
                      whileTap={{ scale: 0.98 }}
                    >
                      <RomanticCard className="hover:shadow-xl transition-shadow">
                        <div className="flex items-center gap-3">
                          <div className="w-10 h-10 rounded-xl bg-gradient-to-br from-purple-100 to-pink-100 flex items-center justify-center text-xl flex-shrink-0">
                            {item.icon}
                          </div>
                          <div className="flex-1 text-left">
                            <p className="text-gray-800 font-medium text-sm">{item.query}</p>
                            <p className="text-gray-400 text-xs">{item.category}</p>
                          </div>
                          <ArrowRight className="w-4 h-4 text-purple-300" />
                        </div>
                      </RomanticCard>
                    </motion.button>
                  ))}
                </div>
              </div>

              {/* Recent Searches */}
              <div>
                <h3 className="text-gray-700 font-medium text-sm mb-3 flex items-center gap-2">
                  <Clock className="w-4 h-4 text-purple-400" />
                  Recent Searches
                </h3>
                <div className="flex flex-wrap gap-2">
                  {recentSearches.map((search, index) => (
                    <motion.button
                      key={index}
                      onClick={() => handleSearch(search)}
                      className="px-4 py-2 bg-white rounded-full shadow-sm hover:shadow-md transition-all border border-purple-100 hover:border-purple-200"
                      whileTap={{ scale: 0.95 }}
                    >
                      <span className="text-gray-700 text-sm">{search}</span>
                    </motion.button>
                  ))}
                </div>
              </div>
            </motion.div>
          ) : null}
        </AnimatePresence>

        {/* Loading State */}
        {isSearching && (
          <div className="flex justify-center py-12">
            <motion.div
              className="w-12 h-12 rounded-full border-4 border-purple-200 border-t-purple-500"
              animate={{ rotate: 360 }}
              transition={{ duration: 1, repeat: Infinity, ease: "linear" }}
            />
          </div>
        )}
      </div>

      <BottomNav />
    </div>
  );
}