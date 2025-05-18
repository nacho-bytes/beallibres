// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'routes.dart';

// **************************************************************************
// GoRouterGenerator
// **************************************************************************

List<RouteBase> get $appRoutes => [
      $shellNavigationRoute,
    ];

RouteBase get $shellNavigationRoute => ShellRouteData.$route(
      factory: $ShellNavigationRouteExtension._fromState,
      routes: [
        GoRouteData.$route(
          path: '/',
          name: 'home',
          factory: $HomeRouteExtension._fromState,
          routes: [
            GoRouteData.$route(
              path: 'book-details/:isbn',
              name: 'book-details',
              factory: $BookDetailsRouteExtension._fromState,
            ),
            GoRouteData.$route(
              path: 'login',
              name: 'login',
              factory: $LoginRouteExtension._fromState,
            ),
            GoRouteData.$route(
              path: 'singup',
              name: 'singup',
              factory: $SignUpRouteExtension._fromState,
            ),
            GoRouteData.$route(
              path: 'profile',
              name: 'profile',
              factory: $ProfileRouteExtension._fromState,
            ),
            GoRouteData.$route(
              path: 'admin',
              name: 'admin',
              factory: $AdminRouteExtension._fromState,
            ),
          ],
        ),
      ],
    );

extension $ShellNavigationRouteExtension on ShellNavigationRoute {
  static ShellNavigationRoute _fromState(GoRouterState state) =>
      const ShellNavigationRoute();
}

extension $HomeRouteExtension on HomeRoute {
  static HomeRoute _fromState(GoRouterState state) => const HomeRoute();

  String get location => GoRouteData.$location(
        '/',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

extension $BookDetailsRouteExtension on BookDetailsRoute {
  static BookDetailsRoute _fromState(GoRouterState state) => BookDetailsRoute(
        isbn: state.pathParameters['isbn']!,
      );

  String get location => GoRouteData.$location(
        '/book-details/${Uri.encodeComponent(isbn)}',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

extension $LoginRouteExtension on LoginRoute {
  static LoginRoute _fromState(GoRouterState state) => const LoginRoute();

  String get location => GoRouteData.$location(
        '/login',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

extension $SignUpRouteExtension on SignUpRoute {
  static SignUpRoute _fromState(GoRouterState state) => const SignUpRoute();

  String get location => GoRouteData.$location(
        '/singup',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

extension $ProfileRouteExtension on ProfileRoute {
  static ProfileRoute _fromState(GoRouterState state) => const ProfileRoute();

  String get location => GoRouteData.$location(
        '/profile',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

extension $AdminRouteExtension on AdminRoute {
  static AdminRoute _fromState(GoRouterState state) => const AdminRoute();

  String get location => GoRouteData.$location(
        '/admin',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}
