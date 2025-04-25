
# Transsectes APP: mobile application for carrying out transects along the beaches to locate sea turtles or their nests

<div align="center">
<h3>

[Homepage](https://github.com/0xArnau/transsectes_app/tree/trunk) | [Play store (comming soon)](https://play.google.com/store/apps/developer?id=GEPEC-EdC) | [App store (comming soon)](https://apps.apple.com/us/developer/elisabeth-bofill-ventosa/id1697539680)

</h3>

<a href="https://gepec.cat">
<picture>
  <source media="(prefers-color-scheme: dark)" srcset="assets/imgs/logo/GEPEC_EdC_OFICIAL_blanc.png">
  <img alt="GePeE-EdC logo" src="assets/imgs/logo/GEPEC_EdC_OFICIAL.png" width="50%" height="50%">
</picture>
</a>
</div>


## Table of Contents

- [Transsectes APP: mobile application for carrying out transects along the beaches to locate sea turtles or their nests](#transsectes-app-mobile-application-for-carrying-out-transects-along-the-beaches-to-locate-sea-turtles-or-their-nests)
  - [Table of Contents](#table-of-contents)
    - [Screenshots](#screenshots)
      - [Store](#store)
      - [App](#app)
    - [Dependencies](#dependencies)
    - [Installation](#installation)
    - [Deployment](#deployment)
      - [Build](#build)
        - [Android](#android)
          - [Errors](#errors)
          - [Warnings](#warnings)
        - [iOS](#ios)
      - [Play store](#play-store)
    - [Usage](#usage)
      - [Changelogs](#changelogs)
      - [i10n](#i10n)
    - [Features](#features)
      - [Users](#users)
      - [Technicians](#technicians)

---

### Screenshots

#### Store

<div align="center">
  <img src="docs/readme/screens/Store/Frame 1.jpg" alt="Frame 1" width="300px" />
  <img src="docs/readme/screens/Store/Frame 2.jpg" alt="Frame 2" width="300px" />
  <img src="docs/readme/screens/Store/Frame 3.jpg" alt="Frame 3" width="300px" />
  <img src="docs/readme/screens/Store/Frame 4.jpg" alt="Frame 4" width="300px" />
  <img src="docs/readme/screens/Store/Frame 5.jpg" alt="Frame 5" width="300px" />
  <img src="docs/readme/screens/Store/Frame 6.jpg" alt="Frame 6" width="300px" />
  <img src="docs/readme/screens/Store/Frame 7.jpg" alt="Frame 7" width="300px" />
  <img src="docs/readme/screens/Store/Frame 8.jpg" alt="Frame 8" width="300px" />
</div>


#### App

|       | **Contact**        | **Forgot Password** | **Home**           | **How To**         | **Login**          | **Save**           | **Settings**       | **Sign Up**        | **Splash**         | **Start**          | **Stop**           | **Transects**      | **Charts (1)**     | **Charts (2)**     | **Charts (3)**     | **Charts (4)**     |
|--------------------|--------------------|---------------------|--------------------|--------------------|--------------------|--------------------|--------------------|--------------------|--------------------|--------------------|--------------------|--------------------|--------------------|--------------------|--------------------|--------------------|
| Dark Mode          | <img src="docs/readme/screens/Dark/Contact.png" alt="Contact - Dark" width="300px" /> | <img src="docs/readme/screens/Dark/ForgotPassword.png" alt="Forgot Password - Dark" width="300px" /> | <img src="docs/readme/screens/Dark/Home.png" alt="Home - Dark" width="300px" /> | <img src="docs/readme/screens/Dark/HowTo.png" alt="How To - Dark" width="300px" /> | <img src="docs/readme/screens/Dark/Login.png" alt="Login - Dark" width="300px" /> | <img src="docs/readme/screens/Dark/Save.png" alt="Save - Dark" width="300px" /> | <img src="docs/readme/screens/Dark/Settings.png" alt="Settings - Dark" width="300px" /> | <img src="docs/readme/screens/Dark/SignUp.png" alt="Sign Up - Dark" width="300px" /> | <img src="docs/readme/screens/Dark/Splash.png" alt="Splash - Dark" width="300px" /> | <img src="docs/readme/screens/Dark/Start.png" alt="Start - Dark" width="300px" /> | <img src="docs/readme/screens/Dark/Stop.png" alt="Stop - Dark" width="300px" /> | <img src="docs/readme/screens/Dark/Transects.png" alt="Transects - Dark" width="300px" /> | <img src="docs/readme/screens/Dark/Chart-1.png" alt="Chart-1 - Dark" width="300px" /> | <img src="docs/readme/screens/Dark/Chart-2.png" alt="Chart-2 - Dark" width="300px" /> | <img src="docs/readme/screens/Dark/Chart-3.png" alt="Chart-3 - Dark" width="300px" /> | <img src="docs/readme/screens/Dark/Chart-4.png" alt="Chart-4 - Dark" width="300px" /> |
| Light Mode         | <img src="docs/readme/screens/Light/Contact.png" alt="Contact - Light" width="300px" /> | <img src="docs/readme/screens/Light/ForgotPassword.png" alt="Forgot Password - Light" width="300px" /> | <img src="docs/readme/screens/Light/Home.png" alt="Home - Light" width="300px" /> | <img src="docs/readme/screens/Light/HowTo.png" alt="How To - Light" width="300px" /> | <img src="docs/readme/screens/Light/Login.png" alt="Login - Light" width="300px" /> | <img src="docs/readme/screens/Light/Save.png" alt="Save - Light" width="300px" /> | <img src="docs/readme/screens/Light/Settings.png" alt="Settings - Light" width="300px" /> | <img src="docs/readme/screens/Light/SignUp.png" alt="Sign Up - Light" width="300px" /> | <img src="docs/readme/screens/Light/Splash.png" alt="Splash - Light" width="300px" /> | <img src="docs/readme/screens/Light/Start.png" alt="Start - Light" width="300px" /> | <img src="docs/readme/screens/Light/Stop.png" alt="Stop - Light" width="300px" /> | <img src="docs/readme/screens/Light/Transects.png" alt="Transects - Light" width="300px" /> | <img src="docs/readme/screens/Light/Chart-1.png" alt="Chart-1 - Light" width="300px" /> | <img src="docs/readme/screens/Light/Chart-2.png" alt="Chart-2 - Light" width="300px" /> | <img src="docs/readme/screens/Light/Chart-3.png" alt="Chart-3 - Light" width="300px" /> | <img src="docs/readme/screens/Light/Chart-4.png" alt="Chart-4 - Light" width="300px" /> |

---

### Dependencies

1. [Flutter (3.27.1)](https://docs.flutter.dev/get-started/install) 
2. macOS, to be able to build the iOS app
   1. Ruby: [cocoapods](https://guides.cocoapods.org/using/getting-started.html#installation)
   2. [Xcode](https://developer.apple.com/xcode/)
3. [Android Studio](https://developer.android.com/studio)

### Installation

To get started with the project, follow these steps:

1. Clone the repository.
2. Add the API_KEYs from [Google Maps](https://console.cloud.google.com/apis/dashboard?) to the .env file:
   1. GOOGLE_MAPS_API_KEY_ANDROID
   2. GOOGLE_MAPS_API_KEY_IOS
3. Firebase service:
   1. **Android**: place the `google-services.json` ([downloaded from the Firebase console, Android app project](https://console.firebase.google.com/)) to `android/app/`
   2. **iOS**: place the `GoogleService-Info.plist` ([downloaded from the Firebase console, iOS app project](https://console.firebase.google.com/)) to `ios/Runner/`

> [!WARNING]
> Read the [private.md](private.md) file to know how to set up the private keys.

### Deployment

#### Build

##### Android

- [Flutter docs](https://docs.flutter.dev/deployment/android)
- [YT](https://www.youtube.com/watch?v=mUpF8R6Nfcw&list=PLPRFjV_AptwAJ1WTY_xHLw1zq0eHXM__c&index=29) (Recommended)

```shell
mkdir -p ~/.corriol-app/.android

keytool -genkey -v -keystore ~/.corriol-app/.android/debug-keystore.jks -keyalg RSA -keysize 2048 -validity 10000 -alias androiddebugkey
keytool -genkey -v -keystore ~/.corriol-app/.android/upload-keystore.jks -keyalg RSA -keysize 2048 -validity 10000 -alias upload
```

1. Modify the `version` of `pubspec.yaml`
     1. 1.0.0(version name)+3(version code), at least update the version code every time an update is going to be done on Play Store.
2. Build the app bundle: `flutter build appbundle`

###### Errors

###### Warnings

- This App Bundle contains native code, and you've not uploaded debug symbols. We recommend you upload a symbol file to make your crashes and ANRs easier to analyze and debug
  - [StackOverflow](https://stackoverflow.com/questions/62568757/playstore-error-app-bundle-contains-native-code-and-youve-not-uploaded-debug/68778908#68778908)
  - [YT](https://www.youtube.com/watch?v=nbDjfPbc6hk) (Recommended)
    - The native debug symbols contain an invalid directory __MACOSX. Only Android ABIs are supported.
      - `zip -d symbols.zip "__MACOSX*"`

##### iOS

- [Flutter docs](https://docs.flutter.dev/deployment/ios)
- [YT](https://www.youtube.com/watch?v=6QMadUJF78U&list=PLPRFjV_AptwAJ1WTY_xHLw1zq0eHXM__c&index=30)

1. Open the iOS project on xcode (`ios/Runner.xcodeproj`)
   1. In the Signing & Capabilities tab:
      1. Team -> Select the team associated with your registered Apple Developer account. If required, select Add Account…, then update this setting.
2. Generate the `ipa` format using flutter cli
3. [Upload the app bundle to App Store Connect](https://docs.flutter.dev/deployment/ios#upload-the-app-bundle-to-app-store-connect)

```sh
flutter build ipa
```

#### Play store

1. Go to the [Play Store Console](https://play.google.com/console/developers)
2. Create or View app

### Usage

#### Changelogs

Use [git cliff](https://git-cliff.org/docs/) to generate the changelogs

To install: 

```sh
cargo install git-cliff
```

To auto generate the changelog

```sh
git cliff -o CHANGELOG.md
```

#### i10n

To generate Dart code for using translations, run the following command:

```bash
flutter pub global run intl_utils:generate
```

### Features

#### Users

- Create transects (the app listens to the GPS in the background and records the position; once the transect is finished, it asks - a few questions)
- Discard transects
- View transects on the map

#### Technicians

- View all users' transects
- Download all users' transects
- View transects on the map
- Delete all users' transects
