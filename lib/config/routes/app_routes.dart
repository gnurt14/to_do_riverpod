import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';
import 'package:to_do_riverpod/config/routes/route_location.dart';
import 'package:to_do_riverpod/screens/create_task_screen.dart';
import 'package:to_do_riverpod/screens/home_screen.dart';

final navigationKey = GlobalKey<NavigatorState>();

final appRoutes = [
  GoRoute(
    path: RouteLocation.home,
    parentNavigatorKey: navigationKey,
    builder: HomeScreen.builder,
  ),

  GoRoute(
    path: RouteLocation.createTask,
    parentNavigatorKey: navigationKey,
    builder: CreateTaskScreen.builder,
  ),
];
