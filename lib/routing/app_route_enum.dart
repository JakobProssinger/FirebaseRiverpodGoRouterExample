enum AppRoutes {
  home,
  signIn,
  signUp,
}

extension AppRoutesExtension on AppRoutes {
  String get path {
    switch (this) {
      case AppRoutes.home:
        return '/';
      case AppRoutes.signIn:
        return '/signin';
      case AppRoutes.signUp:
        return '/signup';
    }
  }

  String get routeName {
    switch (this) {
      case AppRoutes.home:
        return 'Home';
      case AppRoutes.signIn:
        return 'SignIn';
      case AppRoutes.signUp:
        return 'SignUp';
    }
  }
}
