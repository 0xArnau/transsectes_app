
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
    - [Installation](#installation)
    - [Usage](#usage)
      - [Changelogs](#changelogs)
      - [i10n](#i10n)
    - [Features](#features)
      - [Users](#users)
      - [Technicians](#technicians)

---

### Screenshots

#### Store

<img src="docs/readme/screens/Store/Frame 1.jpg" alt="Frame 1" width="300px" />
<img src="docs/readme/screens/Store/Frame 2.jpg" alt="Frame 1" width="300px" />
<img src="docs/readme/screens/Store/Frame 3.jpg" alt="Frame 1" width="300px" />
<img src="docs/readme/screens/Store/Frame 4.jpg" alt="Frame 1" width="300px" />
<img src="docs/readme/screens/Store/Frame 5.jpg" alt="Frame 1" width="300px" />
<img src="docs/readme/screens/Store/Frame 6.jpg" alt="Frame 1" width="300px" />
<img src="docs/readme/screens/Store/Frame 7.jpg" alt="Frame 1" width="300px" />
<img src="docs/readme/screens/Store/Frame 8.jpg" alt="Frame 1" width="300px" />

#### App

| Screen             | Dark Mode                                                                                  | Light Mode                                                                                 |
|--------------------|--------------------------------------------------------------------------------------------|-------------------------------------------------------------------------------------------|
| **Contact**        | <img src="docs/readme/screens/Dark/Contact.png" alt="Contact - Dark" width="300px" />     | <img src="docs/readme/screens/Light/Contact.png" alt="Contact - Light" width="300px" />    |
| **Forgot Password**| <img src="docs/readme/screens/Dark/ForgotPassword.png" alt="Forgot Password - Dark" width="300px" /> | <img src="docs/readme/screens/Light/ForgotPassword.png" alt="Forgot Password - Light" width="300px" /> |
| **Home**           | <img src="docs/readme/screens/Dark/Home.png" alt="Home - Dark" width="300px" />           | <img src="docs/readme/screens/Light/Home.png" alt="Home - Light" width="300px" />          |
| **How To**         | <img src="docs/readme/screens/Dark/HowTo.png" alt="How To - Dark" width="300px" />         | <img src="docs/readme/screens/Light/HowTo.png" alt="How To - Light" width="300px" />       |
| **Login**          | <img src="docs/readme/screens/Dark/Login.png" alt="Login - Dark" width="300px" />          | <img src="docs/readme/screens/Light/Login.png" alt="Login - Light" width="300px" />        |
| **Save**           | <img src="docs/readme/screens/Dark/Save.png" alt="Save - Dark" width="300px" />            | <img src="docs/readme/screens/Light/Save.png" alt="Save - Light" width="300px" />          |
| **Settings**       | <img src="docs/readme/screens/Dark/Settings.png" alt="Settings - Dark" width="300px" />    | <img src="docs/readme/screens/Light/Settings.png" alt="Settings - Light" width="300px" />  |
| **Sign Up**        | <img src="docs/readme/screens/Dark/SignUp.png" alt="Sign Up - Dark" width="300px" />       | <img src="docs/readme/screens/Light/SignUp.png" alt="Sign Up - Light" width="300px" />     |
| **Splash**         | <img src="docs/readme/screens/Dark/Splash.png" alt="Splash - Dark" width="300px" />        | <img src="docs/readme/screens/Light/Splash.png" alt="Splash - Light" width="300px" />      |
| **Start**          | <img src="docs/readme/screens/Dark/Start.png" alt="Start - Dark" width="300px" />          | <img src="docs/readme/screens/Light/Start.png" alt="Start - Light" width="300px" />        |
| **Stop**           | <img src="docs/readme/screens/Dark/Stop.png" alt="Stop - Dark" width="300px" />            | <img src="docs/readme/screens/Light/Stop.png" alt="Stop - Light" width="300px" />          |
| **Transects**      | <img src="docs/readme/screens/Dark/Transects.png" alt="Transects - Dark" width="300px" />  | <img src="docs/readme/screens/Light/Transects.png" alt="Transects - Light" width="300px" />|
| **Charts (1)**      | <img src="docs/readme/screens/Dark/Chart-1.png" alt="Chart-1 - Dark" width="300px" />  | <img src="docs/readme/screens/Light/Chart-1.png" alt="Chart-1 - Light" width="300px" />|
| **Charts (2)**      | <img src="docs/readme/screens/Dark/Chart-2.png" alt="Chart-2 - Dark" width="300px" />  | <img src="docs/readme/screens/Light/Chart-2.png" alt="Chart-2 - Light" width="300px" />|
| **Charts (3)**      | <img src="docs/readme/screens/Dark/Chart-3.png" alt="Chart-3 - Dark" width="300px" />  | <img src="docs/readme/screens/Light/Chart-3.png" alt="Chart-3 - Light" width="300px" />|
| **Charts (4)**      | <img src="docs/readme/screens/Dark/Chart-4.png" alt="Chart-4 - Dark" width="300px" />  | <img src="docs/readme/screens/Light/Chart-4.png" alt="Chart-4 - Light" width="300px" />|

### Installation

coming soon...

### Usage

coming soon...

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
