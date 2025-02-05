import 'package:flutter/material.dart' show AnimatedSwitcher, Animation, Axis, BuildContext, Colors, Column, Drawer, Expanded, Icon, IconData, KeyedSubtree, ListTile, MediaQuery, NavigationBar, NavigationDestination, NavigationRail, NavigationRailDestination, Row, Scaffold, SizeTransition, SizedBox, StatelessWidget, Text, ValueKey, VerticalDivider, Widget;
import 'package:go_router/go_router.dart' show GoRouter, GoRouterHelper, GoRouterState;

/// The navigation destination.
class AdaptativeNavigationDestination {
  /// Creates the navigation destination.
  ///
  /// [title] is the title.
  /// [icon] is the icon.
  /// [location] es la ruta a la que navega (string, obtenido de `GoRouteData.location`).
  const AdaptativeNavigationDestination({
    required this.title,
    required this.icon,
    required this.location,
  });

  /// The title.
  final String title;

  /// The icon.
  final IconData icon;

  /// The route location (string path).
  final String location;

  @override
  String toString() => 'AdaptativeNavigationDestination{'
    'title: $title'
    ', icon: $icon'
    ', location: $location'
  '}';
}

class AdaptiveNavigationTrail extends StatelessWidget {
  const AdaptiveNavigationTrail({
    required this.destinations,
    super.key,
    this.child,
  });

  final Widget? child;
  final List<AdaptativeNavigationDestination> destinations;

  static bool isLargeScreen(final BuildContext context) =>
    MediaQuery.of(context).size.width > 960.0;

  static bool isMediumScreen(final BuildContext context) =>
    MediaQuery.of(context).size.width > 640.0;

  int? _computeSelectedIndex(final BuildContext context) {
    final GoRouterState? state = GoRouter.of(context).state;
    final String? currentLocation = state?.matchedLocation; 

    final int index = destinations.indexWhere(
      (final AdaptativeNavigationDestination d) =>
        d.location == currentLocation,
    );

    return index >= 0 ? index : null;
  }

  void _onDestinationSelected(final BuildContext context, final int index) {
    context.go(destinations[index].location);
  }

  @override
  Widget build(final BuildContext context) {
    final int? currentIndex = _computeSelectedIndex(context);

    final bool large = isLargeScreen(context);
    final bool medium = isMediumScreen(context);
    final bool small = !medium;

    Widget leftNav;
    String leftKey; 
    if (large) {
      leftNav = _buildDrawer(currentIndex, context);
      leftKey = 'drawer';
    } else if (medium) {
      leftNav = _buildNavigationRail(currentIndex, context);
      leftKey = 'rail';
    } else {
      leftNav = const SizedBox.shrink();
      leftKey = 'empty';
    }

    Widget bottomNav;
    String bottomKey;
    if (small) {
      bottomNav = _buildBottomNavigationBar(currentIndex, context);
      bottomKey = 'bottomBar';
    } else {
      bottomNav = const SizedBox.shrink();
      bottomKey = 'noBottomBar';
    }

    return Scaffold(
      body: Row(
        children: <Widget>[
          AnimatedSwitcher(
            duration: const Duration(milliseconds: 250),
            transitionBuilder: (
              final Widget child,
              final Animation<double> anim,
            ) => SizeTransition(
              axis: Axis.horizontal,
              axisAlignment: -1,
              sizeFactor: anim,
              child: child,
            ),
            child: KeyedSubtree(
              key: ValueKey<String>(leftKey),
              child: leftNav,
            ),
          ),
          if (!small)
            VerticalDivider(
              width: 1,
              thickness: 1,
              color: Colors.grey[300],
            ),
          Expanded(
            child: Column(
              children: <Widget>[
                Expanded(child: child ?? const SizedBox.shrink()),
                AnimatedSwitcher(
                  duration: const Duration(milliseconds: 400),
                  transitionBuilder: (
                    final Widget child,
                    final Animation<double> animation,
                  ) => SizeTransition(
                    sizeFactor: animation,
                    child: child,
                  ),
                  child: KeyedSubtree(
                    key: ValueKey<String>(bottomKey),
                    child: bottomNav,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBottomNavigationBar(
    final int? currentIndex,
    final BuildContext context,
  ) {
    if (destinations.length <= 1) {
      return const SizedBox.shrink();
    }
    return NavigationBar(
      destinations: destinations.map(
        (final AdaptativeNavigationDestination d) => NavigationDestination(
          icon: Icon(d.icon),
          label: d.title,
        ),
      ).toList(),
      selectedIndex: currentIndex ?? 0, // TODO - Make it so it stays as the last selected
      onDestinationSelected: (final int index) => _onDestinationSelected(context, index),
    );
  }

  Widget _buildNavigationRail(
    final int? currentIndex,
    final BuildContext context,
  ) => NavigationRail(
    destinations: destinations.map(
      (final AdaptativeNavigationDestination d) => NavigationRailDestination(
        icon: Icon(d.icon),
        label: Text(d.title),
      ),
    ).toList(),
    selectedIndex: currentIndex,
    onDestinationSelected: (
      final int index,
    ) => _onDestinationSelected(
      context,
      index,
    ),
  );

  Widget _buildDrawer(
    final int? currentIndex,
    final BuildContext context,
  ) => Drawer(
    child: Column(
      children: <Widget>[
        for (int i = 0; i < destinations.length; i++)
          ListTile(
            leading: Icon(destinations[i].icon),
            title: Text(destinations[i].title),
            selected: i == currentIndex,
            onTap: () => _onDestinationSelected(context, i),
          ),
      ],
    ),
  );
}
