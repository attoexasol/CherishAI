import { useNavigate } from 'react-router-dom';
import { Heart, Plus, Edit, Trash2, ArrowLeft, X } from 'lucide-react';
import BottomNav from '../../../components/BottomNav';
import { useApp } from '../../../context/AppContext';
import { motion, AnimatePresence } from 'motion/react';
import { useState } from 'react';

interface LovedOne {
  id: string;
  name: string;
  relationship: string;
  emoji: string;
}

export default function LovedOnesListScreen() {
  const navigate = useNavigate();
  const { lovedOnes } = useApp();
  const [showDeleteConfirm, setShowDeleteConfirm] = useState<string | null>(null);
  const [showEditModal, setShowEditModal] = useState<string | null>(null);
  const [editFormData, setEditFormData] = useState({
    name: '',
    relationship: '',
    emoji: '',
  });

  // Mock data for demonstration
  const mockLovedOnes: LovedOne[] = [
    { 
      id: '1', 
      name: 'Sarah', 
      relationship: 'Partner', 
      emoji: '💑',
    },
    { 
      id: '2', 
      name: 'Mom', 
      relationship: 'Mother', 
      emoji: '👩',
    },
    { 
      id: '3', 
      name: 'Jake', 
      relationship: 'Best Friend', 
      emoji: '🤝',
    },
    { 
      id: '4', 
      name: 'Dad', 
      relationship: 'Father', 
      emoji: '👨',
    },
    { 
      id: '5', 
      name: 'Emma', 
      relationship: 'Sister', 
      emoji: '👧',
    },
    { 
      id: '6', 
      name: 'Alex', 
      relationship: 'Brother', 
      emoji: '👦',
    },
    { 
      id: '7', 
      name: 'Olivia', 
      relationship: 'Friend', 
      emoji: '🌸',
    },
  ];

  // Combine context loved ones with mock data
  const displayLovedOnes: LovedOne[] = [...mockLovedOnes, ...lovedOnes];

  const handleDelete = (id: string) => {
    // In a real app, this would delete from the backend
    console.log('Deleting loved one:', id);
    setShowDeleteConfirm(null);
    // Would update the lovedOnes array in context
  };

  const handleEdit = (id: string) => {
    const person = displayLovedOnes.find(p => p.id === id);
    if (person) {
      setEditFormData({
        name: person.name,
        relationship: person.relationship,
        emoji: person.emoji,
      });
      setShowEditModal(id);
    }
  };

  const handleSaveEdit = () => {
    // In a real app, this would update the backend
    console.log('Saving edits for person:', showEditModal, editFormData);
    setShowEditModal(null);
    // Would update the lovedOnes array in context
  };

  const commonEmojis = ['💑', '👩', '👨', '👧', '👦', '🤝', '🌸', '💝', '❤️', '💕', '🌹', '⭐'];

  return (
    <div className="min-h-screen bg-gradient-to-br from-rose-50 via-pink-50 to-purple-50 pb-24">
      {/* Header */}
      <div className="sticky top-0 z-20 bg-gradient-to-br from-rose-50/95 via-pink-50/95 to-purple-50/95 backdrop-blur-xl border-b border-pink-100/50">
        <div className="max-w-4xl mx-auto px-6 py-6">
          <div className="flex items-center justify-between">
            <div className="flex items-center gap-4">
              <button
                onClick={() => navigate('/individual/home')}
                className="w-10 h-10 rounded-xl bg-white/80 border border-pink-200/50 hover:shadow-lg transition-all flex items-center justify-center"
              >
                <ArrowLeft className="w-5 h-5 text-rose-600" />
              </button>
              <div>
                <h1 className="text-3xl font-bold text-gray-800">Loved Ones</h1>
                <p className="text-sm text-gray-600">{displayLovedOnes.length} {displayLovedOnes.length === 1 ? 'person' : 'people'} you cherish</p>
              </div>
            </div>
            <div className="flex flex-col items-end gap-1">
              <button
                onClick={() => navigate('/individual/add-loved-one')}
                className="px-5 py-3 rounded-2xl bg-gradient-to-r from-rose-500 via-pink-500 to-purple-500 text-white font-semibold shadow-lg hover:shadow-xl hover:scale-[1.02] transition-all flex items-center gap-2"
              >
                <Plus className="w-5 h-5" />
                <span className="hidden sm:inline">Add Person</span>
              </button>
              <p className="text-xs text-gray-500 mt-1">Add a loved one</p>
            </div>
          </div>
        </div>
      </div>

      {/* Loved Ones List */}
      <div className="max-w-4xl mx-auto px-6 py-8">
        {displayLovedOnes.length === 0 ? (
          /* Empty State */
          <motion.div
            className="text-center py-16"
            initial={{ opacity: 0, y: 20 }}
            animate={{ opacity: 1, y: 0 }}
          >
            <div className="w-24 h-24 rounded-full bg-gradient-to-br from-rose-400 to-pink-400 mx-auto mb-6 flex items-center justify-center shadow-xl">
              <Heart className="w-12 h-12 text-white fill-white" />
            </div>
            <h2 className="text-2xl font-bold text-gray-800 mb-3">No Loved Ones Yet</h2>
            <p className="text-gray-600 mb-8 max-w-md mx-auto">
              Start your journey by adding the special people in your life
            </p>
            <button
              onClick={() => navigate('/individual/add-loved-one')}
              className="px-8 py-4 rounded-2xl bg-gradient-to-r from-rose-500 via-pink-500 to-purple-500 text-white font-semibold shadow-lg hover:shadow-xl hover:scale-[1.02] transition-all inline-flex items-center gap-2"
            >
              <Plus className="w-5 h-5" />
              Add Your First Person
            </button>
          </motion.div>
        ) : (
          /* List of Loved Ones */
          <div className="space-y-4">
            {displayLovedOnes.map((person, index) => (
              <motion.div
                key={person.id}
                className="bg-white/90 backdrop-blur border-2 border-rose-200 rounded-3xl p-6 shadow-lg hover:shadow-xl hover:border-rose-300 transition-all cursor-pointer"
                initial={{ opacity: 0, y: 20 }}
                animate={{ opacity: 1, y: 0 }}
                transition={{ delay: index * 0.1 }}
                onClick={() => navigate(`/individual/loved-one-details/${person.id}`)}
              >
                <div className="flex items-center justify-between">
                  {/* Left: Avatar and Info */}
                  <div className="flex items-center gap-4">
                    <div className="w-16 h-16 rounded-2xl bg-gradient-to-br from-rose-100 to-pink-100 flex items-center justify-center text-3xl shadow-md ring-2 ring-rose-200">
                      {person.emoji || '💝'}
                    </div>
                    <div>
                      <h3 className="text-xl font-bold text-gray-800">{person.name}</h3>
                      <p className="text-sm text-gray-600 font-medium">{person.relationship}</p>
                    </div>
                  </div>

                  {/* Right: Action Buttons */}
                  <div className="flex items-center gap-2">
                    <motion.button
                      onClick={(e) => {
                        e.stopPropagation();
                        navigate(`/individual/edit-loved-one/${person.id}`);
                      }}
                      className="px-4 py-2.5 rounded-xl bg-rose-50 hover:bg-rose-100 border border-rose-200 hover:border-rose-300 transition-all flex items-center gap-2 shadow-sm hover:shadow-md"
                      whileHover={{ scale: 1.05 }}
                      whileTap={{ scale: 0.95 }}
                    >
                      <Edit className="w-4 h-4 text-rose-600" />
                      <span className="text-sm font-semibold text-rose-700 hidden sm:inline">Edit</span>
                    </motion.button>
                    
                    <motion.button
                      onClick={(e) => {
                        e.stopPropagation();
                        setShowDeleteConfirm(person.id);
                      }}
                      className="px-4 py-2.5 rounded-xl bg-red-50 hover:bg-red-100 border border-red-200 hover:border-red-300 transition-all flex items-center gap-2 shadow-sm hover:shadow-md"
                      whileHover={{ scale: 1.05 }}
                      whileTap={{ scale: 0.95 }}
                    >
                      <Trash2 className="w-4 h-4 text-red-600" />
                      <span className="text-sm font-semibold text-red-700 hidden sm:inline">Delete</span>
                    </motion.button>
                  </div>
                </div>
              </motion.div>
            ))}
          </div>
        )}
      </div>

      {/* Delete Confirmation Modal */}
      <AnimatePresence>
        {showDeleteConfirm && (
          <motion.div
            className="fixed inset-0 z-50 flex items-center justify-center p-4 bg-black/50 backdrop-blur-sm"
            initial={{ opacity: 0 }}
            animate={{ opacity: 1 }}
            exit={{ opacity: 0 }}
            onClick={() => setShowDeleteConfirm(null)}
          >
            <motion.div
              className="bg-white rounded-3xl p-8 max-w-md w-full shadow-2xl border-2 border-rose-200"
              initial={{ scale: 0.9, y: 20 }}
              animate={{ scale: 1, y: 0 }}
              exit={{ scale: 0.9, y: 20 }}
              onClick={(e) => e.stopPropagation()}
            >
              <div className="w-16 h-16 rounded-full bg-gradient-to-br from-red-400 to-rose-400 mx-auto mb-6 flex items-center justify-center shadow-lg">
                <Trash2 className="w-8 h-8 text-white" />
              </div>
              
              <h2 className="text-2xl font-bold text-gray-800 mb-3 text-center">Delete Loved One?</h2>
              <p className="text-gray-600 mb-8 text-center">
                Are you sure you want to remove this person? This action cannot be undone.
              </p>

              <div className="flex gap-3">
                <button
                  onClick={() => setShowDeleteConfirm(null)}
                  className="flex-1 px-6 py-3 rounded-2xl bg-gray-100 hover:bg-gray-200 text-gray-700 font-semibold transition-all"
                >
                  Cancel
                </button>
                <button
                  onClick={() => handleDelete(showDeleteConfirm)}
                  className="flex-1 px-6 py-3 rounded-2xl bg-gradient-to-r from-red-500 to-rose-500 text-white font-semibold shadow-lg hover:shadow-xl hover:scale-[1.02] transition-all"
                >
                  Delete
                </button>
              </div>
            </motion.div>
          </motion.div>
        )}
      </AnimatePresence>

      {/* Edit Modal */}
      <AnimatePresence>
        {showEditModal && (
          <motion.div
            className="fixed inset-0 z-50 flex items-center justify-center p-4 bg-black/50 backdrop-blur-sm"
            initial={{ opacity: 0 }}
            animate={{ opacity: 1 }}
            exit={{ opacity: 0 }}
            onClick={() => setShowEditModal(null)}
          >
            <motion.div
              className="bg-white rounded-3xl p-8 max-w-md w-full shadow-2xl border-2 border-rose-200 max-h-[90vh] overflow-y-auto"
              initial={{ scale: 0.9, y: 20 }}
              animate={{ scale: 1, y: 0 }}
              exit={{ scale: 0.9, y: 20 }}
              onClick={(e) => e.stopPropagation()}
            >
              {/* Close Button */}
              <button
                onClick={() => setShowEditModal(null)}
                className="absolute top-4 right-4 w-10 h-10 rounded-xl bg-gray-100 hover:bg-gray-200 flex items-center justify-center transition-all"
              >
                <X className="w-5 h-5 text-gray-600" />
              </button>

              <div className="w-16 h-16 rounded-full bg-gradient-to-br from-rose-400 to-pink-400 mx-auto mb-6 flex items-center justify-center shadow-lg">
                <Edit className="w-8 h-8 text-white" />
              </div>
              
              <h2 className="text-2xl font-bold text-gray-800 mb-3 text-center">Edit Loved One</h2>
              <p className="text-gray-600 mb-8 text-center">
                Update the details for this special person
              </p>

              <div className="space-y-5 mb-8">
                {/* Name Input */}
                <div>
                  <label className="block text-sm font-semibold text-gray-700 mb-2">
                    Name
                  </label>
                  <input
                    type="text"
                    value={editFormData.name}
                    onChange={(e) => setEditFormData({ ...editFormData, name: e.target.value })}
                    className="w-full px-4 py-3 rounded-xl border-2 border-rose-200 focus:border-rose-400 focus:outline-none text-gray-800 font-medium transition-all"
                    placeholder="Enter name"
                  />
                </div>

                {/* Relationship Input */}
                <div>
                  <label className="block text-sm font-semibold text-gray-700 mb-2">
                    Relationship
                  </label>
                  <input
                    type="text"
                    value={editFormData.relationship}
                    onChange={(e) => setEditFormData({ ...editFormData, relationship: e.target.value })}
                    className="w-full px-4 py-3 rounded-xl border-2 border-rose-200 focus:border-rose-400 focus:outline-none text-gray-800 font-medium transition-all"
                    placeholder="Enter relationship"
                  />
                </div>

                {/* Emoji Selector */}
                <div>
                  <label className="block text-sm font-semibold text-gray-700 mb-2">
                    Choose an Emoji
                  </label>
                  <div className="grid grid-cols-6 gap-2 mb-3">
                    {commonEmojis.map((emoji) => (
                      <button
                        key={emoji}
                        type="button"
                        onClick={() => setEditFormData({ ...editFormData, emoji })}
                        className={`w-full aspect-square rounded-xl flex items-center justify-center text-2xl transition-all ${
                          editFormData.emoji === emoji
                            ? 'bg-gradient-to-br from-rose-400 to-pink-400 scale-110 shadow-lg'
                            : 'bg-rose-50 hover:bg-rose-100 border-2 border-rose-200'
                        }`}
                      >
                        {emoji}
                      </button>
                    ))}
                  </div>
                  <input
                    type="text"
                    value={editFormData.emoji}
                    onChange={(e) => setEditFormData({ ...editFormData, emoji: e.target.value })}
                    className="w-full px-4 py-3 rounded-xl border-2 border-rose-200 focus:border-rose-400 focus:outline-none text-gray-800 font-medium transition-all text-center text-2xl"
                    placeholder="Or type your own"
                  />
                </div>
              </div>

              <div className="flex gap-3">
                <button
                  onClick={() => setShowEditModal(null)}
                  className="flex-1 px-6 py-3 rounded-2xl bg-gray-100 hover:bg-gray-200 text-gray-700 font-semibold transition-all"
                >
                  Cancel
                </button>
                <button
                  onClick={handleSaveEdit}
                  className="flex-1 px-6 py-3 rounded-2xl bg-gradient-to-r from-rose-500 to-pink-500 text-white font-semibold shadow-lg hover:shadow-xl hover:scale-[1.02] transition-all"
                >
                  Save Changes
                </button>
              </div>
            </motion.div>
          </motion.div>
        )}
      </AnimatePresence>

      <BottomNav />
    </div>
  );
}