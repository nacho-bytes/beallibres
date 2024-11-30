import 'package:go_router/go_router.dart' show GoRouter;
import 'routes.dart';

/// The application router.
final GoRouter router = GoRouter(
  initialLocation: '/',
  routes: $appRoutes,
);
