import { BrowserRouter, Routes, Route } from 'react-router';
import { AppProvider } from './context/AppContext';
import { SubscriptionProvider } from './contexts/SubscriptionContext';
import { BusinessProvider } from './contexts/BusinessContext';

// Public Screens
import InitialSplashScreen from './screens/public/InitialSplashScreen';
import NewSplashScreen from './screens/public/NewSplashScreen';
import OnboardingStep2Screen from './screens/public/OnboardingStep2Screen';
import OnboardingStep3Screen from './screens/public/OnboardingStep3Screen';
import OnboardingStep4Screen from './screens/public/OnboardingStep4Screen';
import OnboardingStep5Screen from './screens/public/OnboardingStep5Screen';
import OnboardingStep6Screen from './screens/public/OnboardingStep6Screen';
import OnboardingStep7Screen from './screens/public/OnboardingStep7Screen';
import SplashScreen from './screens/public/SplashScreen';
import AuthScreen from './screens/public/AuthScreen';
import UserTypeScreen from './screens/public/UserTypeScreen';
import LanguageSelectionScreen from './screens/public/LanguageSelectionScreen';
import HeroBannerDemo from './screens/public/HeroBannerDemo';

// Individual Onboarding
import UserInfoScreen from './screens/individual/onboarding/UserInfoScreen';
import AddLovedOneScreen from './screens/individual/onboarding/AddLovedOneScreen';
import YourRelationshipGoalsScreen from './screens/individual/onboarding/YourRelationshipGoalsScreen';
import SecondaryGoalsContextScreen from './screens/individual/onboarding/SecondaryGoalsContextScreen';
import LovedOnePreferencesScreen from './screens/individual/onboarding/LovedOnePreferencesScreen';
import DislikesScreen from './screens/individual/onboarding/DislikesScreen';
import PersonalNoteScreen from './screens/individual/onboarding/PersonalNoteScreen';
import IndividualSubscriptionScreen from './screens/individual/onboarding/SubscriptionScreen';
import CheckoutScreen from './screens/individual/onboarding/CheckoutScreen';

// Individual Core
import HomeDashboard from './screens/individual/core/HomeDashboard';
import LovedOnesListScreen from './screens/individual/core/LovedOnesListScreen';
import LovedOneDetailsScreen from './screens/individual/core/LovedOneDetailsScreen';
import EditLovedOneScreen from './screens/individual/core/EditLovedOneScreen';
import GiftIdeasScreen from './screens/individual/core/GiftIdeasScreen';
import GiftsHubScreen from './screens/individual/core/GiftsHubScreen';
import AllGiftIdeasScreen from './screens/individual/core/AllGiftIdeasScreen';
import AllUpcomingEventsScreen from './screens/individual/core/AllUpcomingEventsScreen';
import BusinessSuggestionsScreen from './screens/individual/core/BusinessSuggestionsScreen';
import NotificationsListScreen from './screens/individual/core/NotificationsListScreen';
import SearchScreen from './screens/individual/core/SearchScreen';
import OldMessagesScreen from './screens/individual/core/OldMessagesScreen';
import LocalBusinessScreen from './screens/individual/core/LocalBusinessScreen';
import YourApproachScreen from './screens/individual/core/YourApproachScreen';

// Individual Settings
import UserProfileScreen from './screens/individual/settings/UserProfileScreen';
import NotificationsPrivacyScreen from './screens/individual/settings/NotificationsPrivacyScreen';
import ContactUsScreen from './screens/individual/settings/ContactUsScreen';
import ManageSubscriptionScreen from './screens/individual/settings/ManageSubscriptionScreen';

// Shared Screens
import HelpFeedbackScreen from './screens/shared/HelpFeedbackScreen';

// Business Screens
import BusinessSplashScreen from './screens/business/BusinessSplashScreen';
import BusinessRegistrationScreen from './screens/business/BusinessRegistrationScreen';
import ProductRegistrationScreen from './screens/business/ProductRegistrationScreen';
import BusinessDashboardScreen from './screens/business/BusinessDashboardScreen';
import BusinessProfileScreen from './screens/business/BusinessProfileScreen';
import BusinessSubscriptionScreen from './screens/business/SubscriptionScreen';
import BusinessManageSubscriptionScreen from './screens/business/ManageSubscriptionScreen';

