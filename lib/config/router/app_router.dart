import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ccp_puno_flutter/config/router/app_router_notifier.dart';

import 'package:ccp_puno_flutter/features/auth/auth.dart';
import 'package:ccp_puno_flutter/features/products/products.dart';
import 'package:ccp_puno_flutter/features/pagos/pagos.dart';
import 'package:ccp_puno_flutter/features/certificados/certificados.dart';
import 'package:ccp_puno_flutter/features/tramites/tramites.dart';
import 'package:ccp_puno_flutter/features/profile/profile.dart';

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

        ///* Pagos Routes
        GoRoute(
          path: '/pagos',
          builder: (context, state) => const PagosScreen(),
        ),

        ///* Certificados Routes
        GoRoute(
          path: '/certificados',
          builder: (context, state) => const CertificadosScreen(),
        ),

        ///* Tramites Routes
        GoRoute(
          path: '/tramites',
          builder: (context, state) => const TramitesScreen(),
        ),

        ///* Profile Routes
        GoRoute(
          path: '/profile',
          builder: (context, state) => const ProfileScreen(),
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
