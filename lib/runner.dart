import 'dart:io';

import 'package:path/path.dart' as p;

import 'init_context.dart';
import 'init_step.dart';
// import 'steps/architecture_step.dart';
// import 'steps/localization_step.dart';
import 'steps/pubspec_step.dart';
import 'steps/analysis_step.dart';
import 'steps/readme_step.dart';
import 'steps/localization_step.dart';
import 'steps/routing_step.dart';
// import 'steps/theme_step.dart';
import 'utils/logger.dart';

class InitRunner {
  const InitRunner({required this.projectPath, required this.stateManagement});

  final String projectPath;
  final String stateManagement;

  Future<void> run() async {
    final absolutePath = p.absolute(projectPath);

    // Validate project path
    if (!File(p.join(absolutePath, 'pubspec.yaml')).existsSync()) {
      Logger.error('pubspec.yaml not found in: $absolutePath');
      Logger.error('Make sure you are pointing to a Flutter project.');
      exit(1);
    }

    final context = InitContext(
      projectPath: absolutePath,
      projectName: p.basename(absolutePath),
      stateManagement: stateManagement,
    );

    Logger.header('🚀  Flutter Project Initializer');
    Logger.info('Project : ${context.projectName}');
    Logger.info('Path    : ${context.projectPath}');
    Logger.info('State   : ${context.stateManagement}');
    Logger.divider();

    // Steps run in order — each is independent and can fail fast.
    final steps = <InitStep>[
      PubspecStep(),
      AnalysisStep(),
      // ArchitectureStep(),
      // ThemeStep(),
      LocalizationStep(),
      RoutingStep(),
      ReadmeStep(),
    ];

    for (final step in steps) {
      Logger.step(step.name);
      try {
        await step.run(context);
      } catch (e, st) {
        Logger.error('$e\n$st');
        exit(1);
      }
    }

    Logger.divider();
    Logger.header('✅  Done! Next steps:');
    Logger.info('  cd ${context.projectPath}');
    Logger.info('  flutter pub get');
  }
}
