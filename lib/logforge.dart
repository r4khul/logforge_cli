import 'dart:io';

import 'package:args/command_runner.dart';
import 'package:logforge/src/core/command_runner.dart';

Future<void> runLogForge(List<String> args) async {
  final CommandRunner<void> runner = buildLogForgeCommandRunner();
  try {
    await runner.run(args);
  } on UsageException catch (e) {
    stderr.writeln(e.message);
    stderr.writeln();
    stderr.writeln(e.usage);
    exitCode = 64;
  }
}
