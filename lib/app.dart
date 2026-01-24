import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grocery_shop_app/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:grocery_shop_app/features/auth/presentation/pages/register_page.dart';
import 'package:grocery_shop_app/features/auth/presentation/pages/verify_code_page.dart';
import 'config/di/injection_container.dart';
import 'config/routes/app_routes.dart';
import 'core/services/navigation_service.dart';
import 'core/theme/app_theme.dart';
import 'core/utils/layout.dart';
import 'features/Home/domain/usecases/get_deal_products.dart';
import 'features/Home/domain/usecases/get_recommended_products.dart';
import 'features/Home/presentation/manager/deal_product/deal_product_cubit.dart';
import 'features/Home/presentation/manager/recommended/recommended_cubit.dart';
import 'features/auth/presentation/pages/forgot_password_page.dart';
import 'features/auth/presentation/pages/login_page.dart';
import 'features/auth/presentation/pages/reset_password_page.dart';
import 'features/cart/presentation/manager/cart_cubit.dart';
import 'features/categories/domain/usecases/get_categories.dart';
import 'features/categories/presentation/manger/categories_cubit.dart';
import 'features/checkout/presentation/manager/checkout_cubit.dart';
import 'features/checkout/presentation/screens/add_address_sscreen.dart';
import 'features/checkout/presentation/screens/checkout_screen.dart';
import 'features/onboarding/presentation/views/onboarding_v2_screen.dart';

import 'features/payment/domain/usecase/tokenize_and_pay.dart';
import 'features/payment/presentation/manager/payment_cubit/payment_cubit.dart';
import 'features/payment/presentation/screens/add_card_screen.dart';
import 'features/product_details/domain/usecases/get_product_details.dart';
import 'features/product_details/domain/usecases/get_similar_product.dart';
import 'features/product_details/presentation/manager/product_details/product_details_cubit.dart';
import 'features/product_details/presentation/manager/similar_product/similar_product_cubit.dart';
import 'features/products/data/repositories/product_repository_impl.dart';
import 'features/products/domain/usecases/get_products.dart';
import 'features/products/presentation/manger/products_cubit.dart';
import 'features/products/presentation/screens/products_screen.dart';
import 'features/cart/presentation/screens/cart_screen.dart';
import 'features/search/presentation/manager/search_cubit.dart';
import 'features/search/presentation/screens/search_screen.dart';
import 'features/splash/presentation/screens/splash_screen.dart';
import 'features/wishlist/presentation/manager/cubit/wishlist_cubit.dart';
import 'features/wishlist/presentation/screens/wishlist_screen.dart';
import 'features/orders/presentation/manager/orders_cubit.dart';
import 'features/orders/presentation/screens/orders_screen.dart';

class GroceryShopApp extends StatelessWidget {
  const GroceryShopApp({super.key});

