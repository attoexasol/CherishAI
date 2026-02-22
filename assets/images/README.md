# Image assets — Flutter local

The Flutter app loads images only from `assets/images/`. No external or React paths.

**User Type screen:** `cherish_logo.png`, `individual_illustration.png`, and `business_illustration.png` are present as minimal placeholder PNGs so the screen loads assets. Replace them with real exports from your design tool for correct visuals.

## How to get the images

1. **From Figma Make**: In your Figma Make project, open **Code → Download code** and extract the exported assets, or export each image from the Figma design file.
2. **Save each file** into this folder (`assets/images/`) using the **exact suggested filename** from the table below.
3. The app uses `AssetImageWithFallback` and checks for asset existence before loading, so **missing assets never crash** — a placeholder is shown instead.

All paths are centralized in `lib/app/constants/app_assets.dart`. Screens use `AssetImageWithFallback(assetPath: AppAssets.xxx, placeholder: ...)`.

---

## Full asset table: figma hash → filename → used in

| figma:asset hash | suggested filename | used in (screen / component) |
|------------------|--------------------|------------------------------|
| `1ba0763b2c65c413d13ec69a501bf3eb00e15b25.png` | `cherish_logo.png` | InitialSplashScreen, NewSplashScreen, AuthScreen, UserTypeScreen |
| `c5abe42ed0b9fbf185fb3afab3a63c164a92e403.png` | `onboarding_family_illustration.png` | HeroBannerDemo (hero card illustration) |
| `b9321a626bb492078cfc740f3911e32d7d7847ca.png` | `cherish_ai_branded_logo.png` | HeroBannerDemo (branded logo) |
| `18e444e6a0754359dd5861d75bd22280f3572ee3.png` | `time_clock.png` | HeroBannerDemo (bullet "Your time") |
| `173a2d824017e52434275f3f4f6fa54bb138f6c4.png` | `efforts.png` | HeroBannerDemo (bullet "Your efforts") |
| `396ef3d84039d9c724035b5ecbc2a3fc0a478c6f.png` | `emotional_work.png` | HeroBannerDemo (bullet "Emotional work") |
| `e8b604f0c3ff46a950f6de8039686bdf587fad28.png` | `cherish_ai_logo.png` | HeroBannerDemo |
| `d861638b7f197188535a7e92c0ff01938810a016.png` | `cherish_ai_purple_logo.png` | HeroBannerDemo |
| `d88d7c41ef23467b5a012731343f1e4e022fdbca.png` | `cherish_ai_logo_text.png` | HeroBannerDemo |
| `9b6b67ca9953a0817ca7e99b65bdd215fced53de.png` | `cherish_ai_logo_pink.png` | HeroBannerDemo ("CherishAI" pink logo) |
| `28d4c22fb590b3b1ac67e00069eacc779556f431.png` | `onboarding_background.png` | OnboardingStep2, 3, 4, 5, 6, 7 (background) |
| `1fff69374a5fa7e8fd341d7c3c7e0424dd965b86.png` | `onboarding_step2_illustration.png` | OnboardingStep2Screen |
| `8f9dc6013a9b5bb901d3faf28067cbf21de37706.png` | `individual_illustration.png` | UserTypeScreen (Individual card) |
| `c11c058f162e99a65ee5a7c510045780c1e6dad8.png` | `business_illustration.png` | UserTypeScreen (Business card) |
| `bcec9e8c1009aabd0a6aa8c9756b7ac760d20b79.png` | `icon_whatsapp.png` | LocalBusinessScreen, BusinessSuggestionsScreen, BusinessRegistrationScreen, BusinessProfileScreen |
| `d0f8caa05d569c2ed16ac0d05e749b5f1bed81ac.png` | `icon_instagram.png` | Same as above |
| `fae96de532be20d303dc036129d2277974395b4f.png` | `icon_telegram.png` | Same as above |
| `cc2007467cda7c7222349053d65f4942af04bada.png` | `icon_facebook.png` | Same as above |
| `dac74f85ccf69143e439bee8dafc1b04e0d8bb8d.png` | `icon_tiktok.png` | Same as above |
| `304e161b73873014c33d9d8b3536f8a95d4690a1.png` | `icon_reddit.png` | BusinessRegistrationScreen, BusinessProfileScreen |
| `05d31970f7d942a30da189743cd2e11233d02133.png` | `icon_snapchat.png` | BusinessRegistrationScreen, BusinessProfileScreen |
| `f3a599157b94dbaa22d4df07a6e5ff73c4494e48.png` | `discover_button.png` | LocalBusinessScreen |
| `d8b2eae59d55ff7ad602be170430ffb448ffc77c.png` | `choose_higher_tier.png` | ManageSubscriptionScreen, LovedOneDetailsScreen |
| `2462a27f6d46cce3fc0d4f55c85af2c373958d92.png` | `placeholder_error.png` | ImageWithFallback (error fallback) |

---

## pubspec.yaml

Ensure your `pubspec.yaml` includes:

```yaml
flutter:
  assets:
    - assets/images/
```

Only files that exist under `assets/images/` at build time are bundled; missing files are skipped and the app shows placeholders instead of crashing.
