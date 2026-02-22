import { useState } from 'react';
import { useNavigate } from 'react-router-dom';
import { ArrowLeft, MessageSquare, Calendar, Heart, ChevronDown, ChevronUp, Copy, Share2 } from 'lucide-react';
import { motion, AnimatePresence } from 'motion/react';
import { ImageWithFallback } from '@/app/components/figma/ImageWithFallback';
import BottomNav from '@/app/components/BottomNav';

interface Message {
  id: string;
  lovedOneId: string;
  lovedOneName: string;
  lovedOnePhoto: string;
  content: string;
  date: string;
  occasion?: string;
}

// Mock data - in real app, this would come from AppContext/API
const mockMessages: Message[] = [
  {
    id: '1',
    lovedOneId: '1',
    lovedOneName: 'Sarah',
    lovedOnePhoto: '',
    content: 'Happy Birthday, my love! 🎂 Every moment with you is a treasure. Here\'s to another year of beautiful memories together.',
    date: '2026-01-15',
    occasion: 'Birthday',
  },
  {
    id: '2',
    lovedOneId: '1',
    lovedOneName: 'Sarah',
    lovedOnePhoto: '',
    content: 'Just thinking about you and wanted to remind you how much you mean to me. Your smile brightens my day ☀️',
    date: '2026-01-10',
  },
  {
    id: '3',
    lovedOneId: '2',
    lovedOneName: 'Mom',
    lovedOnePhoto: '',
    content: 'Thank you for always being there for me. Your love and support mean everything. Love you, Mom! 💕',
    date: '2026-01-08',
  },
  {
    id: '4',
    lovedOneId: '1',
    lovedOneName: 'Sarah',
    lovedOnePhoto: '',
    content: 'Happy Anniversary! Three years of love, laughter, and countless memories. Here\'s to many more! 💍',
    date: '2025-12-20',
    occasion: 'Anniversary',
  },
  {
    id: '5',
    lovedOneId: '2',
    lovedOneName: 'Mom',
    lovedOnePhoto: '',
    content: 'Happy Mother\'s Day to the best mom in the world! Thank you for your endless love and wisdom. 🌸',
    date: '2025-12-15',
    occasion: 'Mother\'s Day',
  },
  {
    id: '6',
    lovedOneId: '3',
    lovedOneName: 'Alex',
    lovedOnePhoto: '',
    content: 'Happy Birthday, buddy! Hope your day is filled with joy and laughter. Let\'s celebrate soon! 🎉',
    date: '2025-12-05',
    occasion: 'Birthday',
  },
  {
    id: '7',
    lovedOneId: '1',
    lovedOneName: 'Sarah',
    lovedOnePhoto: '',
    content: 'Can\'t wait to see you tonight! Missing you already 💖',
    date: '2025-11-28',
  },
];