export default function App() {
  return (
    <BrowserRouter>
      <AppProvider>
        <SubscriptionProvider>
          <BusinessProvider>
            <div className="min-h-screen bg-gradient-to-br from-rose-50 via-pink-50 to-purple-50">
              <Routes>
                {/* Public Routes */}
                <Route path="/" element={<HeroBannerDemo />} />
                <Route path="/initial-splash" element={<InitialSplashScreen />} />
                <Route path="/new-splash" element={<NewSplashScreen />} />
                <Route path="/onboarding-step2" element={<OnboardingStep2Screen />} />
                <Route path="/onboarding-step3" element={<OnboardingStep3Screen />} />
                <Route path="/onboarding-step4" element={<OnboardingStep4Screen />} />
                <Route path="/onboarding-step5" element={<OnboardingStep5Screen />} />
                <Route path="/onboarding-step6" element={<OnboardingStep6Screen />} />
                <Route path="/onboarding-step7" element={<OnboardingStep7Screen />} />
                <Route path="/splash" element={<SplashScreen />} />
                <Route path="/auth" element={<AuthScreen />} />
                <Route path="/user-type" element={<UserTypeScreen />} />
                <Route path="/language-selection" element={<LanguageSelectionScreen />} />

                {/* Individual User Routes - Onboarding */}
                <Route path="/individual/user-info" element={<UserInfoScreen />} />
                <Route path="/individual/add-loved-one" element={<AddLovedOneScreen />} />
                <Route path="/individual/your-relationship-goals" element={<YourRelationshipGoalsScreen />} />
                <Route path="/individual/secondary-goals-context" element={<SecondaryGoalsContextScreen />} />
                <Route path="/individual/loved-one-preferences" element={<LovedOnePreferencesScreen />} />
                <Route path="/individual/dislikes" element={<DislikesScreen />} />
                <Route path="/individual/personal-note" element={<PersonalNoteScreen />} />
                <Route path="/individual/subscription" element={<IndividualSubscriptionScreen />} />
                <Route path="/individual/checkout" element={<CheckoutScreen />} />

                {/* Individual User Routes - Core */}
                <Route path="/individual/home" element={<HomeDashboard />} />
                <Route path="/individual/home-dashboard" element={<HomeDashboard />} />
                <Route path="/individual/loved-ones-list" element={<LovedOnesListScreen />} />
                <Route path="/individual/loved-one-details/:id" element={<LovedOneDetailsScreen />} />
                <Route path="/individual/edit-loved-one/:id" element={<EditLovedOneScreen />} />
                <Route path="/individual/gift-ideas/:eventId" element={<GiftIdeasScreen />} />
                <Route path="/individual/gifts-hub" element={<GiftsHubScreen />} />
                <Route path="/individual/all-gift-ideas" element={<AllGiftIdeasScreen />} />
                <Route path="/individual/all-upcoming-events" element={<AllUpcomingEventsScreen />} />
                <Route path="/individual/business-suggestions/:giftId" element={<BusinessSuggestionsScreen />} />
                <Route path="/individual/notifications-list" element={<NotificationsListScreen />} />
                <Route path="/individual/search" element={<SearchScreen />} />
                <Route path="/individual/old-messages" element={<OldMessagesScreen />} />
                <Route path="/individual/local-business" element={<LocalBusinessScreen />} />
                <Route path="/individual/local-businesses" element={<LocalBusinessScreen />} />
                <Route path="/individual/your-approach" element={<YourApproachScreen />} />
                <Route path="/your-approach/:lovedOneName" element={<YourApproachScreen />} />

                {/* Individual User Routes - Settings */}
                <Route path="/individual/user-profile" element={<UserProfileScreen />} />
                <Route path="/individual/notifications-privacy" element={<NotificationsPrivacyScreen />} />
                <Route path="/individual/contact-us" element={<ContactUsScreen />} />
                <Route path="/individual/manage-subscription" element={<ManageSubscriptionScreen />} />

                {/* Shared Routes */}
                <Route path="/help-feedback" element={<HelpFeedbackScreen />} />

                {/* Business Routes */}
                <Route path="/business/splash" element={<BusinessSplashScreen />} />
                <Route path="/business/register" element={<BusinessRegistrationScreen />} />
                <Route path="/business/products" element={<ProductRegistrationScreen />} />
                <Route path="/business/dashboard" element={<BusinessDashboardScreen />} />
                <Route path="/business/profile" element={<BusinessProfileScreen />} />
                <Route path="/business/subscription" element={<BusinessSubscriptionScreen />} />
                <Route path="/business/manage-subscription" element={<BusinessManageSubscriptionScreen />} />
              </Routes>
            </div>
          </BusinessProvider>
        </SubscriptionProvider>
      </AppProvider>
    </BrowserRouter>
  );
}