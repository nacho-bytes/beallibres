import 'package:firebase_core/firebase_core.dart' show Firebase;
import 'package:flutter/material.dart'
    show
        BuildContext,
        Icons,
        MaterialApp,
        StatelessWidget,
        Widget,
        WidgetsFlutterBinding,
        runApp;
import 'package:flutter_bloc/flutter_bloc.dart' show BlocBuilder, BlocProvider;
import 'package:flutter_gen/gen_l10n/app_localizations.dart'
    show AppLocalizations;
import 'package:go_router/go_router.dart';

import 'adaptative_navigation_trail.dart'
    show
        AdaptativeNavigationDestination,
        AdaptiveNavigationTrail;
import 'firebase_options.dart' show DefaultFirebaseOptions;
import 'router/router_bloc.dart' show RouterBloc, RouterState;
import 'router/routes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

/// The main application widget.
///
/// This widget is the root of the application.
class MyApp extends StatelessWidget {
  /// Creates the main application widget.
  ///
  /// The [key] is optional and defaults to `null`.
  const MyApp({
    super.key,
  });

  @override
  Widget build(final BuildContext context) => BlocProvider<RouterBloc>(
    create: (final BuildContext context) => RouterBloc(
      initialState: RouterState(
        destinations: <AdaptativeNavigationDestination>[
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
          AdaptativeNavigationDestination(
            title: 'Admin',
            icon: Icons.admin_panel_settings,
            location: const AdminRoute().location,
          ),
        ],
      ),
    ),
    child: BlocBuilder<RouterBloc, RouterState>(
      builder: (
        final BuildContext context,
        final RouterState routerState,
      ) => MaterialApp.router(
        routerConfig: GoRouter(
          initialLocation: const HomeRoute().location,
          routes: <RouteBase>[
            ShellRoute(
              builder: (
                final BuildContext context,
                final GoRouterState state,
                final Widget child,
              ) => AdaptiveNavigationTrail(
                destinations: routerState.destinations,
                child: child,
              ), 
              routes: $appRoutes,
            ),
          ],
        ),
        onGenerateTitle: (final BuildContext context) =>
            AppLocalizations.of(context)!.appTitle,
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
      ),
    ),
  );
}
