import 'package:firebase_auth_riverpod/auth/repo/firebase_auth_repository.dart';
import 'package:firebase_auth_riverpod/pages/home_page.dart';
import 'package:firebase_auth_riverpod/pages/signin_page.dart';
import 'package:firebase_auth_riverpod/pages/signup_page.dart';
import 'package:firebase_auth_riverpod/utilities/refresh_listenable.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'app_route_enum.dart';

part 'app_router.g.dart';

final _key = GlobalKey<NavigatorState>();

@riverpod
GoRouter router(RouterRef ref) {
  final auth = ref.watch(authRepositoryProvider);
  return GoRouter(
    navigatorKey: _key,
    initialLocation: AppRoutes.home.path,
    routes: [
      GoRoute(
        path: AppRoutes.home.path,
        name: AppRoutes.home.routeName,
        pageBuilder: (context, state) => const MaterialPage(
          child: AppHomePage(),
        ),
      ),
      GoRoute(
        path: AppRoutes.signIn.path,
        name: AppRoutes.signIn.routeName,
        pageBuilder: (context, state) => const MaterialPage(
          child: SignInPage(),
        ),
      ),
      GoRoute(
        path: AppRoutes.signUp.path,
        name: AppRoutes.signUp.routeName,
        pageBuilder: (context, state) => const MaterialPage(
          child: SignUpPage(),
        ),
      ),
    ],
    refreshListenable: GoRouterRefreshStream(auth.authStateChanges()),
    redirect: (context, state) async {
      final bool isLoggedIn = auth.currentUser != null;
      final bool isLoggingIn = state.matchedLocation == AppRoutes.signIn.path ||
          state.matchedLocation == AppRoutes.signUp.path;

      // should redirect the user to the sign in page if they are not logged in
      if (!isLoggedIn && !isLoggingIn) {
        return AppRoutes.signIn.path;
      }

      // should redirect the user after they have logged in
      if (isLoggedIn && isLoggingIn) {
        return AppRoutes.home.path;
      }
      return null;
    },
  );
}
