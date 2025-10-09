<<<<<<< HEAD
# Grocery Shop App

A modern Flutter application for grocery shopping with a clean architecture and beautiful UI.

## 🚀 Features

- **Clean Architecture**: Following Clean Architecture principles with proper separation of concerns
- **Modern UI**: Beautiful and responsive design with Material Design 3
- **Dark Mode**: Support for both light and dark themes
- **State Management**: Using BLoC pattern for state management
- **Dependency Injection**: Using GetIt for dependency injection
- **Localization**: Ready for multi-language support
- **Validation**: Comprehensive form validation
- **Loading States**: Beautiful loading widgets and animations
- **Error Handling**: Proper error handling and user feedback

## 📁 Project Structure

```
lib/
├── app.dart                 # Main app configuration
├── main.dart               # App entry point
├── config/                 # Configuration files
│   ├── di/                 # Dependency injection
│   │   └── injection_container.dart
│   ├── env/                # Environment configuration
│   │   └── app_config.dart
│   └── routes/             # App routing
│       └── app_routes.dart
├── core/                   # Core functionality
│   ├── constants/          # App constants
│   │   ├── app_constants.dart
│   │   └── app_strings.dart
│   ├── theme/              # App theming
│   │   └── app_theme.dart
│   ├── utils/              # Utility functions
│   │   ├── helpers.dart
│   │   └── validators.dart
│   └── widgets/            # Reusable widgets
│       └── loading_widget.dart
└── features/               # Feature modules
    └── (to be implemented)
```

## 🛠️ Getting Started

### Prerequisites

- Flutter SDK (latest stable version)
- Dart SDK
- Android Studio / VS Code
- Git

### Installation

1. Clone the repository:
```bash
git clone https://github.com/eyaddev08/grocery-shop-app.git
cd grocery-shop-app
```

2. Install dependencies:
```bash
flutter pub get
```

3. Run the app:
```bash
flutter run
```

## 📱 Screenshots

*Screenshots will be added as the app develops*

## 🎨 Design System

The app uses a consistent design system with:

- **Primary Color**: Green (#2E7D32)
- **Secondary Color**: Light Green (#4CAF50)
- **Accent Color**: Orange (#FF9800)
- **Typography**: Poppins font family
- **Spacing**: 8px grid system
- **Border Radius**: 8px for cards, 12px for containers

## 🏗️ Architecture

The app follows Clean Architecture principles:

- **Presentation Layer**: UI components, BLoCs, and pages
- **Domain Layer**: Business logic, entities, and use cases
- **Data Layer**: Repositories, data sources, and models

## 📦 Dependencies

### Core Dependencies
- `flutter`: Flutter framework
- `get_it`: Dependency injection
- `shared_preferences`: Local storage
- `google_fonts`: Custom fonts
- `intl`: Internationalization

### State Management
- `flutter_bloc`: BLoC pattern implementation

### Networking
- `dio`: HTTP client
- `retrofit`: Type-safe HTTP client

### UI/UX
- `flutter_screenutil`: Screen adaptation
- `cached_network_image`: Image caching
- `shimmer`: Loading animations

### Utilities
- `equatable`: Value equality
- `json_annotation`: JSON serialization
- `freezed`: Code generation

## 🚀 Development

### Code Style

The project follows Flutter's official style guide and uses:
- `dart format` for code formatting
- `flutter analyze` for static analysis
- Custom lint rules in `analysis_options.yaml`

### Git Workflow

1. Create a feature branch from `main`
2. Make your changes
3. Run tests and ensure they pass
4. Create a pull request
5. Code review and merge

## 📝 TODO

- [ ] Implement authentication feature
- [ ] Add product catalog
- [ ] Implement shopping cart
- [ ] Add user profile management
- [ ] Implement order management
- [ ] Add search functionality
- [ ] Implement favorites
- [ ] Add push notifications
- [ ] Implement payment integration
- [ ] Add offline support

## 🤝 Contributing

1. Fork the repository
2. Create your feature branch (`git checkout -b feature/AmazingFeature`)
3. Commit your changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 👨‍💻 Author

**Eyad**
- GitHub: [@eyaddev08](https://github.com/eyaddev08)

## 🙏 Acknowledgments

- Flutter team for the amazing framework
- Material Design team for the design system
- Open source community for the packages used

---

**Note**: This is a work in progress. Features and screenshots will be updated as development continues.
=======
# grocery-shop-app
>>>>>>> b148234a107a0709f0d3126cf702ae1ecd49a35e
