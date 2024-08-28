import 'package:flutter/material.dart';
import 'package:to_do_riverpod/config/routes/route_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../config/theme/app_theme.dart';

class TodoApp extends ConsumerWidget {
  const TodoApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final routeConfig = ref.watch(routeProvider);

    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light,
      routerConfig: routeConfig,
    );
  }
}
