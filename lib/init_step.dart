import 'init_context.dart';

abstract interface class InitStep {
  String get name;
  Future<void> run(InitContext context);
}
