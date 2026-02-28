// lib/app/bindings/initial_binding.dart
import 'package:get/get.dart';
import '../../presentation/splash/controllers/splash_controller.dart';
import '../../presentation/onboarding/controllers/onboarding_intro_controller.dart';
import '../../presentation/auth/controllers/auth_controller.dart';
import '../../presentation/onboarding/controllers/user_type_controller.dart';
import '../../presentation/onboarding/controllers/individual_step1_profile_controller.dart';
import '../../presentation/onboarding/controllers/individual_step2_add_loved_one_controller.dart';
import '../../presentation/onboarding/controllers/individual_step3_relationship_goals_controller.dart';
import '../../presentation/onboarding/controllers/individual_step4_secondary_goals_controller.dart';
import '../../presentation/loved_one_preferences/controllers/loved_one_preferences_controller.dart';
import '../../presentation/dislikes/controllers/dislikes_controller.dart';
import '../../presentation/personal_note/controllers/personal_note_controller.dart';
import '../../presentation/subscription/controllers/choose_plan_controller.dart';
import '../../presentation/checkout/controllers/checkout_controller.dart';
import '../../presentation/home/controllers/home_controller.dart';
import '../../presentation/notifications/controllers/notifications_controller.dart';
import '../../presentation/profile/controllers/profile_controller.dart';
import '../../presentation/search/controllers/search_controller.dart';
import '../../presentation/loved_ones/controllers/loved_ones_controller.dart';
import '../../presentation/edit_loved_one/controllers/edit_loved_one_controller.dart';
import '../../presentation/account_settings/controllers/account_settings_controller.dart';
import '../../presentation/subscription/controllers/manage_subscription_controller.dart';
import '../../presentation/business_subscription/controllers/business_manage_subscription_controller.dart';
import '../../presentation/business_subscription_plans/controllers/business_choose_plan_controller.dart';
import '../../presentation/help_feedback/controllers/help_feedback_controller.dart';
import '../../presentation/gift_ideas/controllers/gift_ideas_controller.dart';
import '../../presentation/gift_ideas_detail/controllers/gift_ideas_detail_controller.dart';
import '../../presentation/events/controllers/all_upcoming_events_controller.dart';
import '../../presentation/old_messages/controllers/old_messages_controller.dart';
import '../../presentation/loved_one_details/controllers/loved_one_details_controller.dart';
import '../../presentation/business_onboarding/controllers/business_information_controller.dart';
import '../../presentation/business_onboarding/products_services/controllers/products_services_controller.dart';
import '../../presentation/business_dashboard/controllers/business_dashboard_controller.dart';
import '../../presentation/business_profile/controllers/business_profile_controller.dart';

/// Registers global/splash/onboarding/auth dependencies. Extend when adding more screens.
class InitialBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SplashController>(() => SplashController());
    Get.lazyPut<OnboardingIntroController>(() => OnboardingIntroController());
    Get.lazyPut<AuthController>(() => AuthController());
    Get.lazyPut<UserTypeController>(() => UserTypeController());
    Get.lazyPut<IndividualStep1ProfileController>(() => IndividualStep1ProfileController());
    Get.lazyPut<IndividualStep2AddLovedOneController>(() => IndividualStep2AddLovedOneController());
    Get.lazyPut<IndividualStep3RelationshipGoalsController>(() => IndividualStep3RelationshipGoalsController());
    Get.lazyPut<IndividualStep4SecondaryGoalsController>(() => IndividualStep4SecondaryGoalsController());
    Get.lazyPut<LovedOnePreferencesController>(() => LovedOnePreferencesController());
    Get.lazyPut<DislikesController>(() => DislikesController());
    Get.lazyPut<PersonalNoteController>(() => PersonalNoteController());
    Get.lazyPut<ChoosePlanController>(() => ChoosePlanController());
    Get.lazyPut<CheckoutController>(() => CheckoutController());
    Get.lazyPut<HomeController>(() => HomeController());
    Get.lazyPut<NotificationsController>(() => NotificationsController());
    Get.lazyPut<ProfileController>(() => ProfileController());
    Get.lazyPut<SearchController>(() => SearchController());
    Get.lazyPut<LovedOnesController>(() => LovedOnesController());
    Get.lazyPut<EditLovedOneController>(() => EditLovedOneController());
    Get.lazyPut<AccountSettingsController>(() => AccountSettingsController());
    Get.lazyPut<ManageSubscriptionController>(() => ManageSubscriptionController());
    Get.lazyPut<BusinessManageSubscriptionController>(() => BusinessManageSubscriptionController());
    Get.lazyPut<BusinessChoosePlanController>(() => BusinessChoosePlanController());
    Get.lazyPut<HelpFeedbackController>(() => HelpFeedbackController());
    Get.lazyPut<GiftIdeasController>(() => GiftIdeasController());
    Get.lazyPut<GiftIdeasDetailController>(() => GiftIdeasDetailController());
    Get.lazyPut<AllUpcomingEventsController>(() => AllUpcomingEventsController());
    Get.lazyPut<OldMessagesController>(() => OldMessagesController());
    Get.lazyPut<LovedOneDetailsController>(() => LovedOneDetailsController());
    Get.lazyPut<BusinessInformationController>(() => BusinessInformationController());
    Get.lazyPut<ProductsServicesController>(() => ProductsServicesController());
    Get.lazyPut<BusinessDashboardController>(() => BusinessDashboardController());
    Get.lazyPut<BusinessProfileController>(() => BusinessProfileController());
  }
}
