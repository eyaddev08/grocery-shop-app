class AppConfig {
  // Environment
  static const String environment =
      String.fromEnvironment('ENV', defaultValue: 'development');

  // API Configuration
  static const String baseUrl = String.fromEnvironment(
    'BASE_URL',
    defaultValue: 'https://api.groceryshop.com',
  );

  static const String apiVersion = String.fromEnvironment(
    'API_VERSION',
    defaultValue: '/v1',
  );

  // Database Configuration
  static const String databaseName = String.fromEnvironment(
    'DATABASE_NAME',
    defaultValue: 'grocery_shop.db',
  );

  static const int databaseVersion = int.fromEnvironment(
    'DATABASE_VERSION',
    defaultValue: 1,
  );

  // Storage Configuration
  static const String storagePrefix = String.fromEnvironment(
    'STORAGE_PREFIX',
    defaultValue: 'grocery_shop_',
  );

  // Feature Flags
  static const bool enableAnalytics = bool.fromEnvironment(
    'ENABLE_ANALYTICS',
    defaultValue: true,
  );

  static const bool enableCrashlytics = bool.fromEnvironment(
    'ENABLE_CRASHLYTICS',
    defaultValue: true,
  );

  static const bool enablePerformanceMonitoring = bool.fromEnvironment(
    'ENABLE_PERFORMANCE_MONITORING',
    defaultValue: true,
  );

  static const bool enablePushNotifications = bool.fromEnvironment(
    'ENABLE_PUSH_NOTIFICATIONS',
    defaultValue: true,
  );

  static const bool enableBiometricAuth = bool.fromEnvironment(
    'ENABLE_BIOMETRIC_AUTH',
    defaultValue: false,
  );

  static const bool enableDarkMode = bool.fromEnvironment(
    'ENABLE_DARK_MODE',
    defaultValue: true,
  );

  // Pagination
  static const int defaultPageSize = int.fromEnvironment(
    'DEFAULT_PAGE_SIZE',
    defaultValue: 20,
  );

  static const int maxPageSize = int.fromEnvironment(
    'MAX_PAGE_SIZE',
    defaultValue: 100,
  );

  // Timeouts
  static const int connectionTimeout = int.fromEnvironment(
    'CONNECTION_TIMEOUT',
    defaultValue: 30000,
  );

  static const int receiveTimeout = int.fromEnvironment(
    'RECEIVE_TIMEOUT',
    defaultValue: 30000,
  );

  // Cache Configuration
  static const int cacheExpirationMinutes = int.fromEnvironment(
    'CACHE_EXPIRATION_MINUTES',
    defaultValue: 30,
  );

  static const int maxCacheSize = int.fromEnvironment(
    'MAX_CACHE_SIZE',
    defaultValue: 100,
  );

  // Image Configuration
  static const String defaultImageUrl = String.fromEnvironment(
    'DEFAULT_IMAGE_URL',
    defaultValue: 'https://via.placeholder.com/300x200',
  );

  static const int maxImageSize = int.fromEnvironment(
    'MAX_IMAGE_SIZE',
    defaultValue: 5242880, // 5MB
  );

  // Validation
  static const int minPasswordLength = int.fromEnvironment(
    'MIN_PASSWORD_LENGTH',
    defaultValue: 8,
  );

  static const int maxPasswordLength = int.fromEnvironment(
    'MAX_PASSWORD_LENGTH',
    defaultValue: 50,
  );

  static const int minNameLength = int.fromEnvironment(
    'MIN_NAME_LENGTH',
    defaultValue: 2,
  );

  static const int maxNameLength = int.fromEnvironment(
    'MAX_NAME_LENGTH',
    defaultValue: 50,
  );

  // Currency
  static const String defaultCurrency = String.fromEnvironment(
    'DEFAULT_CURRENCY',
    defaultValue: 'USD',
  );

  static const String currencySymbol = String.fromEnvironment(
    'CURRENCY_SYMBOL',
    defaultValue: '\$',
  );

  // Social Login
  static const bool enableGoogleLogin = bool.fromEnvironment(
    'ENABLE_GOOGLE_LOGIN',
    defaultValue: false,
  );

  static const bool enableFacebookLogin = bool.fromEnvironment(
    'ENABLE_FACEBOOK_LOGIN',
    defaultValue: false,
  );

  static const bool enableAppleLogin = bool.fromEnvironment(
    'ENABLE_APPLE_LOGIN',
    defaultValue: false,
  );

  // Payment
  static const bool enableStripe = bool.fromEnvironment(
    'ENABLE_STRIPE',
    defaultValue: false,
  );

  static const bool enablePayPal = bool.fromEnvironment(
    'ENABLE_PAYPAL',
    defaultValue: false,
  );

  static const bool enableApplePay = bool.fromEnvironment(
    'ENABLE_APPLE_PAY',
    defaultValue: false,
  );

  static const bool enableGooglePay = bool.fromEnvironment(
    'ENABLE_GOOGLE_PAY',
    defaultValue: false,
  );

  // Maps
  static const bool enableMaps = bool.fromEnvironment(
    'ENABLE_MAPS',
    defaultValue: false,
  );

  static const String googleMapsApiKey = String.fromEnvironment(
    'GOOGLE_MAPS_API_KEY',
    defaultValue: '',
  );

  // Analytics
  static const String firebaseAnalyticsId = String.fromEnvironment(
    'FIREBASE_ANALYTICS_ID',
    defaultValue: '',
  );

  static const String mixpanelToken = String.fromEnvironment(
    'MIXPANEL_TOKEN',
    defaultValue: '',
  );

  // Crashlytics
  static const String firebaseCrashlyticsId = String.fromEnvironment(
    'FIREBASE_CRASHLYTICS_ID',
    defaultValue: '',
  );

  // Push Notifications
  static const String firebaseMessagingId = String.fromEnvironment(
    'FIREBASE_MESSAGING_ID',
    defaultValue: '',
  );

  // Deep Links
  static const String deepLinkScheme = String.fromEnvironment(
    'DEEP_LINK_SCHEME',
    defaultValue: 'groceryshop',
  );

  static const String deepLinkHost = String.fromEnvironment(
    'DEEP_LINK_HOST',
    defaultValue: 'groceryshop.com',
  );

  // App Store
  static const String appStoreId = String.fromEnvironment(
    'APP_STORE_ID',
    defaultValue: '',
  );

  static const String playStoreId = String.fromEnvironment(
    'PLAY_STORE_ID',
    defaultValue: '',
  );

  // Support
  static const String supportEmail = String.fromEnvironment(
    'SUPPORT_EMAIL',
    defaultValue: 'support@groceryshop.com',
  );

  static const String supportPhone = String.fromEnvironment(
    'SUPPORT_PHONE',
    defaultValue: '+1-800-123-4567',
  );

  // Social Media
  static const String facebookUrl = String.fromEnvironment(
    'FACEBOOK_URL',
    defaultValue: 'https://facebook.com/groceryshop',
  );

  static const String twitterUrl = String.fromEnvironment(
    'TWITTER_URL',
    defaultValue: 'https://twitter.com/groceryshop',
  );

  static const String instagramUrl = String.fromEnvironment(
    'INSTAGRAM_URL',
    defaultValue: 'https://instagram.com/groceryshop',
  );

  static const String linkedinUrl = String.fromEnvironment(
    'LINKEDIN_URL',
    defaultValue: 'https://linkedin.com/company/groceryshop',
  );

  // Privacy & Terms
  static const String privacyPolicyUrl = String.fromEnvironment(
    'PRIVACY_POLICY_URL',
    defaultValue: 'https://groceryshop.com/privacy',
  );

  static const String termsOfServiceUrl = String.fromEnvironment(
    'TERMS_OF_SERVICE_URL',
    defaultValue: 'https://groceryshop.com/terms',
  );

  // Helper methods
  static bool get isDevelopment => environment == 'development';
  static bool get isStaging => environment == 'staging';
  static bool get isProduction => environment == 'production';

  static String get fullApiUrl => '$baseUrl$apiVersion';

  static bool get isAnalyticsEnabled => enableAnalytics && isProduction;
  static bool get isCrashlyticsEnabled => enableCrashlytics && isProduction;
  static bool get isPerformanceMonitoringEnabled =>
      enablePerformanceMonitoring && isProduction;

  static Map<String, dynamic> toMap() {
    return {
      'environment': environment,
      'baseUrl': baseUrl,
      'apiVersion': apiVersion,
      'databaseName': databaseName,
      'databaseVersion': databaseVersion,
      'storagePrefix': storagePrefix,
      'enableAnalytics': enableAnalytics,
      'enableCrashlytics': enableCrashlytics,
      'enablePerformanceMonitoring': enablePerformanceMonitoring,
      'enablePushNotifications': enablePushNotifications,
      'enableBiometricAuth': enableBiometricAuth,
      'enableDarkMode': enableDarkMode,
      'defaultPageSize': defaultPageSize,
      'maxPageSize': maxPageSize,
      'connectionTimeout': connectionTimeout,
      'receiveTimeout': receiveTimeout,
      'cacheExpirationMinutes': cacheExpirationMinutes,
      'maxCacheSize': maxCacheSize,
      'defaultImageUrl': defaultImageUrl,
      'maxImageSize': maxImageSize,
      'minPasswordLength': minPasswordLength,
      'maxPasswordLength': maxPasswordLength,
      'minNameLength': minNameLength,
      'maxNameLength': maxNameLength,
      'defaultCurrency': defaultCurrency,
      'currencySymbol': currencySymbol,
      'enableGoogleLogin': enableGoogleLogin,
      'enableFacebookLogin': enableFacebookLogin,
      'enableAppleLogin': enableAppleLogin,
      'enableStripe': enableStripe,
      'enablePayPal': enablePayPal,
      'enableApplePay': enableApplePay,
      'enableGooglePay': enableGooglePay,
      'enableMaps': enableMaps,
      'googleMapsApiKey': googleMapsApiKey,
      'firebaseAnalyticsId': firebaseAnalyticsId,
      'mixpanelToken': mixpanelToken,
      'firebaseCrashlyticsId': firebaseCrashlyticsId,
      'firebaseMessagingId': firebaseMessagingId,
      'deepLinkScheme': deepLinkScheme,
      'deepLinkHost': deepLinkHost,
      'appStoreId': appStoreId,
      'playStoreId': playStoreId,
      'supportEmail': supportEmail,
      'supportPhone': supportPhone,
      'facebookUrl': facebookUrl,
      'twitterUrl': twitterUrl,
      'instagramUrl': instagramUrl,
      'linkedinUrl': linkedinUrl,
      'privacyPolicyUrl': privacyPolicyUrl,
      'termsOfServiceUrl': termsOfServiceUrl,
    };
  }
}
