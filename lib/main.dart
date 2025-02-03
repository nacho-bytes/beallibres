import 'package:firebase_core/firebase_core.dart' show Firebase;
import 'package:flutter/material.dart'
    show BuildContext, Builder, MaterialApp, StatelessWidget, ThemeData, ThemeExtension, Widget, WidgetsFlutterBinding, runApp;
import 'package:flutter_bloc/flutter_bloc.dart'
    show
        Bloc,
        BlocBuilder,
        BlocListener,
        BlocProvider,
        MultiBlocProvider,
        MultiRepositoryProvider,
        ReadContext,
        RepositoryProvider;
import 'package:flutter_gen/gen_l10n/app_localizations.dart'
    show AppLocalizations;
import 'package:go_router/go_router.dart'
    show GoRouter, GoRouterState, RouteBase, ShellRoute;
import 'package:nested/nested.dart' show SingleChildWidget;

import 'app/app.dart'
    show
        $HomeRouteExtension,
        $appRoutes,
        AppBlocObserver,
        AuthenticationBloc,
        AuthenticationState,
        AuthenticationSubscriptionRequested,
        HomeRoute,
        NavigationBloc,
        NavigationNewUserTypeEvent,
        NavigationState;
import 'domain/domain.dart' show AuthenticationRepository, UsersRepository;
import 'firebase_options.dart' show DefaultFirebaseOptions;
import 'presentation/presentation.dart'
    show AdaptiveNavigationTrail, SpacingThemeExtension;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = const AppBlocObserver();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  final AuthenticationRepository authenticationRepository =
      AuthenticationRepository();
  await authenticationRepository.user.first;

  final UsersRepository usersRepository = UsersRepository();

  runApp(
    App(
      authenticationRepository: authenticationRepository,
      usersRepository: usersRepository,
    ),
  );
}

/// The main application widget.
///
/// This widget is the root of the application.
class App extends StatelessWidget {
  /// Creates the main application widget.
  ///
  /// The [key] is optional and defaults to `null`.
  const App({
    required final AuthenticationRepository authenticationRepository,
    required final UsersRepository usersRepository,
    super.key,
  }) :  _authenticationRepository = authenticationRepository,
        _usersRepository = usersRepository;

  final AuthenticationRepository _authenticationRepository;
  final UsersRepository _usersRepository;

  @override
  Widget build(final BuildContext context) => MultiRepositoryProvider(
    providers: <SingleChildWidget>[
      RepositoryProvider<AuthenticationRepository>.value(
        value: _authenticationRepository,
      ),
      RepositoryProvider<UsersRepository>.value(
        value: _usersRepository,
      ),
    ],
    child: MultiBlocProvider(
      providers: <SingleChildWidget>[
        BlocProvider<AuthenticationBloc>(
          create: (final BuildContext context) => AuthenticationBloc(
            authenticationRepository:
                context.read<AuthenticationRepository>(),
            usersRepository: context.read<UsersRepository>(),
          )..add(const AuthenticationSubscriptionRequested()),
        ),
      ],
      child: MaterialApp.router(
        theme: ThemeData(
          extensions: const <ThemeExtension<dynamic>>[
            SpacingThemeExtension(
              small: 4,
              medium: 8,
              large: 16,
            ),
          ],
        ),
        routerConfig: GoRouter(
          initialLocation: const HomeRoute().location,
          routes: <RouteBase>[
            ShellRoute(
              builder: (
                final BuildContext context,
                final GoRouterState routerState,
                final Widget child,
              ) => BlocProvider<NavigationBloc>(
                create: (final BuildContext context) => NavigationBloc(),
                child: Builder(
                  builder: (final BuildContext context) {
                    // TODO - Should be a better way to do this
                    if (context.read<NavigationBloc>().state.destinations.isEmpty) {
                      context.read<NavigationBloc>().add(
                        NavigationNewUserTypeEvent(
                          localizations: AppLocalizations.of(context)!,
                          type: context.read<AuthenticationBloc>().state.user.data.userType,
                        ),
                      );
                    }
                    return BlocListener<AuthenticationBloc, AuthenticationState>(
                      listener: (
                        final BuildContext context,
                        final AuthenticationState authenticationState,
                      ) {
                        context.read<NavigationBloc>().add(
                          NavigationNewUserTypeEvent(
                            localizations: AppLocalizations.of(context)!,
                            type: authenticationState.user.data.userType,
                          ),
                        );
                      },
                      listenWhen: (
                        final AuthenticationState previous,
                        final AuthenticationState current,
                      ) =>
                          previous.user.data.userType !=
                          current.user.data.userType,
                      child: BlocBuilder<NavigationBloc, NavigationState>(
                        builder: (
                          final BuildContext context,
                          final NavigationState navigationState,
                        ) =>
                            AdaptiveNavigationTrail(
                          destinations: navigationState.destinations,
                          child: child,
                        ),
                      ),
                    );
                  },
                ),
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
