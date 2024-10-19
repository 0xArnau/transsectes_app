# How to Set Up the Private Keys

## Firebase - Android

- Download the `google-services.json` file and save it in the `android/app/` directory.

## Firebase - iOS

- Download the `GoogleService-Info.plist` file and save it in the `ios/Runner/` directory.

## Google Maps - Android

- Create the file `android/app/src/main/res/values/strings.xml` and add the following code:

```xml
<resources>
    <!-- Otras cadenas de recursos -->

    <!-- Definir la clave de la API de Google Maps -->
    <string name="GOOGLE_MAPS_API_KEY_ANDROID">GOOGLE_MAPS_API_KEY_ANDROID</string>
</resources>
```

- Change the value of `GOOGLE_MAPS_API_KEY_ANDROID` to your actual API Key.

## Google Maps- iOS

- Create the file `ios/Common.xcconfig` and add the following code:

```xconfig
// Configuration settings file format documentation can be found at:
// https://help.apple.com/xcode/#/dev745c5c974

GOOGLE_MAPS_API_KEY_IOS = your_google_maps_ios_api_key
****
```

- Change the value of `GOOGLE_MAPS_API_KEY_IOS` to your actual API Key.
