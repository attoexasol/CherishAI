import { useState } from 'react';
import { useNavigate, useParams } from 'react-router';
import { ArrowLeft, MapPin, ShoppingBag, Heart, Sparkles, Filter, DollarSign, Share2, ExternalLink, RefreshCw, History } from 'lucide-react';
import { motion } from 'motion/react';
import BottomNav from '../../../components/BottomNav';

export default function GiftIdeasScreen() {
  const navigate = useNavigate();
  const { id } = useParams();
  const [savedGifts, setSavedGifts] = useState<number[]>([]);
  const [regenerationsLeft, setRegenerationsLeft] = useState(3);
  const [isRegenerating, setIsRegenerating] = useState(false);
  const [selectedCategory, setSelectedCategory] = useState<string>('all');
  const [priceFilter, setPriceFilter] = useState<string>('all');

  // Event data based on ID
  const events = [
    {
      id: 1,
      lovedOneName: 'Sarah',
      eventType: 'Birthday',
      eventDate: 'January 23, 2026',
      daysUntil: 6,
      eventIcon: '🎂',
    },
    {
      id: 2,
      lovedOneName: 'Mom',
      eventType: "Mother's Day",
      eventDate: 'May 11, 2026',
      daysUntil: 114,
      eventIcon: '🌸',
    },
    {
      id: 3,
      lovedOneName: 'Jake',
      eventType: 'Friendship Anniversary',
      eventDate: 'March 15, 2026',
      daysUntil: 57,
      eventIcon: '🤝',
    },
  ];

  const currentEvent = events.find(e => e.id === Number(id)) || events[0];

  // Categories
  const categories = [
    { id: 'all', label: 'All Gifts', icon: '🎁' },
    { id: 'experience', label: 'Experiences', icon: '✨' },
    { id: 'personalized', label: 'Personalized', icon: '💝' },
    { id: 'luxury', label: 'Luxury', icon: '💎' },
    { id: 'practical', label: 'Practical', icon: '🎯' },
  ];

  // Price filters
  const priceRanges = [
    { id: 'all', label: 'All Prices' },
    { id: 'under50', label: 'Under $50' },
    { id: '50-100', label: '$50 - $100' },
    { id: '100-250', label: '$100 - $250' },
    { id: 'over250', label: 'Over $250' },
  ];

  // Dynamic gift ideas based on event
  const getGiftIdeas = () => {
    if (currentEvent.lovedOneName === 'Sarah' && currentEvent.eventType === 'Birthday') {
      return [
        {
          id: 1,
          title: 'Personalized Photo Album',
          description: 'A beautifully crafted photo album with your favorite memories together. Premium leather cover with custom embossing.',
          icon: '📸',
          price: 65,
          priceRange: '$45 - $85',
          category: 'personalized',
          whyPerfect: 'Sarah loves photography and cherishes memories from your travels together.',
          emoji: '💕',
          vendor: 'Artifact Uprising',
        },
        {
          id: 2,
          title: 'Artisan Coffee Subscription',
          description: 'Monthly delivery of specialty coffee from around the world. Includes tasting notes and brewing tips.',
          icon: '☕',
          price: 35,
          priceRange: '$25 - $45/month',
          category: 'practical',
          whyPerfect: 'She mentioned loving that new café on Main Street and trying different coffee blends.',
          emoji: '✨',
          vendor: 'Atlas Coffee Club',
        },
        {
          id: 3,
          title: 'Weekend Spa Getaway',
          description: 'A relaxing weekend at a luxury spa resort. Includes massage, facials, and gourmet dining.',
          icon: '🧖‍♀️',
          price: 375,
          priceRange: '$250 - $500',
          category: 'experience',
          whyPerfect: 'Sarah has been working hard and mentioned needing some relaxation time.',
          emoji: '🌸',
          vendor: 'Serenity Spa Resort',
        },
        {
          id: 4,
          title: 'Designer Handbag',
          description: 'Elegant leather crossbody bag from a luxury brand. Perfect size for everyday use with timeless design.',
          icon: '👜',
          price: 450,
          priceRange: '$400 - $600',
          category: 'luxury',
          whyPerfect: 'She admired a similar style when you went shopping together last month.',
          emoji: '💎',
          vendor: 'Nordstrom',
        },
        {
          id: 5,
          title: 'Cooking Class for Two',
          description: 'Private Italian cooking class with a professional chef. Includes wine pairing and a romantic dinner.',
          icon: '👨‍🍳',
          price: 180,
          priceRange: '$150 - $220',
          category: 'experience',
          whyPerfect: 'You both love trying new recipes and she mentioned wanting to learn authentic pasta making.',
          emoji: '🍝',
          vendor: 'Culinary Studio',
        },
        {
          id: 6,
          title: 'Custom Star Map',
          description: 'Beautiful print showing the exact constellation on your first date night. Custom colors and framing available.',
          icon: '⭐',
          price: 75,
          priceRange: '$60 - $120',
          category: 'personalized',
          whyPerfect: 'A romantic reminder of the night you first met under the stars.',
          emoji: '✨',
          vendor: 'The Night Sky',
        },
      ];
    } else if (currentEvent.lovedOneName === 'Mom' && currentEvent.eventType === "Mother's Day") {
      return [
        {
          id: 7,
          title: 'Garden Tool Set with Personalized Apron',
          description: 'Premium gardening tools with ergonomic handles and a custom embroidered apron with her name.',
          icon: '🌷',
          price: 85,
          priceRange: '$70 - $110',
          category: 'personalized',
          whyPerfect: 'Mom loves spending time in her garden and mentioned needing new tools.',
          emoji: '🌸',
          vendor: 'Gardener\'s Supply',
        },
        {
          id: 8,
          title: 'Spa Day Package',
          description: 'Full day spa treatment including massage, facial, manicure, and lunch at an upscale spa.',
          icon: '💆‍♀️',
          price: 280,
          priceRange: '$250 - $350',
          category: 'experience',
          whyPerfect: 'She deserves a day of pampering and relaxation for all she does.',
          emoji: '💕',
          vendor: 'Tranquility Day Spa',
        },
        {
          id: 9,
          title: 'Custom Family Portrait',
          description: 'Professional artist will create a beautiful watercolor portrait from your favorite family photo.',
          icon: '🖼️',
          price: 195,
          priceRange: '$150 - $250',
          category: 'personalized',
          whyPerfect: 'Mom loves displaying family photos and appreciates handmade art.',
          emoji: '❤️',
          vendor: 'Portrait Artists',
        },
        {
          id: 10,
          title: 'Luxury Cashmere Cardigan',
          description: 'Soft, cozy cashmere cardigan in her favorite color. Perfect for elegant comfort.',
          icon: '🧥',
          price: 225,
          priceRange: '$200 - $300',
          category: 'luxury',
          whyPerfect: 'She mentioned feeling cold lately and loves high-quality fabrics.',
          emoji: '✨',
          vendor: 'Bloomingdale\'s',
        },
        {
          id: 11,
          title: 'Afternoon Tea Experience',
          description: 'Traditional afternoon tea at a historic hotel. Includes sandwiches, scones, pastries, and premium tea selection.',
          icon: '🫖',
          price: 65,
          priceRange: '$50 - $80',
          category: 'experience',
          whyPerfect: 'She loves tea and elegant dining experiences with beautiful presentation.',
          emoji: '🌹',
          vendor: 'The Grand Hotel',
        },
        {
          id: 12,
          title: 'Smart Instant Pot with Recipe Book',
          description: 'Latest model Instant Pot with air fryer lid and cookbook featuring her favorite cuisines.',
          icon: '🍲',
          price: 145,
          priceRange: '$120 - $170',
          category: 'practical',
          whyPerfect: 'She mentioned wanting to try pressure cooking and loves efficient kitchen gadgets.',
          emoji: '👩‍🍳',
          vendor: 'Williams Sonoma',
        },
      ];
    } else {
      return [
        {
          id: 13,
          title: 'Wireless Headphones',
          description: 'Premium noise-cancelling headphones with superior sound quality. Perfect for music lovers.',
          icon: '🎧',
          price: 195,
          priceRange: '$180 - $250',
          category: 'practical',
          whyPerfect: 'Jake loves music and has been talking about upgrading his headphones.',
          emoji: '🎵',
          vendor: 'Best Buy',
        },
        {
          id: 14,
          title: 'Adventure Day Pass',
          description: 'Full day of outdoor activities: rock climbing, zip-lining, and lunch included.',
          icon: '🧗',
          price: 120,
          priceRange: '$100 - $150',
          category: 'experience',
          whyPerfect: 'You both love outdoor adventures and trying new activities together.',
          emoji: '⛰️',
          vendor: 'Adventure Park',
        },
        {
          id: 15,
          title: 'Engraved Watch',
          description: 'Classic timepiece with personal message engraved on the back. Comes in premium gift box.',
          icon: '⌚',
          price: 275,
          priceRange: '$250 - $350',
          category: 'personalized',
          whyPerfect: 'A timeless gift to commemorate your friendship milestone.',
          emoji: '🤝',
          vendor: 'Fossil',
        },
        {
          id: 16,
          title: 'Craft Beer Tasting Set',
          description: 'Curated collection of 12 unique craft beers from local breweries with tasting guide.',
          icon: '🍺',
          price: 55,
          priceRange: '$45 - $70',
          category: 'practical',
          whyPerfect: 'Jake is a craft beer enthusiast and loves discovering new breweries.',
          emoji: '🍻',
          vendor: 'Local Brewery Collective',
        },
      ];
    }
  };

  const allGifts = getGiftIdeas();

  // LIMIT TO MAXIMUM 3 GIFTS - Only show current suggestions
  const currentGiftSuggestions = allGifts.slice(0, 3);

  // Filter gifts
  const filteredGifts = currentGiftSuggestions.filter(gift => {
    const categoryMatch = selectedCategory === 'all' || gift.category === selectedCategory;
    
    let priceMatch = true;
    if (priceFilter === 'under50') priceMatch = gift.price < 50;
    else if (priceFilter === '50-100') priceMatch = gift.price >= 50 && gift.price <= 100;
    else if (priceFilter === '100-250') priceMatch = gift.price >= 100 && gift.price <= 250;
    else if (priceFilter === 'over250') priceMatch = gift.price > 250;

    return categoryMatch && priceMatch;
  });

  const handleSaveGift = (giftId: number) => {
    if (savedGifts.includes(giftId)) {
      setSavedGifts(savedGifts.filter(id => id !== giftId));
    } else {
      setSavedGifts([...savedGifts, giftId]);
    }
  };

  const handleShare = (gift: any) => {
    if (navigator.share) {
      navigator.share({
        title: gift.title,
        text: `Check out this gift idea: ${gift.title} - ${gift.description}`,
      });
    }
  };

  const handleBack = () => {
    navigate('/individual/home');
  };

  const handleCheckPicks = (giftId: number) => {
    navigate(`/individual/business-suggestions/${giftId}`);
  };

  const handleRegenerateGifts = () => {
    if (regenerationsLeft > 0) {
      setIsRegenerating(true);
      setTimeout(() => {
        setIsRegenerating(false);
        setRegenerationsLeft(regenerationsLeft - 1);
      }, 2000);
    }
  };

  return (
    <div className="min-h-screen bg-gradient-to-br from-rose-50 via-pink-50 to-purple-50 pb-24">
      {/* Header */}
      <div className="sticky top-0 z-20 bg-gradient-to-br from-rose-50/95 via-pink-50/95 to-purple-50/95 backdrop-blur-xl border-b border-pink-100/50">
        <div className="max-w-4xl mx-auto px-6 py-4">
          <div className="flex items-center justify-between">
            <motion.button
              onClick={handleBack}
              className="p-2.5 rounded-xl bg-gradient-to-br from-purple-500 to-pink-500 border border-purple-400 hover:shadow-lg transition-all shadow-md"
              whileHover={{ scale: 1.05 }}
              whileTap={{ scale: 0.95 }}
            >
              <ArrowLeft className="w-5 h-5 text-white" />
            </motion.button>
            <h1 className="text-lg font-semibold text-gray-800">
              Gift Ideas
            </h1>
            <div className="w-10 h-10"></div> {/* Spacer for centering */}
          </div>
        </div>
      </div>

      {/* Event Info Section */}
      <div className="max-w-4xl mx-auto px-6 pt-8 pb-6">
        <motion.div
          className="bg-white/80 backdrop-blur border border-pink-200/50 rounded-3xl p-8 shadow-lg text-center"
          initial={{ opacity: 0, y: 20 }}
          animate={{ opacity: 1, y: 0 }}
        >
          <div className="w-20 h-20 mx-auto mb-4 rounded-3xl bg-gradient-to-br from-rose-400 to-purple-400 flex items-center justify-center text-4xl shadow-lg">
            {currentEvent.eventIcon}
          </div>
          <h1 className="text-4xl font-bold bg-gradient-to-r from-rose-600 via-pink-600 to-purple-600 bg-clip-text text-transparent mb-3">
            {currentEvent.lovedOneName}'s {currentEvent.eventType}
          </h1>
          <p className="text-lg text-gray-600 mb-2">
            Coming up in <span className="font-bold text-rose-600">{currentEvent.daysUntil} days</span>
          </p>
          <p className="text-sm text-gray-500">
            Carefully selected by Cherish AI, with your loved one's interests in mind
          </p>
        </motion.div>
      </div>

      {/* Filters */}
      <div className="max-w-6xl mx-auto px-6 mb-6">
        <motion.div
          className="bg-white/80 backdrop-blur border border-pink-200/50 rounded-2xl p-4 shadow-lg"
          initial={{ opacity: 0 }}
          animate={{ opacity: 1 }}
        >
          <div className="grid grid-cols-1 md:grid-cols-2 gap-4">
            {/* Price Filter */}
            <div className="flex items-center gap-3">
              <DollarSign className="w-5 h-5 text-rose-600" />
              <div className="flex-1">
                <label className="text-xs font-semibold text-gray-700 mb-1 block">Price Range</label>
                <select
                  value={priceFilter}
                  onChange={(e) => setPriceFilter(e.target.value)}
                  className="w-full px-3 py-2 rounded-xl bg-gray-50 border border-gray-200 text-sm text-gray-700 focus:outline-none focus:border-rose-300"
                >
                  {priceRanges.map(range => (
                    <option key={range.id} value={range.id}>{range.label}</option>
                  ))}
                </select>
              </div>
            </div>

            {/* Category Filter */}
            <div className="flex items-center gap-3">
              <ShoppingBag className="w-5 h-5 text-rose-600" />
              <div className="flex-1">
                <label className="text-xs font-semibold text-gray-700 mb-1 block">Category</label>
                <select
                  value={selectedCategory}
                  onChange={(e) => setSelectedCategory(e.target.value)}
                  className="w-full px-3 py-2 rounded-xl bg-gray-50 border border-gray-200 text-sm text-gray-700 focus:outline-none focus:border-rose-300"
                >
                  {categories.map(category => (
                    <option key={category.id} value={category.id}>{category.icon} {category.label}</option>
                  ))}
                </select>
              </div>
            </div>
          </div>

          {/* Results Count */}
          <div className="mt-3 pt-3 border-t border-gray-200 text-center">
            <p className="text-sm text-gray-600">
              Showing <span className="font-bold text-rose-600">{filteredGifts.length}</span> gift{filteredGifts.length !== 1 ? 's' : ''}
            </p>
          </div>
        </motion.div>
      </div>

      {/* 3 Gift Ideas */}
      <div className="max-w-4xl mx-auto px-6">
        <h2 className="text-2xl font-bold text-gray-800 mb-6 text-center">
          Perfect Gift Ideas
        </h2>

        <div className="grid grid-cols-1 md:grid-cols-3 gap-6 mb-8">
          {filteredGifts.map((gift, index) => (
            <motion.div
              key={gift.id}
              className="bg-white/80 backdrop-blur border-2 border-pink-200/50 rounded-3xl overflow-hidden shadow-lg hover:shadow-xl transition-all"
              initial={{ opacity: 0, y: 30 }}
              animate={{ opacity: 1, y: 0 }}
              transition={{ delay: index * 0.15 }}
            >
              {/* Icon Header */}
              <div className="bg-gradient-to-br from-rose-100 to-pink-100 p-8 text-center">
                <div className="w-24 h-24 mx-auto rounded-3xl bg-gradient-to-br from-rose-400 to-purple-400 flex items-center justify-center text-5xl shadow-xl mb-4">
                  {gift.icon}
                </div>
                <div className="inline-block px-4 py-1.5 rounded-full bg-white/60 backdrop-blur">
                  <span className="text-sm font-semibold text-gray-700">{gift.priceRange}</span>
                </div>
              </div>

              {/* Content */}
              <div className="p-6">
                <h3 className="text-xl font-bold text-gray-800 mb-3 text-center">
                  {gift.title}
                </h3>

                <p className="text-sm text-gray-600 mb-4 leading-relaxed text-center">
                  {gift.description}
                </p>

                {/* Why Perfect Section */}
                <div className="bg-gradient-to-br from-purple-50 to-pink-50 rounded-2xl p-4 mb-5">
                  <div className="flex items-start gap-2 mb-2">
                    <span className="text-lg">{gift.emoji}</span>
                    <p className="text-xs font-semibold text-gray-700 uppercase">Why it's perfect</p>
                  </div>
                  <p className="text-sm text-gray-600 leading-relaxed">
                    {gift.whyPerfect}
                  </p>
                </div>

                {/* Check Best Picks Button */}
                <button
                  onClick={() => handleCheckPicks(gift.id)}
                  className="w-full py-3.5 px-6 rounded-2xl bg-gradient-to-r from-rose-500 via-pink-500 to-purple-500 text-white font-semibold shadow-lg hover:shadow-xl hover:scale-[1.02] transition-all flex items-center justify-center gap-2 mb-3"
                >
                  <MapPin className="w-4 h-4" />
                  Find Near You
                </button>

                {/* Secondary Actions Grid */}
                <div className="grid grid-cols-3 gap-2">
                  {/* Save Gift Button */}
                  <button
                    onClick={() => handleSaveGift(gift.id)}
                    className={`flex flex-col items-center gap-1 px-3 py-2.5 rounded-xl transition-all border ${
                      savedGifts.includes(gift.id)
                        ? 'bg-rose-50 border-rose-200 text-rose-700'
                        : 'bg-gray-50 border-gray-200 text-gray-600 hover:bg-gray-100'
                    }`}
                  >
                    <Heart className={`w-4 h-4 ${savedGifts.includes(gift.id) ? 'fill-rose-700' : ''}`} />
                    <span className="text-xs font-medium">{savedGifts.includes(gift.id) ? 'Saved' : 'Save'}</span>
                  </button>

                  {/* Share Gift Button */}
                  <button
                    onClick={() => handleShare(gift)}
                    className="flex flex-col items-center gap-1 px-3 py-2.5 rounded-xl bg-gray-50 hover:bg-gray-100 transition-all border border-gray-200"
                  >
                    <Share2 className="w-4 h-4 text-gray-600" />
                    <span className="text-xs font-medium text-gray-700">Share</span>
                  </button>

                  {/* Vendor Link */}
                  <a
                    href={`https://www.google.com/search?q=${encodeURIComponent(gift.vendor)}`}
                    target="_blank"
                    rel="noopener noreferrer"
                    className="flex flex-col items-center gap-1 px-3 py-2.5 rounded-xl bg-gray-50 hover:bg-gray-100 transition-all border border-gray-200"
                  >
                    <ExternalLink className="w-4 h-4 text-gray-600" />
                    <span className="text-xs font-medium text-gray-700">Visit</span>
                  </a>
                </div>
              </div>
            </motion.div>
          ))}
        </div>

        {/* Additional Info */}
        <motion.div
          className="bg-gradient-to-br from-purple-50 to-pink-50 border border-purple-200/50 rounded-3xl p-6 text-center mb-6"
          initial={{ opacity: 0 }}
          animate={{ opacity: 1 }}
          transition={{ delay: 0.6 }}
        >
          <Sparkles className="w-10 h-10 mx-auto mb-3 text-purple-600" />
          <p className="text-sm text-gray-600">
            <span className="font-semibold text-gray-800">Tip:</span> Click "Find Near You" to see local businesses offering each gift
          </p>
        </motion.div>

        {/* Action Buttons - Regenerate All & View Gift History */}
        <motion.div
          className="grid grid-cols-1 md:grid-cols-2 gap-4 mb-8"
          initial={{ opacity: 0, y: 20 }}
          animate={{ opacity: 1, y: 0 }}
          transition={{ delay: 0.7 }}
        >
          {/* Regenerate All Button */}
          <button
            onClick={handleRegenerateGifts}
            disabled={isRegenerating || regenerationsLeft === 0}
            className={`py-4 px-6 rounded-2xl font-semibold shadow-lg hover:shadow-xl transition-all flex items-center justify-center gap-3 ${
              isRegenerating || regenerationsLeft === 0
                ? 'bg-gray-300 text-gray-500 cursor-not-allowed'
                : 'bg-gradient-to-r from-purple-500 via-pink-500 to-rose-500 text-white hover:scale-[1.02]'
            }`}
          >
            <motion.div
              animate={isRegenerating ? { rotate: 360 } : {}}
              transition={{ duration: 1, repeat: isRegenerating ? Infinity : 0, ease: 'linear' }}
            >
              <RefreshCw className="w-5 h-5" />
            </motion.div>
            <div className="text-left">
              <div className="font-bold">
                {isRegenerating ? 'Regenerating...' : 'Regenerate All'}
              </div>
              <div className="text-xs opacity-90">
                {regenerationsLeft} regeneration{regenerationsLeft !== 1 ? 's' : ''} left this month
              </div>
            </div>
          </button>

          {/* View Gift History Button */}
          <button
            onClick={() => navigate('/individual/all-gift-ideas')}
            className="py-4 px-6 rounded-2xl bg-white/80 backdrop-blur border-2 border-pink-200/50 text-gray-800 font-semibold shadow-lg hover:shadow-xl hover:scale-[1.02] transition-all flex items-center justify-center gap-3"
          >
            <History className="w-5 h-5 text-rose-600" />
            <div className="text-left">
              <div className="font-bold">View Gift History</div>
              <div className="text-xs text-gray-600">See all past suggestions</div>
            </div>
          </button>
        </motion.div>
      </div>

      <BottomNav />
    </div>
  );
}