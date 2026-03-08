# Flutter Plugin Namespace Fix

## Problem
Android Gradle Plugin 8.0+ requires all Android library modules to specify a `namespace` in their `build.gradle` files. Many Flutter plugins don't have this, causing build failures.

## Solution
A PowerShell script (`fix_plugin_namespaces.ps1`) has been created to automatically fix all plugins in your pub cache.

## Usage
Run the script whenever you encounter namespace errors:
```powershell
.\fix_plugin_namespaces.ps1
```

## What it does
1. Scans all Flutter plugins in `%LOCALAPPDATA%\Pub\Cache\hosted\pub.dev`
2. Checks each plugin's `android/build.gradle` for missing namespace
3. Reads the package name from `android/src/main/AndroidManifest.xml`
4. Adds `namespace = 'package.name'` to the `android {}` block

## Note
This fix is temporary. If you run `flutter pub get` or `flutter clean`, plugins may be re-downloaded and namespaces will need to be added again. Simply run the script again.

## Fixed Plugins (as of last run)
- flutter_plugin_android_lifecycle
- image_picker_android
- connectivity_plus
- device_info
- device_info_plus
- firebase_auth
- firebase_core
- fluttertoast
- flutter_blue_plus
- flutter_secure_storage
- google_mobile_ads
- google_sign_in_android
- image_cropper
- package_info_plus
- path_provider_android
- permission_handler_android
- shared_preferences_android
- share_plus
- sign_in_with_apple
- sqflite_android
- stripe_android
- url_launcher_android
- webview_flutter_android
- And more...

## Permanent Solution
Wait for plugin maintainers to update their plugins with namespaces, or consider downgrading Android Gradle Plugin (not recommended).
