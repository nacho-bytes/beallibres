import 'package:flutter/material.dart' show AnimatedSwitcher, Animation, BottomNavigationBar, BottomNavigationBarItem, BuildContext, Colors, Column, Drawer, Expanded, FadeTransition, Icon, IconData, KeyedSubtree, ListTile, MediaQuery, NavigationRail, NavigationRailDestination, Row, Scaffold, SizedBox, StatelessWidget, Text, ValueKey, VerticalDivider, Widget;
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
}

class AdaptiveNavigationTrail extends StatelessWidget {
  const AdaptiveNavigationTrail({
    required this.destinations,
    super.key,
    this.child,
  });

  final Widget? child;
  final List<AdaptativeNavigationDestination> destinations;

  static bool _isLargeScreen(final BuildContext context) =>
    MediaQuery.of(context).size.width > 960.0;

  static bool _isMediumScreen(final BuildContext context) =>
    MediaQuery.of(context).size.width > 640.0;

  int _computeSelectedIndex(final BuildContext context) {
    final GoRouterState? state = GoRouter.of(context).state;
    final String? currentLocation = state?.matchedLocation; 

    final int index = destinations.indexWhere(
      (final AdaptativeNavigationDestination d) =>
        d.location == currentLocation,
    );

    return index >= 0 ? index : 0;
  }

  void _onDestinationSelected(final BuildContext context, final int index) {
    context.go(destinations[index].location);
  }

  @override
  Widget build(final BuildContext context) {
    final int currentIndex = _computeSelectedIndex(context);

    final bool large = _isLargeScreen(context);
    final bool medium = _isMediumScreen(context);
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
            duration: const Duration(milliseconds: 100),
            transitionBuilder: (
              final Widget child,
              final Animation<double> anim,
            ) => FadeTransition(
              opacity: anim,
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
                // Anima solo la parte inferior (BottomNav o nada)
                AnimatedSwitcher(
                  duration: const Duration(milliseconds: 300),
                  transitionBuilder: (
                    final Widget child,
                    final Animation<double> anim,
                  ) => FadeTransition(
                    opacity: anim,
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
    final int currentIndex,
    final BuildContext context,
  ) => BottomNavigationBar(
    items: destinations.map(
      (final AdaptativeNavigationDestination d) => BottomNavigationBarItem(
        icon: Icon(d.icon),
        label: d.title,
      ),
    ).toList(),
    currentIndex: currentIndex,
    onTap: (final int index) => _onDestinationSelected(context, index),
  );

  Widget _buildNavigationRail(
    final int currentIndex,
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
    final int currentIndex,
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
