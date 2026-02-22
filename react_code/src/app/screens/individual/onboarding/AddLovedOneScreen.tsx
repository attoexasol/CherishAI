import { useState } from 'react';
import { useNavigate } from 'react-router-dom';
import { Heart, Camera } from 'lucide-react';
import RomanticInput from '../../../components/RomanticInput';
import RomanticButton from '../../../components/RomanticButton';
import { useApp } from '../../../context/AppContext';
import { motion } from 'motion/react';
import BackButton from '@/app/components/BackButton';

export default function AddLovedOneScreen() {
  const navigate = useNavigate();
  const { addLovedOne } = useApp();
  const [formData, setFormData] = useState({
    name: '',
    relationship: '',
    photo: '',
  });
  const [photoPreview, setPhotoPreview] = useState<string>('');

  const relationshipCategories = [
    {
      title: 'Romantic / Intimate',
      icon: '💕',
      options: [
        { type: 'Partner (dating / committed, not married)', emoji: '💑' },
        { type: 'Spouse (married partner)', emoji: '💍' },
        { type: 'Crush / Romantic interest', emoji: '😍' },
      ],
    },
    {
      title: 'Family',
      icon: '👨‍👩‍👧‍👦',
      options: [
        { type: 'Parent', emoji: '👨‍👩‍👧' },
        { type: 'Child', emoji: '👶' },
        { type: 'Sibling', emoji: '👫' },
        { type: 'Extended family', emoji: '👪' },
      ],
    },
    {
      title: 'Social',
      icon: '🤝',
      options: [
        { type: 'Friend', emoji: '😊' },
        { type: 'Close friend / Best friend', emoji: '💛' },
      ],
    },
    {
      title: 'Professional',
      icon: '💼',
      options: [
        { type: 'Co-worker', emoji: '👔' },
        { type: 'Manager / Supervisor', emoji: '📊' },
        { type: 'Client / Business contact', emoji: '🤝' },
      ],
    },
  ];

  const handlePhotoChange = (e: React.ChangeEvent<HTMLInputElement>) => {
    const file = e.target.files?.[0];
    if (file) {
      const reader = new FileReader();
      reader.onloadend = () => {
        setPhotoPreview(reader.result as string);
        setFormData({ ...formData, photo: reader.result as string });
      };
      reader.readAsDataURL(file);
    }
  };

  const handleContinue = () => {
    addLovedOne({
      id: Date.now().toString(),
      name: formData.name,
      relationship: formData.relationship,
      photo: formData.photo,
    });
    navigate('/individual/your-relationship-goals');
  };

  return (
    <div className="min-h-screen px-6 pt-20 pb-24 max-w-md mx-auto relative">
      {/* Back Button */}
      <BackButton to="/individual/user-info" />
      
      <motion.div
        className="mb-8 mt-2"
        initial={{ opacity: 0, y: -20 }}
        animate={{ opacity: 1, y: 0 }}
      >
        <div className="inline-flex items-center justify-center w-14 h-14 rounded-full bg-gradient-to-br from-rose-400 to-pink-400 mb-4 shadow-lg">
          <Heart className="w-7 h-7 text-white fill-white" />
        </div>
        <h1 className="text-3xl text-gray-800 mb-2">Add a loved one</h1>
        <p className="text-rose-500">Let's begin with one person you want to show heartfelt love</p>
      </motion.div>

      <motion.div
        className="space-y-6"
        initial={{ opacity: 0 }}
        animate={{ opacity: 1 }}
        transition={{ delay: 0.2 }}
      >
        {/* Photo Upload - Smaller, Better Color */}
        <div className="flex flex-col items-center justify-center">
          <label className="block text-purple-700 mb-3 text-sm font-medium text-center">Photo (Optional)</label>
          <div className="relative">
            <input
              type="file"
              accept="image/*"
              className="absolute inset-0 w-full h-full opacity-0 cursor-pointer z-10"
              onChange={handlePhotoChange}
              id="loved-one-photo"
            />
            <div className="relative w-24 h-24 rounded-full overflow-hidden border-3 border-rose-200 shadow-md bg-gradient-to-br from-rose-100 to-pink-100 flex items-center justify-center cursor-pointer hover:border-rose-300 hover:shadow-lg transition-all">
              {photoPreview ? (
                <img
                  src={photoPreview}
                  alt="Loved one"
                  className="w-full h-full object-cover"
                />
              ) : (
                <Camera className="w-7 h-7 text-rose-400" />
              )}
            </div>
            {photoPreview && (
              <div className="absolute bottom-0 right-0 w-8 h-8 rounded-full bg-gradient-to-br from-rose-400 to-pink-500 flex items-center justify-center shadow-md border-2 border-white">
                <Camera className="w-4 h-4 text-white" />
              </div>
            )}
          </div>
        </div>

        <RomanticInput
          label="What's their name? *"
          placeholder="Name or nickname"
          value={formData.name}
          onChange={(e) => setFormData({ ...formData, name: e.target.value })}
          required
        />

        {/* Relationship Type with Categories */}
        <div>
          <label className="block text-purple-700 mb-4 text-sm font-medium">Relationship Type (Choose 1) *</label>
          <div className="space-y-4">
            {relationshipCategories.map((category) => (
              <div key={category.title} className="bg-gradient-to-br from-white/90 to-purple-50/30 rounded-[20px] border-2 border-purple-100/50 p-5 shadow-sm">
                <div className="flex flex-col items-center mb-4">
                  <span className="text-3xl mb-2">{category.icon}</span>
                  <h3 className="text-sm font-semibold text-purple-700">{category.title}</h3>
                </div>
                <div className="grid grid-cols-2 gap-2.5">
                  {category.options.map((option) => (
                    <button
                      key={option.type}
                      type="button"
                      onClick={() => setFormData({ ...formData, relationship: option.type })}
                      className={`py-4 px-3 rounded-[16px] border-2 transition-all flex flex-col items-center justify-center gap-2 min-h-[110px] ${
                        formData.relationship === option.type
                          ? 'bg-gradient-to-br from-rose-100 to-pink-100 border-rose-300 shadow-md'
                          : 'bg-white/60 border-purple-100 hover:border-rose-200 hover:shadow-sm'
                      }`}
                    >
                      <span className="text-3xl">{option.emoji}</span>
                      <span
                        className={`text-xs font-medium text-center leading-tight ${
                          formData.relationship === option.type ? 'text-rose-700' : 'text-gray-700'
                        }`}
                      >
                        {option.type}
                      </span>
                    </button>
                  ))}
                </div>
              </div>
            ))}
          </div>
        </div>

        <div className="pt-6">
          <RomanticButton
            fullWidth
            onClick={handleContinue}
            disabled={!formData.name || !formData.relationship}
          >
            Save & Continue
          </RomanticButton>
        </div>
      </motion.div>
    </div>
  );
}