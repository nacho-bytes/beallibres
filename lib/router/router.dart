import 'package:go_router/go_router.dart' show GoRouter;
import 'routes.dart';

final GoRouter router = GoRouter(
  initialLocation: '/',
  routes: $appRoutes,

);
