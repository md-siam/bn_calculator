<img src="screenshots/badges/built-with-love.svg" height="28px"/>&nbsp;&nbsp;
<img src="screenshots/badges/flutter-dart.svg" height="28px" />&nbsp;&nbsp;
<a href="https://choosealicense.com/licenses/mit/" target="_blank"><img src="screenshots/badges/license-MIT.svg" height="28px" /></a>&nbsp;&nbsp;
<img src="screenshots/badges/Flutter-3.svg" height="28px" />&nbsp;&nbsp;
<img src="screenshots/badges/dart-null_safety-blue.svg" height="28px"/>

# Bengali Numeric (BN) Calculator

<img align="right" src="assets/images/playstore.png" height="190"></img>

<p align="justify" >
    Bengali Numeric Calculator, in short, BN Calculator is designed with a custom <a href="lib/src/widget/button_widget.dart">neumorphic button</a> class, with a custom button press sound, that imitates the sound of a physical calculator. In addition to that, it has a beautiful dark theme, and a user can turn On/Off the dark theme using a custom animated button on the AppBar.
</p>

Note: It's an open-source project; hence anyone can use this code according to the [MIT License](https://choosealicense.com/licenses/mit/) rules & regulations.

<p align="justify">
  In addition, it is using some other third-party packages from the open-source community. Thanks to those open-source developers for their amazing packages. Those packages are: 
</p>

```
  # For state-management
    provider: ^6.0.2
  # For modern neumorphic containers
    clay_containers: ^0.3.2
  # For animated switch to activate dark/light mode
    day_night_switcher: ^0.2.0+1
  # For playing 'button click' sound
    audioplayers: ^0.20.1
  # For executing mathematical operations
    math_expressions: ^2.3.0
  # For number formatting
    intl: ^0.17.0
```

## Download APK File

<p align="center">
    <a href="https://drive.google.com/file/d/1e1K5Zqu7hBWx9LXkVsKK0O96icGHvsbY/view?usp=sharing" target="_blank"><img src="screenshots/download_apk/apk-download-badge.png" height="100" ></img></a>
</p>

## App Demo

<table align="center" style="margin: 0px auto;">
  <tr>
    <th>Light Mode</th>
    <th>Dark Mode</th>
  </tr>
  <tr>
    <td><img align="right" src="screenshots/lightTheme.gif" height="500"></img></td>
    <td><img align="right" src="screenshots/darkTheme.gif" height="500"></img></td>
  </tr>
  </table>

## File Pattern Inside The lib Folder

```
lib/
├── app/
│   ├── provider/
│   │   ├── history_provider.dart
│   │   ├── sound_provider.dart
│   │   └── theme_provider.dart
│   ├── static/
│   │   └── button.dart
│   ├── view/
│   │   ├── calculator.dart
│   │   └── history.dart
│   └── widget/
│       ├── util/
│       │   └── arrow_clipper.dart
│       ├── button_widget.dart
│       ├── dropdown_menu.dart
│       └── top_appbar.dart
└── main.dart
```
