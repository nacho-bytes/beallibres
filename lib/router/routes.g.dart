// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'routes.dart';

// **************************************************************************
// GoRouterGenerator
// **************************************************************************

List<RouteBase> get $appRoutes => [
      $homeRoute,
      $bookDetailsRoute,
    ];

RouteBase get $homeRoute => GoRouteData.$route(
      path: '/',
      name: 'home',
      factory: $HomeRouteExtension._fromState,
      routes: [
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
    );

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

RouteBase get $bookDetailsRoute => GoRouteData.$route(
      path: '/book',
      name: 'book-details',
      factory: $BookDetailsRouteExtension._fromState,
    );

extension $BookDetailsRouteExtension on BookDetailsRoute {
  static BookDetailsRoute _fromState(GoRouterState state) =>
      const BookDetailsRoute();

  String get location => GoRouteData.$location(
        '/book',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}