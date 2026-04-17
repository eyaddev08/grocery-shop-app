import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grocery_shop_app/core/constants/app_colors.dart';
import 'package:grocery_shop_app/features/auth/presentation/manager/auth_cubit.dart';

import 'config/di/injection_container.dart';
import 'config/routes/app_routes.dart';
import 'config/routes/generate_route.dart';
import 'core/services/navigation_service.dart';
import 'core/theme/app_theme.dart';
import 'core/utils/styles.dart';
import 'core/widgets/custom_app_bar.dart';
import 'core/widgets/custom_button_widget.dart';
import 'features/products/presentation/manager/product_cubit/product_cubit.dart';

import 'features/cart/presentation/manager/cart_cubit.dart';
import 'features/categories/presentation/manager/categories_cubit.dart';
import 'features/checkout/presentation/manager/checkout_cubit.dart';
import 'features/location/presentation/manager/location_cubit.dart';
import 'features/payment/presentation/manager/payment_cubit/payment_cubit.dart';
import 'features/product_details/presentation/manager/product_details/product_details_cubit.dart';
import 'features/product_details/presentation/manager/similar_product/similar_product_cubit.dart';
import 'features/profile/presentation/manager/profile_cubit.dart';
import 'features/search/presentation/manager/search_cubit.dart';

import 'features/track_order/presentation/manager/track_order_cubit.dart';
import 'features/wishlist/presentation/manager/cubit/wishlist_cubit.dart';
import 'features/orders/presentation/manager/order_cubit.dart';

class GroceryShopApp extends StatelessWidget {
  const GroceryShopApp({super.key});

  @override
  Widget build(BuildContext context) => MultiBlocProvider(
      providers: [
        BlocProvider(
            create: (context) => sl<CategoriesCubit>()..loadCategories()),
        BlocProvider(
            create: (context) => sl<LocationCubit>()..getCurrentLocation()),
        BlocProvider(
          create: (_) => sl<ProfileCubit>()..loadProfile(),
        ),
        BlocProvider(
          create: (context) => sl<CartCubit>()..loadCart(),
        ),
        BlocProvider(create: (context) => sl<ProductDetailsCubit>()),
         BlocProvider(create: (context) => sl<ProductCubit>()..loadHomeScreenData()),
        BlocProvider(create: (context) => sl<SimilarProductCubit>()),
        BlocProvider(
          create: (context) => sl<CheckoutCubit>()..loadAddresses(),
        ),
        BlocProvider(
          create: (_) => sl<PaymentCubit>(),
        ),
        BlocProvider(
          create: (_) => sl<WishlistCubit>()..loadWishlist(),
        ),
        BlocProvider(
          create: (_) => sl<OrderCubit>()..loadOrders(),
        ),
         BlocProvider(
          create: (context) => sl<TrackOrderCubit>(),
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
        navigatorKey: NavigationService.navigatorKey,
        initialRoute: AppRoutes.splash,
        onGenerateRoute: generateRoute,
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

class NotFoundScreen extends StatelessWidget {
  const NotFoundScreen({super.key, this.routeName});
  final String? routeName;

  @override
  Widget build(BuildContext context) {
    final title = routeName != null ? 'Page not found' : 'The page not found';
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(50),
        child: CustomAppBar(title: '404'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.error_outline, size: 72, color: kAccentYellow),
              const SizedBox(height: 16),
              Text(title,
                  textAlign: TextAlign.center,
                  style: titleHeader.copyWith(color: kMuted, fontSize: 18)),
              const SizedBox(height: 8),
              Text('Sorry, the page you are trying to access is not available',
                  textAlign: TextAlign.center,
                  style: textBold.copyWith(color: kMuted)),
              const SizedBox(height: 24),
              const CustomButton(
                onPressed: NavigationService.goBack,
                buttonText: 'Back to Home',
                buttonWidth: 180,
                buttonHeight: 48,
                isBorder: true,
                radius: 12,
              )
            ],
          ),
        ),
      ),
    );
  }
}
