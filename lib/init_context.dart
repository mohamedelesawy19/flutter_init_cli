// Data shared across all initialization steps.
class InitContext {
  const InitContext({
    required this.projectPath,
    required this.projectName,
    required this.stateManagement,
  });

  final String projectPath;
  final String projectName;
  final String stateManagement;

  bool get usesBloc => stateManagement == 'bloc';
}
