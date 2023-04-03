import 'package:ccp_puno_flutter/config/router/app_router_notifier.dart';
import 'package:ccp_puno_flutter/features/auth/presentation/providers/auth_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:ccp_puno_flutter/features/auth/auth.dart';
import 'package:ccp_puno_flutter/features/products/products.dart';

final goRouterProvider = Provider((ref) {
  final goRouterNotifier = ref.read(goRouterNotifierProvider);
  return GoRouter(
      initialLocation: '/loading',
      refreshListenable: goRouterNotifier,
      routes: [
        GoRoute(
          path: '/loading',
          builder: (context, state) => const LoadingScreen(),
        ),

        ///* Auth Routes
        GoRoute(
          path: '/login',
          builder: (context, state) => const LoginScreen(),
        ),
        GoRoute(
          path: '/register',
          builder: (context, state) => const RegisterScreen(),
        ),

        ///* Product Routes
        GoRoute(
          path: '/',
          builder: (context, state) => const ProductsScreen(),
        ),
      ],
      redirect: (context, state) {
        final isGoingTo = state.subloc;
        final authStatus = goRouterNotifier.authStatus;

        if (isGoingTo == '/loading' && authStatus == AuthStatus.checking) {
          return null;
        }

        if (authStatus == AuthStatus.noAuthenticated) {
          if (isGoingTo == '/login' || isGoingTo == '/register') return null;
          return '/login';
        }

        if (authStatus == AuthStatus.authenticated) {
          if (isGoingTo == '/login' ||
              isGoingTo == '/register' ||
              isGoingTo == '/loading') return '/';

          return isGoingTo;
        }
        return null;
      });
});
