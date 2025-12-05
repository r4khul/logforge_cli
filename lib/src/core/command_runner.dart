import 'package:args/command_runner.dart';
import 'package:logforge_cli/src/commands/analyze_command.dart';
import 'package:logforge_cli/src/commands/cat_command.dart';
import 'package:logforge_cli/src/commands/hello_command.dart';
import 'package:logforge_cli/src/commands/parse_command.dart';

CommandRunner<void> buildLogForgeCommandRunner() {
  final runner = CommandRunner<void>(
    'logforge',
    'LogForge CLI - high performance log processing toolkit.',
  );

  runner
    ..addCommand(HelloCommand())
    ..addCommand(CatCommand())
    ..addCommand(ParseCommand())
    ..addCommand(AnalyzeCommand());

  return runner;
}
