import { useState } from 'react';
import { useNavigate } from 'react-router';
import { ArrowLeft, Calendar, Gift, Heart, Sparkles } from 'lucide-react';
import { motion } from 'motion/react';

export default function AllUpcomingEventsScreen() {
  const navigate = useNavigate();
  const [sortBy, setSortBy] = useState<'date' | 'lovedOne'>('date');

  // All upcoming events organized by loved one and date
  const allEvents = [
    {
      id: 1,
      lovedOneName: 'Sarah',
      lovedOneAvatar: '👩',
      relationship: 'Partner',
      eventType: 'Birthday',
      eventDate: 'January 23, 2026',
      daysUntil: 6,
      eventIcon: '🎂',
      priority: 'high',
    },
    {
      id: 4,
      lovedOneName: 'Sarah',
      lovedOneAvatar: '👩',
      relationship: 'Partner',
      eventType: 'Anniversary',
      eventDate: 'June 14, 2026',
      daysUntil: 148,
      eventIcon: '💑',
      priority: 'medium',
    },
    {
      id: 2,
      lovedOneName: 'Mom',
      lovedOneAvatar: '👩‍🦳',
      relationship: 'Mother',
      eventType: "Mother's Day",
      eventDate: 'May 11, 2026',
      daysUntil: 114,
      eventIcon: '🌸',
      priority: 'medium',
    },
    {
      id: 5,
      lovedOneName: 'Mom',
      lovedOneAvatar: '👩‍🦳',
      relationship: 'Mother',
      eventType: 'Birthday',
      eventDate: 'August 30, 2026',
      daysUntil: 225,
      eventIcon: '🎂',
      priority: 'low',
    },
    {
      id: 3,
      lovedOneName: 'Jake',
      lovedOneAvatar: '👨',
      relationship: 'Best Friend',
      eventType: 'Friendship Anniversary',
      eventDate: 'March 15, 2026',
      daysUntil: 57,
      eventIcon: '🤝',
      priority: 'low',
    },
    {
      id: 6,
      lovedOneName: 'Jake',
      lovedOneAvatar: '👨',
      relationship: 'Best Friend',
      eventType: 'Birthday',
      eventDate: 'October 12, 2026',
      daysUntil: 268,
      eventIcon: '🎂',
      priority: 'low',
    },
  ];

  // Sort events
  const sortedEvents = [...allEvents].sort((a, b) => {
    if (sortBy === 'date') {
      return a.daysUntil - b.daysUntil;
    } else {
      // Sort by loved one name alphabetically
      const nameCompare = a.lovedOneName.localeCompare(b.lovedOneName);
      if (nameCompare !== 0) return nameCompare;
      // If same loved one, sort by date
      return a.daysUntil - b.daysUntil;
    }
  });

  // Group events by loved one for "lovedOne" sort
  const groupedByLovedOne = sortedEvents.reduce((acc, event) => {
    if (!acc[event.lovedOneName]) {
      acc[event.lovedOneName] = [];
    }
    acc[event.lovedOneName].push(event);
    return acc;
  }, {} as Record<string, typeof allEvents>);

  return (
    <div className="min-h-screen bg-gradient-to-br from-rose-50 via-pink-50 to-purple-50 pb-24">
      {/* Header */}
      <div className="bg-gradient-to-br from-rose-100 via-pink-100 to-purple-100 border-b-4 border-rose-200/50 sticky top-0 z-30 shadow-lg">
        <div className="max-w-6xl mx-auto px-6 py-6">
          <motion.div
            initial={{ opacity: 0, y: -20 }}
            animate={{ opacity: 1, y: 0 }}
          >
            <button
              onClick={() => navigate('/individual/home')}
              className="flex items-center gap-2 text-rose-600 hover:text-rose-700 mb-4 font-semibold transition-colors"
            >
              <ArrowLeft className="w-5 h-5" />
              Back to Dashboard
            </button>
            <div className="flex items-center gap-3 mb-3">
              <div className="w-14 h-14 rounded-2xl bg-gradient-to-br from-purple-400 to-pink-400 flex items-center justify-center shadow-lg">
                <Calendar className="w-7 h-7 text-white" />
              </div>
              <div>
                <h1 className="text-3xl font-bold text-gray-800">
                  All Upcoming Events
                </h1>
                <p className="text-sm text-gray-600">
                  {allEvents.length} special occasions to celebrate
                </p>
              </div>
            </div>
          </motion.div>
        </div>
      </div>

      <div className="max-w-6xl mx-auto px-6 py-8">
        {/* Sort Toggle */}
        <motion.div
          className="mb-6 flex items-center justify-center gap-3"
          initial={{ opacity: 0, y: 20 }}
          animate={{ opacity: 1, y: 0 }}
          transition={{ delay: 0.1 }}
        >
          <span className="text-sm font-semibold text-gray-600">Sort by:</span>
          <div className="flex gap-2 bg-white/80 backdrop-blur border-2 border-pink-200/50 rounded-2xl p-1.5 shadow-md">
            <button
              onClick={() => setSortBy('date')}
              className={`px-4 py-2 rounded-xl font-semibold transition-all ${
                sortBy === 'date'
                  ? 'bg-gradient-to-r from-rose-500 to-pink-500 text-white shadow-md'
                  : 'text-gray-600 hover:bg-rose-50'
              }`}
            >
              By Date
            </button>
            <button
              onClick={() => setSortBy('lovedOne')}
              className={`px-4 py-2 rounded-xl font-semibold transition-all ${
                sortBy === 'lovedOne'
                  ? 'bg-gradient-to-r from-rose-500 to-pink-500 text-white shadow-md'
                  : 'text-gray-600 hover:bg-rose-50'
              }`}
            >
              By Loved One
            </button>
          </div>
        </motion.div>

        {/* Events Display */}
        {sortBy === 'date' ? (
          // Display all events sorted by date
          <div className="space-y-4">
            {sortedEvents.map((event, index) => (
              <motion.div
                key={event.id}
                className={`bg-white/80 backdrop-blur border-2 rounded-3xl p-6 shadow-lg hover:shadow-xl transition-all ${
                  event.priority === 'high' ? 'border-rose-300' : 'border-pink-200/50'
                } ${event.eventType === "Mother's Day" ? 'bg-gradient-to-br from-purple-50 to-pink-50' : ''}`}
                initial={{ opacity: 0, y: 20 }}
                animate={{ opacity: 1, y: 0 }}
                transition={{ delay: index * 0.05 }}
              >
                {event.priority === 'high' && (
                  <div className="mb-3">
                    <span className="px-3 py-1 rounded-full text-xs font-semibold bg-gradient-to-r from-rose-500 to-pink-500 text-white">
                      URGENT
                    </span>
                  </div>
                )}

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
                    <p className="text-sm text-gray-600 mb-1 flex items-center gap-2">
                      <span className="text-xl">{event.lovedOneAvatar}</span>
                      {event.relationship}
                    </p>
                    <p className="text-sm text-gray-600 mb-1">{event.eventDate}</p>
                    <p className={`text-sm font-semibold ${
                      event.priority === 'high' ? 'text-rose-600' : 
                      event.eventType === "Mother's Day" ? 'text-purple-600' : 'text-purple-600'
                    }`}>
                      In {event.daysUntil} days
                    </p>
                  </div>
                </div>

                <button
                  onClick={() => navigate(`/individual/gift-ideas/${event.id}`)}
                  className={`w-full py-3 px-6 rounded-2xl text-white font-semibold shadow-lg hover:shadow-xl hover:scale-[1.02] transition-all flex items-center justify-center gap-2 ${
                    event.eventType === "Mother's Day"
                      ? 'bg-gradient-to-r from-purple-500 via-pink-500 to-rose-500'
                      : 'bg-gradient-to-r from-rose-500 via-pink-500 to-purple-500'
                  }`}
                >
                  <Gift className="w-5 h-5" />
                  View Gift Ideas
                </button>
              </motion.div>
            ))}
          </div>
        ) : (
          // Display events grouped by loved one
          <div className="space-y-6">
            {Object.entries(groupedByLovedOne).map(([lovedOneName, events], groupIndex) => (
              <motion.div
                key={lovedOneName}
                initial={{ opacity: 0, y: 20 }}
                animate={{ opacity: 1, y: 0 }}
                transition={{ delay: groupIndex * 0.1 }}
              >
                {/* Loved One Header */}
                <div className="flex items-center gap-3 mb-4 bg-gradient-to-r from-rose-100 to-pink-100 border-2 border-rose-200/50 rounded-2xl p-4 shadow-md">
                  <div className="w-12 h-12 rounded-xl bg-white shadow-md flex items-center justify-center text-2xl ring-2 ring-rose-200">
                    {events[0].lovedOneAvatar}
                  </div>
                  <div>
                    <h2 className="text-xl font-bold text-gray-800">{lovedOneName}</h2>
                    <p className="text-sm text-gray-600">{events[0].relationship} • {events.length} upcoming event{events.length !== 1 ? 's' : ''}</p>
                  </div>
                </div>

                {/* Events for this loved one */}
                <div className="space-y-4 ml-4 border-l-4 border-pink-200/50 pl-6">
                  {events.map((event, eventIndex) => (
                    <motion.div
                      key={event.id}
                      className={`bg-white/80 backdrop-blur border-2 rounded-3xl p-6 shadow-lg hover:shadow-xl transition-all ${
                        event.priority === 'high' ? 'border-rose-300' : 'border-pink-200/50'
                      } ${event.eventType === "Mother's Day" ? 'bg-gradient-to-br from-purple-50 to-pink-50' : ''}`}
                      initial={{ opacity: 0, x: -20 }}
                      animate={{ opacity: 1, x: 0 }}
                      transition={{ delay: (groupIndex * 0.1) + (eventIndex * 0.05) }}
                    >
                      {event.priority === 'high' && (
                        <div className="mb-3">
                          <span className="px-3 py-1 rounded-full text-xs font-semibold bg-gradient-to-r from-rose-500 to-pink-500 text-white">
                            URGENT
                          </span>
                        </div>
                      )}

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
                            {event.eventType}
                          </h3>
                          <p className="text-sm text-gray-600 mb-1">{event.eventDate}</p>
                          <p className={`text-sm font-semibold ${
                            event.priority === 'high' ? 'text-rose-600' : 
                            event.eventType === "Mother's Day" ? 'text-purple-600' : 'text-purple-600'
                          }`}>
                            In {event.daysUntil} days
                          </p>
                        </div>
                      </div>

                      <button
                        onClick={() => navigate(`/individual/gift-ideas/${event.id}`)}
                        className={`w-full py-3 px-6 rounded-2xl text-white font-semibold shadow-lg hover:shadow-xl hover:scale-[1.02] transition-all flex items-center justify-center gap-2 ${
                          event.eventType === "Mother's Day"
                            ? 'bg-gradient-to-r from-purple-500 via-pink-500 to-rose-500'
                            : 'bg-gradient-to-r from-rose-500 via-pink-500 to-purple-500'
                        }`}
                      >
                        <Gift className="w-5 h-5" />
                        View Gift Ideas
                      </button>
                    </motion.div>
                  ))}
                </div>
              </motion.div>
            ))}
          </div>
        )}

        {/* Summary Card */}
        <motion.div
          className="mt-8 bg-gradient-to-br from-purple-50 to-pink-50 border-2 border-purple-200/50 rounded-3xl p-6 text-center shadow-lg"
          initial={{ opacity: 0 }}
          animate={{ opacity: 1 }}
          transition={{ delay: 0.5 }}
        >
          <Sparkles className="w-10 h-10 mx-auto mb-3 text-purple-600" />
          <p className="text-sm text-gray-600">
            <span className="font-semibold text-gray-800">Stay prepared:</span> Cherish AI will remind you about upcoming events and help you find the perfect gift for each occasion
          </p>
        </motion.div>
      </div>
    </div>
  );
}