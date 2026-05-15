import 'dart:io';

import 'package:args/args.dart';
import 'package:flutter_init_cli/runner.dart';

Future<void> main(List<String> args) async {
  final parser = ArgParser()
    ..addOption(
      'path',
      abbr: 'p',
      help: 'Path to Flutter project directory',
      defaultsTo: '.',
    )
    ..addOption(
      'state',
      abbr: 's',
      help: 'State management solution',
      defaultsTo: 'bloc',
      allowed: ['bloc', 'riverpod'],
      allowedHelp: {
        'bloc': 'flutter_bloc',
        'riverpod': 'flutter_riverpod + riverpod_annotation',
      },
    )
    ..addFlag('help', abbr: 'h', help: 'Show usage', negatable: false);

  late final ArgResults results;
  try {
    results = parser.parse(args);
  } catch (e) {
    stderr.writeln('Error: $e\n');
    stderr.writeln(parser.usage);
    exit(1);
  }

  if (results['help'] as bool) {
    stdout
      ..writeln('Flutter Project Initializer\n')
      ..writeln('Usage: flutter_init [options]\n')
      ..writeln(parser.usage);
    exit(0);
  }

  await InitRunner(
    projectPath: results['path'] as String,
    stateManagement: results['state'] as String,
  ).run();
}
