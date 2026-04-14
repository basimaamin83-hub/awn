Overview

Awn is a Flutter application that connects people with disabilities and volunteers in Jordan. The app provides an inclusive and accessible platform to request and offer help through both urgent and scheduled support features.

Key Features
Bilingual support (Arabic / English) with RTL support
Role-based dashboards (users and volunteers)
Maps integration and geolocation services
Support for urgent and scheduled assistance requests
Getting Started

To run the project locally:

flutter pub get
flutter run
Configuration

Make sure to configure Google Maps API keys in the following files:

web/index.html
AndroidManifest.xml
AppDelegate.swift

Refer to lib/core/maps_config.dart for more details.
