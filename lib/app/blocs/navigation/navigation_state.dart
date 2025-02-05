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
  ];

  static List<AdaptativeNavigationDestination> adminDestinations(
    final AppLocalizations localizations,
  ) => <AdaptativeNavigationDestination>[
    ...userDestinations(localizations),
    AdaptativeNavigationDestination(
      title: localizations.admin,
      icon: Icons.admin_panel_settings,
      location: const AdminRoute().location,
    ),
  ];

  @override
  String toString() => 'NavigationState{destinations: $destinations}';
}
