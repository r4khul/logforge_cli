import 'dart:io';

import 'package:args/command_runner.dart';
import 'package:logforge/src/services/file_reader.dart';
import 'package:logforge/src/transformers/log_entry_transformer.dart';

class ParseCommand extends Command<void> {
  @override
  final String name = 'parse';
  @override
  final String description = 'Parses log lines into structured entries.';

  ParseCommand() {
    argParser.addOption(
      'file',
      abbr: 'f',
      help: 'Path to the file to parse.',
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
      final entries = lines.transform(const LogEntryTransformer());
      await for (final entry in entries) {
        print(entry.toString());
      }
    } on FileSystemException catch (e) {
      stderr.writeln("Error reading the file: ${e.message}");
      stderr.writeln("Path: ${e.path}");
    }
  }
}