export default function OldMessagesScreen() {
  const navigate = useNavigate();
  const [selectedLovedOne, setSelectedLovedOne] = useState<string>('all');
  const [expandedLovedOne, setExpandedLovedOne] = useState<string | null>(null);

  // Get unique loved ones from messages
  const lovedOnes = Array.from(
    new Set(mockMessages.map((msg) => msg.lovedOneId))
  ).map((id) => {
    const msg = mockMessages.find((m) => m.lovedOneId === id);
    return {
      id,
      name: msg?.lovedOneName || '',
      photo: msg?.lovedOnePhoto || '',
    };
  });

  // Filter messages based on selected loved one
  const filteredMessages =
    selectedLovedOne === 'all'
      ? mockMessages
      : mockMessages.filter((msg) => msg.lovedOneId === selectedLovedOne);

  // Group messages by loved one
  const messagesByLovedOne = lovedOnes.map((lovedOne) => {
    const messages = mockMessages.filter((msg) => msg.lovedOneId === lovedOne.id);
    
    // Group messages by date
    const messagesByDate = messages.reduce((acc, msg) => {
      const date = new Date(msg.date).toLocaleDateString('en-US', {
        year: 'numeric',
        month: 'long',
        day: 'numeric',
      });
      if (!acc[date]) {
        acc[date] = [];
      }
      acc[date].push(msg);
      return acc;
    }, {} as Record<string, Message[]>);

    return {
      ...lovedOne,
      messages: messagesByDate,
      totalMessages: messages.length,
    };
  });

  const toggleLovedOne = (lovedOneId: string) => {
    setExpandedLovedOne(expandedLovedOne === lovedOneId ? null : lovedOneId);
  };

  const formatDate = (dateString: string) => {
    const date = new Date(dateString);
    return date.toLocaleDateString('en-US', {
      year: 'numeric',
      month: 'long',
      day: 'numeric',
    });
  };

  const handleCopy = (message: string) => {
    navigator.clipboard.writeText(message);
    // Could add toast notification here
  };

  const handleShare = (message: string) => {
    if (navigator.share) {
      navigator.share({
        text: message,
      });
    } else {
      // Fallback: copy to clipboard
      handleCopy(message);
    }
  };

  return (
    <div className="min-h-screen bg-gradient-to-br from-rose-50 via-pink-50 to-purple-50 pb-28">
      {/* Header */}
      <div className="sticky top-0 z-20 bg-gradient-to-br from-rose-50/95 via-pink-50/95 to-purple-50/95 backdrop-blur-xl border-b border-rose-100/50">
        <div className="max-w-2xl mx-auto px-6 py-4">
          <div className="flex items-center gap-3">
            <button
              onClick={() => navigate(-1)}
              className="flex items-center gap-2 text-rose-600 hover:text-rose-700 transition-colors"
            >
              <ArrowLeft className="w-5 h-5" />
            </button>
            <div className="flex items-center gap-2 flex-1">
              <MessageSquare className="w-6 h-6 text-rose-500" />
              <h1 className="text-xl font-semibold text-gray-800">Old Messages</h1>
            </div>
          </div>
        </div>
      </div>

      <div className="max-w-2xl mx-auto px-6 pt-6">
        {/* Filter Tabs */}
        <div className="mb-6">
          <div className="flex gap-2 overflow-x-auto pb-2">
            <button
              onClick={() => setSelectedLovedOne('all')}
              className={`px-4 py-2 rounded-full font-medium transition-all whitespace-nowrap ${
                selectedLovedOne === 'all'
                  ? 'bg-gradient-to-r from-rose-500 to-pink-500 text-white shadow-lg shadow-pink-300/50'
                  : 'bg-white text-gray-600 border border-pink-200 hover:border-pink-300'
              }`}
            >
              All Messages
            </button>
            {lovedOnes.map((lovedOne) => (
              <button
                key={lovedOne.id}
                onClick={() => setSelectedLovedOne(lovedOne.id)}
                className={`px-4 py-2 rounded-full font-medium transition-all whitespace-nowrap ${
                  selectedLovedOne === lovedOne.id
                    ? 'bg-gradient-to-r from-rose-500 to-pink-500 text-white shadow-lg shadow-pink-300/50'
                    : 'bg-white text-gray-600 border border-pink-200 hover:border-pink-300'
                }`}
              >
                {lovedOne.name}
              </button>
            ))}
          </div>
        </div>

        {/* Messages List Organized by Loved One */}
        <div className="space-y-4">
          {messagesByLovedOne.map((lovedOne, index) => (
            <motion.div
              key={lovedOne.id}
              initial={{ opacity: 0, y: 20 }}
              animate={{ opacity: 1, y: 0 }}
              transition={{ delay: index * 0.1 }}
              className="bg-white/80 backdrop-blur-sm rounded-2xl border border-rose-200/50 shadow-lg overflow-hidden"
            >
              {/* Loved One Header */}
              <button
                onClick={() => toggleLovedOne(lovedOne.id)}
                className="w-full p-5 flex items-center justify-between hover:bg-rose-50/50 transition-colors"
              >
                <div className="flex items-center gap-3">
                  {lovedOne.photo ? (
                    <div className="w-12 h-12 rounded-full overflow-hidden border-2 border-rose-200">
                      <ImageWithFallback
                        src={lovedOne.photo}
                        alt={lovedOne.name}
                        className="w-full h-full object-cover"
                      />
                    </div>
                  ) : (
                    <div className="w-12 h-12 rounded-full bg-gradient-to-br from-rose-200 to-pink-200 flex items-center justify-center text-2xl">
                      💑
                    </div>
                  )}
                  <div className="text-left">
                    <h3 className="font-semibold text-gray-800">{lovedOne.name}</h3>
                    <p className="text-sm text-gray-500">
                      {lovedOne.totalMessages} {lovedOne.totalMessages === 1 ? 'message' : 'messages'}
                    </p>
                  </div>
                </div>
                {expandedLovedOne === lovedOne.id ? (
                  <ChevronUp className="w-5 h-5 text-rose-500" />
                ) : (
                  <ChevronDown className="w-5 h-5 text-rose-500" />
                )}
              </button>

              {/* Messages by Date */}
              <AnimatePresence>
                {expandedLovedOne === lovedOne.id && (
                  <motion.div
                    initial={{ height: 0, opacity: 0 }}
                    animate={{ height: 'auto', opacity: 1 }}
                    exit={{ height: 0, opacity: 0 }}
                    transition={{ duration: 0.3 }}
                    className="border-t border-rose-200/50"
                  >
                    <div className="p-5 space-y-4 bg-gradient-to-br from-rose-50/30 to-pink-50/30">
                      {Object.entries(lovedOne.messages)
                        .sort((a, b) => new Date(b[0]).getTime() - new Date(a[0]).getTime())
                        .map(([date, messages]) => (
                          <div key={date} className="space-y-3">
                            {/* Date Header */}
                            <div className="flex items-center gap-2 text-sm text-gray-600">
                              <Calendar className="w-4 h-4 text-purple-500" />
                              <span className="font-medium">{date}</span>
                            </div>

                            {/* Messages for this date */}
                            {messages.map((message) => (
                              <motion.div
                                key={message.id}
                                initial={{ opacity: 0, x: -20 }}
                                animate={{ opacity: 1, x: 0 }}
                                className="bg-white rounded-xl p-4 border border-pink-200/50 shadow-sm"
                              >
                                {message.occasion && (
                                  <div className="inline-flex items-center gap-1 px-3 py-1 rounded-full bg-gradient-to-r from-purple-100 to-pink-100 mb-2">
                                    <Heart className="w-3 h-3 text-purple-600" />
                                    <span className="text-xs font-medium text-purple-700">
                                      {message.occasion}
                                    </span>
                                  </div>
                                )}
                                <p className="text-gray-700 leading-relaxed mb-3">{message.content}</p>
                                
                                {/* Copy & Share Actions */}
                                <div className="flex items-center gap-2 pt-2 border-t border-pink-100">
                                  <button
                                    onClick={(e) => {
                                      e.stopPropagation();
                                      handleCopy(message.content);
                                    }}
                                    className="flex-1 flex items-center justify-center gap-1.5 px-3 py-2 rounded-lg bg-rose-50 hover:bg-rose-100 transition-all border border-rose-200 text-rose-600"
                                  >
                                    <Copy className="w-3.5 h-3.5" />
                                    <span className="text-xs font-medium">Copy</span>
                                  </button>
                                  <button
                                    onClick={(e) => {
                                      e.stopPropagation();
                                      handleShare(message.content);
                                    }}
                                    className="flex-1 flex items-center justify-center gap-1.5 px-3 py-2 rounded-lg bg-rose-50 hover:bg-rose-100 transition-all border border-rose-200 text-rose-600"
                                  >
                                    <Share2 className="w-3.5 h-3.5" />
                                    <span className="text-xs font-medium">Share</span>
                                  </button>
                                </div>
                              </motion.div>
                            ))}
                          </div>
                        ))}
                    </div>
                  </motion.div>
                )}
              </AnimatePresence>
            </motion.div>
          ))}
        </div>

        {/* Empty State */}
        {messagesByLovedOne.length === 0 && (
          <div className="text-center py-12">
            <div className="w-20 h-20 rounded-full bg-gradient-to-br from-purple-100 to-pink-100 mx-auto mb-4 flex items-center justify-center text-4xl">
              💌
            </div>
            <p className="text-gray-600 font-medium mb-2">No messages yet</p>
            <p className="text-gray-400 text-sm">
              Your message history will appear here
            </p>
          </div>
        )}
      </div>

      <BottomNav />
    </div>
  );
}