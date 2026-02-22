import { useState } from 'react';
import { useNavigate } from 'react-router';
import { ArrowLeft, Send, Heart } from 'lucide-react';
import { motion } from 'motion/react';
import RomanticCard from '@/app/components/RomanticCard';
import RomanticButton from '@/app/components/RomanticButton';

const FEEDBACK_OPTIONS = [
  'Question / How it works',
  'Suggestion / Idea',
  'Something didn\'t feel right',
  'Bug or technical issue',
  'Subscription or billing',
  'Other'
];

const MAX_CHARACTERS = 1000;

export default function HelpFeedbackScreen() {
  const navigate = useNavigate();
  const [feedbackType, setFeedbackType] = useState('');
  const [message, setMessage] = useState('');
  const [allowContact, setAllowContact] = useState(false);
  const [isSubmitting, setIsSubmitting] = useState(false);
  const [submitted, setSubmitted] = useState(false);

  // Get current user email
  const getCurrentUserEmail = () => {
    const currentUserJson = localStorage.getItem('cherish_current_user');
    if (currentUserJson) {
      const currentUser = JSON.parse(currentUserJson);
      return currentUser.email;
    }
    return '';
  };

  const handleSubmit = async (e: React.FormEvent) => {
    e.preventDefault();
    
    if (!feedbackType || !message.trim()) return;

    setIsSubmitting(true);

    // Simulate submission
    const feedbackData = {
      type: feedbackType,
      message: message.trim(),
      allowContact,
      userEmail: allowContact ? getCurrentUserEmail() : null,
      timestamp: new Date().toISOString(),
    };

    // In a real app, this would send to a backend
    console.log('Feedback submitted:', feedbackData);

    // Simulate network delay
    await new Promise(resolve => setTimeout(resolve, 1000));

    setIsSubmitting(false);
    setSubmitted(true);

    // Reset form after 3 seconds and go back
    setTimeout(() => {
      navigate(-1);
    }, 3000);
  };

  const characterCount = message.length;
  const isOverLimit = characterCount > MAX_CHARACTERS;
  const canSubmit = feedbackType && message.trim() && !isOverLimit;

  if (submitted) {
    return (
      <div className="min-h-screen px-6 py-12 pb-24 max-w-md mx-auto flex items-center justify-center">
        <motion.div
          initial={{ opacity: 0, scale: 0.9 }}
          animate={{ opacity: 1, scale: 1 }}
          className="text-center"
        >
          <div className="w-20 h-20 rounded-full bg-gradient-to-br from-purple-400 to-indigo-400 flex items-center justify-center mx-auto mb-6">
            <Heart className="w-10 h-10 text-white fill-white" />
          </div>
          <h2 className="text-2xl text-gray-800 mb-3">Thank You! 💜</h2>
          <p className="text-purple-600 mb-2">Your feedback means the world to us.</p>
          <p className="text-gray-500 text-sm">
            We're committed to making Cherish AI better for you.
          </p>
        </motion.div>
      </div>
    );
  }

  return (
    <div className="min-h-screen px-6 py-12 pb-24 max-w-md mx-auto">
      {/* Back Button */}
      <motion.button
        onClick={() => navigate(-1)}
        className="mb-6 w-10 h-10 rounded-full bg-white/80 backdrop-blur-sm shadow-md flex items-center justify-center hover:bg-white transition-colors"
        initial={{ opacity: 0, x: -20 }}
        animate={{ opacity: 1, x: 0 }}
        whileHover={{ scale: 1.05 }}
        whileTap={{ scale: 0.95 }}
      >
        <ArrowLeft className="w-5 h-5 text-purple-600" />
      </motion.button>

      {/* Header */}
      <div className="mb-8">
        <h1 className="text-3xl text-gray-800 mb-2">Help & Feedback</h1>
        <p className="text-purple-500">
          We're here to listen. Your message helps Cherish AI grow with care.
        </p>
      </div>

      <form onSubmit={handleSubmit} className="space-y-6">
        {/* What would you like to share? */}
        <RomanticCard>
          <p className="text-purple-700 mb-4 text-sm">What would you like to share?</p>
          
          <div className="space-y-2">
            {FEEDBACK_OPTIONS.map((option) => (
              <button
                key={option}
                type="button"
                onClick={() => setFeedbackType(option)}
                className={`w-full text-left px-5 py-3.5 rounded-[12px] border-2 transition-all ${
                  feedbackType === option
                    ? 'bg-gradient-to-br from-purple-50 to-indigo-50 border-purple-300 shadow-sm'
                    : 'bg-white/60 border-purple-100 hover:border-purple-200'
                }`}
              >
                <div className="flex items-center justify-between">
                  <span className={`text-sm ${
                    feedbackType === option ? 'text-purple-700 font-medium' : 'text-gray-700'
                  }`}>
                    {option}
                  </span>
                  {feedbackType === option && (
                    <div className="w-5 h-5 rounded-full bg-purple-500 flex items-center justify-center">
                      <svg className="w-3 h-3 text-white" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                        <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={3} d="M5 13l4 4L19 7" />
                      </svg>
                    </div>
                  )}
                </div>
              </button>
            ))}
          </div>
        </RomanticCard>

        {/* Tell us more */}
        <RomanticCard>
          <label className="block text-purple-700 mb-3 text-sm">Tell us more *</label>
          <textarea
            className={`w-full px-6 py-4 bg-white/60 backdrop-blur-sm border-2 rounded-[16px] 
              focus:outline-none focus:bg-white/80 transition-all placeholder-purple-300 
              text-gray-700 min-h-[160px] resize-none ${
                isOverLimit ? 'border-red-300 focus:border-red-400' : 'border-purple-100 focus:border-purple-300'
              }`}
            placeholder="Share your thoughts, questions, or experience. You don't need to be technical — we'll figure it out."
            value={message}
            onChange={(e) => setMessage(e.target.value)}
            maxLength={MAX_CHARACTERS + 100} // Allow typing beyond limit but show error
            required
          />
          <div className="flex justify-between items-center mt-2">
            <span className={`text-xs ${
              isOverLimit ? 'text-red-500 font-medium' : 'text-gray-500'
            }`}>
              {characterCount}/{MAX_CHARACTERS} characters
            </span>
            {isOverLimit && (
              <span className="text-xs text-red-500">Message is too long</span>
            )}
          </div>
        </RomanticCard>

        {/* Contact Permission */}
        <RomanticCard>
          <label className="flex items-start gap-3 cursor-pointer group">
            <div className="relative flex items-center justify-center mt-0.5">
              <input
                type="checkbox"
                checked={allowContact}
                onChange={(e) => setAllowContact(e.target.checked)}
                className="w-5 h-5 appearance-none border-2 border-purple-200 rounded bg-white checked:bg-gradient-to-br checked:from-purple-400 checked:to-indigo-400 checked:border-purple-400 transition-all cursor-pointer"
              />
              {allowContact && (
                <svg 
                  className="w-3 h-3 text-white absolute pointer-events-none" 
                  fill="none" 
                  viewBox="0 0 24 24" 
                  stroke="currentColor"
                >
                  <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={3} d="M5 13l4 4L19 7" />
                </svg>
              )}
            </div>
            <div className="flex-1">
              <p className="text-gray-700 text-sm group-hover:text-purple-700 transition-colors">
                You can contact me if you need more details
              </p>
              {allowContact && getCurrentUserEmail() && (
                <p className="text-purple-600 text-xs mt-1 font-medium">
                  We'll use: {getCurrentUserEmail()}
                </p>
              )}
            </div>
          </label>
        </RomanticCard>

        {/* Submit Button */}
        <RomanticButton
          fullWidth
          type="submit"
          disabled={!canSubmit || isSubmitting}
        >
          <div className="flex items-center justify-center gap-2">
            <Send className="w-4 h-4" />
            <span>{isSubmitting ? 'Sending...' : 'Submit'}</span>
          </div>
        </RomanticButton>

        {/* Footer Note */}
        <div className="text-center pt-4">
          <p className="text-gray-500 text-sm">
            Visit our website to learn more about Cherish AI, your love assistant.
          </p>
        </div>
      </form>
    </div>
  );
}