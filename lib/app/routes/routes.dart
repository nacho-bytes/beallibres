import 'package:flutter/material.dart' show BuildContext, Widget, immutable;
import 'package:go_router/go_router.dart'
    show
        GoRouteData,
        GoRouterHelper,
        GoRouterState,
        RouteBase,
        RouteData,
        TypedGoRoute,
        TypedRoute;

import '../../presentation/presentation.dart'
    show
        AddUserPage,
        AdminPage,
        BookDetailsPage,
        BookGaleryPage,
        LoginPage,
        ProfilePage,
        SignUpPage;

part 'routes.g.dart';

@TypedGoRoute<HomeRoute>(
  name: 'home',
  path: '/',
  routes: <TypedRoute<RouteData>>[
    TypedGoRoute<BookDetailsRoute>(
      name: 'book-details',
      path: 'book-details/:isbn',
    ),
    TypedGoRoute<LoginRoute>(
      name: 'login',
      path: 'login',
    ),
    TypedGoRoute<SignUpRoute>(
      name: 'singup',
      path: 'singup',
    ),
    TypedGoRoute<ProfileRoute>(
      name: 'profile',
      path: 'profile',
    ),
    TypedGoRoute<AdminRoute>(
      name: 'admin',
      path: 'admin',
      routes: <TypedRoute<RouteData>>[
        TypedGoRoute<AddUserRoute>(
          name: 'add-user',
          path: 'add-user',
        ),
      ],
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
  ) =>
      const BookGaleryPage();
}

/// The login route.
@immutable
class LoginRoute extends GoRouteData {
  /// Creates the login route.
  const LoginRoute();

  @override
  Widget build(
    final BuildContext context,
    final GoRouterState state,
  ) =>
      const LoginPage();
}

/// The register route.
@immutable
class SignUpRoute extends GoRouteData {
  /// Creates the register route.
  const SignUpRoute();

  @override
  Widget build(
    final BuildContext context,
    final GoRouterState state,
  ) =>
      const SignUpPage();
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
  ) =>
      const ProfilePage();
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
  ) =>
      const AdminPage();
}

/// The add user route.
@immutable
class AddUserRoute extends GoRouteData {
  /// Creates the add user route.
  const AddUserRoute();

  @override
  Widget build(
    final BuildContext context,
    final GoRouterState state,
  ) =>
      const AddUserPage();
}

/// The book details route.
@immutable
class BookDetailsRoute extends GoRouteData {
  /// Creates the book details route.
  const BookDetailsRoute({
    required this.isbn,
  });

  /// The ISBN of the book.
  final String isbn;

  @override
  Widget build(
    final BuildContext context,
    final GoRouterState state,
  ) =>
      BookDetailsPage(isbn: isbn);
}
