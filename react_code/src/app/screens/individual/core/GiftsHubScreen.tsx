import { useState } from 'react';
import { useNavigate } from 'react-router-dom';
import { Gift, Heart, Calendar, Sparkles, ChevronRight, TrendingUp, ArrowLeft, List } from 'lucide-react';
import { motion } from 'motion/react';
import BottomNav from '../../../components/BottomNav';
import { useApp } from '../../../context/AppContext';

export default function GiftsHubScreen() {
  const navigate = useNavigate();
  const { currentUser } = useApp();
  const [savedGiftsCount] = useState(8);

  // Upcoming events with gift opportunities
  const upcomingEvents = [
    {
      id: 1,
      lovedOneName: 'Sarah',
      eventType: 'Birthday',
      eventDate: 'January 23, 2026',
      daysUntil: 6,
      eventIcon: '🎂',
      urgent: true,
    },
    {
      id: 2,
      lovedOneName: 'Mom',
      eventType: "Mother's Day",
      eventDate: 'May 11, 2026',
      daysUntil: 114,
      eventIcon: '🌸',
      urgent: false,
    },
    {
      id: 3,
      lovedOneName: 'Jake',
      eventType: 'Friendship Anniversary',
      eventDate: 'March 15, 2026',
      daysUntil: 57,
      eventIcon: '🤝',
      urgent: false,
    },
    {
      id: 4,
      lovedOneName: 'Dad',
      eventType: "Father's Day",
      eventDate: 'June 21, 2026',
      daysUntil: 155,
      eventIcon: '👔',
      urgent: false,
    },
  ];

  // Popular gift categories
  const giftCategories = [
    { id: 'personalized', label: 'Personalized', icon: '💝', color: 'from-rose-400 to-pink-400' },
    { id: 'experience', label: 'Experiences', icon: '✨', color: 'from-purple-400 to-pink-400' },
    { id: 'luxury', label: 'Luxury', icon: '💎', color: 'from-pink-400 to-rose-400' },
    { id: 'practical', label: 'Practical', icon: '🎯', color: 'from-rose-400 to-purple-400' },
  ];

  const handleViewGifts = (eventId: number) => {
    navigate(`/individual/gift-ideas/${eventId}`);
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
          
          <p className="text-lg text-gray-700 mb-3">
            Hello, {currentUser?.name || 'Friend'}! 👋
          </p>
          <h1 className="text-3xl font-bold bg-gradient-to-r from-rose-600 via-pink-600 to-purple-600 bg-clip-text text-transparent mb-2">
            Gift Ideas
          </h1>
          <p className="text-gray-600">
            Find the perfect gift for every special moment
          </p>
        </div>
      </div>

      {/* Stats Cards */}
      <div className="max-w-4xl mx-auto px-6 pt-6 pb-4">
        <div className="grid grid-cols-2 gap-4">
          <motion.div
            className="bg-white/80 backdrop-blur border border-pink-200/50 rounded-2xl p-5 shadow-lg"
            initial={{ opacity: 0, y: 20 }}
            animate={{ opacity: 1, y: 0 }}
            transition={{ delay: 0.1 }}
          >
            <div className="flex items-center gap-3 mb-2">
              <div className="w-12 h-12 rounded-xl bg-gradient-to-br from-rose-400 to-pink-400 flex items-center justify-center shadow-lg">
                <Calendar className="w-6 h-6 text-white" />
              </div>
              <div>
                <p className="text-2xl font-bold text-gray-800">{upcomingEvents.length}</p>
                <p className="text-xs text-gray-600">Upcoming Events</p>
              </div>
            </div>
          </motion.div>

          <motion.div
            className="bg-white/80 backdrop-blur border border-pink-200/50 rounded-2xl p-5 shadow-lg"
            initial={{ opacity: 0, y: 20 }}
            animate={{ opacity: 1, y: 0 }}
            transition={{ delay: 0.2 }}
          >
            <div className="flex items-center gap-3 mb-2">
              <div className="w-12 h-12 rounded-xl bg-gradient-to-br from-purple-400 to-pink-400 flex items-center justify-center shadow-lg">
                <Heart className="w-6 h-6 text-white" />
              </div>
              <div>
                <p className="text-2xl font-bold text-gray-800">{savedGiftsCount}</p>
                <p className="text-xs text-gray-600">Saved Gift Ideas</p>
              </div>
            </div>
          </motion.div>
        </div>

        {/* View All Gift Ideas Button */}
        <motion.button
          onClick={() => navigate('/individual/all-gift-ideas')}
          className="w-full mt-4 py-4 px-6 rounded-2xl bg-gradient-to-r from-purple-500 via-pink-500 to-rose-500 text-white font-semibold shadow-lg hover:shadow-xl hover:scale-[1.02] transition-all flex items-center justify-center gap-2"
          initial={{ opacity: 0, y: 20 }}
          animate={{ opacity: 1, y: 0 }}
          transition={{ delay: 0.3 }}
          whileHover={{ scale: 1.02 }}
          whileTap={{ scale: 0.98 }}
        >
          <List className="w-5 h-5" />
          View All Gift Ideas
          <ChevronRight className="w-5 h-5" />
        </motion.button>
      </div>

      {/* Upcoming Events Section */}
      <div className="max-w-4xl mx-auto px-6 py-6">
        <div className="flex items-center justify-between mb-5">
          <h2 className="text-2xl font-bold text-gray-800">Upcoming Events</h2>
          <TrendingUp className="w-5 h-5 text-rose-600" />
        </div>

        <div className="space-y-4">
          {upcomingEvents.map((event, index) => (
            <motion.div
              key={event.id}
              className="bg-white/80 backdrop-blur border-2 border-pink-200/50 rounded-3xl overflow-hidden shadow-lg hover:shadow-xl transition-all cursor-pointer"
              initial={{ opacity: 0, x: -20 }}
              animate={{ opacity: 1, x: 0 }}
              transition={{ delay: index * 0.1 }}
              onClick={() => handleViewGifts(event.id)}
            >
              <div className="p-6">
                <div className="flex items-start gap-4">
                  {/* Event Icon */}
                  <div className="w-16 h-16 rounded-2xl bg-gradient-to-br from-rose-400 to-purple-400 flex items-center justify-center text-3xl shadow-lg flex-shrink-0">
                    {event.eventIcon}
                  </div>

                  {/* Event Details */}
                  <div className="flex-1">
                    <div className="flex items-start justify-between mb-2">
                      <div>
                        <h3 className="text-xl font-bold text-gray-800 mb-1">
                          {event.lovedOneName}'s {event.eventType}
                        </h3>
                        <p className="text-sm text-gray-600">{event.eventDate}</p>
                      </div>
                      {event.urgent && (
                        <span className="px-3 py-1.5 rounded-full text-xs font-bold bg-gradient-to-r from-rose-500 to-pink-500 text-white shadow-lg">
                          Urgent
                        </span>
                      )}
                    </div>

                    {/* Days Until */}
                    <div className="bg-gradient-to-br from-purple-50 to-pink-50 rounded-xl p-3 mb-4">
                      <p className="text-sm text-gray-700">
                        <span className="font-bold text-rose-600">{event.daysUntil} days</span> until the big day
                      </p>
                    </div>

                    {/* View Gifts Button */}
                    <button
                      className="w-full py-3 px-6 rounded-2xl bg-gradient-to-r from-rose-500 via-pink-500 to-purple-500 text-white font-semibold shadow-lg hover:shadow-xl hover:scale-[1.02] transition-all flex items-center justify-center gap-2"
                      onClick={(e) => {
                        e.stopPropagation();
                        handleViewGifts(event.id);
                      }}
                    >
                      <Gift className="w-4 h-4" />
                      View Gift Ideas
                      <ChevronRight className="w-4 h-4" />
                    </button>
                  </div>
                </div>
              </div>
            </motion.div>
          ))}
        </div>
      </div>

      <BottomNav />
    </div>
  );
}