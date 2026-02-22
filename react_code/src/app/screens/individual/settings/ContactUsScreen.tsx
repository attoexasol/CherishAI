import { useState } from 'react';
import { MessageCircle, Send } from 'lucide-react';
import RomanticCard from '../../../components/RomanticCard';
import RomanticInput from '../../../components/RomanticInput';
import RomanticButton from '../../../components/RomanticButton';
import BottomNav from '../../../components/BottomNav';
import { motion } from 'motion/react';

export default function ContactUsScreen() {
  const [submitted, setSubmitted] = useState(false);
  const [message, setMessage] = useState('');

  const handleSubmit = (e: React.FormEvent) => {
    e.preventDefault();
    setSubmitted(true);
  };

  if (submitted) {
    return (
      <div className="min-h-screen pb-32 flex items-center justify-center px-6">
        <motion.div
          initial={{ opacity: 0, scale: 0.9 }}
          animate={{ opacity: 1, scale: 1 }}
          className="text-center"
        >
          <div className="w-20 h-20 rounded-full bg-gradient-to-br from-green-400 to-emerald-400 mx-auto mb-6 flex items-center justify-center">
            <span className="text-4xl">✓</span>
          </div>
          <h2 className="text-2xl text-gray-800 mb-3">Thank you!</h2>
          <p className="text-gray-600 mb-6">
            We've received your message and will get back to you within 24 hours.
          </p>
          <RomanticButton onClick={() => setSubmitted(false)}>Send Another</RomanticButton>
        </motion.div>
      </div>
    );
  }

  return (
    <div className="min-h-screen pb-24">
      <div className="bg-gradient-to-br from-rose-400 to-pink-400 px-6 pt-12 pb-8">
        <h1 className="text-white text-3xl mb-2">Contact Us</h1>
        <p className="text-white/80">We're here to help you spread love</p>
      </div>

      <div className="px-6 py-6">
        <RomanticCard className="mb-6">
          <form onSubmit={handleSubmit} className="space-y-4">
            <div>
              <label className="block text-rose-700 mb-2 text-sm">Your Message</label>
              <textarea
                className="w-full px-6 py-4 bg-white/60 backdrop-blur-sm border-2 border-rose-100 rounded-[16px] 
                  focus:outline-none focus:border-rose-300 focus:bg-white/80 transition-all placeholder-rose-300 
                  text-gray-700 min-h-[150px]"
                placeholder="Tell us how we can help..."
                value={message}
                onChange={(e) => setMessage(e.target.value)}
                required
              />
            </div>
            <div className="p-4 bg-rose-50 rounded-[16px]">
              <p className="text-gray-600 text-sm mb-2">Auto-filled from your profile:</p>
              <p className="text-gray-800 text-sm">Alex Johnson</p>
              <p className="text-gray-500 text-xs">alex@example.com</p>
            </div>
            <RomanticButton fullWidth type="submit">
              <div className="flex items-center justify-center gap-2">
                <Send className="w-5 h-5" />
                Send Message
              </div>
            </RomanticButton>
          </form>
        </RomanticCard>

        <RomanticCard gradient>
          <div className="text-center">
            <p className="text-gray-700 mb-2">We typically respond within</p>
            <p className="text-2xl text-rose-600">24 hours</p>
            <p className="text-gray-500 text-sm mt-2">Mon-Fri, 9AM-6PM PST</p>
          </div>
        </RomanticCard>
      </div>

      <BottomNav />
    </div>
  );
}