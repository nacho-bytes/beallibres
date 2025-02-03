part of 'navigation_bloc.dart';

class NavigationState {
  NavigationState({
    final List<AdaptativeNavigationDestination>? destinations,
  }) : destinations = destinations ?? <AdaptativeNavigationDestination>[];

  final List<AdaptativeNavigationDestination> destinations;

  NavigationState copyWith({
    final List<AdaptativeNavigationDestination>? destinations,
  }) => NavigationState(
    destinations: destinations ?? this.destinations,
  );

  static List<AdaptativeNavigationDestination> baseDestinations(
    final AppLocalizations localizations,
  ) => <AdaptativeNavigationDestination>[
      AdaptativeNavigationDestination(
        title: localizations.home,
        icon: Icons.home,
        location: const HomeRoute().location,
      ),
    ]; 

  static List<AdaptativeNavigationDestination> anonymousDestinations(
    final AppLocalizations localizations,
  ) => <AdaptativeNavigationDestination>[
    ...baseDestinations(localizations),
    AdaptativeNavigationDestination(
      title: localizations.login,
      icon: Icons.login,
      location: const LoginRoute().location,
    ),
  ];

  static List<AdaptativeNavigationDestination> userDestinations(
    final AppLocalizations localizations,
  ) => <AdaptativeNavigationDestination>[
    ...baseDestinations(localizations),
    AdaptativeNavigationDestination(
      title: localizations.profile,
      icon: Icons.person,
      location: const ProfileRoute().location,
    ),
    AdaptativeNavigationDestination(
      title: 'Log out',
      icon: Icons.logout,
      location: const LoginRoute().location, // TODO - Switch to logout route
    ),
  ];

  static List<AdaptativeNavigationDestination> adminDestinations(
    final AppLocalizations localizations,
  ) => <AdaptativeNavigationDestination>[
    ...userDestinations(localizations).sublist(0, userDestinations(localizations).length - 1), // Without the logout destination
    AdaptativeNavigationDestination(
      title: localizations.admin,
      icon: Icons.admin_panel_settings,
      location: const AdminRoute().location,
    ),
    userDestinations(localizations).last, // Add the logout destination
  ];
}