  @override
  Widget build(BuildContext context) {
    // Set system UI overlay style
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
        systemNavigationBarColor: Colors.white,
        systemNavigationBarIconBrightness: Brightness.dark,
      ),
    );

    return MultiBlocProvider(
      providers: [
        BlocProvider(
            create: (context) =>
                DealProductCubit(sl<GetDealProductsUseCase>())),
        BlocProvider(
            create: (context) =>
                RecommendedCubit(sl<GetRecommendedProducts>())),
        BlocProvider(
            create: (context) => CategoriesCubit(sl<GetCategories>())..load()),
        BlocProvider(
          create: (context) =>
              ProductsCubit(GetProducts(ProductRepositoryImpl()))..load(),
        ),
        BlocProvider(
          create: (context) => sl<CartCubit>()..load(),
        ),
        BlocProvider(
            create: (context) => ProductDetailsCubit(sl<GetProductDetails>())),
        BlocProvider(
            create: (context) => SimilarProductCubit(
                getSimilarProduct: sl<GetSimilarProduct>())),
        BlocProvider(
          create: (context) => sl<CheckoutCubit>()..loadAddresses(),
        ),
        BlocProvider(
          create: (_) => PaymentCubit(useCase: sl<TokenizeAndPayUseCase>()),
        ),
        BlocProvider(
          create: (_) => sl<WishlistCubit>()..loadWishlist(),
        ),
        BlocProvider(
          create: (_) => OrdersCubit(getOrdersUseCase: sl())..loadOrders(),
        ),
        BlocProvider(
          create: (_) => sl<SearchCubit>()..loadSuggestions(''),
        ),
        BlocProvider(
          create: (_) => sl<AuthCubit>(),
        ),
      ],
      child: MaterialApp(
        title: 'Grocery Shop',
        debugShowCheckedModeBanner: false,
        theme: AppTheme.lightTheme,
        darkTheme: AppTheme.darkTheme,
        themeMode: ThemeMode.system,
        navigatorKey: NavigationService.navigatorKey,
        initialRoute: AppRoutes.splash,
        onGenerateRoute: _generateRoute,
        builder: (context, child) => MediaQuery(
          data: MediaQuery.of(context).copyWith(
            textScaler: TextScaler.linear(
              MediaQuery.of(context).textScaleFactor.clamp(0.8, 1.2),
            ),
          ),
          child: child!,
        ),
      ),
    );
  }

  Route<dynamic>? _generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case AppRoutes.splash:
        return MaterialPageRoute(
          builder: (_) => const SplashScreen(),
          settings: settings,
        );
      case AppRoutes.login:
        return MaterialPageRoute(
          builder: (context) => const LoginScreen(),
          settings: settings,
        );
      case AppRoutes.forgotPassword:
        return MaterialPageRoute(
          builder: (context) => const ForgotPasswordPage(),
          settings: settings,
        );
      case AppRoutes.register:
        return MaterialPageRoute(
          builder: (context) => const RegisterPage(),
          settings: settings,
        );
      case AppRoutes.resetPassword:
      return MaterialPageRoute(
        builder: (context) =>  const ResetPasswordPage(token: 'fake_token_123456'),
        settings: settings,
      );
            case AppRoutes.verifyCode:
      return MaterialPageRoute(
        builder: (context) =>  const VerifyCodePage(email: 'eyaddev08@gmail.com'),
        settings: settings,
      );
      case AppRoutes.layout:
        return MaterialPageRoute(
          builder: (context) => const Layout(),
          settings: settings,
        );
      case AppRoutes.cart:
        return MaterialPageRoute(
          builder: (context) => const CartScreen(),
          settings: settings,
        );
      case AppRoutes.products:
        return MaterialPageRoute(
          builder: (context) => const ProductsScreen(),
          settings: settings,
        );
      case AppRoutes.checkout:
        return MaterialPageRoute(
          builder: (context) => const CheckoutScreen(),
          settings: settings,
        );
      case AppRoutes.addAddress:
        return MaterialPageRoute(
          builder: (context) => const AddAddressScreen(),
          settings: settings,
        );
      case AppRoutes.addCard:
        return MaterialPageRoute(
          builder: (context) => const AddCardScreen(amount: 37),
          settings: settings,
        );
      case AppRoutes.favorites:
        return MaterialPageRoute(
          builder: (context) => const WishlistScreen(),
          settings: settings,
        );
      case AppRoutes.orders:
        return MaterialPageRoute(
          builder: (context) => const OrdersScreen(),
          settings: settings,
        );
      case AppRoutes.search:
        return MaterialPageRoute(
          builder: (context) => const SearchScreen(),
          settings: settings,
        );
      // case AppRoutes.trackOrder:
      //   final orderId = settings.arguments as String? ?? '765433';
      //   return MaterialPageRoute(
      //     builder: (context) => BlocProvider(
      //       create: (context) => TrackOrderCubit(
      //         getTrackOrderUseCase: sl<GetTrackOrder>(),
      //       )..loadTrackOrder(orderId),
      //       child: TrackOrderScreen(orderId: orderId),
      //     ),
      //     settings: settings,
      //   );
      case AppRoutes.onboarding:
        return MaterialPageRoute(builder: (_) => const OnboardingV2Screen());
      default:
        return MaterialPageRoute(
          builder: (_) => const NotFoundScreen(),
          settings: settings,
        );
    }
  }
}

// Placeholder screens - these will be implemented in the features folder

// class LoginScreen extends StatelessWidget {
//   const LoginScreen({super.key});

//   @override
//   Widget build(BuildContext context) => Scaffold(
//         appBar: AppBar(
//           title: const Text('Login'),
//         ),
//         body: Column(
//           mainAxisAlignment: MainAxisAlignment.spaceAround,
//           children: [
//             const Text('Login Screen - To be implemented'),
//             Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 16),
//               child: SizedBox(
//                 width: double.infinity,
//                 height: 54,
//                 child: ElevatedButton(
//                   style: ElevatedButton.styleFrom(
//                     backgroundColor: const Color(0xFF2E4482),
//                     foregroundColor: Colors.white,
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(16),
//                     ),
//                     elevation: 0,
//                   ),
//                   onPressed: () {
//                     NavigationService.navigateTo(AppRoutes.layout);
//                   },
//                   child: const Row(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       Text('Go To Home',
//                           style: TextStyle(
//                               fontSize: 16, fontWeight: FontWeight.w500)),
//                       SizedBox(width: 8),
//                       Icon(Icons.arrow_forward, size: 22),
//                     ],
//                   ),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       );
// }

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: const Text('Home'),
        ),
        body: Center(
          child: Column(
            children: [
              const Text('Home Screen - To be implemented'),
              SizedBox(
                width: double.infinity,
                height: 54,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF2E4482),
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    elevation: 0,
                  ),
                  onPressed: () {
                    NavigationService.navigateTo(AppRoutes.home);
                  },
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Go To Login',
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w500)),
                      SizedBox(width: 8),
                      Icon(Icons.arrow_forward, size: 22),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      );
}

class NotFoundScreen extends StatelessWidget {
  const NotFoundScreen({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: const Text('Not Found'),
        ),
        body: const Center(
          child: Text('Page not found'),
        ),
      );
}
