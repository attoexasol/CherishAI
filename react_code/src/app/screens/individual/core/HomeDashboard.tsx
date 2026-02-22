import { useNavigate } from 'react-router-dom';
import { Heart, Calendar, Gift, Sparkles, Copy, RefreshCw, Send, Bell, Share2, ThumbsUp, ThumbsDown, MessageCircle, Star, User, Settings, ArrowLeft, ArrowRight, Compass } from 'lucide-react';
import BottomNav from '../../../components/BottomNav';
import { useApp } from '../../../context/AppContext';
import { useState } from 'react';
import { motion } from 'motion/react';
import AccountSettingsModal from '../../../components/AccountSettingsModal';

export default function HomeDashboard() {
  const navigate = useNavigate();
  const { lovedOnes, currentUser } = useApp();
  const [likedMessages, setLikedMessages] = useState<number[]>([]);
  const [dislikedMessages, setDislikedMessages] = useState<number[]>([]);
  const [isInspirationLiked, setIsInspirationLiked] = useState(false);
  const [showAccountSettings, setShowAccountSettings] = useState(false);
  
  // Track which message (0, 1, or 2) is currently showing for each loved one
  const [currentMessageIndexes, setCurrentMessageIndexes] = useState<Record<number, number>>({
    1: 0, // Sarah starts at message 0
    2: 0, // Mom starts at message 0
    3: 0, // Jake starts at message 0
  });

  // SECTION 1: Daily Messages Per Loved One (3 messages per loved one)
  const dailyMessages = [
    {
      id: 1,
      lovedOneName: 'Sarah',
      lovedOneAvatar: '👩',
      relationship: 'Partner',
      messages: [
        'Good morning beautiful! I was just thinking about that amazing dinner we had last week. Want to try that new Italian place tonight?',
        'You make every day brighter just by being in it. Looking forward to our weekend together! ❤️',
        'I picked up your favorite coffee on my way home. Can\'t wait to see your smile when I get there! ☕💕',
      ],
      backgroundColor: 'from-rose-50 to-pink-50',
      borderColor: 'border-rose-200',
    },
    {
      id: 2,
      lovedOneName: 'Mom',
      lovedOneAvatar: '👩‍🦳',
      relationship: 'Mother',
      messages: [
        'Hi Mom! Just wanted to let you know I\'m thinking of you today. Thank you for always being my biggest supporter. Love you! ❤️',
        'Remember that recipe you taught me? I tried making it today and it turned out great! You\'re the best teacher. 🥘',
        'Hope you\'re having a wonderful day! Let\'s plan a lunch date this week - I miss our chats! 💐',
      ],
      backgroundColor: 'from-purple-50 to-pink-50',
      borderColor: 'border-purple-200',
    },
    {
      id: 3,
      lovedOneName: 'Jake',
      lovedOneAvatar: '👨',
      relationship: 'Best Friend',
      messages: [
        'Hey buddy! That hiking trip we talked about? Let\'s make it happen this weekend. I found an awesome trail!',
        'Dude, just saw this meme and immediately thought of you 😂 Sending it your way!',
        'Game night at my place Friday? I\'ll order the pizza, you bring the competitive spirit! 🎮🍕',
      ],
      backgroundColor: 'from-blue-50 to-cyan-50',
      borderColor: 'border-blue-200',
    },
  ];

  // SECTION 2: Upcoming Events
  const upcomingEvents = [
    {
      id: 1,
      lovedOneName: 'Sarah',
      eventType: 'Birthday',
      eventDate: 'January 23, 2026',
      daysUntil: 6,
      eventIcon: '🎂',
      priority: 'high',
    },
    {
      id: 2,
      lovedOneName: 'Mom',
      eventType: 'Mother\'s Day',
      eventDate: 'May 11, 2026',
      daysUntil: 114,
      eventIcon: '🌸',
      priority: 'medium',
    },
    {
      id: 3,
      lovedOneName: 'Jake',
      eventType: 'Friendship Anniversary',
      eventDate: 'March 15, 2026',
      daysUntil: 57,
      eventIcon: '🤝',
      priority: 'low',
    },
  ];

  // SECTION 3: Daily Inspiration
  const dailyInspiration = {
    quote: '"Cherish the little moments - they often turn into the most beautiful memories."',
    author: 'Cherish AI',
  };

  const handleCopy = (message: string) => {
    navigator.clipboard.writeText(message);
    // Could add toast notification here
  };

  const handleSend = (lovedOneName: string, message: string) => {
    console.log(`Sending to ${lovedOneName}: ${message}`);
    // Would integrate with messaging API
  };

  // Cycle to next message for a specific loved one
  const handleRegenerate = (lovedOneId: number) => {
    setCurrentMessageIndexes(prev => {
      const currentIndex = prev[lovedOneId] || 0;
      const nextIndex = (currentIndex + 1) % 3; // Cycle through 0, 1, 2
      return { ...prev, [lovedOneId]: nextIndex };
    });
  };

  // Go to previous message for a specific loved one
  const handlePreviousMessage = (lovedOneId: number) => {
    setCurrentMessageIndexes(prev => {
      const currentIndex = prev[lovedOneId] || 0;
      const prevIndex = currentIndex === 0 ? 2 : currentIndex - 1; // Cycle backwards
      return { ...prev, [lovedOneId]: prevIndex };
    });
  };

  // Go to next message for a specific loved one
  const handleNextMessage = (lovedOneId: number) => {
    setCurrentMessageIndexes(prev => {
      const currentIndex = prev[lovedOneId] || 0;
      const nextIndex = (currentIndex + 1) % 3; // Cycle through 0, 1, 2
      return { ...prev, [lovedOneId]: nextIndex };
    });
  };

  const handleShare = (message: string) => {
    if (navigator.share) {
      navigator.share({
        text: message,
      });
    }
  };

  const handleLike = (messageId: number) => {
    if (likedMessages.includes(messageId)) {
      setLikedMessages(likedMessages.filter(id => id !== messageId));
    } else {
      setLikedMessages([...likedMessages, messageId]);
      setDislikedMessages(dislikedMessages.filter(id => id !== messageId));
    }
  };

  const handleDislike = (messageId: number) => {
    if (dislikedMessages.includes(messageId)) {
      setDislikedMessages(dislikedMessages.filter(id => id !== messageId));
    } else {
      setDislikedMessages([...dislikedMessages, messageId]);
      setLikedMessages(likedMessages.filter(id => id !== messageId));
    }
  };

  const handleGiftIdeas = (eventId: number) => {
    navigate(`/individual/gift-ideas/${eventId}`);
  };

  return (
    <div className="min-h-screen bg-gradient-to-br from-rose-50 via-pink-50 to-purple-50 pb-24">
      {/* Header */}
      <div className="sticky top-0 z-20 bg-gradient-to-br from-rose-50/95 via-pink-50/95 to-purple-50/95 backdrop-blur-xl border-b border-pink-100/50">
        <div className="max-w-6xl mx-auto px-4 py-4">
          <div className="flex items-center justify-between gap-2">
            {/* Left: Logo & Title */}
            <div className="flex items-center gap-2 min-w-0">
              <div className="w-10 h-10 sm:w-12 sm:h-12 rounded-2xl bg-gradient-to-br from-rose-500 to-purple-500 flex items-center justify-center shadow-lg flex-shrink-0">
                <Heart className="w-5 h-5 sm:w-6 sm:h-6 text-white fill-white" />
              </div>
              <div className="hidden sm:block">
                <h1 className="text-xl sm:text-2xl font-bold bg-gradient-to-r from-rose-600 via-pink-600 to-purple-600 bg-clip-text text-transparent">
                  Cherish AI
                </h1>
                <p className="text-xs sm:text-sm text-gray-600">Your Love Assistant</p>
              </div>
            </div>

            {/* Right: Action Buttons */}
            <div className="flex items-center gap-2 flex-shrink-0">
              {/* Notification Button */}
              <button
                onClick={() => navigate('/individual/notifications-list')}
                className="relative p-2 sm:p-3 rounded-xl bg-white/80 border border-pink-200/50 hover:shadow-lg transition-all"
              >
                <Bell className="w-4 h-4 sm:w-5 sm:h-5 text-rose-600" />
                <span className="absolute top-1 right-1 sm:top-2 sm:right-2 w-2 h-2 bg-rose-500 rounded-full"></span>
              </button>

              {/* Settings Button */}
              <button
                onClick={() => setShowAccountSettings(true)}
                className="p-2 sm:p-3 rounded-xl bg-white/80 border border-pink-200/50 hover:shadow-lg transition-all"
              >
                <Settings className="w-4 h-4 sm:w-5 sm:h-5 text-rose-600" />
              </button>
            </div>
          </div>
        </div>
      </div>

      {/* Welcome Section */}
      <div className="max-w-6xl mx-auto px-6 pt-6 pb-4">
        <motion.div
          className="bg-white/80 backdrop-blur border border-pink-200/50 rounded-3xl p-6 shadow-lg"
          initial={{ opacity: 0, y: 20 }}
          animate={{ opacity: 1, y: 0 }}
        >
          <h2 className="text-3xl font-bold text-gray-800 mb-2">
            Hello Sarah! 👋
          </h2>
          <p className="text-lg text-gray-600 mb-4">
            Let's make today meaningful for those you cherish
          </p>
          <div className="flex items-center gap-4">
            <div className="flex items-center gap-2 px-4 py-2 rounded-xl bg-gradient-to-r from-rose-50 to-pink-50 border border-rose-200/30">
              <Heart className="w-5 h-5 text-rose-600" />
              <span className="font-semibold text-gray-700">{lovedOnes.length} Loved Ones</span>
            </div>
            <button
              onClick={() => navigate('/individual/all-upcoming-events')}
              className="flex items-center gap-2 px-4 py-2 rounded-xl bg-gradient-to-r from-purple-50 to-pink-50 border border-purple-200/30 hover:border-purple-300 hover:shadow-md transition-all"
            >
              <Calendar className="w-5 h-5 text-purple-600" />
              <span className="font-semibold text-gray-700">{upcomingEvents.length} Events Soon</span>
            </button>
          </div>
        </motion.div>
      </div>

      {/* SECTION 1: DAILY MESSAGES PER LOVED ONE */}
      <div className="max-w-6xl mx-auto px-6 py-6">
        <div className="mb-5">
          <h2 className="text-2xl font-bold text-gray-800 mb-1">Daily Messages</h2>
          <p className="text-sm text-gray-600 whitespace-nowrap">Personalized for each loved one. <span style={{ color: '#A855F7', fontWeight: '600' }}>• SWIPE HORIZONTALLY</span></p>
        </div>

        {/* Horizontally Scrollable Cards with VISIBLE scrollbar */}
        <div 
          className="overflow-x-auto pb-4 -mx-6 px-6 snap-x snap-mandatory scroll-smooth lg:overflow-visible"
          style={{
            scrollbarWidth: 'thin',
            scrollbarColor: '#F9A8D4 #FDF2F8',
          }}
        >
          <style>{`
            .overflow-x-auto::-webkit-scrollbar {
              height: 8px;
            }
            .overflow-x-auto::-webkit-scrollbar-track {
              background: #FDF2F8;
              border-radius: 10px;
            }
            .overflow-x-auto::-webkit-scrollbar-thumb {
              background: linear-gradient(to right, #F9A8D4, #FBCFE8);
              border-radius: 10px;
            }
            .overflow-x-auto::-webkit-scrollbar-thumb:hover {
              background: linear-gradient(to right, #F472B6, #F9A8D4);
            }
          `}</style>
          <div className="flex gap-5 lg:grid lg:grid-cols-3 lg:gap-6">
            {dailyMessages.map((msg, index) => (
              <motion.div
                key={msg.id}
                data-message-card
                className="bg-white backdrop-blur border-2 border-rose-300 rounded-3xl shadow-2xl hover:shadow-[0_20px_60px_rgba(244,114,182,0.4)] hover:scale-[1.02] transition-all snap-center lg:w-auto overflow-hidden"
                style={{ 
                  width: '360px',
                  maxWidth: '90vw',
                  flexShrink: 0,
                }}
                initial={{ opacity: 0, x: 20 }}
                animate={{ opacity: 1, x: 0 }}
                transition={{ delay: index * 0.1 }}
              >
                {/* Header Section with Gradient Background */}
                <div className={`bg-gradient-to-br ${msg.backgroundColor} p-4 border-b-2 border-rose-200`}>
                  <div className="flex items-center gap-3">
                    <div className="w-12 h-12 rounded-xl bg-white shadow-md flex items-center justify-center text-2xl ring-2 ring-rose-200">
                      {msg.lovedOneAvatar}
                    </div>
                    <div className="flex-1">
                      <h3 className="text-lg font-bold text-gray-800">For {msg.lovedOneName}</h3>
                      <p className="text-xs text-gray-600 font-medium">{msg.relationship}</p>
                      <button
                        onClick={() => navigate(`/your-approach/${msg.lovedOneName}`)}
                        className="flex items-center gap-1.5 text-sm font-semibold text-purple-600 hover:text-purple-700 mt-2 transition-colors py-1.5 px-2 -ml-2 rounded-lg hover:bg-purple-50"
                      >
                        <span>Your approach with {msg.lovedOneName}</span>
                        <ArrowRight className="w-4 h-4" />
                      </button>
                    </div>
                  </div>
                </div>

                {/* Message Content - ENLARGED AND PROMINENT */}
                <div className="p-5">
                  <div className="bg-gradient-to-br from-rose-50 to-pink-50 rounded-2xl p-8 mb-6 border-2 border-rose-200 shadow-md min-h-[180px] flex items-center">
                    <p className="text-gray-800 leading-relaxed text-lg font-medium">
                      {msg.messages[currentMessageIndexes[msg.id]]}
                    </p>
                  </div>

                  {/* Navigation Buttons - PROMINENT */}
                  <div className="flex items-center gap-2 mb-4">
                    <button
                      onClick={() => handlePreviousMessage(msg.id)}
                      disabled={dailyMessages.length === 1}
                      className={`flex-1 flex items-center justify-center gap-2 px-4 py-3.5 rounded-xl transition-all font-semibold shadow-md ${
                        dailyMessages.length === 1
                          ? 'bg-gray-100 text-gray-400 cursor-not-allowed'
                          : 'bg-white hover:bg-rose-50 border-2 border-rose-300 text-rose-600 hover:border-rose-400 hover:shadow-lg'
                      }`}
                    >
                      <ArrowLeft className="w-4 h-4" />
                      <span className="text-sm">Previous</span>
                    </button>
                    <button
                      onClick={() => handleNextMessage(msg.id)}
                      disabled={dailyMessages.length === 1}
                      className={`flex-1 flex items-center justify-center gap-2 px-4 py-3.5 rounded-xl transition-all font-semibold shadow-md ${
                        dailyMessages.length === 1
                          ? 'bg-gray-100 text-gray-400 cursor-not-allowed'
                          : 'bg-white hover:bg-rose-50 border-2 border-rose-300 text-rose-600 hover:border-rose-400 hover:shadow-lg'
                      }`}
                    >
                      <span className="text-sm">Next</span>
                      <ArrowRight className="w-4 h-4" />
                    </button>
                  </div>

                  {/* Primary Action - Regenerate shows next message */}
                  <button
                    onClick={() => handleRegenerate(msg.id)}
                    className="w-full py-3 px-6 rounded-xl font-semibold shadow-md transition-all flex items-center justify-center gap-2 mb-3 bg-gradient-to-r from-rose-500 via-pink-500 to-purple-500 text-white hover:shadow-lg hover:scale-[1.02]"
                  >
                    <RefreshCw className="w-4 h-4" />
                    <span className="text-sm">Regenerate Message</span>
                  </button>

                  {/* Secondary Actions Grid */}
                  <div className="grid grid-cols-2 gap-2 mb-3">
                    <button
                      onClick={() => handleCopy(msg.messages[currentMessageIndexes[msg.id]])}
                      className="flex flex-col items-center gap-1 px-3 py-2 rounded-lg bg-rose-50 hover:bg-rose-100 transition-all border border-rose-200"
                    >
                      <Copy className="w-3 h-3 text-rose-600" />
                      <span className="text-xs font-medium text-rose-700">Copy</span>
                    </button>
                    <button
                      onClick={() => handleShare(msg.messages[currentMessageIndexes[msg.id]])}
                      className="flex flex-col items-center gap-1 px-3 py-2 rounded-lg bg-rose-50 hover:bg-rose-100 transition-all border border-rose-200"
                    >
                      <Share2 className="w-3 h-3 text-rose-600" />
                      <span className="text-xs font-medium text-rose-700">Share</span>
                    </button>
                  </div>

                  {/* Like/Dislike Actions */}
                  <div className="flex items-center gap-2">
                    <button
                      onClick={() => handleLike(msg.id)}
                      className={`flex-1 flex items-center justify-center gap-2 px-4 py-2 rounded-lg transition-all border-2 ${
                        likedMessages.includes(msg.id)
                          ? 'bg-green-50 border-green-300 text-green-700 shadow-sm'
                          : 'bg-white border-rose-200 text-gray-600 hover:bg-rose-50 hover:border-rose-300'
                      }`}
                    >
                      <ThumbsUp className={`w-3 h-3 ${likedMessages.includes(msg.id) ? 'fill-green-700' : ''}`} />
                      <span className="text-xs font-medium">Like</span>
                    </button>
                    <button
                      onClick={() => handleDislike(msg.id)}
                      className={`flex-1 flex items-center justify-center gap-2 px-4 py-2 rounded-lg transition-all border-2 ${
                        dislikedMessages.includes(msg.id)
                          ? 'bg-red-50 border-red-300 text-red-700 shadow-sm'
                          : 'bg-white border-rose-200 text-gray-600 hover:bg-rose-50 hover:border-rose-300'
                      }`}
                    >
                      <ThumbsDown className={`w-3 h-3 ${dislikedMessages.includes(msg.id) ? 'fill-red-700' : ''}`} />
                      <span className="text-xs font-medium">Dislike</span>
                    </button>
                  </div>
                </div>
              </motion.div>
            ))}
          </div>
        </div>
      </div>

      {/* SECTION 2: UPCOMING EVENTS */}
      <div className="max-w-6xl mx-auto px-6 py-6">
        <div className="mb-5">
          <h2 className="text-2xl font-bold text-gray-800 mb-1">Upcoming Events</h2>
          <p className="text-sm text-gray-600">
            Never miss a meaningful moment meant to celebrate the people you love • <span style={{ color: '#A855F7', fontWeight: '600' }}>SWIPE</span> <span style={{ color: '#A855F7', fontWeight: '600' }}>HORIZONTALLY</span>
          </p>
        </div>

        {/* Horizontal Scrollable Events on Mobile, Grid on Desktop */}
        <div 
          className="overflow-x-auto pb-4 -mx-6 px-6 snap-x snap-mandatory scroll-smooth lg:overflow-visible"
          style={{
            scrollbarWidth: 'none',
            msOverflowStyle: 'none',
            WebkitOverflowScrolling: 'touch',
          }}
        >
          <style>{`
            .overflow-x-auto::-webkit-scrollbar {
              display: none;
            }
          `}</style>
          <div className="flex gap-5 lg:grid lg:grid-cols-3 lg:gap-6">
            {upcomingEvents.map((event, index) => (
              <motion.div
                key={event.id}
                className={`bg-white/80 backdrop-blur border-2 rounded-3xl p-6 shadow-lg hover:shadow-xl transition-all snap-center lg:w-auto ${
                  event.priority === 'high' ? 'border-rose-300' : 'border-pink-200/50'
                } ${event.eventType === "Mother's Day" ? 'bg-gradient-to-br from-purple-50 to-pink-50' : ''}`}
                style={{ 
                  width: '340px',
                  maxWidth: '90vw',
                  flexShrink: 0,
                }}
                initial={{ opacity: 0, y: 20 }}
                animate={{ opacity: 1, y: 0 }}
                transition={{ delay: index * 0.1 }}
              >
                {event.priority === 'high' && (
                  <div className="mb-3">
                    <span className="px-3 py-1 rounded-full text-xs font-semibold bg-gradient-to-r from-rose-500 to-pink-500 text-white">
                      URGENT
                    </span>
                  </div>
                )}

                {/* Special Badge for Mother's Day */}
                {event.eventType === "Mother's Day" && (
                  <div className="mb-3">
                    <span className="px-3 py-1 rounded-full text-xs font-semibold bg-gradient-to-r from-purple-500 to-pink-500 text-white flex items-center gap-1 w-fit">
                      ✨ Special Occasion
                    </span>
                  </div>
                )}

                <div className="flex items-start gap-4 mb-5">
                  <div className={`w-16 h-16 rounded-2xl flex items-center justify-center text-3xl shadow-lg flex-shrink-0 ${
                    event.eventType === "Mother's Day" 
                      ? 'bg-gradient-to-br from-purple-400 to-pink-400' 
                      : 'bg-gradient-to-br from-rose-400 to-purple-400'
                  }`}>
                    {event.eventIcon}
                  </div>
                  <div className="flex-1">
                    <h3 className="text-lg font-bold text-gray-800 mb-1">
                      {event.lovedOneName}'s {event.eventType}
                    </h3>
                    <p className="text-sm text-gray-600 mb-1">{event.eventDate}</p>
                    <p className={`text-sm font-semibold ${event.priority === 'high' ? 'text-rose-600' : event.eventType === "Mother's Day" ? 'text-purple-600' : 'text-purple-600'}`}>
                      In {event.daysUntil} days
                    </p>
                  </div>
                </div>

                <button
                  onClick={() => handleGiftIdeas(event.id)}
                  className={`w-full py-3 px-6 rounded-2xl text-white font-semibold shadow-lg hover:shadow-xl hover:scale-[1.02] transition-all flex items-center justify-center gap-2 ${
                    event.eventType === "Mother's Day"
                      ? 'bg-gradient-to-r from-purple-500 via-pink-500 to-rose-500'
                      : 'bg-gradient-to-r from-rose-500 via-pink-500 to-purple-500'
                  }`}
                >
                  <Gift className="w-4 h-4" />
                  {event.eventType === "Mother's Day" ? 'Special Gift Ideas' : 'Gift Ideas'}
                </button>
              </motion.div>
            ))}
          </div>
        </div>
      </div>

      {/* SECTION 3: DAILY INSPIRATION */}
      <div className="max-w-6xl mx-auto px-6 py-6">
        <div className="mb-5">
          <h2 className="text-2xl font-bold text-gray-800 mb-1">Daily Inspiration</h2>
          <p className="text-sm text-gray-600">A moment of reflection</p>
        </div>

        <motion.div
          className="bg-gradient-to-br from-purple-50 via-pink-50 to-rose-50 border-2 border-purple-200/50 rounded-3xl p-8 shadow-xl"
          initial={{ opacity: 0, scale: 0.95 }}
          animate={{ opacity: 1, scale: 1 }}
        >
          {/* Icon */}
          <div className="w-16 h-16 mx-auto mb-6 rounded-2xl bg-gradient-to-br from-purple-400 to-pink-400 flex items-center justify-center shadow-lg">
            <Sparkles className="w-8 h-8 text-white" />
          </div>

          {/* Quote Card */}
          <div className="bg-white/80 backdrop-blur rounded-2xl p-6 mb-6 shadow-lg">
            <p className="text-lg text-gray-800 mb-4 leading-relaxed text-center italic font-serif">
              {dailyInspiration.quote}
            </p>
            <p className="text-sm text-gray-600 font-medium text-center">
              — {dailyInspiration.author}
            </p>
          </div>

          {/* Action Buttons */}
          <div className="flex items-center justify-center gap-4">
            <button
              onClick={() => setIsInspirationLiked(!isInspirationLiked)}
              className={`flex items-center gap-2 px-6 py-3 rounded-2xl transition-all shadow-lg hover:shadow-xl hover:scale-[1.02] ${
                isInspirationLiked
                  ? 'bg-gradient-to-r from-rose-500 to-pink-500 text-white'
                  : 'bg-white/80 text-gray-700 hover:bg-white'
              }`}
            >
              <Heart className={`w-5 h-5 ${isInspirationLiked ? 'fill-white' : ''}`} />
              <span className="font-semibold">{isInspirationLiked ? 'Liked' : 'Like'}</span>
            </button>
            <button
              onClick={() => handleShare(dailyInspiration.quote)}
              className="flex items-center gap-2 px-6 py-3 rounded-2xl bg-white/80 text-gray-700 hover:bg-white transition-all shadow-lg hover:shadow-xl hover:scale-[1.02]"
            >
              <Share2 className="w-5 h-5" />
              <span className="font-semibold">Share</span>
            </button>
          </div>

        </motion.div>
      </div>

      <BottomNav />
      <AccountSettingsModal
        isOpen={showAccountSettings}
        onClose={() => setShowAccountSettings(false)}
        userType="individual"
      />
    </div>
  );
}