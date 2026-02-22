import { useState } from 'react';
import { Bell, Heart, Lock, Shield } from 'lucide-react';
import RomanticCard from '../../../components/RomanticCard';
import BottomNav from '../../../components/BottomNav';
import { Switch } from '../../../components/ui/switch';

export default function NotificationsPrivacyScreen() {
  const [settings, setSettings] = useState({
    dailyNotifications: true,
    relationshipQuotes: true,
    eventReminders: true,
    giftSuggestions: false,
    dataSharing: false,
  });

  const toggleSetting = (key: string) => {
    setSettings(prev => ({ ...prev, [key]: !prev[key as keyof typeof prev] }));
  };

  return (
    <div className="min-h-screen pb-24">
      <div className="bg-gradient-to-br from-rose-400 to-pink-400 px-6 pt-12 pb-8">
        <h1 className="text-white text-3xl mb-2">Settings</h1>
        <p className="text-white/80">Notifications & Privacy</p>
      </div>

      <div className="px-6 py-6 space-y-6">
        <div>
          <h3 className="text-gray-700 mb-3 flex items-center gap-2">
            <Bell className="w-5 h-5 text-rose-400" />
            Notifications
          </h3>
          <RomanticCard>
            <div className="space-y-4">
              <div className="flex items-center justify-between">
                <div>
                  <p className="text-gray-800">Daily Notifications</p>
                  <p className="text-gray-500 text-sm">Get daily reminders</p>
                </div>
                <Switch
                  checked={settings.dailyNotifications}
                  onCheckedChange={() => toggleSetting('dailyNotifications')}
                />
              </div>
              <div className="h-px bg-rose-50"></div>
              <div className="flex items-center justify-between">
                <div>
                  <p className="text-gray-800">Relationship Quotes</p>
                  <p className="text-gray-500 text-sm">Daily inspiration</p>
                </div>
                <Switch
                  checked={settings.relationshipQuotes}
                  onCheckedChange={() => toggleSetting('relationshipQuotes')}
                />
              </div>
              <div className="h-px bg-rose-50"></div>
              <div className="flex items-center justify-between">
                <div>
                  <p className="text-gray-800">Event Reminders</p>
                  <p className="text-gray-500 text-sm">Birthdays & anniversaries</p>
                </div>
                <Switch
                  checked={settings.eventReminders}
                  onCheckedChange={() => toggleSetting('eventReminders')}
                />
              </div>
            </div>
          </RomanticCard>
        </div>

        <div>
          <h3 className="text-gray-700 mb-3 flex items-center gap-2">
            <Shield className="w-5 h-5 text-rose-400" />
            Privacy
          </h3>
          <RomanticCard>
            <div className="space-y-4">
              <div className="flex items-center justify-between">
                <div>
                  <p className="text-gray-800">Data Sharing</p>
                  <p className="text-gray-500 text-sm">Help improve our service</p>
                </div>
                <Switch
                  checked={settings.dataSharing}
                  onCheckedChange={() => toggleSetting('dataSharing')}
                />
              </div>
            </div>
          </RomanticCard>
          <p className="text-gray-500 text-xs mt-3 leading-relaxed px-2">
            We take your privacy seriously. Your personal information is encrypted and never shared
            without your explicit consent.
          </p>
        </div>
      </div>

      <BottomNav />
    </div>
  );
}