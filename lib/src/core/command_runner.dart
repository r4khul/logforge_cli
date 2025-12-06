import 'package:args/command_runner.dart';
import 'package:logforge/src/commands/analyze_command.dart';
import 'package:logforge/src/commands/cat_command.dart';
import 'package:logforge/src/commands/config_command.dart';
import 'package:logforge/src/commands/hello_command.dart';
import 'package:logforge/src/commands/parse_command.dart';

CommandRunner<void> buildLogForgeCommandRunner() {
  final runner = CommandRunner<void>(
    'logforge',
    'LogForge CLI - high performance log processing toolkit.',
  );

  runner
    ..addCommand(HelloCommand())
    ..addCommand(CatCommand())
    ..addCommand(ParseCommand())
    ..addCommand(AnalyzeCommand())
    ..addCommand(ConfigCommand());

  return runner;
}
