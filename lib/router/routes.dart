import 'package:flutter/material.dart' show BuildContext, Widget, Placeholder, immutable;
import 'package:go_router/go_router.dart';

part 'routes.g.dart';

@TypedGoRoute<HomeRoute>(
  name: 'home',
  path: '/',
  routes: [
    TypedGoRoute<BookDetailsRoute>(
      name: 'book-details',
      path: '/book',
    ),
    TypedGoRoute<ProfileRoute>(
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
@immutable
class HomeRoute extends GoRouteData {
  const HomeRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const Placeholder();
  }
}

@immutable
class ProfileRoute extends GoRouteData {
  const ProfileRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const Placeholder();
  }
}

@immutable
class AdminRoute extends GoRouteData {
  const AdminRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const Placeholder();
  }
}

@immutable
class BookDetailsRoute extends GoRouteData {
  const BookDetailsRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const Placeholder();
  }
}
