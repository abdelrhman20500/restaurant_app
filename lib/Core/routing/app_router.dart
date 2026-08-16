import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:restaurant_app/features/profile/presentation/view/profile_view.dart';

import '../../features/auth/presentation/view/login_view.dart';
import '../../features/auth/presentation/view/sign_up_view.dart';
import '../../features/home/presentation/view/home_view.dart';
import '../../features/layout/presentation/view/layout_view.dart';
import '../../features/onBoarding/presentation/view/on_boarding_view.dart';
import '../../features/splash/presentation/view/splash_view.dart';

class AppRouter {
  AppRouter._();

  /// Route Names
  static const String splash = '/';
  static const String onboarding = '/onboarding';
  static const String login = '/login';
  static const String signUp = '/signUp';
  static const String layout = '/layout';
  static const String home = '/home';
  static const String profile = '/profile';
  // static const String searchView = '/searchView';
  //
  // static const String productDetails = '/product-details';
  // static const String cart = '/cart';
  // static const String forgotPassword = '/forgotPassword';
  // static const String verificationCode = '/verificationCode';
  // static const String createNewPassword = '/createNewPassword';
  // static const String productsByCategory = '/productsByCategory';
  // static const String brands = '/brands';

  static final GoRouter router = GoRouter(
    debugLogDiagnostics: true,

    initialLocation: splash,

    routes: [
      /// Splash
      GoRoute(
        path: splash,
        name: 'splash',
        builder: (context, state) => const SplashView(),
      ),

      //  Onboarding
      GoRoute(
        path: onboarding,
        // name: 'onboarding',
        builder: (context, state) => OnBoardingView(),
      ),

      // Login
      GoRoute(
        path: login,
        // name: 'login',
        builder: (context, state) => LoginView(),
      ),
      // layout
      GoRoute(
        path: layout,
        // name: 'login',
        builder: (context, state) => LayoutView(),
      ),

      // Register
      GoRoute(
        path: signUp,
        // name: 'register',
        builder: (context, state) => SignUpView(),
      ),

      // /// Home
      GoRoute(
        path: home,
        // name: 'home',
        builder: (context, state) => const HomeView(),
      ),

      GoRoute(
        path: profile,
        // name: 'home',
        builder: (context, state) => ProfileView(),
      ),

      // GoRoute(
      //   path: forgotPassword,
      //   // name: 'home',
      //   builder: (context, state) => ForgotPasswordView(),
      // ),
      //
      // GoRoute(
      //   path: searchView,
      //   // name: 'home',
      //   builder: (context, state) => BlocProvider(
      //     create: (context) => SearchCubit(
      //       searchRepo: SearchRepo(apiConsumer: DioConsumer(Dio())),
      //     ),
      //     child: SearchView(),
      //   ),
      // ),
      //
      // GoRoute(
      //   path: verificationCode,
      //   // name: 'home',
      //   builder: (context, state) {
      //     final email = state.extra as String;
      //     return VerificationCodeView(email: email);
      //   },
      // ),
      // GoRoute(
      //   path: productsByCategory,
      //   // name: 'home',
      //   builder: (context, state) {
      //     final categoryName = state.extra as String;
      //     return ProductsByCategoryView(categoryName: categoryName);

      // ),

      // /// Product Details
      // GoRoute(
      //   path: '$productDetails/:id',
      //   name: 'productDetails',
      //   builder: (context, state) {
      //     final productId = state.pathParameters['id'];

      //     return ProductDetailsView(productId: productId!);
      //   },
      // ),

      // /// Cart
      // GoRoute(
      //   path: cart,
      //   name: 'cart',
      //   builder: (context, state) => const CartView(),
      // ),
    ],

    /// Error Page
    errorBuilder: (context, state) {
      return Scaffold(body: Center(child: Text(state.error.toString())));
    },
  );
}
