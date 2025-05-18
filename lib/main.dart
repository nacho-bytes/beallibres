import 'package:firebase_core/firebase_core.dart' show Firebase;
import 'package:flutter/material.dart'
    show
        BuildContext,
        MaterialApp,
        StatelessWidget,
        ThemeData,
        ThemeExtension,
        Widget,
        WidgetsFlutterBinding,
        runApp;
import 'package:flutter_bloc/flutter_bloc.dart'
    show
        Bloc,
        BlocListener,
        BlocProvider,
        MultiBlocProvider,
        MultiRepositoryProvider,
        ReadContext,
        RepositoryProvider;
import 'package:flutter_gen/gen_l10n/app_localizations.dart'
    show AppLocalizations;
import 'package:go_router/go_router.dart' show GoRouter;
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
        NavigationNewUserTypeEvent;
import 'domain/domain.dart'
    show AuthenticationRepository, BooksRepository, UsersRepository;
import 'firebase_options.dart' show DefaultFirebaseOptions;
import 'presentation/presentation.dart' show SpacingThemeExtension;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = const AppBlocObserver();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  final UsersRepository usersRepository = UsersRepository();
  final AuthenticationRepository authenticationRepository =
      AuthenticationRepository(usersRepository: usersRepository);
  await authenticationRepository.logInAnonymously();
  final BooksRepository booksRepository = BooksRepository();

  runApp(
    App(
      authenticationRepository: authenticationRepository,
      usersRepository: usersRepository,
      booksRepository: booksRepository,
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
    required final BooksRepository booksRepository,
    super.key,
  })  : _authenticationRepository = authenticationRepository,
        _usersRepository = usersRepository,
        _booksRepository = booksRepository;

  final AuthenticationRepository _authenticationRepository;
  final UsersRepository _usersRepository;
  final BooksRepository _booksRepository;

  @override
  Widget build(final BuildContext context) => MultiRepositoryProvider(
        providers: <SingleChildWidget>[
          RepositoryProvider<AuthenticationRepository>.value(
            value: _authenticationRepository,
          ),
          RepositoryProvider<UsersRepository>.value(
            value: _usersRepository,
          ),
          RepositoryProvider<BooksRepository>.value(
            value: _booksRepository,
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
            BlocProvider<NavigationBloc>(
              create: (final BuildContext context) => NavigationBloc()
                ..add(
                  NavigationNewUserTypeEvent(
                    type:
                        context.read<AuthenticationBloc>().state.user?.userType,
                  ),
                ),
            ),
          ],
          child: BlocListener<AuthenticationBloc, AuthenticationState>(
            listenWhen: (
              final AuthenticationState previous,
              final AuthenticationState current,
            ) =>
                current.user != null &&
                previous.user?.userType != current.user?.userType,
            listener: (
              final BuildContext context,
              final AuthenticationState authenticationState,
            ) {
              context.read<NavigationBloc>().add(
                    NavigationNewUserTypeEvent(
                      type: authenticationState.user!.userType,
                    ),
                  );
            },
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
                routes: $appRoutes,
              ),
              onGenerateTitle: (final BuildContext context) =>
                  AppLocalizations.of(context)!.appTitle,
              localizationsDelegates: AppLocalizations.localizationsDelegates,
              supportedLocales: AppLocalizations.supportedLocales,
            ),
          ),
        ),
      );
}
