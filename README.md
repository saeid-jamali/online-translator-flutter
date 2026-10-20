# Online Translator | Flutter

A mobile translation application built with Flutter and Dart.

## Overview

Online Translator is a mobile application designed to support text input, language selection, text recognition from images, and text-to-speech functionality.

## Features

- Source and target language selection
- Text input and processing
- OCR (Optical Character Recognition) using Google ML Kit
- Select images from the gallery
- Capture images using the camera
- Text-to-speech functionality
- Right-to-left (RTL) interface support

## Tech Stack

- Flutter
- Dart
- Google ML Kit Text Recognition
- Android

## Screenshots

| First Page |
|---|---|
| ![Home Screen](screenshots/Firstpage.jfif) |

| Second Page |
|---|
| ![Image Recognition](screenshots/Secondpage.jfif) |

## Getting Started

### Prerequisites

- Flutter SDK
- Android Studio or another Flutter-compatible development environment
- Android SDK

### Run Locally

Clone the repository:

```bash
git clone https://github.com/saeid-jamali/online-translator-flutter.git
```

Navigate to the project directory:

```bash
cd online-translator-flutter
```

Install dependencies:

```bash
flutter pub get
```

Run the application:

```bash
flutter run
```

## Build APK

```bash
flutter build apk --release
```

The generated APK is normally available at:

`build/app/outputs/flutter-apk/app-release.apk`

## License

No license has been specified yet.
