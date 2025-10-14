class AppRoutes {
  // Authentication Routes
  static const String splash = '/';
  static const String login = '/login';
  static const String register = '/register';
  static const String forgotPassword = '/forgot-password';
  static const String resetPassword = '/reset-password';

  // Main App Routes
  static const String layout = '/layout';
  static const String home = '/home';
  static const String categories = '/categories';
  static const String products = '/products';
  static const String productDetails = '/product-details';
  static const String search = '/search';
  static const String cart = '/cart';
  static const String checkout = '/checkout';
  static const String profile = '/profile';
  static const String orders = '/orders';
  static const String orderDetails = '/order-details';
  static const String favorites = '/favorites';
  static const String settings = '/settings';
  static const String notifications = '/notifications';
  static const String help = '/help';
  static const String about = '/about';
  static const String contact = '/contact';

  // Onboarding Routes
  static const String onboarding = '/onboarding';
  static const String welcome = '/welcome';

  // Error Routes
  static const String notFound = '/not-found';
  static const String error = '/error';

  // Route Names Map
  static const Map<String, String> routeNames = {
    splash: 'Splash',
    login: 'Login',
    register: 'Register',
    forgotPassword: 'Forgot Password',
    resetPassword: 'Reset Password',
    layout: 'Layout',
    home: 'Home',
    categories: 'Categories',
    products: 'Products',
    productDetails: 'Product Details',
    search: 'Search',
    cart: 'Cart',
    checkout: 'Checkout',
    profile: 'Profile',
    orders: 'Orders',
    orderDetails: 'Order Details',
    favorites: 'Favorites',
    settings: 'Settings',
    notifications: 'Notifications',
    help: 'Help',
    about: 'About',
    contact: 'Contact',
    onboarding: 'Onboarding',
    welcome: 'Welcome',
    notFound: 'Not Found',
    error: 'Error',
  };

  // Get route name
  static String getRouteName(String route) {
    return routeNames[route] ?? 'Unknown';
  }

  // Check if route is authentication route
  static bool isAuthRoute(String route) {
    return [
      login,
      register,
      forgotPassword,
      resetPassword,
    ].contains(route);
  }

  // Check if route is main app route
  static bool isMainAppRoute(String route) {
    return [
      layout,
      home,
      categories,
      products,
      productDetails,
      search,
      cart,
      checkout,
      profile,
      orders,
      orderDetails,
      favorites,
      settings,
      notifications,
      help,
      about,
      contact,
    ].contains(route);
  }

  // Check if route is onboarding route
  static bool isOnboardingRoute(String route) {
    return [
      onboarding,
      welcome,
    ].contains(route);
  }

  // Check if route is error route
  static bool isErrorRoute(String route) {
    return [
      notFound,
      error,
    ].contains(route);
  }

  // Get all routes
  static List<String> getAllRoutes() {
    return routeNames.keys.toList();
  }

  // Get auth routes
  static List<String> getAuthRoutes() {
    return [
      login,
      register,
      forgotPassword,
      resetPassword,
    ];
  }

  // Get main app routes
  static List<String> getMainAppRoutes() {
    return [
      layout,
      home,
      categories,
      products,
      productDetails,
      search,
      cart,
      checkout,
      profile,
      orders,
      orderDetails,
      favorites,
      settings,
      notifications,
      help,
      about,
      contact,
    ];
  }

  // Get onboarding routes
  static List<String> getOnboardingRoutes() {
    return [
      onboarding,
      welcome,
    ];
  }

  // Get error routes
  static List<String> getErrorRoutes() {
    return [
      notFound,
      error,
    ];
  }
}
