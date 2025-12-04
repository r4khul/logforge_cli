import 'dart:io';

import 'package:args/command_runner.dart';
import 'package:logforge_cli/src/services/file_reader.dart';

class CatCommand extends Command<void> {
  @override
  final String name = 'cat';
  @override
  final String description =
      'Streams the contents of a text file to standard output.';

  CatCommand() {
    argParser.addOption(
      'file',
      abbr: 'f',
      help: 'Path to the file to read',
      valueHelp: 'path',
    );
  }

  @override
  Future<void> run() async {
    final String? filePath = argResults!['file'] as String?;

    if (filePath == null || filePath.trim().isEmpty) {
      throw UsageException('Missing required option --file', usage);
    }

    try {
      final lines = readFileStream(filePath);

      await for (final line in lines) {
        print(line);
      }
    } on FileSystemException catch (e) {
      stderr.writeln("Error reading the file: ${e.message}");
      stderr.writeln("Path: ${e.path}");
    }
  }
}
