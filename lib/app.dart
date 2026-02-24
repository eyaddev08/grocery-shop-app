import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
import 'core/widgets/custom_app_bar_widget.dart';
import 'core/widgets/custom_button_widget.dart';
import 'features/Home/domain/usecases/get_deal_products.dart';
import 'features/Home/domain/usecases/get_recommended_products.dart';
import 'features/Home/presentation/manager/deal_product/deal_product_cubit.dart';
import 'features/Home/presentation/manager/recommended/recommended_cubit.dart';

import 'features/cart/presentation/manager/cart_cubit.dart';
import 'features/categories/domain/usecases/get_categories.dart';
import 'features/categories/presentation/manager/categories_cubit.dart';
import 'features/checkout/presentation/manager/checkout_cubit.dart';

import 'features/cart/domain/usecases/clear_cart_usecase.dart';
import 'features/orders/domain/usecases/create_orders_usecase.dart';
import 'features/payment/domain/usecase/tokenize_and_pay.dart';
import 'features/payment/presentation/manager/payment_cubit/payment_cubit.dart';
import 'features/product_details/domain/usecases/get_product_details.dart';
import 'features/product_details/domain/usecases/get_similar_product.dart';
import 'features/product_details/presentation/manager/product_details/product_details_cubit.dart';
import 'features/product_details/presentation/manager/similar_product/similar_product_cubit.dart';

import 'features/search/presentation/manager/search_cubit.dart';

import 'features/wishlist/presentation/manager/cubit/wishlist_cubit.dart';
import 'features/orders/presentation/manager/orders_cubit.dart';

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
            create: (context) =>
                CategoriesCubit(sl<GetCategories>())..loadCategories()),
        // BlocProvider(
        //   create: (context) =>
        //       ProductsCubit(GetProducts(ProductRepositoryImpl()))..load(),
        // ),
        BlocProvider(
          create: (context) => sl<CartCubit>()..loadCarts(),
        ),
        BlocProvider(
            create: (context) => ProductDetailsCubit(sl<GetProductDetails>())),
        BlocProvider(
            create: (context) => SimilarProductCubit(
                getSimilarProduct: sl<GetSimilarProduct>())),
        BlocProvider(
          create: (context) => sl<CheckoutCubit>()
            ..loadAddresses(),
            
        ),
        BlocProvider(
          create: (_) => PaymentCubit(
            useCase: sl<TokenizeAndPayUseCase>(),
            createOrderUseCase: sl<CreateOrderUseCase>(),
            clearCartUseCase: sl<ClearCartUseCase>(),
          ),
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
                onTap: NavigationService.goBack,
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
