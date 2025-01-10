import 'package:flutter/material.dart' show BuildContext, Icons, Widget;
import 'package:go_router/go_router.dart' show GoRouter, GoRouterState, RouteBase, ShellRoute;
import '../adaptative_navigation_trail.dart' show AdaptativeNavigationDestination, AdaptiveNavigationTrail;
import 'routes.dart';

final List<AdaptativeNavigationDestination> _appDestinations =
    <AdaptativeNavigationDestination>[
  AdaptativeNavigationDestination(
    title: 'Home',
    icon: Icons.home,
    // location: '/',
    location: const HomeRoute().location,
  ),
  AdaptativeNavigationDestination(
    title: 'Profile',
    icon: Icons.person,
    location: const ProfileRoute().location,
  ),
];

/// The application router.
final GoRouter router = GoRouter(
  initialLocation: '/',
  routes: <RouteBase>[
    ShellRoute(
      builder: (
        final BuildContext context,
        final GoRouterState state,
        final Widget child,
      ) => AdaptiveNavigationTrail(
        destinations: _appDestinations,
        child: child,
      ),
      routes: $appRoutes,
    ),
  ],
);
