import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'config/di/injection_container.dart' as di;
import 'config/di/injection_container.dart';
import 'config/routes/app_routes.dart';
import 'core/services/navigation_service.dart';
import 'core/theme/app_theme.dart';
import 'core/utils/layout.dart';
import 'features/Home/domain/usecases/get_products_usecase.dart';
import 'features/Home/presentation/manger/cubit/grocery_cubit.dart';
import 'features/cart/domain/usecases/add_to_cart.dart';
import 'features/cart/domain/usecases/remove_from_cart.dart';
import 'features/cart/domain/usecases/update_quantity.dart';
import 'features/cart/presentation/manager/cart_cubit.dart';
import 'features/categories/domain/usecases/get_categories.dart';
import 'features/categories/presentation/manger/categories_cubit.dart';
import 'features/checkout/domain/usecases/add_address.dart';
import 'features/checkout/domain/usecases/delete_address.dart';
import 'features/checkout/domain/usecases/get_addresses.dart';
import 'features/checkout/domain/usecases/set_default_address.dart';
import 'features/checkout/domain/usecases/update_address.dart';
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
import 'features/cart/domain/usecases/get_cart.dart';
import 'features/splash/presentation/screens/splash_screen.dart';
import 'features/wishlist/domain/repositories/wishlist_repository.dart';
import 'features/wishlist/domain/usecases/get_wishlist.dart';
import 'features/wishlist/domain/usecases/remove_from_wishlist.dart';
import 'features/wishlist/presentation/manager/cubit/wishlist_cubit.dart';
import 'features/wishlist/presentation/screens/wishlist_screen.dart';

class GroceryShopApp extends StatelessWidget {
  const GroceryShopApp({super.key});

  @override
  Widget build(BuildContext context) {
    // Initialize dependencies
    di.init();

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
            create: (context) => GroceryCubit(sl<GetProductsUseCase>())),
        BlocProvider(
            create: (context) => CategoriesCubit(sl<GetCategories>())..load()),
        BlocProvider(
          create: (context) =>
              ProductsCubit(GetProducts(ProductRepositoryImpl()))..load(),
        ),
        BlocProvider(
          create: (context) => CartCubit(
            getCartUsecase: sl<GetCart>(),
            addToCartUsecase: sl<AddToCart>(),
            removeFromCartUsecase: sl<RemoveFromCart>(),
            updateQuantityUsecase: sl<UpdateQuantity>(),
          )..load(),
        ),
        BlocProvider(
                      create: (context) => ProductDetailsCubit(
                          getProductDetails: sl<GetProductDetails>())),
        BlocProvider(
          create: (context) => SimilarProductCubit(getSimilarProduct: sl<GetSimilarProduct>())
        ),
        BlocProvider(
          create: (context) => CheckoutCubit(
            getAddresses: sl<GetAddressesUseCase>(),
            addAddress: sl<AddAddressUseCase>(),
            deleteAddress: sl<DeleteAddressUseCase>(),
            updateAddress: sl<UpdateAddressUseCase>(),
            setDefaultAddress: sl<SetDefaultAddressUseCase>(),
          )..loadAddresses(),
        ),

        BlocProvider(
          create: (_) => PaymentCubit(useCase: sl<TokenizeAndPayUseCase>()),
        ),
        BlocProvider(
          create: (_) => WishlistCubit(
          getWishlist: sl<GetWishlist>(),
          removeFromWishlist: sl<RemoveFromWishlist>(),
          repository: sl<WishlistRepository>(),
        )
            ..loadWishlist(),
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

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: const Text('Login'),
        ),
        body: Center(
          child: Column(
            children: [
              const Text('Login Screen - To be implemented'),
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
                    NavigationService.navigateTo(AppRoutes.layout);
                  },
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Go To Home',
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
