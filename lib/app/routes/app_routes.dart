// lib/app/routes/app_routes.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../presentation/splash/views/splash_screen.dart';
import '../../presentation/onboarding/views/onboarding_intro_screen.dart';
import '../../presentation/auth/views/auth_screen.dart';
import '../../presentation/onboarding/views/user_type_screen.dart';
import '../../presentation/onboarding/views/business_splash_screen.dart';
import '../../presentation/business_onboarding/views/business_information_screen.dart';
import '../../presentation/business_onboarding/products_services/views/products_services_screen.dart';
import '../../presentation/business_dashboard/views/business_dashboard_screen.dart';
import '../../presentation/business_profile/views/business_profile_screen.dart';
import '../../presentation/business_profile/views/business_edit_profile_screen.dart';
import '../../presentation/onboarding/views/individual_step1_profile_screen.dart';
import '../../presentation/onboarding/views/individual_step2_add_loved_one_screen.dart';
import '../../presentation/onboarding/views/individual_step3_relationship_goals_screen.dart';
import '../../presentation/onboarding/views/individual_step4_secondary_goals_screen.dart';
import '../../presentation/loved_one_preferences/views/loved_one_preferences_screen.dart';
import '../../presentation/dislikes/views/dislikes_screen.dart';
import '../../presentation/personal_note/views/personal_note_screen.dart';
import '../../presentation/gift_ideas/views/gift_ideas_screen.dart';
import '../../presentation/gift_ideas_detail/views/gift_ideas_detail_screen.dart';
import '../../presentation/events/views/all_upcoming_events_screen.dart';
import '../../presentation/old_messages/views/old_messages_screen.dart';
import '../../presentation/subscription/views/choose_plan_screen.dart';
import '../../presentation/subscription/views/manage_subscription_screen.dart';
import '../../presentation/business_subscription/views/business_manage_subscription_screen.dart';
import '../../presentation/business_subscription_plans/views/business_choose_plan_screen.dart';
import '../../presentation/help_feedback/views/help_feedback_screen.dart';
import '../../presentation/checkout/views/checkout_screen.dart';
import '../../presentation/home/views/home_screen.dart';
import '../../presentation/notifications/views/notifications_screen.dart';
import '../../presentation/profile/views/profile_screen.dart';
import '../../presentation/search/views/search_screen.dart';
import '../../presentation/loved_ones/views/loved_ones_screen.dart';
import '../../presentation/edit_loved_one/views/edit_loved_one_screen.dart';
import '../../presentation/loved_one_details/views/loved_one_details_screen.dart';
import '../bindings/initial_binding.dart';
import '../bindings/auth_binding.dart';

abstract class AppRoutes {
  static const String splash = '/splash';
  static const String auth = '/auth';
  static const String onboardingIntro = '/onboarding-intro';
  static const String userType = '/user-type';
  static const String individualUserInfo = '/individual/user-info';
  static const String individualAddLovedOne = '/individual/add-loved-one';
  static const String individualRelationshipGoals = '/individual/relationship-goals';
  static const String individualSecondaryGoals = '/individual/secondary-goals';
  static const String lovedOnePreferences = '/loved-one-preferences';
  static const String dislikes = '/dislikes';
  static const String personalNote = '/personal-note';
  static const String choosePlan = '/choose-plan';
  static const String checkout = '/checkout';
  static const String businessSplash = '/business/splash';
  static const String businessInformation = '/business/information';
  static const String productsServices = '/business/products-services';
  static const String businessDashboard = '/business/dashboard';
  static const String businessProfile = '/business/profile';
  static const String businessEditProfile = '/business/profile/edit';

  /// Individual post-onboarding home (after Complete Process)
  static const String home = '/individual/home';
  static const String notificationsList = '/individual/notifications-list';
  static const String profile = '/individual/user-profile';
  static const String giftIdeas = '/individual/gift-ideas';
  static const String giftIdeasDetail = '/individual/gift-ideas-detail';
  static const String businessSuggestions = '/individual/business-suggestions';
  static const String allGiftIdeas = '/individual/all-gift-ideas';
  static const String search = '/individual/search';
  static const String lovedOnesList = '/individual/loved-ones-list';
  static const String lovedOneDetails = '/individual/loved-one-details';
  static const String editLovedOne = '/individual/edit-loved-one';
  static const String allUpcomingEvents = '/individual/all-upcoming-events';
  static const String oldMessages = '/individual/old-messages';
  static const String yourApproach = '/individual/your-approach';
  static const String manageSubscription = '/individual/manage-subscription';
  static const String businessManageSubscription = '/business/manage-subscription';
  static const String businessChoosePlan = '/business/choose-plan';
  static const String helpFeedback = '/help-feedback';

