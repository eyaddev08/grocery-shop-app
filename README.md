# 🛒 Grocery Shop App

<div align="center">
  <h3>A Modern, Production-Ready E-Commerce application built with Flutter.</h3>
</div>

---

## 📖 Short Professional Description

**Grocery Shop App** is a premium, fully-featured e-commerce application designed to deliver exactly what modern shoppers expect: a seamless, intuitive, and fast purchasing experience. Built entirely in Flutter, the application adheres to **Clean Architecture** patterns, ensuring a scalable, robust, and easily maintainable codebase. 

From searching and discovering products to managing the cart, safe checkout, and real-time order tracking, this app provides a complete end-to-end shopping journey. Paired with elegant UI/UX design, Dark Mode support, and seamless localization, it stands as a versatile template for any extensive e-commerce platform.

---

## ✨ Key Features

- **🛍️ Complete E-Commerce Experience**: Discover, browse, and shop for daily groceries seamlessly.
- **🔐 Secure Authentication**: Fast and reliable user login and registration flows.
- **🗂️ Categories & Product Browsing**: Beautifully crafted screens to explore products by categories.
- **🔍 Detailed Product Information**: Crisp, comprehensive product detail screens that highlight what matters.
- **🛒 Smart Cart & Checkout Flow**: Intuitive cart management with a frictionless, step-by-step checkout process.
- **♥️ Wishlist Management**: Save favorite products across sessions to purchase them later.
- **📦 Order History & Tracking**: View past orders and track current shipments effectively.
- **📍 Location Handling**: Advanced location capabilities to easily set and manage delivery addresses.
- **🌙 Dark Mode Support**: A polished and accessible dark theme built natively into the app.
- **🌍 Localization-Ready**: Built-in support for multiple languages to cater to a global audience.

---

## 🏛️ Architecture / Project Structure

This project enforces strict **Clean Architecture** principles, guaranteeing a decoupled, testable, and highly maintainable codebase. Each primary feature operates as an independent module comprising three core layers:

1. **Domain Layer**: The innermost layer where business logic and core Use Cases reside. It contains Entities and Repository Interfaces, remaining completely independent of UI or external frameworks.
2. **Data Layer**: Responsible for interacting with remote APIs and local storage. It implements the Domain layer's repository interfaces and converts raw JSON or database structures into clean Domain Entities.
3. **Presentation Layer**: Built around Flutter widgets and BLoC components. It reacts to states emitted by the business logic, focusing purely on UI aesthetics and user interactivity.

---

## ⚙️ State Management

The application leverages **BLoC / Cubit** for predictable and robust state management. 
- Business logic is heavily isolated from the user interface.
- View components are reactive, updating instantly to state emissions (Loading, Success, Error).
- `flutter_bloc` integrates elegantly with GetIt / Injectable to handle clean dependency injection and scoping.

---

## 📱 Core Screens and Main User Flow

1. **Splash & Onboarding**: Engaging introduction guiding users into the app.
2. **Authentication Flow**: Login, Sign Up, and profile creation.
3. **Home Dashboard**: Dynamic feed showing featured categories, top deals, and quick-add actions.
4. **Browse & Search**: Advanced search capabilities with category filtering to find the exact grocery item.
5. **Product Details**: Immersive item view, price details, and "Add to Cart" functionality.
6. **Cart & Wishlist**: Overview of selected goods and saved-for-later items.
7. **Checkout Pipeline**: Address selection (Location handling), review, and payment confirmation.
8. **Track Order**: Keep an eye on delivery status natively.
9. **Profile & More**: Manage settings, themes, and past orders.

---

## 🛠️ Technologies Used

- **Framework**: Flutter (`>=3.0.0`)
- **State Management**: `flutter_bloc`, `equatable`, `dartz`
- **Dependency Injection**: `get_it`, `injectable`
- **Routing**: `go_router`
- **Networking APIs**: `dio`, `retrofit`
- **Local Storage**: `shared_preferences`, `flutter_secure_storage`, `hive`
- **Localization**: `flutter_intl`
- **UI & Theming**: `google_fonts`, `shimmer`, `flutter_svg`, `cupertino_icons`
- **Maps & Location**: `google_maps_flutter`, `geolocator`, `flutter_typeahead`

---

## 🚀 Installation and Setup

### Prerequisites
- Flutter SDK (`>=3.10.x` recommended)
- Dart SDK (`>=3.0.0 <4.0.0`)
- An IDE (VS Code, Android Studio, IntelliJ)

### Steps to Run

1. **Clone the repository** (if applicable) and navigate to the root directory.
   ```bash
   cd grocery_shop_app
   ```
2. **Install Dependencies**
   Run the following command to download all necessary packages:
   ```bash
   flutter pub get
   ```
3. **Run Code Generation** (Important for Clean Architecture / Injectable & Hive)
   ```bash
   dart run build_runner build --delete-conflicting-outputs
   ```
4. **Run the App**
   Connect your physical device or start an emulator, then execute:
   ```bash
   flutter run
   ```

---

## 📂 Folder Structure Overview

```text
lib/
├── config/              # App routing (go_router), environment setups, and DI config
├── core/                # Shared utilities, constants, themes, and generic widgets
├── features/            # Independent feature modules
│   ├── auth/            # Authentication (Data, Domain, Presentation)
│   ├── cart/            # Cart management
│   ├── categories/      # Category browsing
│   ├── checkout/        # Checkout flow
│   ├── location/        # Geolocation and Maps
│   ├── orders/          # User's historical orders
│   ├── product_details/ # Individual product overview
│   ├── products/        # Product listing
│   ├── profile/         # User profile
│   ├── track_order/     # Order tracking mechanisms
│   └── wishlist/        # User's saved favorites
├── l10n/                # Localization ARB files
└── main.dart            # Application entry point
```

---

## 📝 Notes / Future Improvements

- **Payment Gateway Integration**: Expand the mock payment configuration into real-world providers (e.g., Stripe, PayPal).
- **Push Notifications**: Introduce real-time updates for promotional campaigns and live order status.
- **Advanced Animations**: Include hero transitions and more micro-interactions for a more native, liquid feel.
- **Analytics**: Integrate crash reporting and user tracking frameworks for detailed product improvement.

---

## 📄 License & Legal

Developed using modern cross-platform patterns. This project serves as a comprehensive robust foundation for any Flutter developer or organization looking to scale an e-commerce suite. 

> *Grocery Shop App – Bringing fresh produce right to your doorstep with incredible performance and sleek design.*
