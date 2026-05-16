import 'package:path/path.dart' as p;

import '../init_context.dart';
import '../init_step.dart';
import '../utils/file_writer.dart';

class RoutingStep implements InitStep {
  @override
  String get name => 'Configuring routing';

  @override
  Future<void> run(InitContext context) async {
    final routingDir = p.join(
      context.projectPath,
      'lib',
      'src',
      'config',
      'routing',
    );

    await Future.wait([
      FileWriter.write(
        p.join(routingDir, 'app_routes.dart'),
        _appRoutesContent,
      ),
      FileWriter.write(
        p.join(routingDir, 'app_router.dart'),
        _appRouterContent,
      ),
      FileWriter.write(
        p.join(routingDir, 'routes', 'main_routes.dart'),
        _mainRoutesContent,
      ),
    ]);
  }

  // ── app_routes.dart ──────────────────────────────────────────────────────────

  static const _appRoutesContent = '''
class AppRoutes {
  const AppRoutes._();

  // ── Main Routes ──────────────────────────────────────────────────────

  static const String initial = '/';
}
''';

  // ── app_router.dart ──────────────────────────────────────────────────────────

  static const _appRouterContent = '''
// Package imports:
import 'package:go_router/go_router.dart';

// Project imports:
import '/src/config/routing/app_routes.dart';
import '/src/config/routing/routes/main_routes.dart';

class AppRouter {
  const AppRouter._();

  static final GoRouter _router = GoRouter(
    initialLocation: AppRoutes.initial,
    routes: [
      ...MainRoutes.routes,
    ],
  );

  static GoRouter get router => _router;
}
''';

  // ── routes/main_routes.dart ──────────────────────────────────────────────────

  static const _mainRoutesContent = '''
// Package imports:
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

// Project imports:
import '/src/config/routing/app_routes.dart';

class MainRoutes {
  const MainRoutes._();

  static List<GoRoute> get routes => [
    GoRoute(
      path: AppRoutes.initial,
      builder: (context, state) => const Scaffold(),
    ),
  ];
}
''';
}