  static List<GetPage> get pages => [
        GetPage(
          name: splash,
          page: () => const SplashScreen(),
          binding: InitialBinding(),
        ),
        GetPage(
          name: onboardingIntro,
          page: () => const OnboardingIntroScreen(),
          binding: InitialBinding(),
        ),
        GetPage(
          name: auth,
          page: () => const AuthScreen(),
          binding: AuthBinding(),
        ),
        GetPage(
          name: userType,
          page: () => const UserTypeScreen(),
          binding: InitialBinding(),
        ),
        GetPage(
          name: individualUserInfo,
          page: () => const IndividualStep1ProfileScreen(),
          binding: InitialBinding(),
        ),
        GetPage(
          name: individualAddLovedOne,
          page: () => const IndividualStep2AddLovedOneScreen(),
          binding: InitialBinding(),
        ),
        GetPage(
          name: individualRelationshipGoals,
          page: () => const IndividualStep3RelationshipGoalsScreen(),
          binding: InitialBinding(),
        ),
        GetPage(
          name: individualSecondaryGoals,
          page: () => const IndividualStep4SecondaryGoalsScreen(),
          binding: InitialBinding(),
        ),
        GetPage(
          name: lovedOnePreferences,
          page: () => const LovedOnePreferencesScreen(),
          binding: InitialBinding(),
        ),
        GetPage(
          name: dislikes,
          page: () => const DislikesScreen(),
          binding: InitialBinding(),
        ),
        GetPage(
          name: personalNote,
          page: () => const PersonalNoteScreen(),
          binding: InitialBinding(),
        ),
        GetPage(
          name: choosePlan,
          page: () => const ChoosePlanScreen(),
          binding: InitialBinding(),
        ),
        GetPage(
          name: checkout,
          page: () => const CheckoutScreen(),
          binding: InitialBinding(),
        ),
        GetPage(
          name: home,
          page: () => const HomeScreen(),
          binding: InitialBinding(),
        ),
        GetPage(
          name: notificationsList,
          page: () => const NotificationsScreen(),
          binding: InitialBinding(),
        ),
        GetPage(
          name: profile,
          page: () => const ProfileScreen(),
          binding: InitialBinding(),
        ),
        GetPage(
          name: giftIdeas,
          page: () => const GiftIdeasScreen(),
          binding: InitialBinding(),
        ),
        GetPage(
          name: giftIdeasDetail,
          page: () => const GiftIdeasDetailScreen(),
          binding: InitialBinding(),
        ),
        GetPage(
          name: businessSuggestions,
          page: () => const _PlaceholderScreen(title: 'Business Suggestions'),
          binding: InitialBinding(),
        ),
        GetPage(
          name: allGiftIdeas,
          page: () => const _PlaceholderScreen(title: 'Gift History'),
          binding: InitialBinding(),
        ),
        GetPage(
          name: search,
          page: () => const SearchScreen(),
          binding: InitialBinding(),
        ),
        GetPage(
          name: lovedOnesList,
          page: () => const LovedOnesScreen(),
          binding: InitialBinding(),
        ),
        GetPage(
          name: lovedOneDetails,
          page: () => const LovedOneDetailsScreen(),
          binding: InitialBinding(),
        ),
        GetPage(
          name: editLovedOne,
          page: () => const EditLovedOneScreen(),
          binding: InitialBinding(),
        ),
        GetPage(
          name: allUpcomingEvents,
          page: () => const AllUpcomingEventsScreen(),
          binding: InitialBinding(),
        ),
        GetPage(
          name: oldMessages,
          page: () => const OldMessagesScreen(),
          binding: InitialBinding(),
        ),
        GetPage(
          name: yourApproach,
          page: () => const _PlaceholderScreen(title: 'Your Approach'),
          binding: InitialBinding(),
        ),
        GetPage(
          name: manageSubscription,
          page: () => const ManageSubscriptionScreen(),
          binding: InitialBinding(),
        ),
        GetPage(
          name: businessManageSubscription,
          page: () => const BusinessManageSubscriptionScreen(),
          binding: InitialBinding(),
        ),
        GetPage(
          name: businessChoosePlan,
          page: () => const BusinessChoosePlanScreen(),
          binding: InitialBinding(),
        ),
        GetPage(
          name: helpFeedback,
          page: () => const HelpFeedbackScreen(),
          binding: InitialBinding(),
        ),
        GetPage(
          name: businessSplash,
          page: () => const BusinessSplashScreen(),
          binding: InitialBinding(),
        ),
        GetPage(
          name: businessInformation,
          page: () => const BusinessInformationScreen(),
          binding: InitialBinding(),
        ),
        GetPage(
          name: productsServices,
          page: () => const ProductsServicesScreen(),
          binding: InitialBinding(),
        ),
        GetPage(
          name: businessDashboard,
          page: () => const BusinessDashboardScreen(),
          binding: InitialBinding(),
        ),
        GetPage(
          name: businessProfile,
          page: () => const BusinessProfileScreen(),
          binding: InitialBinding(),
        ),
        GetPage(
          name: businessEditProfile,
          page: () => const BusinessEditProfileScreen(),
          binding: InitialBinding(),
        ),
      ];
}

/// Placeholder until individual/business flows are implemented.
class _PlaceholderScreen extends StatelessWidget {
  const _PlaceholderScreen({required this.title});
  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: Center(child: Text(title)),
    );
  }
}
