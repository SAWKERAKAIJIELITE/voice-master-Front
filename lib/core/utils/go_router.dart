import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../features/auth/pages/signin_page.dart';
import '../../features/auth/pages/signup_page.dart';
import '../../features/home/views/pages/home_page.dart';
import '../../features/home/views/pages/main_page.dart';
import '../../features/splash/views/pages/splash_page.dart';

/// The route configuration.
final _parentKey = GlobalKey<NavigatorState>();
final _shellKey = GlobalKey<NavigatorState>();
final GoRouter goRouter = GoRouter(
  navigatorKey: _parentKey,
  routes: <RouteBase>[
    GoRoute(
      parentNavigatorKey: _parentKey,
      path: NamedRoutes.base,
      builder: (BuildContext context, GoRouterState state) {
        return const SplashPage();
      },
    ),
    GoRoute(
      parentNavigatorKey: _parentKey,
      path: NamedRoutes.signin,
      builder: (BuildContext context, GoRouterState state) {
        return const SigninPage();
      },
    ),
    GoRoute(
      parentNavigatorKey: _parentKey,
      path: NamedRoutes.signup,
      builder: (BuildContext context, GoRouterState state) {
        return const SignupPage();
      },
    ),
    ShellRoute(
      navigatorKey: _shellKey,
      pageBuilder: (BuildContext context, GoRouterState state, child) {
        return NoTransitionPage(
            child: MainPage(
          currentPage: child,
          currentRoute: state.uri.path,
        ));
      },
      routes: [
        GoRoute(
          parentNavigatorKey: _shellKey,
          path: NamedRoutes.home,
          pageBuilder: (BuildContext context, GoRouterState state) {
            return const NoTransitionPage(child: HomePage());
          },
        ),
        GoRoute(
          parentNavigatorKey: _shellKey,
          path: NamedRoutes.callsHistory,
          pageBuilder: (BuildContext context, GoRouterState state) {
            return const NoTransitionPage(child: SizedBox());
          },
        ),
        GoRoute(
          parentNavigatorKey: _shellKey,
          path: NamedRoutes.account,
          pageBuilder: (BuildContext context, GoRouterState state) {
            return const NoTransitionPage(child: SizedBox());
          },
        ),
      ],
    ),
  ],
);

class NamedRoutes {
  static const String base = '/';
  static const String signin = '/signin';
  static const String forgotPassword = '/forgot_password';
  static const String signup = '/signup';
  static const String home = '/home';
  static const String patientHistory = '/patient_history';
  static const String ourWorks = '/our_works';
  static const String account = '/account';
  static const String call = '/call';
  static const String onboardingVideo = '/onboardingVideo';
  static const String callsHistory = '/callsHistory';
  static const String doctors = '/doctors';
  static const String doctorDetails = '/doctorDetails';
  static const String aboutUs = '/aboutUs';
}
