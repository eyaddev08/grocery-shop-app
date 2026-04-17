import 'package:flutter/material.dart';
import 'package:grocery_shop_app/app.dart';

import '../../core/helpers/create_slide_fade_route.dart';
import '../../core/utils/layout.dart';
import '../../features/auth/presentation/screens/forgot_password_screen.dart';
import '../../features/auth/presentation/screens/login_screen.dart';
import '../../features/auth/presentation/screens/register_screen.dart';
import '../../features/auth/presentation/screens/reset_password_screen.dart';
import '../../features/auth/presentation/screens/verify_code_screen.dart';
import '../../features/cart/presentation/screens/cart_screen.dart';
import '../../features/checkout/presentation/screens/address_form_screen.dart';
import '../../features/checkout/presentation/screens/checkout_screen.dart';
import '../../features/location/presentation/screens/map_picker_screen.dart';
import '../../features/onboarding/presentation/screens/onboarding_v2_screen.dart';
import '../../features/orders/presentation/screens/orders_screen.dart';
import '../../features/payment/presentation/screens/add_card_screen.dart';

import '../../features/profile/presentation/screens/change_password_screen.dart';
import '../../features/profile/presentation/screens/edit_profile_screen.dart';
import '../../features/profile/presentation/screens/profile_screen.dart';
import '../../features/search/presentation/screens/search_screen.dart';
import '../../features/splash/presentation/screens/splash_screen.dart';
import '../../features/track_order/presentation/screens/track_order_search_screen.dart';
import '../../features/wishlist/presentation/screens/wishlist_screen.dart';
import 'app_routes.dart';

Route<dynamic>? generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case AppRoutes.splash:
      return createSlideFadeRoute(
        const SplashScreen(),
        settings: settings,
      );
    case AppRoutes.login:
      return createSlideFadeRoute(
        const LoginScreen(),
        settings: settings,
      );
    case AppRoutes.forgotPassword:
      return createSlideFadeRoute(
        const ForgotPasswordScreen(),
        settings: settings,
      );
    case AppRoutes.register:
      return createSlideFadeRoute(
        const RegisterScreen(),
        settings: settings,
      );
    case AppRoutes.resetPassword:
      return createSlideFadeRoute(
        const ResetPasswordScreen(token: 'fake_token_123456'),
        settings: settings,
      );
    case AppRoutes.verifyCode:
      return createSlideFadeRoute(
        const VerifyCodeScreen(email: 'eyaddev08@gmail.com'),
        settings: settings,
      );
    case AppRoutes.layout:
      return createSlideFadeRoute(
        const Layout(),
        settings: settings,
      );
    case AppRoutes.cart:
      return createSlideFadeRoute(
        const CartScreen(),
        settings: settings,
      );
    case AppRoutes.profile:
      return createSlideFadeRoute(
        const ProfileScreen(),
        settings: settings,
      );
    case AppRoutes.editProfile:
      return createSlideFadeRoute(
        const EditProfileScreen(),
        settings: settings,
      );
    case AppRoutes.guestTrackOrder:
      return createSlideFadeRoute(
        const TrackOrderSearchScreen(),
        settings: settings,
      );
    case AppRoutes.changePassword:
      return createSlideFadeRoute(
        const ChangePasswordScreen(),
        settings: settings,
      );

    // case AppRoutes.products:
    //   return MaterialPageRoute(
    //     builder: (context) => const ProductsScreen(),
    //     settings: settings,
    //   );
    //  case AppRoutes.recommendedProducts:
    // return createSlideFadeRoute(
    //   const RecommendedProductsScreen(),
    //   settings: settings,
    // );
    //  case AppRoutes.deals:
    // return createSlideFadeRoute(
    //   const DealsScreen(),
    //   settings: settings,
    // );
    case AppRoutes.checkout:
      return createSlideFadeRoute(
        const CheckoutScreen(),
        settings: settings,
      );
    case AppRoutes.addAddress:
      return createSlideFadeRoute(
        const AddressFormScreen(),
        settings: settings,
      );
    case AppRoutes.mapPicker:
      return createSlideFadeRoute(
        const MapPickerScreen(),
        settings: settings,
      );
    case AppRoutes.addCard:
      return createSlideFadeRoute(
        const AddCardScreen(amount: 37),
        settings: settings,
      );
    case AppRoutes.favorites:
      return createSlideFadeRoute(
        const WishlistScreen(),
        settings: settings,
      );
    case AppRoutes.orders:
      return createSlideFadeRoute(
        const OrdersScreen(),
        settings: settings,
      );
    case AppRoutes.search:
      return createSlideFadeRoute(
        const SearchScreen(),
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
      return createSlideFadeRoute(const OnboardingV2Screen());
    default:
      return createSlideFadeRoute(
        const NotFoundScreen(),
        settings: settings,
      );
  }
}
