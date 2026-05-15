import 'dart:io';

import 'package:path/path.dart' as p;
import 'package:yaml/yaml.dart';

import '../init_context.dart';
import '../init_step.dart';
import '../utils/logger.dart';
import '../services/pub_dev_client.dart';

// ─── Types ────────────────────────────────────────────────────────────────────

typedef _Section = ({String label, List<String> packages});

// ─── SDK Packages (not fetched from pub.dev) ─────────────────────────────────

const _sdkPackages = {
  'flutter': 'flutter',
  'flutter_localizations': 'flutter',
  'flutter_test': 'flutter',
};

// ─── Package Sections ─────────────────────────────────────────────────────────

List<_Section> _depSections(String stateManagement) => [
  (label: 'Localization', packages: ['flutter_localizations', 'intl']),
  (label: 'State Management', packages: _smPackages(stateManagement)),
  (label: 'Dependency Injection', packages: ['get_it']),
  (label: 'Navigation', packages: ['go_router']),
  (label: 'Networking', packages: ['dio', 'connectivity_plus']),
  (
    label: 'Storage',
    packages: ['flutter_secure_storage', 'shared_preferences'],
  ),
  (label: 'Functional', packages: ['dartz']),
  (label: 'UI', packages: ['cupertino_icons']),
];

List<_Section> _devDepSections(String stateManagement) => [
  (label: 'Linting', packages: ['flutter_lints']),
  (label: 'Testing', packages: _testingPackages(stateManagement)),
  (label: 'Coverage', packages: ['coverage', 'test_coverage_badge']),
];

List<String> _smPackages(String sm) => switch (sm.toLowerCase()) {
  'bloc' => ['flutter_bloc', 'bloc_concurrency', 'equatable'],
  'riverpod' => ['flutter_riverpod', 'riverpod_annotation'],
  'provider' => ['provider'],
  'getx' => ['get'],
  _ => throw ArgumentError('Unknown state management: "$sm"'),
};

List<String> _testingPackages(String sm) => [
  if (sm.toLowerCase() == 'bloc') 'bloc_test',
  'mocktail',
  'fake_async',
];

// ─── Step ─────────────────────────────────────────────────────────────────────

class PubspecStep implements InitStep {
  @override
  String get name => 'Updating pubspec.yaml';

  final _pubDev = PubDevClient();

  @override
  Future<void> run(InitContext context) async {
    final file = File(p.join(context.projectPath, 'pubspec.yaml'));
    final yaml = loadYaml(await file.readAsString()) as YamlMap;

    final depSections = _depSections(context.stateManagement);
    final devDepSections = _devDepSections(context.stateManagement);

    final versions = await _fetchLatestVersions(depSections, devDepSections);

    final content = _buildYaml(
      name: yaml['name'] as String,
      description: yaml['description'] as String? ?? '',
      version: yaml['version'] as String? ?? '1.0.0+1',
      sdkConstraint:
          (yaml['environment'] as YamlMap?)?['sdk'] as String? ??
          '>=3.6.0 <4.0.0',
      depSections: depSections,
      devDepSections: devDepSections,
      versions: versions,
    );

    await file.writeAsString(content);
    Logger.success('pubspec.yaml updated with latest versions');
  }

  Future<Map<String, String>> _fetchLatestVersions(
    List<_Section> depSections,
    List<_Section> devDepSections,
  ) async {
    final pubPackages = [
      ...depSections.expand((s) => s.packages),
      ...devDepSections.expand((s) => s.packages),
    ].where((pkg) => !_sdkPackages.containsKey(pkg)).toList();

    Logger.info(
      'Fetching latest versions for ${pubPackages.length} packages...',
    );

    final entries = await Future.wait(
      pubPackages.map((pkg) async {
        final version = await _pubDev.latestVersion(pkg);
        Logger.info('  $pkg: ^$version');
        return MapEntry(pkg, version);
      }),
    );

    return Map.fromEntries(entries);
  }
}

// ─── YAML Builder ─────────────────────────────────────────────────────────────

String _buildYaml({
  required String name,
  required String description,
  required String version,
  required String sdkConstraint,
  required List<_Section> depSections,
  required List<_Section> devDepSections,
  required Map<String, String> versions,
}) {
  final buf = StringBuffer();

  _writeProjectHeader(
    buf,
    name: name,
    description: description,
    version: version,
    sdkConstraint: sdkConstraint,
  );
  _writeDependencies(buf, depSections, versions);
  _writeDevDependencies(buf, devDepSections, versions);
  _writeFlutterSection(buf);

  return buf.toString();
}

void _writeProjectHeader(
  StringBuffer buf, {
  required String name,
  required String description,
  required String version,
  required String sdkConstraint,
}) {
  buf
    ..writeln('name: $name')
    ..writeln('description: "$description"')
    ..writeln()
    ..writeln('publish_to: none')
    ..writeln()
    ..writeln('version: $version')
    ..writeln()
    ..writeln('environment:')
    ..writeln('  sdk: "$sdkConstraint"')
    ..writeln();
}

void _writeDependencies(
  StringBuffer buf,
  List<_Section> sections,
  Map<String, String> versions,
) {
  buf
    ..writeln('dependencies:')
    ..writeln('  flutter:')
    ..writeln('    sdk: flutter')
    ..writeln();

  for (final section in sections) {
    _writeSection(buf, section, versions);
  }
}

void _writeDevDependencies(
  StringBuffer buf,
  List<_Section> sections,
  Map<String, String> versions,
) {
  buf
    ..writeln('dev_dependencies:')
    ..writeln('  flutter_test:')
    ..writeln('    sdk: flutter')
    ..writeln();

  for (final section in sections) {
    _writeSection(buf, section, versions);
  }
}

void _writeSection(
  StringBuffer buf,
  _Section section,
  Map<String, String> versions,
) {
  buf.writeln('  # ${section.label}');
  for (final pkg in section.packages) {
    _writePackageEntry(buf, pkg, versions);
  }
  buf.writeln();
}

void _writePackageEntry(
  StringBuffer buf,
  String pkg,
  Map<String, String> versions,
) {
  final sdk = _sdkPackages[pkg];
  if (sdk != null) {
    buf
      ..writeln('  $pkg:')
      ..writeln('    sdk: $sdk');
  } else {
    buf.writeln('  $pkg: ^${versions[pkg]}');
  }
}

void _writeFlutterSection(StringBuffer buf) {
  buf
    ..writeln('flutter:')
    ..writeln('  uses-material-design: true')
    ..writeln('  generate: true')
    ..writeln();
}
