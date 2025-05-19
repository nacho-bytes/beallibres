import 'package:flutter/material.dart' show BuildContext, Widget, immutable;
import 'package:flutter_bloc/flutter_bloc.dart' show BlocBuilder;
import 'package:go_router/go_router.dart'
    show
        GoRouteData,
        GoRouterHelper,
        GoRouterState,
        RouteBase,
        RouteData,
        ShellRouteData,
        TypedGoRoute,
        TypedRoute,
        TypedShellRoute;

import '../../presentation/presentation.dart'
    show
        AdaptiveNavigationTrail,
        AdminPage,
        BookDetailsPage,
        BookGaleryPage,
        LoginPage,
        ProfilePage,
        SignUpPage,
        UserAdminPage;
import '../blocs/navigation/navigation_bloc.dart'
    show NavigationBloc, NavigationState;

part 'routes.g.dart';

@TypedShellRoute<ShellNavigationRoute>(
  routes: <TypedRoute<RouteData>>[
    TypedGoRoute<HomeRoute>(
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
            TypedGoRoute<UserAdminRoute>(
              name: 'user-admin',
              path: 'user-admin',
            ),
          ],
        ),
      ],
    ),
  ],
)

/// The root shell route that provides navigation scaffold
@immutable
class ShellNavigationRoute extends ShellRouteData {
  /// Creates the shell navigation route.
  const ShellNavigationRoute();

  @override
  Widget builder(
    final BuildContext context,
    final GoRouterState state,
    final Widget navigator,
  ) =>
      BlocBuilder<NavigationBloc, NavigationState>(
        builder: (
          final BuildContext context,
          final NavigationState navigationState,
        ) =>
            AdaptiveNavigationTrail(
          destinations: navigationState.destinations(context),
          child: navigator,
        ),
      );
}

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

/// The user admin route.
@immutable
class UserAdminRoute extends GoRouteData {
  /// Creates the user admin route.
  const UserAdminRoute();

  @override
  Widget build(final BuildContext context, final GoRouterState state) =>
      const UserAdminPage();
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
