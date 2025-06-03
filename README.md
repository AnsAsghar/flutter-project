# 🌱 AI Plant Identifier

A comprehensive Flutter mobile application that uses AI to identify plants from photos and provides detailed care instructions.

## 📱 Features

### Core Functionality
- **Plant Identification**: Take photos or select from gallery to identify plants
- **Plant Type Selection**: Choose from 10+ plant categories (Flower, Tree, Shrub, Succulent, etc.)
- **Detailed Results**: Get common names, scientific names, descriptions, and care instructions
- **Confidence Scoring**: AI confidence percentage for identification accuracy

### App Sections
- **🏠 Home**: Main plant identification interface
- **📚 History**: View previously identified plants
- **📈 Progress**: Track your plant identification journey
- **💡 Insights**: Learn about plant families and care tips
- **⏰ Routine**: Plant care reminders and schedules
- **📖 Diary**: Personal plant care journal
- **🤖 AI Coach**: Get personalized plant care advice

### Technical Features
- **Onboarding Flow**: First-time user experience
- **Local Storage**: Save identified plants offline using Hive
- **Clean Architecture**: Domain-driven design with separation of concerns
- **State Management**: BLoC pattern for reactive programming
- **Dependency Injection**: GetIt for service locator pattern

## 🏗️ Architecture

This project follows **Clean Architecture** principles with a feature-first approach:

```
lib/
├── core/                    # Shared utilities and base classes
│   ├── error/              # Error handling (failures, exceptions)
│   ├── utils/              # Constants, themes, extensions
│   └── widgets/            # Reusable UI components
├── features/               # Feature modules
│   ├── onboarding/         # First-time user experience
│   ├── plant_identification/ # Core plant ID functionality
│   ├── navigation/         # Bottom navigation
│   ├── history/           # Plant history
│   ├── progress/          # User progress tracking
│   ├── insights/          # Plant knowledge
│   ├── routine/           # Care reminders
│   ├── diary/             # Plant journal
│   └── ai_coach/          # AI assistance
└── main.dart              # App entry point
```

Each feature follows the Clean Architecture pattern:
- **Data Layer**: Repositories, data sources, models
- **Domain Layer**: Entities, use cases, repository interfaces
- **Presentation Layer**: Pages, widgets, BLoC

## 🛠️ Tech Stack

- **Framework**: Flutter 3.5.4+
- **Language**: Dart
- **State Management**: flutter_bloc
- **Local Storage**: Hive + SharedPreferences
- **Dependency Injection**: GetIt
- **Functional Programming**: Dartz
- **Code Generation**: build_runner, freezed, json_annotation
- **Image Handling**: image_picker
- **HTTP Client**: http package

## 🚀 Getting Started

### Prerequisites
- Flutter SDK 3.5.4 or higher
- Dart SDK 3.5.4 or higher
- Android Studio / VS Code
- Android SDK (for Android builds)

### Installation

1. **Clone the repository**
   ```bash
   git clone https://github.com/AnsAsghar/flutter-project.git
   cd flutter-project
   ```

2. **Install dependencies**
   ```bash
   flutter pub get
   ```

3. **Generate code**
   ```bash
   dart run build_runner build
   ```

4. **Run the app**
   ```bash
   flutter run
   ```

### Building APK

To build a release APK:
```bash
flutter build apk --release
```

The APK will be generated at: `build/app/outputs/flutter-apk/app-release.apk`

## 📋 Build Configuration

### Android Requirements
- **Compile SDK**: 34
- **Min SDK**: 21
- **Target SDK**: 34
- **NDK Version**: 27.0.12077973
- **Java Version**: 17

### Permissions
- Camera access for taking plant photos
- Storage access for saving/loading images

## 🎨 Design System

### Color Palette
- **Primary**: Plant Green (#4CAF50)
- **Accent**: Light Green (#8BC34A)
- **Background**: White (#FFFFFF)
- **Surface**: Light Gray (#F5F5F5)
- **Error**: Red (#E53E3E)

### Typography
- **Headlines**: Bold, prominent text for titles
- **Body**: Regular text for content
- **Captions**: Secondary information

## 📱 Screenshots

*Screenshots will be added here showing the app's UI*

## 🤝 Contributing

1. Fork the repository
2. Create a feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes (`git commit -m 'Add amazing feature'`)
4. Push to the branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 👨‍💻 Author

**Anas Asghar**
- GitHub: [@AnsAsghar](https://github.com/AnsAsghar)

## 🙏 Acknowledgments

- Flutter team for the amazing framework
- Plant identification APIs and datasets
- Open source community for the packages used

---

Made with ❤️ and Flutter
