import { useState } from 'react';
import { useNavigate } from 'react-router-dom';
import { ArrowLeft, Bell, Heart, Calendar, Gift, Sparkles, Check, X, TrendingUp, MessageCircle, Award, Star } from 'lucide-react';
import { motion } from 'motion/react';
import BottomNav from '../../../components/BottomNav';

interface Notification {
  id: number;
  type: 'reminder' | 'inspiration' | 'achievement' | 'suggestion' | 'event';
  title: string;
  message: string;
  timestamp: string;
  isRead: boolean;
  icon: any;
  gradient: string;
  lovedOne?: string;
}

export default function NotificationsListScreen() {
  const navigate = useNavigate();
  const [filter, setFilter] = useState<'all' | 'unread'>('all');
  const [notifications, setNotifications] = useState<Notification[]>([
    {
      id: 1,
      type: 'reminder',
      title: "Sarah's Birthday Coming Up!",
      message: "Sarah's birthday is in 5 days. Time to find the perfect gift!",
      timestamp: '2 hours ago',
      isRead: false,
      icon: Calendar,
      gradient: 'from-rose-400 to-pink-400',
      lovedOne: 'Sarah',
    },
    {
      id: 2,
      type: 'inspiration',
      title: 'Daily Love Inspiration',
      message: 'Small gestures of kindness can make someone\'s entire day brighter.',
      timestamp: '5 hours ago',
      isRead: false,
      icon: Sparkles,
      gradient: 'from-purple-400 to-pink-400',
    },
    {
      id: 3,
      type: 'suggestion',
      title: 'Perfect Gift Idea for Mom',
      message: 'Based on her preferences, we found a beautiful handmade ceramic vase she might love!',
      timestamp: '1 day ago',
      isRead: true,
      icon: Gift,
      gradient: 'from-pink-400 to-rose-400',
      lovedOne: 'Mom',
    },
    {
      id: 4,
      type: 'achievement',
      title: '7-Day Streak! 🎉',
      message: 'Amazing! You\'ve stayed connected with your loved ones for 7 days straight!',
      timestamp: '1 day ago',
      isRead: true,
      icon: Award,
      gradient: 'from-amber-400 to-orange-400',
    },
    {
      id: 5,
      type: 'event',
      title: 'Anniversary Reminder',
      message: 'Your anniversary with Jake is coming up on June 1st.',
      timestamp: '2 days ago',
      isRead: true,
      icon: Heart,
      gradient: 'from-red-400 to-pink-400',
      lovedOne: 'Jake',
    },
    {
      id: 6,
      type: 'suggestion',
      title: 'New Message Suggestion',
      message: 'We created a thoughtful message you can send to Sarah today.',
      timestamp: '3 days ago',
      isRead: true,
      icon: MessageCircle,
      gradient: 'from-blue-400 to-cyan-400',
      lovedOne: 'Sarah',
    },
    {
      id: 7,
      type: 'inspiration',
      title: 'Weekly Relationship Tip',
      message: 'Quality time doesn\'t always mean grand gestures. Even a 5-minute phone call can strengthen bonds.',
      timestamp: '4 days ago',
      isRead: true,
      icon: Star,
      gradient: 'from-indigo-400 to-purple-400',
    },
  ]);

  const handleMarkAsRead = (id: number) => {
    setNotifications(notifications.map(notif => 
      notif.id === id ? { ...notif, isRead: true } : notif
    ));
  };

  const handleMarkAllAsRead = () => {
    setNotifications(notifications.map(notif => ({ ...notif, isRead: true })));
  };

  const handleDelete = (id: number) => {
    setNotifications(notifications.filter(notif => notif.id !== id));
  };

  const filteredNotifications = filter === 'all' 
    ? notifications 
    : notifications.filter(n => !n.isRead);

  const unreadCount = notifications.filter(n => !n.isRead).length;

  return (
    <div className="min-h-screen bg-gradient-to-br from-rose-50 via-pink-50 to-purple-50 pb-28">{/* Added pb-28 for bottom nav spacing */}
      {/* Header */}
      <div className="sticky top-0 z-20 bg-gradient-to-br from-rose-50/95 via-pink-50/95 to-purple-50/95 backdrop-blur-xl border-b border-pink-100/50">
        <div className="max-w-4xl mx-auto px-6 py-4">
          <div className="flex items-center justify-between mb-4">
            <button
              onClick={() => navigate(-1)}
              className="flex items-center gap-2 text-rose-600 hover:text-rose-700 transition-colors"
            >
              <ArrowLeft className="w-5 h-5" />
              <span className="font-medium">Back</span>
            </button>
            
            {unreadCount > 0 && (
              <button
                onClick={handleMarkAllAsRead}
                className="text-sm font-medium px-4 py-2 rounded-xl transition-all"
                style={{
                  background: 'linear-gradient(135deg, #E91E63, #F06292)',
                  color: '#FFFFFF',
                  boxShadow: '0px 4px 12px rgba(233, 30, 99, 0.3)',
                }}
              >
                Mark All Read
              </button>
            )}
          </div>

          {/* Title */}
          <div className="mb-4">
            <div className="flex items-center gap-3 mb-2">
              <div
                className="w-12 h-12 rounded-2xl flex items-center justify-center"
                style={{
                  background: 'linear-gradient(135deg, #E91E63, #F06292)',
                  boxShadow: '0px 8px 24px rgba(233, 30, 99, 0.4)',
                }}
              >
                <Bell className="w-6 h-6 text-white" />
              </div>
              <div>
                <h1 className="text-3xl font-bold bg-gradient-to-r from-rose-600 via-pink-600 to-purple-600 bg-clip-text text-transparent">
                  Notifications
                </h1>
                {unreadCount > 0 && (
                  <p className="text-sm font-medium text-gray-600">
                    {unreadCount} unread {unreadCount === 1 ? 'notification' : 'notifications'}
                  </p>
                )}
              </div>
            </div>
          </div>

          {/* Filter Tabs */}
          <div className="flex gap-2">
            <button
              onClick={() => setFilter('all')}
              className="px-5 py-2.5 rounded-xl font-medium transition-all"
              style={{
                background: filter === 'all'
                  ? 'linear-gradient(135deg, #E91E63, #F06292)'
                  : 'linear-gradient(135deg, #FFFFFF, #FFF5F8)',
                color: filter === 'all' ? '#FFFFFF' : '#6B4B5E',
                border: filter === 'all' ? 'none' : '2px solid rgba(246, 166, 193, 0.2)',
                boxShadow: filter === 'all'
                  ? '0px 4px 12px rgba(233, 30, 99, 0.3)'
                  : '0px 2px 8px rgba(246, 166, 193, 0.1)',
              }}
            >
              All ({notifications.length})
            </button>
            <button
              onClick={() => setFilter('unread')}
              className="px-5 py-2.5 rounded-xl font-medium transition-all"
              style={{
                background: filter === 'unread'
                  ? 'linear-gradient(135deg, #E91E63, #F06292)'
                  : 'linear-gradient(135deg, #FFFFFF, #FFF5F8)',
                color: filter === 'unread' ? '#FFFFFF' : '#6B4B5E',
                border: filter === 'unread' ? 'none' : '2px solid rgba(246, 166, 193, 0.2)',
                boxShadow: filter === 'unread'
                  ? '0px 4px 12px rgba(233, 30, 99, 0.3)'
                  : '0px 2px 8px rgba(246, 166, 193, 0.1)',
              }}
            >
              Unread ({unreadCount})
            </button>
          </div>
        </div>
      </div>

      {/* Notifications List */}
      <div className="max-w-4xl mx-auto px-6 pt-6">
        {filteredNotifications.length === 0 ? (
          // Empty State
          <motion.div
            className="text-center py-16"
            initial={{ opacity: 0, y: 20 }}
            animate={{ opacity: 1, y: 0 }}
          >
            <div
              className="w-24 h-24 rounded-3xl mx-auto mb-6 flex items-center justify-center"
              style={{
                background: 'linear-gradient(135deg, #F6A6C1, #FAD0DC)',
                boxShadow: '0px 8px 24px rgba(246, 166, 193, 0.3)',
              }}
            >
              <Bell className="w-12 h-12 text-white" />
            </div>
            <h3 className="text-2xl font-bold text-gray-800 mb-2">
              All Caught Up!
            </h3>
            <p className="text-gray-600">
              {filter === 'unread' 
                ? "You don't have any unread notifications"
                : "You don't have any notifications yet"}
            </p>
          </motion.div>
        ) : (
          <div className="space-y-4">
            {filteredNotifications.map((notification, index) => {
              const Icon = notification.icon;
              
              return (
                <motion.div
                  key={notification.id}
                  className="bg-white/80 backdrop-blur border rounded-3xl p-5 transition-all hover:shadow-lg group relative overflow-hidden"
                  style={{
                    borderColor: notification.isRead 
                      ? 'rgba(246, 166, 193, 0.1)' 
                      : 'rgba(233, 30, 99, 0.3)',
                    boxShadow: notification.isRead
                      ? '0px 4px 12px rgba(246, 166, 193, 0.1)'
                      : '0px 8px 24px rgba(233, 30, 99, 0.2)',
                  }}
                  initial={{ opacity: 0, x: -20 }}
                  animate={{ opacity: 1, x: 0 }}
                  transition={{ duration: 0.3, delay: index * 0.05 }}
                  whileHover={{ x: 4 }}
                >
                  {/* Unread Indicator */}
                  {!notification.isRead && (
                    <div
                      className="absolute left-0 top-0 bottom-0 w-1.5 rounded-l-3xl"
                      style={{
                        background: 'linear-gradient(135deg, #E91E63, #F06292)',
                      }}
                    />
                  )}

                  <div className="flex items-start gap-4">
                    {/* Icon */}
                    <div
                      className={`w-14 h-14 rounded-2xl flex items-center justify-center flex-shrink-0 bg-gradient-to-br ${notification.gradient}`}
                      style={{
                        boxShadow: '0px 4px 12px rgba(246, 166, 193, 0.3)',
                      }}
                    >
                      <Icon className="w-7 h-7 text-white" />
                    </div>

                    {/* Content */}
                    <div className="flex-1 min-w-0">
                      <div className="flex items-start justify-between gap-3 mb-2">
                        <h3 className="font-bold text-gray-800 text-lg">
                          {notification.title}
                        </h3>
                        <span className="text-xs text-gray-500 whitespace-nowrap">
                          {notification.timestamp}
                        </span>
                      </div>

                      <p className="text-gray-600 mb-3 leading-relaxed">
                        {notification.message}
                      </p>

                      {/* Loved One Badge */}
                      {notification.lovedOne && (
                        <div className="mb-3">
                          <span
                            className="inline-flex items-center gap-1.5 px-3 py-1.5 rounded-full text-xs font-medium"
                            style={{
                              background: 'linear-gradient(135deg, #FFF5F8, #FFE4EC)',
                              color: '#E91E63',
                              border: '1px solid rgba(233, 30, 99, 0.2)',
                            }}
                          >
                            <Heart className="w-3 h-3" />
                            {notification.lovedOne}
                          </span>
                        </div>
                      )}

                      {/* Actions */}
                      <div className="flex items-center gap-3">
                        {!notification.isRead && (
                          <button
                            onClick={() => handleMarkAsRead(notification.id)}
                            className="flex items-center gap-1.5 px-4 py-2 rounded-xl text-sm font-medium transition-all"
                            style={{
                              background: 'linear-gradient(135deg, #E91E63, #F06292)',
                              color: '#FFFFFF',
                              boxShadow: '0px 4px 12px rgba(233, 30, 99, 0.3)',
                            }}
                          >
                            <Check className="w-4 h-4" />
                            Mark as Read
                          </button>
                        )}
                        <button
                          onClick={() => handleDelete(notification.id)}
                          className="flex items-center gap-1.5 px-4 py-2 rounded-xl text-sm font-medium transition-all"
                          style={{
                            background: 'linear-gradient(135deg, #FFFFFF, #FFF5F8)',
                            color: '#6B4B5E',
                            border: '1px solid rgba(246, 166, 193, 0.2)',
                          }}
                        >
                          <X className="w-4 h-4" />
                          Delete
                        </button>
                      </div>
                    </div>
                  </div>
                </motion.div>
              );
            })}
          </div>
        )}
      </div>

      {/* Bottom Navigation */}
      <BottomNav />
    </div>
  );
}