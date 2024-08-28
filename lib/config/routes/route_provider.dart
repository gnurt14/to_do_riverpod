import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'package:to_do_riverpod/config/routes/app_routes.dart';
import 'package:to_do_riverpod/config/routes/route_location.dart';

final routeProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    initialLocation: RouteLocation.home,
    navigatorKey: navigationKey,
    routes: appRoutes,
  );
});
