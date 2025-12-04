import 'package:args/command_runner.dart';
import 'package:logforge_cli/src/commands/hello_command.dart';

CommandRunner<void> buildLogForgeCommandRunner() {
  final runner = CommandRunner<void>(
    'logforge',
    'LogForge CLI - high performance log processing toolkit.',
  );

  runner.addCommand(HelloCommand());

  return runner;
}
