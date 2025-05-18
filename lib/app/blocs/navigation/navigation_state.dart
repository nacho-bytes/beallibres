part of 'navigation_bloc.dart';

class NavigationState {
  NavigationState({
    final List<AdaptativeNavigationDestination> Function(BuildContext context)?
        destinations,
  }) : destinations = destinations ?? _defaultDestinationsBuilder;

  static List<AdaptativeNavigationDestination> Function(BuildContext context)
      _defaultDestinationsBuilder =
      (final BuildContext context) => <AdaptativeNavigationDestination>[];

  final List<AdaptativeNavigationDestination> Function(BuildContext context)
      destinations;

  NavigationState copyWith({
    final List<AdaptativeNavigationDestination> Function(BuildContext context)?
        destinations,
  }) =>
      NavigationState(
        destinations: destinations ?? this.destinations,
      );

  static List<AdaptativeNavigationDestination> Function(BuildContext context)
      baseDestinations =
      (final BuildContext context) => <AdaptativeNavigationDestination>[
            AdaptativeNavigationDestination(
              title: AppLocalizations.of(context)!.home,
              icon: Icons.home,
              location: const HomeRoute().location,
            ),
          ];

  static List<AdaptativeNavigationDestination> anonymousDestinations(
    final BuildContext context,
  ) =>
      <AdaptativeNavigationDestination>[
        ...baseDestinations(context),
        AdaptativeNavigationDestination(
          title: AppLocalizations.of(context)!.login,
          icon: Icons.login,
          location: const LoginRoute().location,
        ),
      ];

  static List<AdaptativeNavigationDestination> userDestinations(
    final BuildContext context,
  ) =>
      <AdaptativeNavigationDestination>[
        ...baseDestinations(context),
        AdaptativeNavigationDestination(
          title: AppLocalizations.of(context)!.profile,
          icon: Icons.person,
          location: const ProfileRoute().location,
        ),
      ];

  static List<AdaptativeNavigationDestination> adminDestinations(
    final BuildContext context,
  ) =>
      <AdaptativeNavigationDestination>[
        ...userDestinations(context),
        AdaptativeNavigationDestination(
          title: AppLocalizations.of(context)!.admin,
          icon: Icons.admin_panel_settings,
          location: const AdminRoute().location,
        ),
      ];

  @override
  String toString() => 'NavigationState{destinations: $destinations}';
}
