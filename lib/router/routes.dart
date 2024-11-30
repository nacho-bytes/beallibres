import 'package:flutter/material.dart' show BuildContext, Placeholder, Widget, immutable;
import 'package:go_router/go_router.dart' show GoRouteData, GoRouterHelper, GoRouterState, RouteBase, RouteData, TypedGoRoute, TypedRoute;

part 'routes.g.dart';

@TypedGoRoute<HomeRoute>(
  name: 'home',
  path: '/',
  routes: <TypedRoute<RouteData>>[
    TypedGoRoute<BookDetailsRoute>(
      name: 'book-details',
      path: '/book',
    ),
    TypedGoRoute<LoginRouse>(
      name: 'login',
      path: '/login',
    ),
    TypedGoRoute<ProfileRoute>(
      name: 'profile',
      path: 'profile',
    ),
    TypedGoRoute<AdminRoute>(
      name: 'admin',
      path: 'admin',
    ),
  ],
)
/// The home route.
@immutable
class HomeRoute extends GoRouteData {
  /// Creates the home route.
  const HomeRoute();

  @override
  Widget build(
    final BuildContext context,
    final GoRouterState state,
  ) => const Placeholder();
}

/// The login route.
@immutable
class LoginRouse extends GoRouteData {
  /// Creates the login route.
  const LoginRouse();

  @override
  Widget build(
    final BuildContext context,
    final GoRouterState state,
  ) => const Placeholder();
}

/// The profile route.
@immutable
class ProfileRoute extends GoRouteData {
  /// Creates the profile route.
  const ProfileRoute();

  @override
  Widget build(
    final BuildContext context,
    final GoRouterState state,
  ) => const Placeholder();
}

/// The admin route.
@immutable
class AdminRoute extends GoRouteData {
  /// Creates the admin route.
  const AdminRoute();

  @override
  Widget build(
    final BuildContext context,
    final GoRouterState state,
  ) => const Placeholder();
}

/// The book details route.
@immutable
class BookDetailsRoute extends GoRouteData {
  /// Creates the book details route.
  const BookDetailsRoute();

  @override
  Widget build(
    final BuildContext context,
    final GoRouterState state,
  ) => const Placeholder();
}
